Date: Thu, 29 Jul 2004 22:33:19 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [0/9] Support for old IBM PReP boxes
Message-ID: <20040729213319.GA5857@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This set of patches add support for old IBM PReP machines.  They are
not perfect, but they are known working on the E20, E30, 140, 240
and F30.  The F40 is not currently working, but it doesn't work at
all without these patches so I'm not too concerned right now.

As 060-old-openpic.diff has not shown up any problems on any machines
I think it's worth applying, but if Tom is still unhappy then it can
be left for now.

Summary:

[1/9] 005-have-residual-data.diff

Introduce have_residual_data() function and change existing code to
use it.  This is mainly to avoid my additions adding loads of ugly
#ifdef CONFIG_RESIDUAL_DATA sections.

[2/9] 020-ibm_prep_statusled.diff

This allows use of the IBM status LED if it's found in the residual
data, plus a couple of other bells and whistles.  It removes the
140-specific code.

[3/9] 040-residual-pcidev.diff

This adds a function to use the residual data to determine the IRQ
for a given PCI device, and changes prep_pcibios_fixup() to use it.

[4/9] 045-residual-irqmask.diff

This adds a function to determine the 8259 level/edge mask word.
With this function we can now (in theory) support any IBM PReP
machine.  We therefore add a little bit more code to fallback
to using residual data if we don't recognise the machine.

[5/9] 050-residual-isapic-addr.diff

This adds a function to use the residual data to determine the
address to pass to i8259_init().

[6/9] 055-host-bridge.diff

This adds support for the "PCIBridgeRS6K" bridge type in residual
data to prep_find_bridges() - this is for the 7043-240.

[7/9] 060-old-openpic.diff

Some older E20/E30 machines have a very old implementation of the
OpenPIC which trips up the existing ibm_prep_init() function.  This
adds support for it.  It also changes the OPENPIC_VEC_SPURIOUS
constant to work around the buggy OpenPIC in those machines.

[8/9] 080-shorter-planar-id.diff

The planar id is only a byte, so why waste 8 characters displaying
it?

[9/9] 090-show-level.diff

This makes the /proc/interrupts display the correct edge/level
indicator for each interrupt.  This is purely cosmetic, but does
reduce confusion.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
