Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1AE5CB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Jul 2011 09:56:02 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
In-Reply-To: <1312050011.2265.185.camel@x201.home>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 31 Jul 2011 09:54:57 +1000
Message-ID: <1312070097.8793.786.camel@pasglop>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	David Gibson <dwg@au1.ibm.com>, aafabbri <aafabbri@cisco.com>,
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

On Sat, 2011-07-30 at 12:20 -0600, Alex Williamson wrote:

> On x86, the USB controllers don't typically live behind a PCIe-to-PCI
> bridge, so don't suffer the source identifier problem, but they do often
> share an interrupt.  But even then, we can count on most modern devices
> supporting PCI2.3, and thus the DisINTx feature, which allows us to
> share interrupts.  In any case, yes, it's more rare but we need to know
> how to handle devices behind PCI bridges.  However I disagree that we
> need to assign all the devices behind such a bridge to the guest.

Well, ok so let's dig a bit more here :-) First, yes I agree they don't
all need to appear to the guest. My point is really that we must prevent
them to be "used" by somebody else, either host or another guest.

Now once you get there, I personally prefer having a clear "group"
ownership rather than having devices stay in some "limbo" under vfio
control but it's an implementation detail.

Regarding DisINTx, well, it's a bit like putting separate PCIe functions
into separate guests, it looks good ... but you are taking a chance.
Note that I do intend to do some of that for power ... well I think, I
haven't completely made my mind.

pHyp for has a stricter requirement, PEs essentially are everything
behind a bridge. If you have a slot, you have some kind of bridge above
this slot and everything on it will be a PE.

The problem I see is that with your filtering of config space, BAR
emulation, DisINTx etc... you essentially assume that you can reasonably
reliably isolate devices. But in practice, it's chancy. Some devices for
example have "backdoors" into their own config space via MMIO. If I have
such a device in a guest, I can completely override your DisINTx and
thus DOS your host or another guest with a shared interrupt. I can move
my MMIO around and DOS another function by overlapping the addresses.

You can really only be protect yourself against a device if you have it
behind a bridge (in addition to having a filtering iommu), which limits
the MMIO span (and thus letting the guest whack the BARs randomly will
only allow that guest to shoot itself in the foot).

Some bridges also provide a way to block INTx below them which comes in
handy but it's bridge specific. Some devices can be coerced to send the
INTx "assert" message and never de-assert it (for example by doing a
soft-reset while it's asserted, which can be done with some devices with
an MMIO).

Anything below a PCIe -> PCI/PCI-X needs to also be "grouped" due to
simple lack of proper filtering by the iommu (PCI-X in theory has RIDs
and fowards them up, but this isn't very reliable, for example it fails
over with split transactions).

Fortunately in PCIe land, we most have bridges above everything. The
problem somewhat remains with functions of a device, how can you be sure
that there isn't a way via some MMIO to create side effects on the other
functions of the device ? (For example by checkstopping the whole
thing). You can't really :-)

So it boils down of the "level" of safety/isolation you want to provide,
and I suppose to some extent it's a user decision but the user needs to
be informed to some extent. A hard problem :-)
 
> There's a difference between removing the device from the host and
> exposing the device to the guest.  If I have a NIC and HBA behind a
> bridge, it's perfectly reasonable that I might only assign the NIC to
> the guest, but as you describe, we then need to prevent the host, or any
> other guest from making use of the HBA.

Yes. However the other device is in "limbo" and it may be not clear to
the user why it can't be used anymore :-)

The question is more, the user needs to "know" (or libvirt does, or
somebody ... ) that in order to pass-through device A, it must also
"remove" device B from the host. How can you even provide a meaningful
error message to the user if all VFIO does is give you something like
-EBUSY ?

So the information about the grouping constraint must trickle down
somewhat.

Look at it from a GUI perspective for example. Imagine a front-end
showing you devices in your system and allowing you to "Drag & drop"
them to your guest. How do you represent that need for grouping ? First
how do you expose it from kernel/libvirt to the GUI tool and how do you
represent it to the user ?

By grouping the devices in logical groups which end up being the
"objects" you can drag around, at least you provide some amount of
clarity. Now if you follow that path down to how the GUI app, libvirt
and possibly qemu need to know / resolve the dependency, being given the
"groups" as the primary information of what can be used for pass-through
makes everything a lot simpler.
 
> > - The -minimum- granularity of pass-through is not always a single
> > device and not always under SW control
> 
> But IMHO, we need to preserve the granularity of exposing a device to a
> guest as a single device.  That might mean some devices are held hostage
> by an agent on the host.

Maybe but wouldn't that be even more confusing from a user perspective ?
And I think it makes it harder from an implementation of admin &
management tools perspective too.

> > - Having a magic heuristic in libvirt to figure out those constraints is
> > WRONG. This reeks of XFree 4 PCI layer trying to duplicate the kernel
> > knowledge of PCI resource management and getting it wrong in many many
> > cases, something that took years to fix essentially by ripping it all
> > out. This is kernel knowledge and thus we need the kernel to expose in a
> > way or another what those constraints are, what those "partitionable
> > groups" are.
> > 
> > - That does -not- mean that we cannot specify for each individual device
> > within such a group where we want to put it in qemu (what devfn etc...).
> > As long as there is a clear understanding that the "ownership" of the
> > device goes with the group, this is somewhat orthogonal to how they are
> > represented in qemu. (Not completely... if the iommu is exposed to the
> > guest ,via paravirt for example, some of these constraints must be
> > exposed but I'll talk about that more later).
> 
> Or we can choose not to expose all of the devices in the group to the
> guest?

As I said, I don't mind if you don't, I'm just worried about the
consequences of that from a usability standpoint. Having advanced
command line option to fine tune is fine. Being able to specify within a
"group" which devices to show and at what address if fine.

But I believe the basic entity to be manipulated from an interface
standpoitn remains the group.

To get back to my GUI example, once you've D&D your group of devices
over, you can have the option to open that group and check/uncheck
individual devices & assign them addresses if you want. That doesn't
change the fact that practically speaking, the whole group is now owned
by the guest.

I will go further than that actually. If you look at how the isolation
HW works on POWER, the fact that I have the MMIO segmentation means that
I can simply give the entire group MMIO space to the guest. No problem
of small BARs, no need to slow-map them ... etc.. that's a pretty handy
feature don't you think ?

But that means that those other devices -will- be there, mapped along
with the one you care about. We may not expose it in config space but it
will be accessible. I suppose we can keep its IO/MEM decoding disabled.
But my point is that for all intend and purpose, it's actually owned by
the guest.

> > The interface currently proposed for VFIO (and associated uiommu)
> > doesn't handle that problem at all. Instead, it is entirely centered
> > around a specific "feature" of the VTd iommu's for creating arbitrary
> > domains with arbitrary devices (tho those devices -do- have the same
> > constraints exposed above, don't try to put 2 legacy PCI devices behind
> > the same bridge into 2 different domains !), but the API totally ignores
> > the problem, leaves it to libvirt "magic foo" and focuses on something
> > that is both quite secondary in the grand scheme of things, and quite
> > x86 VTd specific in the implementation and API definition.
> 
> To be fair, libvirt's "magic foo" is built out of the necessity that
> nobody else is defining the rules.

Sure, which is why I propose that the kernel exposes the rules since
it's really the one right place to have that sort of HW constraint
knowledge, especially since it can be partially at least platform
specific.
 
 .../...

> > Maybe something like /sys/devgroups ? This probably warrants involving
> > more kernel people into the discussion.
> 
> I don't yet buy into passing groups to qemu since I don't buy into the
> idea of always exposing all of those devices to qemu.  Would it be
> sufficient to expose iommu nodes in sysfs that link to the devices
> behind them and describe properties and capabilities of the iommu
> itself?  More on this at the end.

Well, iommu aren't the only factor. I mentioned shared interrupts (and
my unwillingness to always trust DisINTx), there's also the MMIO
grouping I mentioned above (in which case it's an x86 -limitation- with
small BARs that I don't want to inherit, especially since it's based on
PAGE_SIZE and we commonly have 64K page size on POWER), etc...

So I'm not too fan of making it entirely look like the iommu is the
primary factor, but we -can-, that would be workable. I still prefer
calling a cat a cat and exposing the grouping for what it is, as I think
I've explained already above, tho. 

 .../...

> > Now some of this can be fixed with tweaks, and we've started doing it
> > (we have a working pass-through using VFIO, forgot to mention that, it's
> > just that we don't like what we had to do to get there).
> 
> This is a result of wanting to support *unmodified* x86 guests.  We
> don't have the luxury of having a predefined pvDMA spec that all x86
> OSes adhere to. 

No but you could emulate a HW iommu no ?

>  The 32bit problem is unfortunate, but the priority use
> case for assigning devices to guests is high performance I/O, which
> usually entails modern, 64bit hardware.  I'd like to see us get to the
> point of having emulated IOMMU hardware on x86, which could then be
> backed by VFIO, but for now guest pinning is the most practical and
> useful.

For your current case maybe. It's just not very future proof imho.
Anyways, it's fixable, but the APIs as they are make it a bit clumsy.

 .../...

> > Also our next generation chipset may drop support for PIO completely.
> > 
> > On the other hand, because PIO is just a special range of MMIO for us,
> > we can do normal pass-through on it and don't need any of the emulation
> > done qemu.
> 
> Maybe we can add mmap support to PIO regions on non-x86.

We have to yes. I haven't looked into it yet, it should be easy if VFIO
kernel side starts using the "proper" PCI mmap interfaces in kernel (the
same interfaces sysfs & proc use).

> >   * MMIO constraints
> > 
> > The QEMU side VFIO code hard wires various constraints that are entirely
> > based on various requirements you decided you have on x86 but don't
> > necessarily apply to us :-)
> > 
> > Due to our paravirt nature, we don't need to masquerade the MSI-X table
> > for example. At all. If the guest configures crap into it, too bad, it
> > can only shoot itself in the foot since the host bridge enforce
> > validation anyways as I explained earlier. Because it's all paravirt, we
> > don't need to "translate" the interrupt vectors & addresses, the guest
> > will call hyercalls to configure things anyways.
> 
> With interrupt remapping, we can allow the guest access to the MSI-X
> table, but since that takes the host out of the loop, there's
> effectively no way for the guest to correctly program it directly by
> itself.

Right, I think what we need here is some kind of capabilities to
"disable" those "features" of qemu vfio.c that aren't needed on our
platform :-) Shouldn't be too hard. We need to make this runtime tho
since different machines can have different "capabilities".

> > We don't need to prevent MMIO pass-through for small BARs at all. This
> > should be some kind of capability or flag passed by the arch. Our
> > segmentation of the MMIO domain means that we can give entire segments
> > to the guest and let it access anything in there (those segments are a
> > multiple of the page size always). Worst case it will access outside of
> > a device BAR within a segment and will cause the PE to go into error
> > state, shooting itself in the foot, there is no risk of side effect
> > outside of the guest boundaries.
> 
> Sure, this could be some kind of capability flag, maybe even implicit in
> certain configurations.

Yup.

> > In fact, we don't even need to emulate BAR sizing etc... in theory. Our
> > paravirt guests expect the BARs to have been already allocated for them
> > by the firmware and will pick up the addresses from the device-tree :-)
> > 
> > Today we use a "hack", putting all 0's in there and triggering the linux
> > code path to reassign unassigned resources (which will use BAR
> > emulation) but that's not what we are -supposed- to do. Not a big deal
> > and having the emulation there won't -hurt- us, it's just that we don't
> > really need any of it.
> > 
> > We have a small issue with ROMs. Our current KVM only works with huge
> > pages for guest memory but that is being fixed. So the way qemu maps the
> > ROM copy into the guest address space doesn't work. It might be handy
> > anyways to have a way for qemu to use MMIO emulation for ROM access as a
> > fallback. I'll look into it.
> 
> So that means ROMs don't work for you on emulated devices either?  The
> reason we read it once and map it into the guest is because Michael
> Tsirkin found a section in the PCI spec that indicates devices can share
> address decoders between BARs and ROM.

Yes, he is correct.

>   This means we can't just leave
> the enabled bit set in the ROM BAR, because it could actually disable an
> address decoder for a regular BAR.  We could slow-map the actual ROM,
> enabling it around each read, but shadowing it seemed far more
> efficient.

Right. We can slow map the ROM, or we can not care :-) At the end of the
day, what is the difference here between a "guest" under qemu and the
real thing bare metal on the machine ? IE. They have the same issue vs.
accessing the ROM. IE. I don't see why qemu should try to make it safe
to access it at any time while it isn't on a real machine. Since VFIO
resets the devices before putting them in guest space, they should be
accessible no ? (Might require a hard reset for some devices tho ... )

In any case, it's not a big deal and we can sort it out, I'm happy to
fallback to slow map to start with and eventually we will support small
pages mappings on POWER anyways, it's a temporary limitation.

> >   * EEH
> > 
> > This is the name of those fancy error handling & isolation features I
> > mentioned earlier. To some extent it's a superset of AER, but we don't
> > generally expose AER to guests (or even the host), it's swallowed by
> > firmware into something else that provides a superset (well mostly) of
> > the AER information, and allow us to do those additional things like
> > isolating/de-isolating, reset control etc...
> > 
> > Here too, we'll need arch specific APIs through VFIO. Not necessarily a
> > huge deal, I mention it for completeness.
> 
> We expect to do AER via the VFIO netlink interface, which even though
> its bashed below, would be quite extensible to supporting different
> kinds of errors.

As could platform specific ioctls :-)

> >    * Misc
> > 
> > There's lots of small bits and pieces... in no special order:
> > 
> >  - netlink ? WTF ! Seriously, we don't need a hybrid API with a bit of
> > netlink and a bit of ioctl's ... it's not like there's something
> > fundamentally  better for netlink vs. ioctl... it really depends what
> > you are doing, and in this case I fail to see what netlink brings you
> > other than bloat and more stupid userspace library deps.
> 
> The netlink interface is primarily for host->guest signaling.  I've only
> implemented the remove command (since we're lacking a pcie-host in qemu
> to do AER), but it seems to work quite well.  If you have suggestions
> for how else we might do it, please let me know.  This seems to be the
> sort of thing netlink is supposed to be used for.

I don't understand what the advantage of netlink is compared to just
extending your existing VFIO ioctl interface, possibly using children
fd's as we do for example with spufs but it's not a huge deal. It just
that netlink has its own gotchas and I don't like multi-headed
interfaces.

> >  - I don't like too much the fact that VFIO provides yet another
> > different API to do what we already have at least 2 kernel APIs for, ie,
> > BAR mapping and config space access. At least it should be better at
> > using the backend infrastructure of the 2 others (sysfs & procfs). I
> > understand it wants to filter in some case (config space) and -maybe-
> > yet another API is the right way to go but allow me to have my doubts.
> 
> The use of PCI sysfs is actually one of my complaints about current
> device assignment.  To do assignment with an unprivileged guest we need
> to open the PCI sysfs config file for it, then change ownership on a
> handful of other PCI sysfs files, then there's this other pci-stub thing
> to maintain ownership, but the kvm ioctls don't actually require it and
> can grab onto any free device...  We are duplicating some of that in
> VFIO, but we also put the ownership of the device behind a single device
> file.  We do have the uiommu problem that we can't give an unprivileged
> user ownership of that, but your usage model may actually make that
> easier.  More below...
> 
> > One thing I thought about but you don't seem to like it ... was to use
> > the need to represent the partitionable entity as groups in sysfs that I
> > talked about earlier. Those could have per-device subdirs with the usual
> > config & resource files, same semantic as the ones in the real device,
> > but when accessed via the group they get filtering. I might or might not
> > be practical in the end, tbd, but it would allow apps using a slightly
> > modified libpci for example to exploit some of this.
> 
> I may be tainted by our disagreement that all the devices in a group
> need to be exposed to the guest and qemu could just take a pointer to a
> sysfs directory.  That seems very unlike qemu and pushes more of the
> policy into qemu, which seems like the wrong direction.

I don't see how it pushes "policy" into qemu.

The "policy" here is imposed by the HW setup and exposed by the
kernel :-) Giving qemu a group means qemu takes "owership" of that bunch
of devices, so far I don't see what's policy about that. From there, it
would be "handy" for people to just stop there and just see all the
devices of the group show up in the guest, but by all means feel free to
suggest a command line interface that allows to more precisely specify
which of the devices in the group to pass through and at what address.

> >  - The qemu vfio code hooks directly into ioapic ... of course that
> > won't fly with anything !x86
> 
> I spent a lot of time looking for an architecture neutral solution here,
> but I don't think it exists.  Please prove me wrong.

No it doesn't I agree, that's why it should be some kind of notifier or
function pointer setup by the platform specific code.

>   The problem is
> that we have to disable INTx on an assigned device after it fires (VFIO
> does this automatically).  If we don't do this, a non-responsive or
> malicious guest could sit on the interrupt, causing it to fire
> repeatedly as a DoS on the host.  The only indication that we can rely
> on to re-enable INTx is when the guest CPU writes an EOI to the APIC.
> We can't just wait for device accesses because a) the device CSRs are
> (hopefully) direct mapped and we'd have to slow map them or attempt to
> do some kind of dirty logging to detect when they're accesses b) what
> constitutes an interrupt service is device specific.
> 
> That means we need to figure out how PCI interrupt 'A' (or B...)
> translates to a GSI (Global System Interrupt - ACPI definition, but
> hopefully a generic concept).  That GSI identifies a pin on an IOAPIC,
> which will also see the APIC EOI.  And just to spice things up, the
> guest can change the PCI to GSI mappings via ACPI.  I think the set of
> callbacks I've added are generic (maybe I left ioapic in the name), but
> yes they do need to be implemented for other architectures.  Patches
> appreciated from those with knowledge of the systems and/or access to
> device specs.  This is the only reason that I make QEMU VFIO only build
> for x86.

Right, and we need to cook a similiar sauce for POWER, it's an area that
has to be arch specific (and in fact specific to the specific HW machine
being emulated), so we just need to find out what's the cleanest way for
the plaform to "register" the right callbacks here.

Not a big deal, I just felt like mentioning it :-)

> >  - The various "objects" dealt with here, -especially- interrupts and
> > iommu, need a better in-kernel API so that fast in-kernel emulation can
> > take over from qemu based emulation. The way we need to do some of this
> > on POWER differs from x86. We can elaborate later, it's not necessarily
> > a killer either but essentially we'll take the bulk of interrupt
> > handling away from VFIO to the point where it won't see any of it at
> > all.
> 
> The plan for x86 is to connect VFIO eventfds directly to KVM irqfds and
> bypass QEMU.  This is exactly what VHOST does today and fairly trivial
> to enable for MSI once we get it merged.  INTx would require us to be
> able to define a level triggered irqfd in KVM and it's not yet clear if
> we care that much about INTx performance.

I care enough because our exit cost to qemu is much higher than x86, and
I can pretty easily emulate my PIC entirely in real mode (from within
the guest context) which is what I intend to do :-)

On the other hand, I have no reason to treat MSI or LSI differently, so
all I really need to is get back to the underlying platform HW interrupt
number and I think I can do that. So as long as I have a hook to know
what's there and what has been enabled, thse interrupts will simply
cease to be visible to either qemu or vfio.

Another reason why I don't like allowing shared interrupts in differrent
guests with DisINTx :-) Because that means that such interrupts would
have to go back all the way to qemu/vfio :-) But I can always have a
fallback there, it's really the problem of "trusting" DisINTx that
concerns me.

> We don't currently have a plan for accelerating IOMMU access since our
> current usage model doesn't need one.  We also need to consider MSI-X
> table acceleration for x86.  I hope we'll be able to use the new KVM
> ioctls for this.

Ok, we can give direct access to the MSI-X table to the guest on power
so that isn't an issue for us.

> Thanks for the write up, I think it will be good to let everyone digest
> it before we discuss this at KVM forum.

Agreed. As I think I may have mentioned already, I won't be able to make
it to the forum, but Paulus will and I'll be in a closeby timezone, so I
might be able to join a call if it's deemed useful.

> Rather than your "groups" idea, I've been mulling over whether we can
> just expose the dependencies, configuration, and capabilities in sysfs
> and build qemu commandlines to describe it.  For instance, if we simply
> start with creating iommu nodes in sysfs, we could create links under
> each iommu directory to the devices behind them.  Some kind of
> capability file could define properties like whether it's page table
> based or fixed iova window or the granularity of mapping the devices
> behind it.  Once we have that, we could probably make uiommu attach to
> each of those nodes.

Well, s/iommu/groups and you are pretty close to my original idea :-)

I don't mind that much what the details are, but I like the idea of not
having to construct a 3-pages command line every time I want to
pass-through a device, most "simple" usage scenario don't care that
much.

> That means we know /dev/uiommu7 (random example) is our access to a
> specific iommu with a given set of devices behind it.

Linking those sysfs iommus or groups to a /dev/ entry is fine by me.
  
>   If that iommu is
> a PE (via those capability files), then a user space entity (trying hard
> not to call it libvirt) can unbind all those devices from the host,
> maybe bind the ones it wants to assign to a guest to vfio and bind the
> others to pci-stub for safe keeping.  If you trust a user with
> everything in a PE, bind all the devices to VFIO, chown all
> the /dev/vfioX entries for those devices, and the /dev/uiommuX device.
>
> We might then come up with qemu command lines to describe interesting
> configurations, such as:
> 
> -device iommu,model=PAPR,uiommu=/dev/uiommu7,id=iommu.0 \
> -device pci-bus,...,iommu=iommu0,id=pci.0 \
> -device vfio,host=ssss:bb:dd.f,bus=pci.0,addr=dd.f,id=hostdev0
> 
> The userspace entity would obviously need to put things in the same PE
> in the right place, but it doesn't seem to take a lot of sysfs info to
> get that right.
> 
> Today we do DMA mapping via the VFIO device because the capabilities of
> the IOMMU domains change depending on which devices are connected (for
> VT-d, the least common denominator of the IOMMUs in play).  Forcing the
> DMA mappings through VFIO naturally forces the call order.  If we moved
> to something like above, we could switch the DMA mapping to the uiommu
> device, since the IOMMU would have fixed capabilities.

That makes sense.

> What gaps would something like this leave for your IOMMU granularity
> problems?  I'll need to think through how it works when we don't want to
> expose the iommu to the guest, maybe a model=none (default) that doesn't
> need to be connected to a pci bus and maps all guest memory.  Thanks,

Well, I would map those "iommus" to PEs, so what remains is the path to
put all the "other" bits and pieces such as inform qemu of the location
and size of the MMIO segment(s) (so we can map the whole thing and not
bother with individual BARs) etc... 

Cheers,
Ben.
