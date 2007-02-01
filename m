Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73462DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 15:25:44 +1100 (EST)
Date: Wed, 31 Jan 2007 20:24:22 -0800
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
Message-ID: <20070201042422.GC3648@kroah.com>
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"EricW.Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 29, 2007 at 06:22:57PM +1100, Michael Ellerman wrote:
> On Sun, 2007-01-28 at 01:27 -0700, Eric W. Biederman wrote:
> > Michael Ellerman <michael@ellerman.id.au> writes:
> > 
> > > Currently pci_disable_device() disables MSI on a device by twiddling
> > > bits in config space via disable_msi_mode().
> > >
> > > On some platforms that may not be appropriate, so abstract the MSI
> > > suspend logic into pci_disable_device_msi().
> > 
> > >
> > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > > ---
> > >
> > >  drivers/pci/msi.c |   11 +++++++++++
> > >  drivers/pci/pci.c |    7 +------
> > >  drivers/pci/pci.h |    2 ++
> > >  3 files changed, 14 insertions(+), 6 deletions(-)
> > >
> > > Index: msi/drivers/pci/msi.c
> > > ===================================================================
> > > --- msi.orig/drivers/pci/msi.c
> > > +++ msi/drivers/pci/msi.c
> > > @@ -271,6 +271,17 @@ void disable_msi_mode(struct pci_dev *de
> > >  	pci_intx(dev, 1);  /* enable intx */
> > >  }
> > >  
> > > +void pci_disable_device_msi(struct pci_dev *dev)
> > > +{
> > > +	if (dev->msi_enabled)
> > > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
> > > +			PCI_CAP_ID_MSI);
> > > +
> > > +	if (dev->msix_enabled)
> > > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
> > > +			PCI_CAP_ID_MSIX);
> > 
> > Just a quick note. This is wrong.  It should be PCI_CAP_ID_MSIX.
> > The code that is being moved is buggy.  So the patch itself doesn't
> > make the situation any worse.
> 
> Greg, if you want to drop that patch I'll prepare two patches to fix it
> and then move it. I don't have any hardware to test, although I'm
> guessing no one does given that it's been broken since its inception.

Ok, I've now dropped it.

thanks,

greg k-h
