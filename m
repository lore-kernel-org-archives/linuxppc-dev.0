From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15596.28533.954307.94549@argo.ozlabs.ibm.com>
Date: Thu, 23 May 2002 14:26:29 +1000 (EST)
To: <acurtis@onz.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: eieio rule-of-thumb?
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEHMDHAA.acurtis@onz.com>
References: <15595.13374.704999.529737@argo.ozlabs.ibm.com>
	<NCBBIINEHIPFGJPLBEIFOEHMDHAA.acurtis@onz.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis writes:

> Could you provide an example of when you should insert this instruction into
> your code. From you description it is a wonder that "var += 2;" works if I
> am accessing dual-port on an 8260.

That works because the value stored has a data dependency on the value
loaded, i.e. the processor can't do the store until it has the value
back from the load.

In general it is sufficient to do an eieio before each non-cacheable
load, and between two non-cacheable stores if you need to prevent any
possibility of the two stores being combined into a single transaction
(e.g. if you have PCI and a PCI host bridge that can do write
combining).  At present the I/O macros do an eieio after each
non-cacheable load and store, which works but is overkill.

In device driver code I much prefer not to see explicit "eieio()"
calls unless it is absolutely necessary.  There are sets of macros
provided for access to I/O devices and it is almost always cleaner to
use them instead of explicitly putting "eieio()" in your code.  It
cuts down on the "Old Macdonald" jokes too. :)

For access to PCI devices, use:

{in,out}{b,w,l}		access to PCI I/O space (little endian)
{read,write}{b,w,l}	access to PCI memory space (little endian)

For access to non-PCI devices on PPC platforms, use:

{in,out}_8
{in,out}_{le,be}{16,32}

These all take a kernel virtual address, i.e. the result of an
ioremap.  The little-endian variants use the byte-reversed load and
store instructions.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
