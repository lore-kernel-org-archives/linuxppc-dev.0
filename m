Date: Tue, 16 Apr 2002 07:40:34 -0600
From: Stephen Cameron <steve.cameron@compaq.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: walnut, external pci arbiter enabled
Message-ID: <20020416074034.A17754@quandary.cca.cpqcorp.net>
Reply-To: steve.cameron@compaq.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a walnut with a PCI board in it that's got a PCI
bus arbiter on ot.  The arbiter is not normally used (in x86
systems, where this board is usually used), but it seems
to be causing trouble now.  I'm told (in a vague sort of way)
the arbiter on the PCI board only gets turned on if there's no
other PCI arbiter out there.

I'm using the kernel from linuxppc_2_4_devel kernel from
bitkeeper.

I'm seeing this bit of code in arch/ppc/kernel/ppc405_pci.c triggered:

	/* Check if running in slave mode */
	if ((mfdcr(DCRN_CHPSR) & PSR_PCI_ARBIT_EN) == 0) {
		printk("Running as PCI slave, kernel PCI disabled !\n");
		return;
	}

When I first turn on my walnut, I see this on the console:

405GP 1.15 ROM Monitor (8/9/00)

 --------------------- System Info ----------------------
 Processor         = 405GP,   PVR: 401100c4
 Processor speed   = 200 MHz
 PLB speed         = 100 MHz
 OPB speed         = 50 MHz
 Ext Bus speed     = 33 MHz
 PCI Bus speed     = 33 MHz (Sync)
 Amount of SDRAM   = 32 MBytes
 External PCI arbiter enabled        <---  This looks like trouble
 --------------------------------------------------------

Then on booting, "Running as PCI slave, kernel PCI disabled !"
comes out.

Consequently, I can't access the board, which is just sitting
there waiting for somebody to set its BARs.

Any ideas?  New ROM maybe?

Thanks,

-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
