Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 379FC6842A
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Oct 2005 01:49:45 +1000 (EST)
Received: from mephisto.spb.rtsoft.ru ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j8UFnht12238
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2005 20:49:43 +0500
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-qmgLh4Y1Cu2GR8PT9HCX"
Date: Fri, 30 Sep 2005 19:49:43 +0400
Message-Id: <1128095383.15236.21.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Subject: [PATCH 1/3] Fix fphysical addresses or I2C and GPIO controllers
	for Yucca board
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qmgLh4Y1Cu2GR8PT9HCX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes physical address for I2C and GPIO controllers on Yucca
PPC440SPe board. The fixes above allows to enable ibm ocp i2c driver to
access to Yucca peripheral devices. The patch is implemented for Roland
Dreier git tree for Yucca PPC440SPe board.

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

--=-qmgLh4Y1Cu2GR8PT9HCX
Content-Disposition: attachment; filename=yucca_i2c.patch
Content-Type: text/x-patch; name=yucca_i2c.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/ppc440spe.c b/arch/ppc/platforms/4xx/ppc440spe.c
--- a/arch/ppc/platforms/4xx/ppc440spe.c
+++ b/arch/ppc/platforms/4xx/ppc440spe.c
@@ -90,7 +90,7 @@ struct ocp_def core_ocp[] = {
 	{ .vendor	= OCP_VENDOR_IBM,
 	  .function	= OCP_FUNC_IIC,
 	  .index	= 0,
-	  .paddr	= 0x00000001f0000400ULL,
+	  .paddr	= 0x00000004f0000400ULL,
 	  .irq		= 2,
 	  .pm		= IBM_CPM_IIC0,
 	  .additions	= &ppc440spe_iic0_def,
@@ -99,7 +99,7 @@ struct ocp_def core_ocp[] = {
 	{ .vendor	= OCP_VENDOR_IBM,
 	  .function	= OCP_FUNC_IIC,
 	  .index	= 1,
-	  .paddr	= 0x00000001f0000500ULL,
+	  .paddr	= 0x00000004f0000500ULL,
 	  .irq		= 3,
 	  .pm		= IBM_CPM_IIC1,
 	  .additions	= &ppc440spe_iic1_def,
@@ -108,7 +108,7 @@ struct ocp_def core_ocp[] = {
 	{ .vendor	= OCP_VENDOR_IBM,
 	  .function	= OCP_FUNC_GPIO,
 	  .index	= 0,
-	  .paddr	= 0x00000001f0000700ULL,
+	  .paddr	= 0x00000004f0000700ULL,
 	  .irq		= OCP_IRQ_NA,
 	  .pm		= IBM_CPM_GPIO0,
 	},




--=-qmgLh4Y1Cu2GR8PT9HCX--
