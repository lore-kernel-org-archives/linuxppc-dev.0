Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4EB10DE166
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 04:24:21 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca,
	jacmet@sunsite.dk, ntl@pobox.com
Subject: [PATCH 2/2] [POWERPC] Xilinx: hwicap: update booting-without-of.txt
Date: Tue,  5 Feb 2008 09:24:10 -0800
In-Reply-To: <1202232250-24971-1-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1201900363-25230-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1202232250-24971-1-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080205172414.A88721AA0090@mail177-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ICAP device in Xilinx FPGAs differs slightly between different
FPGAs.  The driver needs an additional attribute in the device tree to
distinguish this.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 Documentation/powerpc/booting-without-of.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9a3cb1..035e28f 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2513,6 +2513,20 @@ platforms are moved over to use the flattened-device-tree model.

       Requred properties:
        - current-speed : Baud rate of uartlite
+
+      v) Xilinx hwicap
+
+		Xilinx hwicap devices provide access to the configuration logic
+		of the FPGA through the Internal Configuration Access Port
+		(ICAP).  The ICAP enables partial reconfiguration of the FPGA,
+		readback of the configuration information, and some control over
+		'warm boots' of the FPGA fabric.
+
+		Required properties:
+		- xlnx,family : The family of the FPGA, necessary since the
+                      capabilities of the underlying ICAP hardware
+                      differ between different families.  May be
+                      'virtex2p', 'virtex4', or 'virtex5'.
 
    More devices will be defined as this spec matures.
 
-- 
1.5.3.4-dirty
