Message-ID: <20000430025608.3878.qmail@www0w.netaddress.usa.net>
Date: 29 Apr 00 21:56:08 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: IDE Dependancy Fix in 2.3.99pre6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here is the diff -u, sorry. I'm not used to using diff so please don't flame
me elitist, condescending corrections if I knackered it up.

--- drivers/ide/Config.in       Wed Apr 26 01:07:40 2000
+++ drivers/ide/Config.jdawg        Sat Apr 29 20:45:07 2000
@@ -63,16 +63,16 @@
            dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)'
CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
            dep_bool '    VIA82CXXX chipset support (EXPERIMENTAL)'
CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
            dep_mbool '      VIA82CXXX Tuning support (WIP)'
CONFIG_VIA82CXXX_TUNING $CONFIG_BLK_DEV_VIA82CXXX $CONFIG_IDEDMA_PCI_WIP
+            if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
+               bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
+            fi
+            if [ "$CONFIG_PMAC" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
+               bool '    Builtin PowerMac IDE support'
CONFIG_BLK_DEV_IDE_PMAC
+               dep_bool '      PowerMac IDE DMA support'
CONFIG_BLK_DEV_IDEDMA_PMAC $CONFIG_BLK_DEV_IDE_PMAC
+               dep_bool '        Use DMA by default' CONFIG_IDEDMA_PMAC_AUTO
$CONFIG_BLK_DEV_IDEDMA_PMAC
+               define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PMAC
+            fi
          fi
-        if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
-           bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
-        fi
-      fi
-      if [ "$CONFIG_PMAC" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
-        bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
-        dep_bool '      PowerMac IDE DMA support' CONFIG_BLK_DEV_IDEDMA_PMAC
$CONFIG_BLK_DEV_IDE_PMAC
-        dep_bool '        Use DMA by default' CONFIG_IDEDMA_PMAC_AUTO
$CONFIG_BLK_DEV_IDEDMA_PMAC
-        define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PMAC
       fi
       if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
         dep_bool '    ICS IDE interface support' CONFIG_BLK_DEV_IDE_ICSIDE
$CONFIG_ARCH_ACORN

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
