Message-ID: <39F8B44B.7980796@mvista.com>
Date: Thu, 26 Oct 2000 15:46:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Early PCI auto-configuration
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[The discussion below is based on the latest fsmlabs 5005 repository
code]

Disclaimer: I'm fairly new to linux PPC so my apologies if this has been
discussed before.


My problem:  The firmware on a couple platform I need to support do
absolutely _no_ PCI device initialization.

To make things work for these boards in the current setup, I need to use
one of the pcibios_fixup() or pcibios_fixup_bus() hooks to walk the
entire bus tree, setup the devices (including bridges), and sort out all
the stuff that's already been put in the the "resource" entries--or am I
missing something??

I would prefer to run a "pci auto-configurator" that sets up all the
devices and bridges before pci_init() runs so I don't waste as much time
reading bad info and they trying to fix it all up later.  The "fixup"
routines can still be used for minor tweaks and interrupt routing, etc.

I was thinking of doing it this ways...

>From the xxx_find_bridges() routine, call "pci_auto_scan_hose()" which
walks the entire bus hierarchy under each "hose" sorting out resources,
enumerating the buses, setting up bridges and their bounds, etc.
pci_init() will run some time later and pick up reasonable BAR values.

To make this work, I will add 4 fields to the pci_controller [or "hose"]
structure that have the upper and lower bounds for PCI I/O and memory
space for each hose.  This is what the auto-configurator will use to
constrain his resource allocations.

Also, while I'm at it, add 2 more fields to pci_controller, one an array
of 32*8 int's that contian the devfn value of any devfn's that the
auto-configurator should skip.  The other is the number of valid entries
in the array.  This is useful--to me anyway--because I want the
auto-configurator to skip the host bridge itself.  Also, on some
platforms, the host bridge also has an external IDSEL line that is
hooked up to a PCI address line.  Some bridges can not handle having
themselves selected so that device needs to be skipped.

Any comments?  Is there a better way?  Am I getting carried away?

Thanks,

Mark

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
