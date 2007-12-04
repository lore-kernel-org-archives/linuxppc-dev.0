Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 42E4FDDE1C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 12:09:08 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, david@gibson.dropbear.id.au,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] [v2] Improved documentation of device tree 'ranges'.
Date: Mon,  3 Dec 2007 17:08:57 -0800
Message-Id: <20071204010818.AD4231798062@mail212-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was misled by the prior language.  I've attempted to clarify how
'ranges' are used, in particular, how to get an identity mapping.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 Documentation/powerpc/booting-without-of.txt |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9a3cb1..7327f37 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -711,13 +711,14 @@ define a bus type with a more complex address format, including things
 like address space bits, you'll have to add a bus translator to the
 prom_parse.c file of the recent kernels for your bus type.
 
-The "reg" property only defines addresses and sizes (if #size-cells
-is non-0) within a given bus. In order to translate addresses upward
+The "reg" property only defines addresses and sizes (if #size-cells is
+non-0) within a given bus. In order to translate addresses upward
 (that is into parent bus addresses, and possibly into CPU physical
 addresses), all busses must contain a "ranges" property. If the
 "ranges" property is missing at a given level, it's assumed that
-translation isn't possible. The format of the "ranges" property for a
-bus is a list of:
+translation isn't possible, i.e., the registers are not visible on the
+parent bus.  The format of the "ranges" property for a bus is a list
+of:
 
 	bus address, parent bus address, size
 
@@ -735,6 +736,10 @@ fit in a single 32-bit word.   New 32-bit powerpc boards should use a
 1/1 format, unless the processor supports physical addresses greater
 than 32-bits, in which case a 2/1 format is recommended.
 
+Alternatively, the "ranges" property may be empty, indicating that the
+registers are visible on the parent bus using an identity mapping
+translation.  In other words, the parent bus address space is the same
+as the child bus address space.
 
 2) Note about "compatible" properties
 -------------------------------------
-- 
1.5.3.4-dirty
