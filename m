Date: Wed, 9 Feb 2000 15:09:09 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Patrick Lerda <Lerda@microprocess.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu,
        "'Benjamin Herrenschmidt'" <bh40@calva.net>
Subject: RE: [linux-fbdev] Retrace
In-Reply-To: <3AC9A1611DF4D211AA8E00105AA56D8A048B45@iis000.microdata.fr>
Message-ID: <Pine.HPX.4.10.10002091458540.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 9 Feb 2000, Patrick Lerda wrote:

>
> The best way to handle, PCI devices base_address[] on an independant
> processor way, is
> to use physical memory pointers, we can do this trick on the linux pcifixup
> subroutine,
> some PPC architectures don't change this value and leave the pci bus
> address, this address
> can't be used easely... Using the physical memory works with all well
> written linux drivers, because
> the base_address is taken and used as an argument to ioremap to get a
> virtual pointer.

That's what I had done on my MVME boards when I had them still using prep
style memeory maps. I think the code is still there in my patches on
ftp://vlab1.iram.es, but is simply not executed since now I reprogram the
bridge in CHRP mode first.

However this gives also quite a lot of problems wit hot plugging: a new
device pops up and you try allocate a resource for it but you have to
remember that there you have to write a different value in the BAR and in
the resource structure. Ugly, you need a fixup which goes the other way
around, allocating physical space first and subtracting whatever offset
you need before writing the BAR.

That's why I suggested extending the resource tree definitions to describe
non transparent mappings to handle these cases (at least for 2.3/2.4).
This would also help in handling nontransparent PCI<->PCI bridges like the
Intel/ex DEC 21554 (is it the right part number ?).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
