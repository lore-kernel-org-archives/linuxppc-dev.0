Message-ID: <3BB4B6D8.44DA5A35@we.mediaone.net>
Date: Fri, 28 Sep 2001 10:43:52 -0700
From: Dan Taylor <danieltaylor@we.mediaone.net>
Reply-To: danieltaylor@acm.org
MIME-Version: 1.0
To: mgreer@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: double host bridges
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Greer wrote:

> With the gt64260, BOTH hoses are considered PCI bus 0 so when generating the
> config addr that gets passed to the bridge for the second hose, you have to
> subtract out the number of buses on the first hose.  That's the problem being
> solved here.
>
> Now that I've said all that, I think I've just found a way to set the bus
> number of the second hose so, if it works, all of this becomes moot.
>
> Mark
>

I faced the same problem using a GT on another project.

Although you have to use "bus 0", to run config cycles, that does not mean
that you have to use the pci_dev->pci_bus->number.  PCI bus numbers assigned
to each side of GT must be contiguous, but that does not mean that they
must be contigous from 0.  Nothing in that chip, or the PCI bus spec, prevents
you from assigning the pci_bus->number for the host bridge-attached busses as
0 and 1.  However, the pci_bus->primary can be 0 for both of them ( which works
even if the numbers are 0 and "whatever"; I just like using the lowest numbers
for host bridges. ). As host bridges, the code for them is hardware-specific,
anyway, so the primary number is meaningless.  Perhaps we (linux developers
in general) should agree on an "overloaded" value, or type of value, to be
assigned to pci_bus->primary for host bridges, but host bridges are special
cases, so it may not be worth the effort.

I implemented a system with a MPC106 and a GT64180 this way; the '106 was bus
0 and the GT was bus 1.  The really fun part was that there was a non-standard
PCI-PCI bridge as a secondary on the GT, with standard PCI-PCI bridge support
on its secondary.  There was more than a little special-case code there, but
the device drivers didn't have to be modified; it was all handled in the arch-
specific part of the kernel.

Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
