Date: Fri, 5 Oct 2001 08:05:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pierre AUBERT <p.aubert@staubli.com>
Cc: Mailing list Embedded linux on PowerPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: xconfig
Message-ID: <20011005080512.C4379@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BBD9FC3.3F742EF6@staubli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BBD9FC3.3F742EF6@staubli.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 05, 2001 at 01:55:48PM +0200, Pierre AUBERT wrote:

> I have a problem with the 'make xconfig'. I try to use it on a 2.4.10
> kernel for power PC, I have the following
> error messages when I save the config file :
> ERROR - Attempting to write value for unconfigured variable
> (CONFIG_SCC_ENET).
> ERROR - Attempting to write value for unconfigured variable
> (CONFIG_FEC_ENET).

Yeap.  Try the following patch.  It is old, I just looked and it won't
apply cleanly, but it should give you an idea how the right fix should
look.  If you can make this patch apply to the current tree and send it
back to me I'd appreciate it.
still.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/config.in 1.17 vs edited =====
--- 1.17/arch/ppc/config.in	Thu Apr 19 15:50:05 2001
+++ edited/arch/ppc/config.in	Wed May  2 13:50:45 2001
@@ -337,12 +337,13 @@
 endmenu

 if [ "$CONFIG_8xx" = "y" ]; then
-source arch/ppc/8xx_io/Config.in
+  source arch/ppc/8xx_io/Config.in
 fi

-if [ "$CONFIG_8260" = "y" ]; then
-source arch/ppc/8260_io/Config.in
-fi
+# This is empty right now -- Tom
+#if [ "$CONFIG_8260" = "y" ]; then
+#  source arch/ppc/8260_io/Config.in
+#fi

 source drivers/usb/Config.in

===== arch/ppc/8260_io/Config.in 1.1 vs edited =====
--- 1.1/arch/ppc/8260_io/Config.in	Sat Jan  6 00:30:23 2001
+++ edited/arch/ppc/8260_io/Config.in	Wed May  2 13:50:24 2001
@@ -4,22 +4,5 @@
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
   mainmenu_option next_comment
   comment 'MPC8260 Communication Options'
-  bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
-  if [ "$CONFIG_SCC_ENET" = "y" ]; then
-  bool 'Ethernet on SCC1' CONFIG_SCC1_ENET
-    if [ "$CONFIG_SCC1_ENET" != "y" ]; then
-      bool 'Ethernet on SCC2' CONFIG_SCC2_ENET
-    fi
-  fi
-#
-#  CONFIG_FEC_ENET is only used to get netdevices to call our init
-#    function.  Any combination of FCC1,2,3 are supported.
-#
-  bool 'FCC Ethernet' CONFIG_FEC_ENET
-  if [ "$CONFIG_FEC_ENET" = "y" ]; then
-    bool 'Ethernet on FCC1' CONFIG_FCC1_ENET
-    bool 'Ethernet on FCC2' CONFIG_FCC2_ENET
-    bool 'Ethernet on FCC3' CONFIG_FCC3_ENET
-  fi
   endmenu
 fi
===== arch/ppc/8xx_io/Config.in 1.4 vs edited =====
--- 1.4/arch/ppc/8xx_io/Config.in	Thu Apr 26 15:34:57 2001
+++ edited/arch/ppc/8xx_io/Config.in	Wed May  2 13:49:33 2001
@@ -4,20 +4,6 @@
 mainmenu_option next_comment
 comment 'MPC8xx CPM Options'

-if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
-  bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
-  if [ "$CONFIG_SCC_ENET" = "y" ]; then
-    choice 'SCC used for Ethernet'	\
-  	"SCC1	CONFIG_SCC1_ENET	\
-	 SCC2	CONFIG_SCC2_ENET	\
-	 SCC3	CONFIG_SCC3_ENET"	SCC1
-  fi
-  bool '860T FEC Ethernet' CONFIG_FEC_ENET
-  if [ "$CONFIG_FEC_ENET" = "y" ]; then
-    bool 'Use MDIO for PHY configuration' CONFIG_USE_MDIO
-  fi
-  bool 'Use Big CPM Ethernet Buffers' CONFIG_ENET_BIG_BUFFERS
-fi
 bool 'Use SMC2 for UART' CONFIG_SMC2_UART
 if [ "$CONFIG_SMC2_UART" = "y" ]; then
   bool 'Use Alternate SMC2 I/O (823/850)' CONFIG_ALTSMC2
===== drivers/net/Config.in 1.14 vs edited =====
--- 1.14/drivers/net/Config.in	Wed Apr 25 19:35:07 2001
+++ edited/drivers/net/Config.in	Wed May  2 13:52:58 2001
@@ -39,6 +39,28 @@
       tristate '  GMAC (G4/iBook ethernet) support' CONFIG_GMAC
       tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
       tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
+      if [ "$CONFIG_8xx" = "y" -o "$CONFIG_8260" = "y" ]; then
+         bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
+         if [ "$CONFIG_SCC_ENET" = "y" ]; then
+            choice 'SCC used for Ethernet (SCC3 valid only on 8xx)'	\
+               "SCC1	CONFIG_SCC1_ENET	\
+                SCC2	CONFIG_SCC2_ENET	\
+        	SCC3	CONFIG_SCC3_ENET"	SCC1
+         fi
+         bool 'FCC Ethernet' CONFIG_FEC_ENET
+         if [ "$CONFIG_FEC_ENET" = "y" -a "$CONFIG_8260" = "y" ]; then
+            bool 'Ethernet on FCC1' CONFIG_FCC1_ENET
+            bool 'Ethernet on FCC2' CONFIG_FCC2_ENET
+            bool 'Ethernet on FCC3' CONFIG_FCC3_ENET
+         fi
+         if [ "$CONFIG_FEC_ENET" = "y" -a "$CONFIG_8xx" = "y" ]; then
+            bool 'Use MDIO for PHY configuration' CONFIG_USE_MDIO
+         fi
+         if [ "$CONFIG_8xx" = "y" -a "$CONFIG_FEC_ENET" = "y" \
+        	-o "$CONFIG_SCC_ENET" = "y" ]; then
+              bool 'Use Big CPM Ethernet Buffers' CONFIG_ENET_BIG_BUFFERS
+         fi
+      fi
    fi
    if [ "$CONFIG_ZORRO" = "y" ]; then
       tristate '  Ariadne support' CONFIG_ARIADNE

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
