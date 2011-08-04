Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id 909F1B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Aug 2011 20:35:45 +1000 (EST)
Date: Thu, 4 Aug 2011 12:35:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110804103543.GB22329@8bytes.org>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312050011.2265.185.camel@x201.home>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	qemu-devel <qemu-devel@nongnu.org>,
	David Gibson <dwg@au1.ibm.com>, aafabbri <aafabbri@cisco.com>,
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

On Sat, Jul 30, 2011 at 12:20:08PM -0600, Alex Williamson wrote:
> On Sat, 2011-07-30 at 09:58 +1000, Benjamin Herrenschmidt wrote:
> > - The -minimum- granularity of pass-through is not always a single
> > device and not always under SW control
> 
> But IMHO, we need to preserve the granularity of exposing a device to a
> guest as a single device.  That might mean some devices are held hostage
> by an agent on the host.

Thats true. There is a difference between unassign a group from the host
and make single devices in that PE visible to the guest. But we need
to make sure that no device in a PE is used by the host while at least
one device is assigned to a guest.

Unlike the other proposals to handle this in libvirt, I think this
belongs into the kernel. Doing this in userspace may break the entire
system if done wrong.

For example, if one device from e PE is assigned to a guest while
another one is not unbound from its host driver, the driver may get very
confused when DMA just stops working. This may crash the entire system
or lead to silent data corruption in the guest. The behavior is
basically undefined then. The kernel must not not allow that.


	Joerg
