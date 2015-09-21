Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22d.google.com (mail-yk0-x22d.google.com
 [IPv6:2607:f8b0:4002:c07::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 176C91A0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:23:14 +1000 (AEST)
Received: by ykdg206 with SMTP id g206so96750334ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 02:23:10 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] powerpc: fsl_pci: cast the regs->nip to void * when passing
 it to probe_kernel_address()
Date: Mon, 21 Sep 2015 17:22:50 +0800
Message-Id: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the reimplementation of probe_kernel_address() in commit
ecc83243e1d4 ("uaccess: reimplement probe_kernel_address() using
probe_kernel_read()"), the explication of the cast for the addr
parameter has been dropped. So we have to explicitly cast the
regs->nip to void * when passing it to probe_kernel_address() in
order to fix the following build error:
  arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_mcheck_exception':
  arch/powerpc/sysdev/fsl_pci.c:1002:4: error: passing argument 2 of 'probe_kernel_read' makes pointer from integer without a cast [-Werror]
      ret = probe_kernel_address(regs->nip, inst);
      ^

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---

This is against linux-next.

 arch/powerpc/sysdev/fsl_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ebc1f412cf49..13b9bcf5485e 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -999,7 +999,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 			ret = get_user(regs->nip, &inst);
 			pagefault_enable();
 		} else {
-			ret = probe_kernel_address(regs->nip, inst);
+			ret = probe_kernel_address((void *)regs->nip, inst);
 		}
 
 		if (mcheck_handle_load(regs, inst)) {
-- 
2.4.3
