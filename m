Return-Path: <aafabbri@cisco.com>
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "rcdn-iport-5.cisco.com", Issuer "Cisco SSCA2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3420BB7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 02:54:34 +1000 (EST)
Date: Tue, 23 Aug 2011 09:54:27 -0700
Subject: Re: kvm PCI assignment & VFIO ramblings
From: aafabbri <aafabbri@cisco.com>
To: Joerg Roedel <joerg.roedel@amd.com>
Message-ID: <CA792953.FB87%aafabbri@cisco.com>
In-Reply-To: <20110823110431.GK2079@amd.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
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




On 8/23/11 4:04 AM, "Joerg Roedel" <joerg.roedel@amd.com> wrote:

> On Mon, Aug 22, 2011 at 08:52:18PM -0400, aafabbri wrote:
>> You have to enforce group/iommu domain assignment whether you have the
>> existing uiommu API, or if you change it to your proposed
>> ioctl(inherit_iommu) API.
>> 
>> The only change needed to VFIO here should be to make uiommu fd assignment
>> happen on the groups instead of on device fds.  That operation fails or
>> succeeds according to the group semantics (all-or-none assignment/same
>> uiommu).
> 
> That is makes uiommu basically the same as the meta-groups, right?

Yes, functionality seems the same, thus my suggestion to keep uiommu
explicit.  Is there some need for group-groups besides defining sets of
groups which share IOMMU resources?

I do all this stuff (bringing up sets of devices which may share IOMMU
domain) dynamically from C applications.  I don't really want some static
(boot-time or sysfs fiddling) supergroup config unless there is a good
reason KVM/power needs it.

As you say in your next email, doing it all from ioctls is very easy,
programmatically.

-Aaron Fabbri
