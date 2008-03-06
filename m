Return-Path: <bjorn.helgaas@hp.com>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 87054DE0BE
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 02:40:38 +1100 (EST)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [patch 4/6] ARM: move bridge enable out of
	pcibios_enable_resources()
Date: Thu, 6 Mar 2008 08:42:49 -0700
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.013269726@ldl.fc.hp.com>
	<20080306150640.GL3283@flint.arm.linux.org.uk>
In-Reply-To: <20080306150640.GL3283@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803060842.51127.bjorn.helgaas@hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 March 2008 08:06:40 am Russell King - ARM Linux wrote:
> On Wed, Feb 27, 2008 at 05:04:41PM -0700, Bjorn Helgaas wrote:
> > Move bridge enable from pcibios_enable_resources() to
> > platform_pci_enable_device() so the former matches other
> > architectures and can be shared.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > Index: work6/arch/arm/kernel/bios32.c
> > ===================================================================
> > --- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 11:25:29.000000000 -0700
> > +++ work6/arch/arm/kernel/bios32.c	2008-02-27 11:55:59.000000000 -0700
> > @@ -683,15 +683,32 @@
> >  			cmd |= PCI_COMMAND_MEMORY;
> >  	}
> >  
> > +	if (cmd != old_cmd) {
> > +		printk("PCI: enabling device %s (%04x -> %04x)\n",
> > +		       pci_name(dev), old_cmd, cmd);
> 
> Should be dev_info().
> 
> Apart from that...
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

I fixed that in the v3 patch that Greg KH put in his tree.

Thanks,
  Bjorn
