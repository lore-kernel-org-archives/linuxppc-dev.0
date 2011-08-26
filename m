Return-Path: <chrisw@sous-sol.org>
Received: from sequoia.sous-sol.org (sous-sol.org [216.99.217.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5289B6FD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 07:07:11 +1000 (EST)
Date: Fri, 26 Aug 2011 14:06:19 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Aaron Fabbri <aafabbri@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110826210619.GE13060@sequoia.sous-sol.org>
References: <20110826193559.GD13060@sequoia.sous-sol.org>
	<CA7D4D51.FD84%aafabbri@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA7D4D51.FD84%aafabbri@cisco.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, "Roedel,
	Joerg" <joerg.roedel@amd.com>, Alexander Graf <agraf@suse.de>,
	qemu-devel <qemu-devel@nongnu.org>, Chris Wright <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
> On 8/26/11 12:35 PM, "Chris Wright" <chrisw@sous-sol.org> wrote:
> > * Aaron Fabbri (aafabbri@cisco.com) wrote:
> >> Each process will open vfio devices on the fly, and they need to be able to
> >> share IOMMU resources.
> > 
> > How do you share IOMMU resources w/ multiple processes, are the processes
> > sharing memory?
> 
> Sorry, bad wording.  I share IOMMU domains *within* each process.

Ah, got it.  Thanks.

> E.g. If one process has 3 devices and another has 10, I can get by with two
> iommu domains (and can share buffers among devices within each process).
> 
> If I ever need to share devices across processes, the shared memory case
> might be interesting.
> 
> > 
> >> So I need the ability to dynamically bring up devices and assign them to a
> >> group.  The number of actual devices and how they map to iommu domains is
> >> not known ahead of time.  We have a single piece of silicon that can expose
> >> hundreds of pci devices.
> > 
> > This does not seem fundamentally different from the KVM use case.
> > 
> > We have 2 kinds of groupings.
> > 
> > 1) low-level system or topoolgy grouping
> > 
> >    Some may have multiple devices in a single group
> > 
> >    * the PCIe-PCI bridge example
> >    * the POWER partitionable endpoint
> > 
> >    Many will not
> > 
> >    * singleton group, e.g. typical x86 PCIe function (majority of
> >      assigned devices)
> > 
> >    Not sure it makes sense to have these administratively defined as
> >    opposed to system defined.
> > 
> > 2) logical grouping
> > 
> >    * multiple low-level groups (singleton or otherwise) attached to same
> >      process, allowing things like single set of io page tables where
> >      applicable.
> > 
> >    These are nominally adminstratively defined.  In the KVM case, there
> >    is likely a privileged task (i.e. libvirtd) involved w/ making the
> >    device available to the guest and can do things like group merging.
> >    In your userspace case, perhaps it should be directly exposed.
> 
> Yes.  In essence, I'd rather not have to run any other admin processes.
> Doing things programmatically, on the fly, from each process, is the
> cleanest model right now.

I don't see an issue w/ this.  As long it can not add devices to the
system defined groups, it's not a privileged operation.  So we still
need the iommu domain concept exposed in some form to logically put
groups into a single iommu domain (if desired).  In fact, I believe Alex
covered this in his most recent recap:

  ...The group fd will provide interfaces for enumerating the devices
  in the group, returning a file descriptor for each device in the group
  (the "device fd"), binding groups together, and returning a file
  descriptor for iommu operations (the "iommu fd").

thanks,
-chris
