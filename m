Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 2047867C1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 10:47:43 +1100 (EST)
To: mporter@kernel.crashing.org
Subject: [POWERPC] Fix config space address for 440SPe PCIeport 2
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 07 Dec 2006 15:47:28 -0800
Message-ID: <adazm9z8e0f.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The PCI Express code for PowerPC 440SPe sets up windows for memory
mapped config space access starting with port 0 at 0xc40000000, with
port 1 offset at 0x40000000 and port 2 offset at 0x80000000.  However,
ppc440spe_setup_pcie() calculates the offset as port * 0x40000000,
which doesn't work for port 2, since port is signed and the result is
big enough to be treated as negative.  Fix this by using the unsigned
constant 0x40000000u instead.

Bug originally found by Ruslan V. Sushko <rsushko@ru.mvista.com>.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---
I'm still working on cleaning up my Rev B 440SPe changes, but this bug
kills PCIe port 2 on rev A silicon so I want to send this in now.

diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
index dd5d4b9..a116325 100644
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -378,14 +378,14 @@ void ppc440spe_setup_pcie(struct pci_controller *hose, int port)
 	/*
 	 * Map 16MB, which is enough for 4 bits of bus #
 	 */
-	hose->cfg_data = ioremap64(0xc40000000ull + port * 0x40000000,
+	hose->cfg_data = ioremap64(0xc40000000ull + port * 0x40000000u,
 				   1 << 24);
 	hose->ops = &pcie_pci_ops;
 
 	/*
 	 * Set bus numbers on our root port
 	 */
-	mbase = ioremap64(0xc50000000ull + port * 0x40000000, 4096);
+	mbase = ioremap64(0xc50000000ull + port * 0x40000000u, 4096);
 	out_8(mbase + PCI_PRIMARY_BUS, 0);
 	out_8(mbase + PCI_SECONDARY_BUS, 0);
 
