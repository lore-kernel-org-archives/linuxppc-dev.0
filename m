Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id 424D2DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:42:16 +1100 (EST)
Date: 12 Jan 2007 04:42:13 -0000
Message-ID: <20070112044213.27744.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Problems with devices that use PCI shared memory on 2nd PCI bus
	(6 slot powermac)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Wrote:
> On Wed, 2007-01-10 at 15:05 +0000, Bob Brose wrote:
> > Since Ben fixed the irq routing on 32 bit powermacs with changes to pci_32.c
> > and prom_parse.c I've been able to use all 6 slots with interrupt
> > driven devices however there appears to be a problem with devices that use
> > memory mapping. (this is on a S900 w/ 21052 second PCI controller)
> >
> > A couple of examples:
> > When using a 21143 tulip ethernet card on the second PCI bus and with the
> > "Use PCI shared mem for NIC registers" option turned on the driver
> > fails with incorrect status register reads. If I compile a kernel without
> > this option it works fine.
> >
> > Also, if I put a rage 128 video board in one of the slots on the
> > second bus it cannot do DRM. If I turn DRM off it works ok or if I move the
> > card to the first bus it works fine with DRM.
> 
> In lspci -vv, do you see the BusMaster bit enabled on the PCI-2-PCI
> bridge ?
> 
> Ben.

Yes. Here is the lspci -vv for the 21052:

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 80800000-808fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-


Bob
