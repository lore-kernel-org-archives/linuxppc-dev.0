Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1111667A64
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:12 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKggsS014929
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:42 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg8D436112
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:09 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg7k428274
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:07 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZqo7002571
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:53 -0400
Subject: [PATCH 3/8] Avoid use of ppc64_interrupt_controller.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:05 -0400
Message-Id: <114893532551-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: mostrows@watson.ibm.com
Reply-To: mostrows@watson.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

xics_irq_8259_cascade being a valid (non -1) value is sufficient criteria
for registering the cascade interrupt vector.

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/platforms/pseries/xics.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

35c3db8657f7716ae93d7423ce49f32a5f008359
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 2d60ea3..0fae097 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -82,8 +82,8 @@ struct xics_ipl {
 
 static struct xics_ipl __iomem *xics_per_cpu[NR_CPUS];
 
-static int xics_irq_8259_cascade = 0;
-static int xics_irq_8259_cascade_real = 0;
+static int xics_irq_8259_cascade = -1; /* default to invalid value*/
+static int xics_irq_8259_cascade_real = -1;
 static unsigned int default_server = 0xFF;
 static unsigned int default_distrib_server = 0;
 static unsigned int interrupt_server_size = 8;
@@ -571,8 +571,7 @@ nextnode:
  */
 static int __init xics_setup_i8259(void)
 {
-	if (ppc64_interrupt_controller == IC_PPC_XIC &&
-	    xics_irq_8259_cascade != -1) {
+	if (xics_irq_8259_cascade != -1) {
 		if (request_irq(irq_offset_up(xics_irq_8259_cascade),
 				no_action, 0, "8259 cascade", NULL))
 			printk(KERN_ERR "xics_setup_i8259: couldn't get 8259 "
-- 
1.1.4.g0b63-dirty
