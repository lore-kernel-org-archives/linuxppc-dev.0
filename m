From: tom_gall@vnet.ibm.com
Message-ID: <394E3E12.FD8524E6@vnet.ibm.com>
Date: Mon, 19 Jun 2000 15:36:50 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: cort@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Config Power3/Power4 Broken Again
References: <14669.50829.334947.977935@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul, Cort

  In Alan's 2.4.0-test1-AC21 someone must have backed out the arch/ppc/config.in
change that I did. It's back to the old one which was broke! I don't mind
CONFIG_PPC64BRIDGE being turned on by default, as that makes perfect sense for
the moment.

  Below is patch that will have the options setup right without causing
menuconfig to have a problem, turn on CONFIG_PPC64BRIDGE by default and define
CONFIG_POWER3.

  Thanks,

  Tom

diff -u --recursive --new-file linux.original/arch/ppc/config.in
linux/arch/ppc/config.in
--- linux.original/arch/ppc/config.in   Tue Jun 13 11:17:14 2000
+++ linux/arch/ppc/config.in    Tue Jun 13 11:23:36 2000
@@ -17,12 +17,14 @@
 choice 'Processor Type'    \
    "6xx/7xx/7400       CONFIG_6xx  \
     4xx            CONFIG_4xx  \
-    POWER3/POWER4(64-Bit)  CONFIG_PPC64BRIDGE  \
+    POWER3                 CONFIG_POWER3   \
+    POWER4                 CONFIG_POWER4   \
     8260           CONFIG_8260 \
     8xx            CONFIG_8xx" 6xx

-if [ "$CONFIG_PPC64BRIDGE" = "y" ]; then
-  bool 'Power 4 support'   CONFIG_POWER4
+if [ "$CONFIG_POWER3" = "y" -o "$CONFIG_POWER4" = "y" ]; then
+  bool 'Power 3/4 32 bit Bridge support'   CONFIG_PPC64BRIDGE  y
+  define_bool CONFIG_ALL_PPC y
 fi

 if [ "$CONFIG_8260" = "y" ]; then
@@ -52,10 +54,6 @@
     Gemini     CONFIG_GEMINI       \
     EST8260    CONFIG_EST8260      \
     APUS       CONFIG_APUS"        PowerMac/PReP/MTX/CHRP
-fi
-
-if [ "$CONFIG_PPC64BRIDGE" = "y" ]; then
-  define_bool CONFIG_ALL_PPC y
 fi

 if [ "$CONFIG_8xx" = "y" -o "$CONFIG_8260" = "y" ]; then


--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
