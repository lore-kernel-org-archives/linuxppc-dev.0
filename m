Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id C54B8B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 23:44:47 +1000 (EST)
Date: Fri, 5 Aug 2011 15:44:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110805134446.GC30353@8bytes.org>
References: <1311983933.8793.42.camel@pasglop>
	<20110804102752.GA22329@8bytes.org>
	<1312540958.8598.46.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312540958.8598.46.camel@pasglop>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2011 at 08:42:38PM +1000, Benjamin Herrenschmidt wrote:

> Right. In fact to try to clarify the problem for everybody, I think we
> can distinguish two different classes of "constraints" that can
> influence the grouping of devices:
> 
>  1- Hard constraints. These are typically devices using the same RID or
> where the RID cannot be reliably guaranteed (the later is the case with
> some PCIe-PCIX bridges which will take ownership of "some" transactions
> such as split but not all). Devices like that must be in the same
> domain. This is where PowerPC adds to what x86 does today the concept
> that the domains are pre-existing, since we use the RID for error
> isolation & MMIO segmenting as well. so we need to create those domains
> at boot time.

Domains (in the iommu-sense) are created at boot time on x86 today.
Every device needs at least a domain to provide dma-mapping
functionality to the drivers. So all the grouping is done too at
boot-time. This is specific to the iommu-drivers today but can be
generalized I think.

>  2- Softer constraints. Those constraints derive from the fact that not
> applying them risks enabling the guest to create side effects outside of
> its "sandbox". To some extent, there can be "degrees" of badness between
> the various things that can cause such constraints. Examples are shared
> LSIs (since trusting DisINTx can be chancy, see earlier discussions),
> potentially any set of functions in the same device can be problematic
> due to the possibility to get backdoor access to the BARs etc...

Hmm, there is no sane way to handle such constraints in a safe way,
right? We can either blacklist devices which are know to have such
backdoors or we just ignore the problem.

> Now, what I derive from the discussion we've had so far, is that we need
> to find a proper fix for #1, but Alex and Avi seem to prefer that #2
> remains a matter of libvirt/user doing the right thing (basically
> keeping a loaded gun aimed at the user's foot with a very very very
> sweet trigger but heh, let's not start a flamewar here :-)
> 
> So let's try to find a proper solution for #1 now, and leave #2 alone
> for the time being.

Yes, and the solution for #1 should be entirely in the kernel. The
question is how to do that. Probably the most sane way is to introduce a
concept of device ownership. The ownership can either be a kernel driver
or a userspace process. Giving ownership of a device to userspace is
only possible if all devices in the same group are unbound from its
respective drivers. This is a very intrusive concept, no idea if it
has a chance of acceptance :-)
But the advantage is clearly that this allows better semantics in the
IOMMU drivers and a more stable handover of devices from host drivers to
kvm guests.

> Maybe the right option is for x86 to move toward pre-existing domains
> like powerpc does, or maybe we can just expose some kind of ID.

As I said, the domains are created a iommu driver initialization time
(usually boot time). But the groups are internal to the iommu drivers
and not visible somewhere else.

> Ah you started answering to my above questions :-)
> 
> We could do what you propose. It depends what we want to do with
> domains. Practically speaking, we could make domains pre-existing (with
> the ability to group several PEs into larger domains) or we could keep
> the concepts different, possibly with the limitation that on powerpc, a
> domain == a PE.
> 
> I suppose we -could- make arbitrary domains on ppc as well by making the
> various PE's iommu's in HW point to the same in-memory table, but that's
> a bit nasty in practice due to the way we manage those, and it would to
> some extent increase the risk of a failing device/driver stomping on
> another one and thus taking it down with itself. IE. isolation of errors
> is an important feature for us.

These arbitrary domains exist in the iommu-api. It would be good to
emulate them on Power too. Can't you put a PE into an isolated
error-domain when something goes wrong with it? This should provide the
same isolation as before.
What you derive the group number from is your business :-) On x86 it is
certainly the best to use the RID these devices share together with the
PCI segment number.

Regards,

	Joerg
