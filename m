Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0AAD3DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 04:49:42 +1100 (EST)
Date: Thu, 4 Jan 2007 18:49:47 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
Message-ID: <20070104174947.GA3636@aepfle.de>
References: <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
	<1165293679.29784.39.camel@localhost.localdomain>
	<20061205081557.GA8483@aepfle.de>
	<1165349941.5469.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1165349941.5469.1.camel@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, greg@kroah.com, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 06, Benjamin Herrenschmidt wrote:

> On Tue, 2006-12-05 at 09:15 +0100, Olaf Hering wrote:
> > On Tue, Dec 05, Benjamin Herrenschmidt wrote:
> > 
> > > Olaf, can you give me a dump of /proc/ioports ? What is sitting at 0 on
> > > that PCI bus ?
> > 
> > with IDE=y
> > 
> > ==> /proc/ioports <==
> > 00000000-0000001f : dma1
> 
> So it's indeed colliding with the cruft above.
> 
> I reckon it's a bug in the firmware of this machine.
> 
> Add to pseries/pci.c a quirk for that chipset (don't forget to test for
> machine_is(pseries) in the quirk as they get called for all platforms in
> a combo kernel. The quirk shall check if resource 6 has a 0 base and
> clear the size as Alan suggested (possibly setting the UNSET flag as
> well).

I will test this change tomorrow:

+++ linux-2.6/arch/powerpc/platforms/pseries/pci.c
@@ -98,6 +98,10 @@ static void fixup_winbond_82c105(struct
                if (dev->resource[i].flags & IORESOURCE_IO
                    && dev->bus->number == 0 && dev->devfn == 0x81)
                        dev->resource[i].flags &= ~IORESOURCE_IO;
+               if (dev->resource[i].start == 0) {
+                       printk("disable IO resource %d on W82c105 IDE controller\n", i);
+                       dev->resource[i].flags = IORESOURCE_DISABLED;
+               }
        }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,



Or did you mean 'if (dev->resource[5].start == 0)' ?
