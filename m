Date: Sat, 6 Jan 2001 17:17:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] drivers/macintosh/Config.in
Message-ID: <20010106171733.M556@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JWEK1jqKZ6MHAcjA"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey all.  I was wondering what both camps would think of a
drivers/macintosh/Config.in?  It would simply a few things and remove some
duplicated bits.  I've attached my first attempt at it, and everything should
look the same as before (I did rename some of the ADB driver comments from
the m68k side so they matched the others).

Comments?  (We probably wouldn't see this until 2.5 anyways tho..)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="macConfig.patch"

===== arch/ppc/config.in 1.58 vs edited =====
--- 1.58/arch/ppc/config.in	Thu Dec 28 09:46:13 2000
+++ edited/arch/ppc/config.in	Sat Jan  6 17:12:13 2001
@@ -281,37 +281,7 @@

 source drivers/input/Config.in

-mainmenu_option next_comment
-comment 'Macintosh device drivers'
-
-if [ "$CONFIG_WORKSTATION_PPC" = "y" ]; then
-  # we want to change this to something like CONFIG_SYSCTRL_CUDA/PMU
-  bool 'Support for CUDA based PowerMacs' CONFIG_ADB_CUDA
-  bool 'Support for PMU  based PowerMacs' CONFIG_ADB_PMU
-  if [ "$CONFIG_ADB_PMU" = "y" ]; then
-    bool '   Power management support for PowerBooks' CONFIG_PMAC_PBOOK
-    # made a separate option since backlight may end up beeing used
-    # on non-powerbook machines (but only on PMU based ones AFAIK)
-    bool '   Backlight control for LCD screens' CONFIG_PMAC_BACKLIGHT
-  fi
-  bool 'Support for PowerMac floppy' CONFIG_MAC_FLOPPY
-  tristate 'Support for PowerMac serial ports' CONFIG_MAC_SERIAL
-  if [ "$CONFIG_MAC_SERIAL" = "y" ]; then
-    bool '   Support for console on serial port' CONFIG_SERIAL_CONSOLE
-  fi
-  bool 'Apple Desktop Bus (ADB) support' CONFIG_ADB
-  if [ "$CONFIG_ADB" = "y" ]; then
-    bool '   Include MacIO (CHRP) ADB driver' CONFIG_ADB_MACIO
-    dep_bool '   Use input layer for ADB devices' CONFIG_INPUT_ADBHID $CONFIG_INPUT
-    if [ "$CONFIG_INPUT_ADBHID" = "y" ]; then
-      bool '     Support for ADB raw keycodes' CONFIG_MAC_ADBKEYCODES
-      bool '     Support for mouse button 2+3 emulation' CONFIG_MAC_EMUMOUSEBTN
-    else
-      bool '   Support for ADB keyboard (old driver)' CONFIG_ADB_KEYBOARD
-    fi
-  fi
-fi
-endmenu
+source drivers/macintosh/Config.in

 source drivers/char/Config.in

===== arch/m68k/config.in 1.17 vs edited =====
--- 1.17/arch/m68k/config.in	Sat Nov 18 04:02:44 2000
+++ edited/arch/m68k/config.in	Sat Jan  6 16:58:19 2001
@@ -407,20 +407,7 @@
    fi
 fi
 if [ "$CONFIG_MAC" = "y" ]; then
-   tristate 'Macintosh serial support' CONFIG_MAC_SCC
-   bool 'Apple Desktop Bus (ADB) support' CONFIG_ADB
-   if [ "$CONFIG_ADB" = "y" ]; then
-      bool '   Support for ADB keyboard' CONFIG_ADB_KEYBOARD
-      bool '   Support for ADB mouse' CONFIG_ADBMOUSE
-      bool '   Include Mac II ADB driver' CONFIG_ADB_MACII
-      bool '   Include Mac IIsi ADB driver' CONFIG_ADB_MACIISI
-      bool '   Include CUDA ADB driver' CONFIG_ADB_CUDA
-      bool '   Include IOP (IIfx/Quadra 9x0) ADB driver' CONFIG_ADB_IOP
-      bool '   Include PMU (Powerbook) ADB driver' CONFIG_ADB_PMU68K
-   fi
-   if [ "$CONFIG_ADBMOUSE" = "y" ]; then
-      define_bool CONFIG_BUSMOUSE y
-   fi
+  source drivers/macintosh/Config.in
 fi
 if [ "$CONFIG_HP300" = "y" -a "$CONFIG_DIO" = "y" ]; then
    tristate 'HP DCA serial support' CONFIG_HPDCA
--- /dev/null	Tue May  5 13:32:27 1998
+++ drivers/macintosh/Config.in	Sat Jan  6 17:08:30 2001
@@ -0,0 +1,56 @@
+#
+# Macintosh driver configuration
+#
+
+mainmenu_option next_comment
+comment 'Macintosh device drivers'
+
+bool 'Macintosh driver support' CONFIG_MACINTOSH_DRIVERS
+if [ "$CONFIG_MACINTOSH_DRIVERS" = "y" ]; then
+  bool 'Apple Desktop Bus (ADB) support' CONFIG_ADB
+  if [ "$CONFIG_ADB" = "y" ]; then
+    # We want to change these to something like CONFIG_SYSCTRL_xxx
+    # PowerPC macintoshes
+    if [ "$CONFIG_WORKSTATION_PPC" = "y" ]; then
+      bool '   Support for MacIO (CHRP) based machines' CONFIG_ADB_MACIO
+      bool '   Support for PMU based machines' CONFIG_ADB_PMU
+    fi
+    # 68k macintoshes
+    if [ "$CONFIG_MAC" = "y" ]; then
+      bool '   Support for Mac II machines' CONFIG_ADB_MACII
+      bool '   Support for Mac IIsi machines' CONFIG_ADB_MACIISI
+      bool '   Support for IOP (IIfx/Quadra 9x0) based machines' CONFIG_ADB_IOP
+      bool '   Support for PMU (Powerbook) based machines' CONFIG_ADB_PMU68K
+    fi
+    # Common
+    bool '   Support for CUDA based machines' CONFIG_ADB_CUDA
+    dep_bool '   Use input layer for ADB devices' CONFIG_INPUT_ADBHID $CONFIG_INPUT
+    if [ "$CONFIG_INPUT_ADBHID" = "y" ]; then
+      bool '     Support for ADB raw keycodes' CONFIG_MAC_ADBKEYCODES
+      bool '     Support for mouse button 2+3 emulation' CONFIG_MAC_EMUMOUSEBTN
+    else
+      bool '   Support for ADB keyboard (old driver)' CONFIG_ADB_KEYBOARD
+      bool '   Support for ADB mouse (old driver)' CONFIG_ADBMOUSE
+    fi
+  fi
+  if [ "$CONFIG_ADB_PMU" = "y" ]; then
+    bool '   Power management support for PowerBooks' CONFIG_PMAC_PBOOK
+    # made a separate option since backlight may end up beeing used
+    # on non-powerbook machines (but only on PMU based ones AFAIK)
+    bool '   Backlight control for LCD screens' CONFIG_PMAC_BACKLIGHT
+  fi
+  if [ "$CONFIG_WORKSTATION_PPC" = "y" ]; then
+    bool 'Support for PowerMac floppy' CONFIG_MAC_FLOPPY
+    tristate 'Support for PowerMac serial ports' CONFIG_MAC_SERIAL
+    if [ "$CONFIG_MAC_SERIAL" = "y" ]; then
+      bool '   Support for console on serial port' CONFIG_SERIAL_CONSOLE
+    fi
+  fi
+  if [ "$CONFIG_MAC" = "y" ]; then
+    tristate 'Macintosh serial support' CONFIG_MAC_SCC
+  fi
+  if [ "$CONFIG_ADBMOUSE" = "y" ]; then
+    define_bool CONFIG_BUSMOUSE y
+  fi
+fi
+endmenu

--JWEK1jqKZ6MHAcjA--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
