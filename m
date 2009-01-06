Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 29548DE5F8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 07:41:08 +1100 (EST)
Message-ID: <4963C1DE.6020007@harris.com>
Date: Tue, 06 Jan 2009 15:41:02 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
References: <496268E7.5090907@harris.com>	 <1231190318.14860.17.camel@pasglop>
	<49627D33.8030605@harris.com> <1231223634.14860.18.camel@pasglop>
In-Reply-To: <1231223634.14860.18.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> 
>> Here is a complete startup log, with debug turned on as you requested.
>> This is still against 2.6.27.9, as it will take me a little time to
>> build 2.6.28.  Hopefully, this log will be useful in the meantime.
> 
> Can you add "debug" to your kernel command line option or send the
> output of the "dmesg" command please ?
> 
> Cheers,
> Ben.
> 

I saw a recent post from Anton talking about U-Boot configuring PCI.  That
got me wondering if U-Boot has anything to do with the problem I've
reported.  So, I turned on debug in uboot's pci_auto.c, and added another
DEBUGF like so:

	if (addr - res->bus_start + size > res->size) {
		DEBUGF("address=0x%lx bus_start=%lx size=%x limit=%lx\n",
			       	addr, res->bus_start, size, res->size);
		DEBUGF("No room in resource");
		goto error;
	}

When starting U-Boot, I get a "No room in resource" message.  Will this
affect Linux, or is it just a U-Boot warning?

	Steve


U-Boot 2008.10-00079-gebb3412-dirty (Jan  6 2009 - 15:21:56)

CPU:   AMCC PowerPC 440EPx Rev. A at 666.666 MHz (PLB=166, OPB=83, EBC=55 MHz)
       Security/Kasumi support
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       Internal PCI arbiter enabled, PCI async ext clock used
       32 kB I-Cache 32 kB D-Cache
Board: Sequoia - AMCC PPC440EPx Evaluation Board, Rev. F, PCI=66 MHz, serial# 7654
I2C:   ready
SPI:   ready
DTT:   1 is 35 C
DRAM:  256 MB
FLASH: 64 MB
NAND:  32 MiB
PCI:   Bus Dev VenId DevId Class Int
PCI Autoconfig: Bus Memory region: [80000000-8fffffff],
                Physical Memory [80000000-8fffffff]
PCI Autoconfig: Bus I/O region: [0-ffff],
                Physical Memory: [e8000000-e800ffff]
PCI Autoconfig: Found P2P bridge, device 12
PCI Autoconfig: BAR 0, Mem, size=0x80000, address=0x80000000 bus_lower=80080000
PCI Autoconfig: BAR 1, Mem, size=0x10000000, address=0x90000000 bus_start=80000000 size=10000000 limit=10000000
No room in resource
        01  00  1172  0004  ff00  43
        00  0c  10b5  8112  0604  43
