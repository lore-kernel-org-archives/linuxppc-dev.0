Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:11:30 +1100
Subject: [RFC/PATCH 0/10] powerpc: PCI updates & merges
Message-Id: <1196928690.864849.322811660859.qpush@grosgo>
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

Note that the patch that updates 4xx platforms to enable full resource
assignments applied on top of my 4xx series for which I'll post a new
version soon. You can apply the other ones and ignore this one if you
want to test on some other platform without the other patch serie.
