Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B62AFB7199
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 12:01:14 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
In-Reply-To: <1312225174.2653.352.camel@bling.home>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<1312070097.8793.786.camel@pasglop>
	<1312225174.2653.352.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Aug 2011 12:00:45 +1000
Message-ID: <1312250445.8793.860.camel@pasglop>
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

On Mon, 2011-08-01 at 12:59 -0600, Alex Williamson wrote:

> >  
> >  .../...
> 
> I'll try to consolidate my reply to all the above here because there are
> too many places above to interject and make this thread even more
> difficult to respond to.

True, I should try to do the same :-)

>   Much of what you're discussion above comes
> down to policy.  Do we trust DisINTx?  Do we trust multi-function
> devices?  I have no doubt there are devices we can use as examples for
> each behaving badly.  On x86 this is one of the reasons we have SR-IOV.

Right, that and having the ability to provide way more functions that
you would normally have.

> Besides splitting a single device into multiple, it makes sure each
> devices is actually virtualization friendly.  POWER seems to add
> multiple layers of hardware so that you don't actually have to trust the
> device, which is a great value add for enterprise systems, but in doing
> so it mostly defeats the purpose and functionality of SR-IOV.

Well not entirely. A lot of what POWER does is also about isolation on
errors. This is going to be useful with and without SR-IOV. Also not all
devices are SR-IOV capable and there are plenty of situations where one
would want to pass-through devices that aren't, I don't see that as
disappearing tomorrow.

> How we present this in a GUI is largely irrelevant because something has
> to create a superset of what the hardware dictates (can I uniquely
> identify transactions from this device, can I protect other devices from
> it, etc.), the system policy (do I trust DisINTx, do I trust function
> isolation, do I require ACS) and mold that with what the user actually
> wants to assign.  For the VFIO kernel interface, we should only be
> concerned with the first problem.  Userspace is free to make the rest as
> simple or complete as it cares to.  I argue for x86, we want device
> level granularity of assignment, but that also tends to be the typical
> case (when only factoring in hardware restrictions) due to our advanced
> iommus.

Well, POWER iommu's are advanced too ... just in a different way :-) x86
seems to be a lot less interested in robustness and reliability for
example :-)

I tend to agree that the policy decisions in general should be done by
the user, tho with appropriate information :-)

But some of them on our side are hard requirements imposed by how our
firmware or early kernel code assigned the PE's and we need to expose
that. It directly derives the sharing of iommu's too but then we -could-
have those different iommu's point to the same table in memory and
essentially mimmic the x86 domains. We chose not to. The segments are
too small in our current HW design for one and it means we lose the
isolation between devices which is paramount to getting the kind of
reliability and error handling we want to achieve. 

> > > > Maybe something like /sys/devgroups ? This probably warrants involving
> > > > more kernel people into the discussion.
> > > 
> > > I don't yet buy into passing groups to qemu since I don't buy into the
> > > idea of always exposing all of those devices to qemu.  Would it be
> > > sufficient to expose iommu nodes in sysfs that link to the devices
> > > behind them and describe properties and capabilities of the iommu
> > > itself?  More on this at the end.
> > 
> > Well, iommu aren't the only factor. I mentioned shared interrupts (and
> > my unwillingness to always trust DisINTx),
> 
> *userspace policy*

Maybe ... some of it yes. I suppose. You can always hand out to
userspace bigger guns to shoot itself in the foot. Not always very wise
but heh.

Some of these are hard requirements tho. And we have to make that
decision when we assign PE's at boot time.

> >  there's also the MMIO
> > grouping I mentioned above (in which case it's an x86 -limitation- with
> > small BARs that I don't want to inherit, especially since it's based on
> > PAGE_SIZE and we commonly have 64K page size on POWER), etc...
> 
> But isn't MMIO grouping effectively *at* the iommu?

No exactly. It's a different set of tables & registers in the host
bridge and essentially a different set of logic, tho it does hook into
the whole "shared PE# state" thingy to enforce isolation of all layers
on error.

> > So I'm not too fan of making it entirely look like the iommu is the
> > primary factor, but we -can-, that would be workable. I still prefer
> > calling a cat a cat and exposing the grouping for what it is, as I think
> > I've explained already above, tho. 
> 
> The trouble is the "group" analogy is more fitting to a partitionable
> system, whereas on x86 we can really mix-n-match devices across iommus
> fairly easily.  The iommu seems to be the common point to describe these
> differences.

No. You can do that by throwing away isolation between those devices and
thus throwing away error isolation capabilities as well. I suppose if
you don't care about RAS... :-)

> > > > Now some of this can be fixed with tweaks, and we've started doing it
> > > > (we have a working pass-through using VFIO, forgot to mention that, it's
> > > > just that we don't like what we had to do to get there).
> > > 
> > > This is a result of wanting to support *unmodified* x86 guests.  We
> > > don't have the luxury of having a predefined pvDMA spec that all x86
> > > OSes adhere to. 
> > 
> > No but you could emulate a HW iommu no ?
> 
> We can, but then we have to worry about supporting legacy, proprietary
> OSes that may not have support or may make use of it differently.  As
> Avi mentions, hardware is coming the eases the "pin the whole guest"
> requirement and we may implement emulated iommus for the benefit of some
> guests.

That's a pipe dream :-) It will take a LONG time before a reasonable
proportion of devices does this in a reliable way I believe.

> > >  The 32bit problem is unfortunate, but the priority use
> > > case for assigning devices to guests is high performance I/O, which
> > > usually entails modern, 64bit hardware.  I'd like to see us get to the
> > > point of having emulated IOMMU hardware on x86, which could then be
> > > backed by VFIO, but for now guest pinning is the most practical and
> > > useful.
> > 
> > For your current case maybe. It's just not very future proof imho.
> > Anyways, it's fixable, but the APIs as they are make it a bit clumsy.
> 
> You expect more 32bit devices in the future?

Got knows what embedded ARM folks will come up with :-) I wouldn't
dismiss that completely. I do expect to have to deal with OHCI for a
while tho.

> > > > Also our next generation chipset may drop support for PIO completely.
> > > > 
> > > > On the other hand, because PIO is just a special range of MMIO for us,
> > > > we can do normal pass-through on it and don't need any of the emulation
> > > > done qemu.
> > > 
> > > Maybe we can add mmap support to PIO regions on non-x86.
> > 
> > We have to yes. I haven't looked into it yet, it should be easy if VFIO
> > kernel side starts using the "proper" PCI mmap interfaces in kernel (the
> > same interfaces sysfs & proc use).
> 
> Patches welcome.

Sure, we do plan to send patches for a lot of those things as we get
there, I'm just chosing to mention all the issues at once here and we
haven't go to fixing -that- just yet.
 
 .../...

> > Right. We can slow map the ROM, or we can not care :-) At the end of the
> > day, what is the difference here between a "guest" under qemu and the
> > real thing bare metal on the machine ? IE. They have the same issue vs.
> > accessing the ROM. IE. I don't see why qemu should try to make it safe
> > to access it at any time while it isn't on a real machine. Since VFIO
> > resets the devices before putting them in guest space, they should be
> > accessible no ? (Might require a hard reset for some devices tho ... )
> 
> My primary motivator for doing the ROM the way it's done today is that I
> get to push all the ROM handling off to QEMU core PCI code.  The ROM for
> an assigned device is handled exactly like the ROM for an emulated
> device except it might be generated by reading it from the hardware.
> This gives us the benefit of things like rombar=0 if I want to hide the
> ROM or romfile=<file> if I want to load an ipxe image for a device that
> may not even have a physical ROM.  Not to mention I don't have to
> special case ROM handling routines in VFIO.  So it actually has little
> to do w/ making it safe to access the ROM at any time.

On the other hand, let's hope no device has side effects on the ROM and
expects to exploit them :-) Do we know how ROM/flash updates work for
devices in practice ? Do they expect to be able to write to the ROM BAR
or they always use a different MMIO based sideband access ?
 
> > In any case, it's not a big deal and we can sort it out, I'm happy to
> > fallback to slow map to start with and eventually we will support small
> > pages mappings on POWER anyways, it's a temporary limitation.
> 
> Perhaps this could also be fixed in the generic QEMU PCI ROM support so
> it works for emulated devices too... code reuse paying off already ;)

Heh, I think emulation works.

> > > >   * EEH
> > > > 
> > > > This is the name of those fancy error handling & isolation features I
> > > > mentioned earlier. To some extent it's a superset of AER, but we don't
> > > > generally expose AER to guests (or even the host), it's swallowed by
> > > > firmware into something else that provides a superset (well mostly) of
> > > > the AER information, and allow us to do those additional things like
> > > > isolating/de-isolating, reset control etc...
> > > > 
> > > > Here too, we'll need arch specific APIs through VFIO. Not necessarily a
> > > > huge deal, I mention it for completeness.
> > > 
> > > We expect to do AER via the VFIO netlink interface, which even though
> > > its bashed below, would be quite extensible to supporting different
> > > kinds of errors.
> > 
> > As could platform specific ioctls :-)
> 
> Is qemu going to poll for errors?

I wouldn't mind eventfd + ioctl, I really don't like netlink :-) But
others might disagree with me here. However that's not really my
argument, see below...

> > I don't understand what the advantage of netlink is compared to just
> > extending your existing VFIO ioctl interface, possibly using children
> > fd's as we do for example with spufs but it's not a huge deal. It just
> > that netlink has its own gotchas and I don't like multi-headed
> > interfaces.
> 
> We could do yet another eventfd that triggers the VFIO user to go call
> an ioctl to see what happened, but then we're locked into an ioctl
> interface for something that we may want to more easily extend over
> time.  As I said, it feels like this is what netlink is for and the
> arguments against seem to be more gut reaction.

My argument here is we already have an fd open, ie, we already have a
communication open to vfio as a chardev, I don't like the idea of
creating -another- one.

> Hmm... it is.  I added a pci_get_irq() that returns a
> platform/architecture specific translation of a PCI interrupt to it's
> resulting system interrupt.  Implement this in your PCI root bridge.
> There's a notifier for when this changes, so vfio will check
> pci_get_irq() again, also to be implemented in the PCI root bridge code.
> And a notifier that gets registered with that system interrupt and gets
> notice for EOI... implemented in x86 ioapic, somewhere else for power.

Let's leave this one alone, we'll fix it a way or another and we can
discuss the patches when it comes down to it.

> > >   The problem is
> > > that we have to disable INTx on an assigned device after it fires (VFIO
> > > does this automatically).  If we don't do this, a non-responsive or
> > > malicious guest could sit on the interrupt, causing it to fire
> > > repeatedly as a DoS on the host.  The only indication that we can rely
> > > on to re-enable INTx is when the guest CPU writes an EOI to the APIC.
> > > We can't just wait for device accesses because a) the device CSRs are
> > > (hopefully) direct mapped and we'd have to slow map them or attempt to
> > > do some kind of dirty logging to detect when they're accesses b) what
> > > constitutes an interrupt service is device specific.
> > > 
> > > That means we need to figure out how PCI interrupt 'A' (or B...)
> > > translates to a GSI (Global System Interrupt - ACPI definition, but
> > > hopefully a generic concept).  That GSI identifies a pin on an IOAPIC,
> > > which will also see the APIC EOI.  And just to spice things up, the
> > > guest can change the PCI to GSI mappings via ACPI.  I think the set of
> > > callbacks I've added are generic (maybe I left ioapic in the name), but
> > > yes they do need to be implemented for other architectures.  Patches
> > > appreciated from those with knowledge of the systems and/or access to
> > > device specs.  This is the only reason that I make QEMU VFIO only build
> > > for x86.
> > 
> > Right, and we need to cook a similiar sauce for POWER, it's an area that
> > has to be arch specific (and in fact specific to the specific HW machine
> > being emulated), so we just need to find out what's the cleanest way for
> > the plaform to "register" the right callbacks here.
> 
> Aside from the ioapic, I hope it's obvious hooks in the PCI root bridge
> emulation.

Yeah, we'll see, whatever we come up with and we discuss the details
then :-)

>  Thanks,
> > 
> > Well, I would map those "iommus" to PEs, so what remains is the path to
> > put all the "other" bits and pieces such as inform qemu of the location
> > and size of the MMIO segment(s) (so we can map the whole thing and not
> > bother with individual BARs) etc... 
> 
> My assumption is that PEs are largely defined by the iommus already.
> Are MMIO segments a property of the iommu too?  Thanks,

Not exactly but it's all tied together. See my other replies.

Cheers,
Ben.
