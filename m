Return-Path: <peter.senna@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C57AC1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 19:19:10 +1000 (AEST)
Received: by wicfx3 with SMTP id fx3so18756344wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 02:19:06 -0700 (PDT)
From: Peter Senna Tschudin <peter.senna@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Peter Senna Tschudin <peter.senna@gmail.com>
Subject: [PATCH] arch-powerpc: Return false instead of -EFAULT
Date: Thu, 17 Sep 2015 11:18:56 +0200
Message-Id: <1442481536-11088-1-git-send-email-peter.senna@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Returning a negative value for a boolean function seem to have the
undesired effect of returning true. Replace -EINVAL by false in a
bool-returning function.

The diff of the .s file before and after the change (using cross
compilation) starts with:

440,441c440,441
< .L43:
< 	li 3,1	 # D.25775,
---
> .L42:
> 	li 3,0	 # D.25775,
...

while if -EFAULT is replaced by true, the diff is empty.

There is only one call site, and it expects a boolean value:
arch/powerpc/kernel/ftrace.c:129:
        if (!is_module_trampoline(tramp)) {
                pr_err("Not a trampoline\n");
                return -EINVAL;
        }

This issue was found by the following Coccinelle semantic patch:
<smpl>
@@
identifier f;
constant C;
typedef bool;
@@
bool f (...){
<+...
* return -C;
...+>
}
</smpl>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 arch/powerpc/kernel/module_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6838451..a94a5f1 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -160,7 +160,7 @@ bool is_module_trampoline(u32 *p)
 	BUILD_BUG_ON(sizeof(ppc64_stub_insns) != sizeof(ppc64_stub_mask));
 
 	if (probe_kernel_read(insns, p, sizeof(insns)))
-		return -EFAULT;
+		return false;
 
 	for (i = 0; i < ARRAY_SIZE(ppc64_stub_insns); i++) {
 		u32 insna = insns[i];
-- 
2.1.0
