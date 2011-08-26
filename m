Return-Path: <aafabbri@cisco.com>
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "rcdn-iport-8.cisco.com", Issuer "Cisco SSCA2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3A8EB6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 03:53:02 +1000 (EST)
Date: Fri, 26 Aug 2011 10:52:54 -0700
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Aaron Fabbri <aafabbri@cisco.com>
To: Alexander Graf <agraf@suse.de>, "Roedel, Joerg" <joerg.roedel@amd.com>
Message-ID: <CA7D2B86.FD79%aafabbri@cisco.com>
In-Reply-To: <571DC890-A1A3-4528-92BE-566F033FD4BF@suse.de>
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




On 8/26/11 7:07 AM, "Alexander Graf" <agraf@suse.de> wrote:

> 
<snip>
> 
> Forget the KVM case for a moment and think of a user space device driver. I as
> a user am not root. But I as a user when having access to /dev/vfioX want to
> be able to access the device and manage it - and only it. The admin of that
> box needs to set it up properly for me to be able to access it.
> 
> So having two steps is really the correct way to go:
> 
>   * create VFIO group
>   * use VFIO group
> 
> because the two are done by completely different users.

This is not the case for my userspace drivers using VFIO today.

Each process will open vfio devices on the fly, and they need to be able to
share IOMMU resources.

So I need the ability to dynamically bring up devices and assign them to a
group.  The number of actual devices and how they map to iommu domains is
not known ahead of time.  We have a single piece of silicon that can expose
hundreds of pci devices.

In my case, the only administrative task would be to give my processes/users
access to the vfio groups (which are initially singletons), and the
application actually opens them and needs the ability to merge groups
together to conserve IOMMU resources (assuming we're not going to expose
uiommu).

-Aaron
