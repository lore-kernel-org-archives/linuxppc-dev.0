From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mgreer@mvista.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Early PCI auto-configuration
Date: Fri, 27 Oct 2000 01:26:59 +0200
Message-Id: <19340920165843.29028@192.168.1.10>
In-Reply-To: <39F8B44B.7980796@mvista.com>
References: <39F8B44B.7980796@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>[The discussion below is based on the latest fsmlabs 5005 repository
>code]

You mean linuxppc_2_5, I guess ?

>My problem:  The firmware on a couple platform I need to support do
>absolutely _no_ PCI device initialization.
>
>To make things work for these boards in the current setup, I need to use
>one of the pcibios_fixup() or pcibios_fixup_bus() hooks to walk the
>entire bus tree, setup the devices (including bridges), and sort out all
>the stuff that's already been put in the the "resource" entries--or am I
>missing something??

Well, if you set pci_assign_all_busses to 1 before pci_init() (do it
during your setup_arch, when creating your hose), the kernel will at
least setup bus numbers for you.

You still have to handle allocation of device resources. The current code
has no per-hose resources that would allow the common PPC PCI code to
then assign resources to devices on the bus. So you need your own at
fixup time.

>I would prefer to run a "pci auto-configurator" that sets up all the
>devices and bridges before pci_init() runs so I don't waste as much time
>reading bad info and they trying to fix it all up later.  The "fixup"
>routines can still be used for minor tweaks and interrupt routing, etc.

Well, the kernel can behave quite well with unconfigured devices as long
as your implementation of pcibios_enable_device() configures it. Of
course, you need to configure the interrupt controller and other such
vital devices early.

>I was thinking of doing it this ways...
>
>From the xxx_find_bridges() routine, call "pci_auto_scan_hose()" which
>walks the entire bus hierarchy under each "hose" sorting out resources,
>enumerating the buses, setting up bridges and their bounds, etc.
>pci_init() will run some time later and pick up reasonable BAR values.

There is no reason to do it at this point since the pci_scan_bus() can
assign bus numbers and have no trouble with wrong resources.

>To make this work, I will add 4 fields to the pci_controller [or "hose"]
>structure that have the upper and lower bounds for PCI I/O and memory
>space for each hose.  This is what the auto-configurator will use to
>constrain his resource allocations.

That's what I call per-hose resource. That's I think the good way, but
_please_, if you implement that, support multiple (disconiuous) resources
per hose ;) On PowerMac, for example, we have a theorical limit of
something like 28 decoded memory ranges :) In real life, I don't think
we'll have more than 2 or 3 of them on a given bus however.

Then, you could implement your autoconfigurator (triggered via a global
that defaults to 0, something like pci_assign_all_devices) just after the
pci_scan_bus() pass.

But if I understand Geert code correctly, except for IDE devices & VGA
cards, the pcibios_assign_resources() function will assign bases
addresses to unassigned devices. This is done by the call to
pcibios_assign_resources(), and works if your bus resources & ranges have
been setup properly.

You may still need some fixup around, I'm really curious about what is
needed, and if the exception done for IDE & VGA cannot be changed to be
special "rules" of the PPC common pci code that would be enabled by
setup_arch().

You may also want to look at pci_assign_unassigned_resources() (in
drivers/pci/setup-res.c) and friends. They do things a bit differently,
but it might match more closely what you want.

>Also, while I'm at it, add 2 more fields to pci_controller, one an array
>of 32*8 int's that contian the devfn value of any devfn's that the
>auto-configurator should skip.

That's a good idea to handle the special cases discussed above, like
skipping VGA & IDE on some machines.

>The other is the number of valid entries
>in the array.  This is useful--to me anyway--because I want the
>auto-configurator to skip the host bridge itself.  Also, on some
>platforms, the host bridge also has an external IDSEL line that is
>hooked up to a PCI address line.  Some bridges can not handle having
>themselves selected so that device needs to be skipped.
>
Please, keep me in contact, I'm really interested in what you end up doing.

Regards,
Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
