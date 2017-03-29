Return-Path: <srs0=yriu=3g=linux-powerpc.org=kda@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtPq90fT2zDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 21:57:25 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vtPq901hpz8t3x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 21:57:25 +1100 (AEDT)
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vtPq775MNz9s3s
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 21:57:23 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id v2so1224580lfi.2
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 03:57:23 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, paulus@ozlabs.org,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH] kvm: powerpc: book3s: use local_paca instead of get_paca
Date: Wed, 29 Mar 2017 06:55:37 -0400
Message-Id: <1490784937-10593-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

with CONFIG_DEBUG_PREEMPT get_paca produces the following warning
in kvmppc_book3s_init_hv since we are getting into the
smp_processor_id debugging code

There is no real issue with the xics_phys field.
If paca->kvm_hstate.xics_phys is non-zero on one cpu, it will be
non-zero on them all.  Therefore this is not fixing any actual
problem, just the warning.

[  138.521188] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/5596
[  138.521308] caller is .kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
[  138.521404] CPU: 5 PID: 5596 Comm: modprobe Not tainted 4.11.0-rc3-00022-gc7e790c #1
[  138.521509] Call Trace:
[  138.521563] [c0000007d018b810] [c0000000023eef10] .dump_stack+0xe4/0x150 (unreliable)
[  138.521694] [c0000007d018b8a0] [c000000001f6ec04] .check_preemption_disabled+0x134/0x150
[  138.521829] [c0000007d018b940] [d00000000a010274] .kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
[  138.521963] [c0000007d018ba00] [c00000000191d5cc] .do_one_initcall+0x5c/0x1c0
[  138.522082] [c0000007d018bad0] [c0000000023e9494] .do_init_module+0x84/0x240
[  138.522201] [c0000007d018bb70] [c000000001aade18] .load_module+0x1f68/0x2a10
[  138.522319] [c0000007d018bd20] [c000000001aaeb30] .SyS_finit_module+0xc0/0xf0
[  138.522439] [c0000007d018be30] [c00000000191baec] system_call+0x38/0xfc

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1ec86d9..cb4ff36 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3930,7 +3930,7 @@ static int kvmppc_book3s_init_hv(void)
 	 * indirectly, via OPAL.
 	 */
 #ifdef CONFIG_SMP
-	if (!get_paca()->kvm_hstate.xics_phys) {
+	if (!local_paca->kvm_hstate.xics_phys) {
 		struct device_node *np;
 
 		np = of_find_compatible_node(NULL, NULL, "ibm,opal-intc");
-- 
1.8.3.1
