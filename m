From: "Jason Wohlgemuth" <jsw-embedded@mindspring.com>
To: "Steve Rossi" <srossi@ccrl.mot.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: QSPAN PCI wierdness
Date: Thu, 20 Apr 2000 19:09:08 -0400
Message-ID: <NCBBKJKKGDLPHKDPAFFMOECDCEAA.jsw-embedded@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <38FF95C5.DEBB683A@ccrl.mot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,

I got the Qspan going from the mpc8xx-2.2.13 distribution.  If you are
compiling the kernel with gcc 2.95.2 there is an issue with the inline
assembly assuming an important register is not used and the value is thrown
away, ... it was posted in a previous message by me, I just dug it up, here
it is.  If you are not using gcc2.95.2, then let us know and we can all
ponder this some more.

Anyone trying to build in pci support to the kernel using GCC 2.95.2 may
find this patch helpful.

It seems that in the inline-assembly in qspan_pci.c the compiler doesn't
recognize that the first argument to the assembly may be modified.  This
resulted in a register getting trashed where it shouldn't have.  To fix the
problem I modified the in-line assembly to tell the compiler that this
register has been changed.

86c86
<               : "=r"(x) : "r"(addr) : "%0")
---
>               : "=r"(x) : "r"(addr))

Jason <jwohlgem@mindspring.com>


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Steve
Rossi
Sent: Thursday, April 20, 2000 7:42 PM
To: Gabriel Paubert
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QSPAN PCI wierdness



This is way before the kernel has even booted so MMU is still
off. There was an eieio after the config data register read.
I tried adding a sync between the config address register write
and the config data register read - but it didn't help. I also
tried replacing the eieio after the data reg read with sync - still
no go.

As a little test I added some code to the end of qspan_init that looks
like so:

        qptr[320] = 0x00000000; /* device 0 */
        puts("At PCI Device ID 0: ");
        puthex(qptr[321]);
        puts("\n");

This prints out the expected Vendor ID and Device ID.

Its when pci_scanner() calls qs_pci_read_config_dword()
that it reads 0. Can someone verified that pci_scanner() and
the qs_pci_* functions in mbxboot/pci.c and
mbxboot/qspan_pci.c work?

Thanks,
Steve


Gabriel Paubert wrote:

>
> - is the MMU on or off (we know the dache is off) ?
>
> - are accesses separated with at least an eieio instruction ?
>
>  Try with a sync just in case: I had problems while debugging on a 603e
> recently with dcache off and mmu off (tracking a problem in code which was
> designed to run with both cache and MMU on), an eieio was not enough but a
> sync worked just fine.
>
>         Gabriel.

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
