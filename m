Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67118DDE0C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 08:31:00 +1100 (EST)
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070104174947.GA3636@aepfle.de>
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
	<20070104174947.GA3636@aepfle.de>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 08:30:40 +1100
Message-Id: <1167946240.5273.11.camel@localhost.localdomain>
Mime-Version: 1.0
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


> > Add to pseries/pci.c a quirk for that chipset (don't forget to test for
> > machine_is(pseries) in the quirk as they get called for all platforms in
> > a combo kernel. The quirk shall check if resource 6 has a 0 base and
> > clear the size as Alan suggested (possibly setting the UNSET flag as
> > well).
> 
> I will test this change tomorrow:
> 
> +++ linux-2.6/arch/powerpc/platforms/pseries/pci.c
> @@ -98,6 +98,10 @@ static void fixup_winbond_82c105(struct
>                 if (dev->resource[i].flags & IORESOURCE_IO
>                     && dev->bus->number == 0 && dev->devfn == 0x81)
>                         dev->resource[i].flags &= ~IORESOURCE_IO;
> +               if (dev->resource[i].start == 0) {
> +                       printk("disable IO resource %d on W82c105 IDE controller\n", i);
> +                       dev->resource[i].flags = IORESOURCE_DISABLED;
> +               }
>         }
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
> 
> 
> 
> Or did you mean 'if (dev->resource[5].start == 0)' ?

Nah, but also set resource->end = 0 too and or-in IORESOURCE_UNSET for
flags not (=) (or just set it to 0, I have no problem with completely
clearing the resource, that will keep it out of the way)
