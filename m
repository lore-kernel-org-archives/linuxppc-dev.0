Return-Path: <b08248@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 82482DDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 04:25:10 +1100 (EST)
Date: Mon, 19 Feb 2007 11:25:05 -0600
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200702191725.l1JHP5J6025375@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: remove interrupt-controller as a property under
	/chosen
Cc: linuxppc-dev@ozlabs.org, linuxppc-release@sourceforge.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Remove interrupt-controller as a valid property under /chosen in
 the documentation.  There is a consensus that an
 interrupt-controller property does not belong under /chosen.
 /chosen is specifically for dynamic properties set at runtime.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

 As per Ben's  suggestion I also added a note about the 
 obsolete practice.

 Documentation/powerpc/booting-without-of.txt |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1e1abaf..892974c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -834,8 +834,7 @@ address which can extend beyond that lim
 
   This node is a bit "special". Normally, that's where open firmware
   puts some variable environment information, like the arguments, or
-  phandle pointers to nodes like the main interrupt controller, or the
-  default input/output devices.
+  the default input/output devices.
 
   This specification makes a few of these mandatory, but also defines
   some linux-specific properties that would be normally constructed by
@@ -860,14 +859,14 @@ address which can extend beyond that lim
       that the kernel tries to find out the default console and has
       knowledge of various types like 8250 serial ports. You may want
       to extend this function to add your own.
-    - interrupt-controller : This is one cell containing a phandle
-      value that matches the "linux,phandle" property of your main
-      interrupt controller node. May be used for interrupt routing.
-
 
   Note that u-boot creates and fills in the chosen node for platforms
   that use it.
 
+  (Note: a practice that is now obsolete was to include a property
+  under /chosen called interrupt-controller which had a phandle value
+  that pointed to the main interrupt controller)
+
   f) the /soc<SOCname> node
 
   This node is used to represent a system-on-a-chip (SOC) and must be
-- 
1.4.4
