Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-127.roch.qwest.net [67.41.71.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 928BA67E69
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 00:30:08 +1000 (EST)
Subject: [PATCH] PPC 4xx: Fix 4xx handler after pt_regs irq changes
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Sat, 07 Oct 2006 09:29:16 -0500
Message-Id: <1160231356.23429.3.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch fixes 4xx on ARCH=ppc after the removal of pt_regs from
the irq handlers.

Signed-off-by: Josh Boyer <jdub@us.ibm.com>

---
 arch/ppc/syslib/ppc4xx_pic.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.orig/arch/ppc/syslib/ppc4xx_pic.c
+++ linux-2.6/arch/ppc/syslib/ppc4xx_pic.c
@@ -96,7 +96,7 @@ UIC_HANDLERS(1);
 UIC_HANDLERS(2);
 UIC_HANDLERS(3);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
 	if (uic0 & UIC0_UIC1NC)
@@ -125,7 +125,7 @@ UIC_HANDLERS(0);
 UIC_HANDLERS(1);
 UIC_HANDLERS(2);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uicb = mfdcr(DCRN_UIC_MSR(UICB));
 	if (uicb & UICB_UIC0NC)
@@ -158,7 +158,7 @@ static void __init ppc4xx_pic_impl_init(
 UIC_HANDLERS(0);
 UIC_HANDLERS(1);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
 	if (uic0 & UIC0_UIC1NC)
@@ -179,7 +179,7 @@ static void __init ppc4xx_pic_impl_init(
 #define ACK_UIC0_PARENT
 UIC_HANDLERS(0);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
 	return uic0 ? 32 - ffs(uic0) : -1;
