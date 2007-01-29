Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4627DE047
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 19:46:06 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
Date: Mon, 29 Jan 2007 01:45:26 -0700
In-Reply-To: <1170055377.19887.60.camel@concordia.ozlabs.ibm.com> (Michael
	Ellerman's message of "Mon, 29 Jan 2007 18:22:57 +1100")
Message-ID: <m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> On Sun, 2007-01-28 at 01:27 -0700, Eric W. Biederman wrote:
>> Michael Ellerman <michael@ellerman.id.au> writes:
>> 
>> > Currently pci_disable_device() disables MSI on a device by twiddling
>> > bits in config space via disable_msi_mode().
>> >
>> > On some platforms that may not be appropriate, so abstract the MSI
>> > suspend logic into pci_disable_device_msi().
>> 
>> >
>> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>> > ---
>> >
>> >  drivers/pci/msi.c |   11 +++++++++++
>> >  drivers/pci/pci.c |    7 +------
>> >  drivers/pci/pci.h |    2 ++
>> >  3 files changed, 14 insertions(+), 6 deletions(-)
>> >
>> > Index: msi/drivers/pci/msi.c
>> > ===================================================================
>> > --- msi.orig/drivers/pci/msi.c
>> > +++ msi/drivers/pci/msi.c
>> > @@ -271,6 +271,17 @@ void disable_msi_mode(struct pci_dev *de
>> >  	pci_intx(dev, 1);  /* enable intx */
>> >  }
>> >  
>> > +void pci_disable_device_msi(struct pci_dev *dev)
>> > +{
>> > +	if (dev->msi_enabled)
>> > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
>> > +			PCI_CAP_ID_MSI);
>> > +
>> > +	if (dev->msix_enabled)
>> > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
>> > +			PCI_CAP_ID_MSIX);
>> 
>> Just a quick note. This is wrong.  It should be PCI_CAP_ID_MSIX.
>> The code that is being moved is buggy.  So the patch itself doesn't
>> make the situation any worse.
>
> Greg, if you want to drop that patch I'll prepare two patches to fix it
> and then move it. I don't have any hardware to test, although I'm
> guessing no one does given that it's been broken since its inception.

The mthca IB driver was one of the early adopters of MSI, and it uses
MSI-X.  So it isn't that no one is using MSI-X and the MSI-X code
paths don't get exercised.

I expect what is closer to the truth is that the code authors have so
far simply disabled msi separately instead of assuming pci_disable_device
will do it magically for them.  So it may be the case that we can
just kill this code path altogether.

Possibly we can just reduce it to WARN_ON(dev->msi_enabled || dev->msix_enabled);

I suspect msi_remove_pci_irq_vectors may similarly not actually make a
difference.   I think the function dates from a time when the code
attempted to cache the irq number so if you removed and re-added a module
or at least disabled and enabled msi you would get the same linux irq
number.  I remember killing that caching because it made the code
unmaintainable and wasn't really useful.

In summary I think there is still room for cleanup in msi.c, but it
think it is at least reaching the point where you just don't stumble
over opportunities.

Eric
