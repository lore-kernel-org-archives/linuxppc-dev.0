Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:54:41 +1100
Subject: [PATCH 0/19] [POWERPC] PCI updates & merges
Message-Id: <1198122881.874131.56762399546.qpush@grosgo>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This serie of patches converts the 32 bits PCI code to use the generic
pci_assign_unassigned_resources() instead of its own assignment code
which was unable to deal with unassigned PCI<->PCI bridges among
other issues.

It then merges the resource fixup and allocation code between 32 and
64 bits (mostly making 64 bits use the 32 bits code with a few fixups),
hopefully fixing the longstanding issue that not setting pci_probe_only
on ppc64 would generally not work.

We also add flags to control the behaviour of the PCI code, such as
letting some platforms force a full re-assignment (similar to what
pci-auto used to provide in arch/ppc) and remove a whole bunch of
hackish code that is made obsolete by that change.

32 bits platforms with 64 bits resources support will also need my
separate patch to fix the generic setup-bus.c for that situation.

Finally, I also merge the implementations of pcibios_enable_device()
and fixup the PowerMac code that used hooks in that area in ways
that don't work anymore and cleans up a few PowerMac related bits
and pieces.

Note that this wasn't properly tested with hotplug on pSeries as I
have been unable to get it working for other reasons. If there is
a problem there, we'll attempt to fix it with additional patches.
