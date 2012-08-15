Return-Path: <B32579@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B61E2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 01:14:14 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc:Update Integrated Flash controller device tree
 bindings
Date: Wed, 15 Aug 2012 20:43:52 +0530
Message-ID: <1345043632-28535-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale's Integrated Flash controller (IFC) may have one or two
interrupts. In case of single interrupt line, it will cover all IFC
interrupts.

Update this information in IFC device tree bindings

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
Base upon git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
Branch next

 .../devicetree/bindings/powerpc/fsl/ifc.txt        |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt b/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
index 939a26d..88c7a26 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
@@ -12,9 +12,12 @@ Properties:
 - #size-cells : Either one or two, depending on how large each chipselect
                 can be.
 - reg : Offset and length of the register set for the device
-- interrupts : IFC has two interrupts. The first one is the "common"
-               interrupt(CM_EVTER_STAT), and second is the NAND interrupt
-               (NAND_EVTER_STAT).
+- interrupts: IFC may have one or two interrupts.  If two interrupt
+              specifiers are present, the first is the "common"
+              interrupt (CM_EVTER_STAT), and the second is the NAND
+              interrupt (NAND_EVTER_STAT).  If there is only one,
+              that interrupt reports both types of event.
+
 
 - ranges : Each range corresponds to a single chipselect, and covers
            the entire access window as configured.
-- 
1.7.9.5
