Return-Path: <tqnguyen@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
 by ozlabs.org (Postfix) with SMTP id 5A056B6FFE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 18:39:08 +1000 (EST)
Received: by dacx6 with SMTP id x6so16855dac.32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2012 01:39:06 -0700 (PDT)
From: "Thang Q. Nguyen" <tqnguyen@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>, Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 1/1] dts:bluestone: Add support 2 SATA ports
Date: Wed,  4 Apr 2012 15:38:56 +0700
Message-Id: <1333528736-8524-1-git-send-email-tqnguyen@apm.com>
Cc: linux-kernel@vger.kernel.o, linuxppc-dev@lists.ozlabs.org,
 "Thang Q. Nguyen" <tqnguyen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding 2 SATA nodes on Bluestone device tree file.

Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
---
 arch/powerpc/boot/dts/bluestone.dts |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index cfa23bf..803fda6 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -155,6 +155,27 @@
 					/*RXDE*/  0x5 0x4>;
 		};
 
+		/* SATA DWC devices */
+		SATA0: sata@bffd1000 {
+			compatible = "amcc,sata-apm821xx";
+			reg = <4 0xbffd1000 0x800   /* SATA0 */
+			       4 0xbffd0800 0x400>; /* AHBDMA */
+			dma-channel=<0>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <26 4    /* SATA0 */
+			              25 4>;  /* AHBDMA */
+		};
+
+		SATA1: sata@bffd1800 {
+			compatible = "amcc,sata-apm821xx";
+			reg = <4 0xbffd1800 0x800   /* SATA1 */
+			       4 0xbffd0800 0x400>; /* AHBDMA */
+			dma-channel=<1>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <27 4    /* SATA1 */
+			              25 4>;  /* AHBDMA */
+		};
+
 		POB0: opb {
 			compatible = "ibm,opb";
 			#address-cells = <1>;
-- 
1.7.3.4

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information 
that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
