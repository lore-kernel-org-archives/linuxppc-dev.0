Message-ID: <20000430023055.2717.qmail@wwcst269.netaddress.usa.net>
Date: 29 Apr 00 21:30:55 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: IDE Dependancy Fix in 2.3.99pre6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is for drivers/ide/Config.in. Currently, one can choose to compile pmac
ide support without generic ide support. Unfortunately, (as has been discussed
on this list) pmac ide will not compile without generic pci ide support (which
ought to be called something like Core PCI Ide Support). This diff makes it to
where one cannot select pmac ide support without the required pmac ide
support. People used to compiling 2.2 kernels will be caught off guard by this
new dependancy.

66,74d65
<             if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
<                bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
<             fi
<             if [ "$CONFIG_PMAC" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
<                bool '    Builtin PowerMac IDE support'
CONFIG_BLK_DEV_IDE_PMAC
<                dep_bool '      PowerMac IDE DMA support'
CONFIG_BLK_DEV_IDEDMA_PMAC $CONFIG_BLK_DEV_IDE_PMAC
<                dep_bool '        Use DMA by default' CONFIG_IDEDMA_PMAC_AUTO
$CONFIG_BLK_DEV_IDEDMA_PMAC
<                define_bool CONFIG_BLK_DEV_IDEDMA
$CONFIG_BLK_DEV_IDEDMA_PMAC
<             fi
75a67,75
>        if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
>           bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
>        fi
>       fi
>       if [ "$CONFIG_PMAC" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
>        bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
>        dep_bool '      PowerMac IDE DMA support' CONFIG_BLK_DEV_IDEDMA_PMAC
$CONFIG_BLK_DEV_IDE_PMAC
>        dep_bool '        Use DMA by default' CONFIG_IDEDMA_PMAC_AUTO
$CONFIG_BLK_DEV_IDEDMA_PMAC
>        define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PMAC


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
