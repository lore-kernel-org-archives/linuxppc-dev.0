Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 2EDB5B70C3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 09:24:29 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Avi Kivity <avi@redhat.com>
Date: Tue, 09 Aug 2011 17:24:15 -0600
In-Reply-To: <4E3F9E33.5000706@redhat.com>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312932258.4524.55.camel@bling.home>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-08-08 at 11:28 +0300, Avi Kivity wrote:
> On 08/03/2011 05:04 AM, David Gibson wrote:
> > I still don't understand the distinction you're making.  We're saying
> > the group is "owned" by a given user or guest in the sense that no-one
> > else may use anything in the group (including host drivers).  At that
> > point none, some or all of the devices in the group may actually be
> > used by the guest.
> >
> > You seem to be making a distinction between "owned by" and "assigned
> > to" and "used by" and I really don't see what it is.
> >
> 
> Alex (and I) think that we should work with device/function granularity, 
> as is common with other archs, and that the group thing is just a 
> constraint on which functions may be assigned where, while you think 
> that we should work at group granularity, with 1-function groups for 
> archs which don't have constraints.
> 
> Is this an accurate way of putting it?

Mostly correct, yes.  x86 isn't immune to the group problem, it shows up
for us any time there's a PCIe-to-PCI bridge in the device hierarchy.
We lose resolution of devices behind the bridge.  As you state though, I
think of this as only a constraint on what we're able to do with those
devices.

Perhaps part of the differences is that on x86 the constraints don't
really effect how we expose devices to the guest.  We need to hold
unused devices in the group hostage and use the same iommu domain for
any devices assigned, but that's not visible to the guest.  AIUI, POWER
probably needs to expose the bridge (or at least an emulated bridge) to
the guest, any devices in the group need to show up behind that bridge,
some kind of pvDMA needs to be associated with that group, there might
be MMIO segments and IOVA windows, etc.  Effectively you want to
transplant the entire group into the guest.  Is that right?  Thanks,

Alex
