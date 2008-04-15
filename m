Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 94956DE205
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:19:50 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1944609fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 14:19:48 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: make ide_pci_check_iomem() actually work
Date: Tue, 15 Apr 2008 22:45:49 +0200
References: <200804072027.17520.sshtylyov@ru.mvista.com>
	<47FB6747.2050301@ru.mvista.com>
	<200804092034.32063.bzolnier@gmail.com>
In-Reply-To: <200804092034.32063.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804152245.49554.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 April 2008, Bartlomiej Zolnierkiewicz wrote:
> 
> [ added Akira & Kou to cc: ]
> 
> On Tuesday 08 April 2008, Sergei Shtylyov wrote:
> > Hi, I just wrote:
> > 
> > >>> This function didn't actually check if a given BAR is in I/O space 
> > >>> because of
> > >>> using the bogus PCI_BASE_ADDRESS_IO_MASK (which equals ~3) to test 
> > >>> the resource
> > >>> flags instead of IORESOURCE_IO -- fix this, make ide_hwif_configure() 
> > >>> check the
> > >>> results failing if necessary, and move the printk() call to the 
> > >>> failure path.
> > 
> > >> This change is OK in itself but I worry that ide_pci_check_iomem() may 
> > >> now
> > >> return "false" errors (bogus PCI_BASE_ADDRESS_IO_MASK check resulted 
> > >> in MEM
> > >> resources always surviving ide_pci_check_iomem() calls before the fix) 
> > >> for
> > >> some host drivers (siimage, scc_pata...) resulting in failed 
> > >> initialization.
> > 
> > >    The SiI chips do have normal I/O resources at BAR0..BAR3. As for 
> > > scc_pata, the control should not even get there because BAR0..BAR3 are 
> > > *not* IDE command/control block bases on this chip (BAR0/1 are 
> > > control/DMA bases if you look into setup_mmio_scc()) but they are 
> > > treated as such by the code immediately following ide_pci_check_iomem() 
> > > calls in ide_hwif_configure(), i.e. we might have an error here. The 
> > > same can be said about the PowerMAC driver which has all its MMIO 
> > > registers at BAR0.
> > 
> > >> How's about removing this dead/broken function instead for now?
> > 
> > >    If we indeed have a MMIO problem here, it's not in this function but 
> > > in its callers.
> > 
> >      Looks like we actually have this problem with scc_pata -- it calls 
> > ide_setup_pci_device() which should lead to calling ide_hwif_configure(). But 
> > this is broken since this call chain expects a normal PCI IDE controller with 
> > BAR0..BAR3 either non-existant or being primary/secondary port bases in I/O space.
> 
> Yep, scc_pata needs fixing before your patch can be applied.

[...]

Sergei, I applied your patch just after scc_pata's one.

Thanks,
Bart
