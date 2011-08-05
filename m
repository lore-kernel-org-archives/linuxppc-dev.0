Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05468B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Aug 2011 08:49:37 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Roedel <joro@8bytes.org>
In-Reply-To: <20110805134446.GC30353@8bytes.org>
References: <1311983933.8793.42.camel@pasglop>
	<20110804102752.GA22329@8bytes.org> <1312540958.8598.46.camel@pasglop>
	<20110805134446.GC30353@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 06 Aug 2011 08:49:14 +1000
Message-ID: <1312584554.8598.58.camel@pasglop>
Mime-Version: 1.0
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

On Fri, 2011-08-05 at 15:44 +0200, Joerg Roedel wrote:
> On Fri, Aug 05, 2011 at 08:42:38PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Right. In fact to try to clarify the problem for everybody, I think we
> > can distinguish two different classes of "constraints" that can
> > influence the grouping of devices:
> > 
> >  1- Hard constraints. These are typically devices using the same RID or
> > where the RID cannot be reliably guaranteed (the later is the case with
> > some PCIe-PCIX bridges which will take ownership of "some" transactions
> > such as split but not all). Devices like that must be in the same
> > domain. This is where PowerPC adds to what x86 does today the concept
> > that the domains are pre-existing, since we use the RID for error
> > isolation & MMIO segmenting as well. so we need to create those domains
> > at boot time.
> 
> Domains (in the iommu-sense) are created at boot time on x86 today.
> Every device needs at least a domain to provide dma-mapping
> functionality to the drivers. So all the grouping is done too at
> boot-time. This is specific to the iommu-drivers today but can be
> generalized I think.

Ok, let's go there then.

> >  2- Softer constraints. Those constraints derive from the fact that not
> > applying them risks enabling the guest to create side effects outside of
> > its "sandbox". To some extent, there can be "degrees" of badness between
> > the various things that can cause such constraints. Examples are shared
> > LSIs (since trusting DisINTx can be chancy, see earlier discussions),
> > potentially any set of functions in the same device can be problematic
> > due to the possibility to get backdoor access to the BARs etc...
> 
> Hmm, there is no sane way to handle such constraints in a safe way,
> right? We can either blacklist devices which are know to have such
> backdoors or we just ignore the problem.

Arguably they probably all do have such backdoors. A debug register,
JTAG register, ... My point is you don't really know unless you get
manufacturer guarantee that there is no undocumented register somewhere
or way to change the microcode so that it does it etc.... The more
complex the devices, the less likely to have a guarantee.

The "safe" way is what pHyp does and basically boils down to only
allowing pass-through of entire 'slots', ie, things that are behind a
P2P bridge (virtual one typically, ie, a PCIe switch) and disallowing
pass-through with shared interrupts.

That way, even if the guest can move the BARs around, it cannot make
them overlap somebody else device because the parent bridge restricts
the portion of MMIO space that is forwarded down to that device anyway.

> > Now, what I derive from the discussion we've had so far, is that we need
> > to find a proper fix for #1, but Alex and Avi seem to prefer that #2
> > remains a matter of libvirt/user doing the right thing (basically
> > keeping a loaded gun aimed at the user's foot with a very very very
> > sweet trigger but heh, let's not start a flamewar here :-)
> > 
> > So let's try to find a proper solution for #1 now, and leave #2 alone
> > for the time being.
> 
> Yes, and the solution for #1 should be entirely in the kernel. The
> question is how to do that. Probably the most sane way is to introduce a
> concept of device ownership. The ownership can either be a kernel driver
> or a userspace process. Giving ownership of a device to userspace is
> only possible if all devices in the same group are unbound from its
> respective drivers. This is a very intrusive concept, no idea if it
> has a chance of acceptance :-)
> But the advantage is clearly that this allows better semantics in the
> IOMMU drivers and a more stable handover of devices from host drivers to
> kvm guests.

I tend to think around those lines too, but the ownership concept
doesn't necessarily have to be core-kernel enforced itself, it can be in
VFIO.

If we have a common API to expose the "domain number", it can perfectly
be a matter of VFIO itself not allowing to do pass-through until it has 
attached its stub driver to all the devices with that domain number, and
it can handle exclusion of iommu domains from there.

> > Maybe the right option is for x86 to move toward pre-existing domains
> > like powerpc does, or maybe we can just expose some kind of ID.
> 
> As I said, the domains are created a iommu driver initialization time
> (usually boot time). But the groups are internal to the iommu drivers
> and not visible somewhere else.

That's what we need to fix :-)

> > Ah you started answering to my above questions :-)
> > 
> > We could do what you propose. It depends what we want to do with
> > domains. Practically speaking, we could make domains pre-existing (with
> > the ability to group several PEs into larger domains) or we could keep
> > the concepts different, possibly with the limitation that on powerpc, a
> > domain == a PE.
> > 
> > I suppose we -could- make arbitrary domains on ppc as well by making the
> > various PE's iommu's in HW point to the same in-memory table, but that's
> > a bit nasty in practice due to the way we manage those, and it would to
> > some extent increase the risk of a failing device/driver stomping on
> > another one and thus taking it down with itself. IE. isolation of errors
> > is an important feature for us.
> 
> These arbitrary domains exist in the iommu-api. It would be good to
> emulate them on Power too. Can't you put a PE into an isolated
> error-domain when something goes wrong with it? This should provide the
> same isolation as before.

Well, my problem is that it's quite hard for me to arbitrarily make PEs
shared the same iommu table. The iommu tables are assigned at boot time
along with the creation of the PEs, and because sadly, I don't (yet)
support tree structures for them, they are large physically contiguous
things, so I need to allocate them early and keep them around.

I -could- make a hack to share tables when creating such arbitrary
domains, but I would definitely have to keep track of the "original"
table of the PE so that can be reverted, I can't afford to free the
memory or I risk not being able to re-allocate it.

We'll have tree iommu's in future HW but not yet.

> What you derive the group number from is your business :-) On x86 it is
> certainly the best to use the RID these devices share together with the
> PCI segment number.

Ok. The question is more in term of API whether this number is to be
unique at the system scope or only at the PCI host bridge scope. 

Cheers,
Ben.

> Regards,
> 
> 	Joerg
