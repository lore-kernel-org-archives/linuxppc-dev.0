Message-ID: <1798.80.7.99.14.1086885931.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 17:45:31 +0100 (BST)
Subject: [RFC][PATCH 0/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've finally tidied up these patches enough that they are ready for
review.  I still need to do a bit of regression testing with this
updated collection, but I can be doing that while people chew on
them.

The main thrust of the patches is to add code to use residual data
instead of hard-coded tables in the machine setup.  Here's a summary:

005-have-residual-data.diff

Introduce have_residual_data() function and change existing code to
use it.  This is mainly to make my additions look a bit prettier.

020-ibm_prep_statusled.diff

This allows use of the IBM status LED if it's found in the residual
data, plus a couple of other bells and whistles.

040-residual-pcidev.diff

This adds a function to use the residual data to determine the IRQ
for a given PCI device, and changes prep_pcibios_fixup() to use it.

045-residual-irqmask.diff

This adds a function to determine the 8259 level/edge mask word.
With this function we can now (in theory) support any IBM PReP
machine.  We therefore add a little bit more code to fallback
to using residual data if we don't recognise the machine.

050-residual-isapic-addr.diff

This adds a function to use the residual data to determine the
address to pass to i8259_init().

055-host-bridge.diff

This adds support for the "PCIBridgeRS6K" bridge type in residual
data to prep_find_bridges() - this is for the 7043-240, iirc.

060-old-openpic.diff

Some older E20/E30 machines have a very old implementation of the
OpenPIC which trips up the existing ibm_prep_init() function.  This
adds support for it.  It also changes the OPENPIC_VEC_SPURIOUS
constant to work around the buggy OpenPIC in those machines.

070-non-zero-cpu.diff

Some 7043-240's and possibly 7025-F40's seem to be able to boot
from the second CPU.  This adds support to open_pic.c to allow for
that.

080-shorter-planar-id.diff

Not the most important of the patches, but there you go.

Cheers,

Leigh.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
