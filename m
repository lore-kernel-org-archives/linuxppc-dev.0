Date: Tue, 20 Jul 2004 12:47:08 +0200
From: Olaf Hering <olh@suse.de>
To: Ben Collins <bcollins@debian.org>,
	linuxppc-dev@lists.linuxppc.org
Cc: linux1394-devel@lists.sourceforge.net
Subject: Re: PCILynx driver on big-endian
Message-ID: <20040720104708.GB11248@suse.de>
References: <20040305235832.GA1082@phunnypharm.org> <20040306144215.GA23771@suse.de> <20040306171629.GC1082@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040306171629.GC1082@phunnypharm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sat, Mar 06, Ben Collins wrote:

> > pcilynx0: remapped memory spaces reg 0xd2222000, rom 0xd225d000, ram 0xd223b000, aux 0xd224c000
> > Machine check in kernel mode.
> > Caused by (from SRR1=41030): Transfer error ack signal
> > Oops: machine check, sig: 7 [#1]
> > NIP: D2234164 LR: D2235BC0 SP: CB081B10 REGS: cb081a60 TRAP: 0200    Not tainted
> > MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = cf44da00[5313] 'modprobe' Last syscall: 128
> > GPR00: 82000000 CB081B10 CF44DA00 FFFFFFFF 00000200 00000000 00000002 019D6412
> > GPR08: 01A68BD1 D2222F0C 00000000 D2222000 C0290000 1001CDE0 00000001 00000000
> > GPR16: 00000000 00000000 00000000 10001744 100189E0 100161CC 00000000 00000001
> > GPR24: 10019400 00000000 00000000 CB00C000 00000005 C1878C00 00009032 CB00DC8C
> > Call trace:
> >  [d2235bc0] add_card+0x358/0xa4c [pcilynx]
> >  [c00d58f0] pci_device_probe_static+0x64/0x80
> >  [c00d595c] __pci_device_probe+0x50/0x70
> >  [c00d59ac] pci_device_probe+0x30/0x60
> >  [c00f8e70] bus_match+0x50/0x8c
> >  [c00f8ff0] driver_attach+0x88/0xc8
> >  [c00f9388] bus_add_driver+0xa4/0xf4
> >  [c00f981c] driver_register+0x30/0x40
> >  [c00d5c3c] pci_register_driver+0x70/0xac
> >  [d213f024] pcilynx_init+0x24/0xd0 [pcilynx]
> >  [c0033824] sys_init_module+0x1ac/0x33c
> >  [c000794c] ret_from_syscall+0x0/0x4c
>
> Hmm, I don't see this at all.

Did the pcilynx driver ever work on ppc?
The B&W G3 Macs have an onboard Opti chip, I doubt it ever worked.

Its better to hide it.


Index: Kconfig
===================================================================
--- Kconfig	(revision 1233)
+++ Kconfig	(working copy)
@@ -72,7 +72,7 @@

 config IEEE1394_PCILYNX
 	tristate "Texas Instruments PCILynx support"
-	depends on PCI && IEEE1394 && I2C
+	depends on PCI && IEEE1394 && I2C && !PPC_PMAC
 	select I2C_ALGOBIT
 	help
 	  Say Y here if you have an IEEE-1394 controller with the Texas


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
