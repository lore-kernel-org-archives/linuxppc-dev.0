Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 097112C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 11:52:02 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 Dec 2013 19:51:37 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2445D394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 19:51:34 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBAELTm335979364
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 19:51:30 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBAELWUf031280
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 19:51:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: Use schedule instead of cond_resched
Date: Tue, 10 Dec 2013 19:51:24 +0530
Message-Id: <1386685284-3862-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We already checked need_resched. So we can call schedule directly

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

NOTE: This patch also work around a regression upstream w.r.t PR KVM

 BUG: soft lockup - CPU#0 stuck for 23s! [qemu-system-ppc:4394]
 Modules linked in:
 CPU: 0 PID: 4394 Comm: qemu-system-ppc Not tainted 3.13.0-rc3+ #98
 task: c0000001d0788400 ti: c0000001dca00000 task.ti: c0000001dca00000
 NIP: c00000000082dd80 LR: c000000000081ae0 CTR: c000000000062ba0
 REGS: c0000001dca02f70 TRAP: 0901   Not tainted  (3.13.0-rc3+)
 MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 24822024  XER: 00000000
 CFAR: c000000000081adc SOFTE: 1
 GPR00: c000000000081ae0 c0000001dca031f0 c000000000d67ab0 0000000000000001
 GPR04: 0000000071000002 0000000000000001 00000189a0d786b7 00000000018c0000
 GPR08: 0000000000000001 0000000000000000 0000000000000000 c000000000da0000
 GPR12: 0000000000000c00 c00000000fef0000
 NIP [c00000000082dd80] ._cond_resched+0x0/0x40
 LR [c000000000081ae0] .kvmppc_prepare_to_enter+0x2a0/0x2e0
 Call Trace:
 [c0000001dca031f0] [c000000000081ae0] .kvmppc_prepare_to_enter+0x2a0/0x2e0 (unreliable)
 [c0000001dca03290] [c00000000008f2cc] .kvmppc_handle_exit_pr+0xec/0xa40
 [c0000001dca03340] [c0000000000918c4] kvm_start_lightweight+0xac/0xbc
 [c0000001dca03510] [c00000000008efe0] .kvmppc_vcpu_run_pr+0x130/0x2a0
 [c0000001dca039e0] [c0000000000855bc] .kvmppc_vcpu_run+0x2c/0x40
 [c0000001dca03a50] [c000000000082c94] .kvm_arch_vcpu_ioctl_run+0x54/0x1b0
 [c0000001dca03ae0] [c00000000007d5f8] .kvm_vcpu_ioctl+0x478/0x740
 [c0000001dca03ca0] [c000000000218864] .do_vfs_ioctl+0x4a4/0x760
 [c0000001dca03d80] [c000000000218b78] .SyS_ioctl+0x58/0xb0
 [c0000001dca03e30] [c000000000009e58] syscall_exit+0x0/0x98
 Instruction dump:
 e92d0260 e94911c0 812a0004 5529f07e 5529103e 912a0004 38210080 e8010010
 ebc1fff0 ebe1fff8 7c0803a6 4e800020 <7c0802a6> 38600000 f8010010 f821ff91 

 arch/powerpc/kvm/powerpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index e4d511c8b38b..6a49b23a3276 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -74,7 +74,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 	while (true) {
 		if (need_resched()) {
 			local_irq_enable();
-			cond_resched();
+			schedule();
 			local_irq_disable();
 			continue;
 		}
-- 
1.8.3.2
