Message-ID: <27972-80808@sneakemail.com>
Date: Thu, 10 Jun 2004 14:18:17 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Configure tweaks for SystemACE without CONFIG_XILINX_OCP
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm working to clean up my integration of our JSE board, which
is based on PPC405GPr, and has a Xilinx SystemACE as a cf interface.
I find that the block/drivers/xilinx_systemace/adapter driver needs
the arch/ppc/platforms/xilinx_ocp/xilinx_ocp.o file compiled, but
definitely does *NOT* want the CONFIG_XILINX_OCP config defined.
If the latter is defined, then some changes in the ppc405_pci.c
source file are compiled in that are not right for ppc405GPr
devices.

In order to get CONFIG_XILINX_SYSACE to define, the unmodified
source requries that CONFIG_XILINX_OCP is defined. I created this
patch to alloc SYSACE on by board:


@@ -41,7 +41,7 @@
  dep_tristate 'Micro Memory MM5415 Battery Backed RAM support (EXPERIMENTAL)'
CONFIG_BLK_DEV_UMEM $CONFIG_PCI $CONFIG_EXPERIMENTAL
  dep_tristate 'Promise SATA SX8 (carmel) support' CONFIG_BLK_DEV_CARMEL $CONFIG_PCI

-if [ "$CONFIG_XILINX_OCP" = "y" ]; then
+if [ "$CONFIG_XILINX_OCP" = "y" || "$CONFIG_JSE" = "y" ]; then
     tristate 'Xilinx on-chip System ACE' CONFIG_XILINX_SYSACE
  fi

Functional, but brutish. Better would be for the ifdefs on the
CONFIG_XILINX_OCP in arch/ppc/kernel/ppc405_pci.o go away. Who is
the maintainer for this bit (Andrei?) and would in be OK to
further qualify this code so that the CONFIG_XILINX_OCP is not
enough to make a complete mess for non-virtex2pro folks? Heck,
one idea would be to change ppc405_pci.c:135 from:

   #ifdef CONFIG_XILINX_OCP

to the more complete test:

   #if DEFINED(CONFIG_XILINX_OCP) && defined(CONFIG_VIRTEX_II_PRO)

Please?
--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
