Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 7EA66B71CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Aug 2011 04:35:58 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <dwg@au1.ibm.com>
Date: Tue, 02 Aug 2011 12:35:19 -0600
In-Reply-To: <1312308847.2653.467.camel@bling.home>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312310121.2653.470.camel@bling.home>
Mime-Version: 1.0
Cc: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-02 at 12:14 -0600, Alex Williamson wrote:
> On Tue, 2011-08-02 at 18:28 +1000, David Gibson wrote:
> > On Sat, Jul 30, 2011 at 12:20:08PM -0600, Alex Williamson wrote:
> > > On Sat, 2011-07-30 at 09:58 +1000, Benjamin Herrenschmidt wrote:
> > [snip]
> > > On x86, the USB controllers don't typically live behind a PCIe-to-PCI
> > > bridge, so don't suffer the source identifier problem, but they do often
> > > share an interrupt.  But even then, we can count on most modern devices
> > > supporting PCI2.3, and thus the DisINTx feature, which allows us to
> > > share interrupts.  In any case, yes, it's more rare but we need to know
> > > how to handle devices behind PCI bridges.  However I disagree that we
> > > need to assign all the devices behind such a bridge to the guest.
> > > There's a difference between removing the device from the host and
> > > exposing the device to the guest.
> > 
> > I think you're arguing only over details of what words to use for
> > what, rather than anything of substance here.  The point is that an
> > entire partitionable group must be assigned to "host" (in which case
> > kernel drivers may bind to it) or to a particular guest partition (or
> > at least to a single UID on the host).  Which of the assigned devices
> > the partition actually uses is another matter of course, as is at
> > exactly which level they become "de-exposed" if you don't want to use
> > all of then.
> 
> Well first we need to define what a partitionable group is, whether it's
> based on hardware requirements or user policy.  And while I agree that
> we need unique ownership of a partition, I disagree that qemu is
> necessarily the owner of the entire partition vs individual devices.

Sorry, I didn't intend to have such circular logic.  "... I disagree
that qemu is necessarily the owner of the entire partition vs granted
access to devices within the partition".  Thanks,

Alex
