Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CA20068469
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Oct 2005 18:52:15 +1000 (EST)
Received: from mephisto.spb.rtsoft.ru ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j938V0t18069
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Oct 2005 13:31:00 +0500
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="=-TiWb/c7xHAvsIxWkF280"
Date: Mon, 03 Oct 2005 12:30:59 +0400
Message-Id: <1128328259.21396.2.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Subject: [PATCH 1/3] [PPC32] I2C and GPIO controlers addresses fix on Yucca
	board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-TiWb/c7xHAvsIxWkF280
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes physical address for I2C and GPIO controllers on Yucca
PPC440SPe board. The fixes below allows to enable ibm ocp i2c driver to
access to Yucca peripheral devices. The patch is implemented for Roland
Dreier git tree for Yucca PPC440SPe board.

--=-TiWb/c7xHAvsIxWkF280
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




--=-TiWb/c7xHAvsIxWkF280--
