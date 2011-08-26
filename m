Return-Path: <chrisw@sous-sol.org>
Received: from sequoia.sous-sol.org (sous-sol.org [216.99.217.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD7E3B6FF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 06:35:25 +1000 (EST)
Date: Fri, 26 Aug 2011 12:35:59 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Aaron Fabbri <aafabbri@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110826193559.GD13060@sequoia.sous-sol.org>
References: <571DC890-A1A3-4528-92BE-566F033FD4BF@suse.de>
	<CA7D2B86.FD79%aafabbri@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA7D2B86.FD79%aafabbri@cisco.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>, "Roedel,
	Joerg" <joerg.roedel@amd.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Aaron Fabbri (aafabbri@cisco.com) wrote:
> On 8/26/11 7:07 AM, "Alexander Graf" <agraf@suse.de> wrote:
> > Forget the KVM case for a moment and think of a user space device driver. I as
> > a user am not root. But I as a user when having access to /dev/vfioX want to
> > be able to access the device and manage it - and only it. The admin of that
> > box needs to set it up properly for me to be able to access it.
> > 
> > So having two steps is really the correct way to go:
> > 
> >   * create VFIO group
> >   * use VFIO group
> > 
> > because the two are done by completely different users.
> 
> This is not the case for my userspace drivers using VFIO today.
> 
> Each process will open vfio devices on the fly, and they need to be able to
> share IOMMU resources.

How do you share IOMMU resources w/ multiple processes, are the processes
sharing memory?

> So I need the ability to dynamically bring up devices and assign them to a
> group.  The number of actual devices and how they map to iommu domains is
> not known ahead of time.  We have a single piece of silicon that can expose
> hundreds of pci devices.

This does not seem fundamentally different from the KVM use case.

We have 2 kinds of groupings.

1) low-level system or topoolgy grouping

   Some may have multiple devices in a single group

   * the PCIe-PCI bridge example
   * the POWER partitionable endpoint

   Many will not

   * singleton group, e.g. typical x86 PCIe function (majority of
     assigned devices)

   Not sure it makes sense to have these administratively defined as
   opposed to system defined.

2) logical grouping

   * multiple low-level groups (singleton or otherwise) attached to same
     process, allowing things like single set of io page tables where
     applicable.

   These are nominally adminstratively defined.  In the KVM case, there
   is likely a privileged task (i.e. libvirtd) involved w/ making the
   device available to the guest and can do things like group merging.
   In your userspace case, perhaps it should be directly exposed.

> In my case, the only administrative task would be to give my processes/users
> access to the vfio groups (which are initially singletons), and the
> application actually opens them and needs the ability to merge groups
> together to conserve IOMMU resources (assuming we're not going to expose
> uiommu).

I agree, we definitely need to expose _some_ way to do this.

thanks,
-chris
