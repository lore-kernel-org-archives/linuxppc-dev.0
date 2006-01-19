Return-Path: <snakebyte@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id E4E31689F3
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 00:59:23 +1100 (EST)
Subject: [RFC][Patch] pci_0 pci_1 mixup in ppc/platforms/chestnut.c
From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 19 Jan 2006 14:59:19 +0100
Message-Id: <1137679159.22607.5.camel@alice>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi,

i am currently toying around with cp-miner 
( http://opera.cs.uiuc.edu/Projects/ARTS/CP-Miner.htm )
and came across chesnut.c

        /* setup only PCI bus 0 (bus 1 not used) */
        si.pci_0.enable_bus = 1;
        si.pci_0.pci_io.cpu_base = CHESTNUT_PCI0_IO_PROC_ADDR;
        si.pci_0.pci_io.pci_base_hi = 0;
        si.pci_0.pci_io.pci_base_lo = CHESTNUT_PCI0_IO_PCI_ADDR;
        si.pci_0.pci_io.size = CHESTNUT_PCI0_IO_SIZE;

[...SNIP ... ]

                si.pci_1.acc_cntl_options[i] =
                    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
                    MV64360_PCI_ACC_CNTL_SWAP_NONE |
[...]

since the commentary clearly states that only pci_0 is
used i assume this is a bug and the si.pci_0.acc_cntl_options
should be set?
Please cc me on replies since i am not subscribed.


Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.15-git11/arch/ppc/platforms/chestnut.c.orig	2006-01-19 14:54:59.000000000 +0100
+++ linux-2.6.15-git11/arch/ppc/platforms/chestnut.c	2006-01-19 14:55:25.000000000 +0100
@@ -199,7 +199,7 @@ chestnut_setup_bridge(void)
 		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
 		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
 
-		si.pci_1.acc_cntl_options[i] =
+		si.pci_0.acc_cntl_options[i] =
 		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
 		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
 		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
