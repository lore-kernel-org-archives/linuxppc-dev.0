Message-ID: <38FF95C5.DEBB683A@ccrl.mot.com>
Date: Thu, 20 Apr 2000 18:41:57 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QSPAN PCI wierdness
References: <Pine.HPX.4.10.10004202325400.19933-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
