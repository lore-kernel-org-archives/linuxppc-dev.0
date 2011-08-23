Return-Path: <aafabbri@cisco.com>
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "rcdn-iport-7.cisco.com", Issuer "Cisco SSCA2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55D79B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 10:52:23 +1000 (EST)
Date: Mon, 22 Aug 2011 17:52:18 -0700
Subject: Re: kvm PCI assignment & VFIO ramblings
From: aafabbri <aafabbri@cisco.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <CA7847D2.FB3A%aafabbri@cisco.com>
In-Reply-To: <1314049785.7662.44.camel@pasglop>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
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




On 8/22/11 2:49 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
wrote:

> 
>>> I wouldn't use uiommu for that.
>> 
>> Any particular reason besides saving a file descriptor?
>> 
>> We use it today, and it seems like a cleaner API than what you propose
>> changing it to.
> 
> Well for one, we are back to square one vs. grouping constraints.

I'm not following you.

You have to enforce group/iommu domain assignment whether you have the
existing uiommu API, or if you change it to your proposed
ioctl(inherit_iommu) API.

The only change needed to VFIO here should be to make uiommu fd assignment
happen on the groups instead of on device fds.  That operation fails or
succeeds according to the group semantics (all-or-none assignment/same
uiommu).

I think the question is: do we force 1:1 iommu/group mapping, or do we allow
arbitrary mapping (satisfying group constraints) as we do today.

I'm saying I'm an existing user who wants the arbitrary iommu/group mapping
ability and definitely think the uiommu approach is cleaner than the
ioctl(inherit_iommu) approach.  We considered that approach before but it
seemed less clean so we went with the explicit uiommu context.

>  .../...
> 
>> If we in singleton-group land were building our own "groups" which were sets
>> of devices sharing the IOMMU domains we wanted, I suppose we could do away
>> with uiommu fds, but it sounds like the current proposal would create 20
>> singleton groups (x86 iommu w/o PCI bridges => all devices are partitionable
>> endpoints).  Asking me to ioctl(inherit) them together into a blob sounds
>> worse than the current explicit uiommu API.
> 
> I'd rather have an API to create super-groups (groups of groups)
> statically and then you can use such groups as normal groups using the
> same interface. That create/management process could be done via a
> simple command line utility or via sysfs banging, whatever...
