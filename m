Date: Fri, 18 Feb 2000 14:45:08 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Paul Mackerras <paulus@linuxcare.com>, Cort Dougan <cort@fsmlabs.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: insw/outsw/insl/outsl (was: Re: your mail)
In-Reply-To: <Pine.GSO.4.10.10002181314290.22332-100000@dandelion.sonytel.be>
Message-ID: <Pine.HPX.4.10.10002181414590.3887-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 18 Feb 2000, Geert Uytterhoeven wrote:

>
> On Thu, 17 Feb 2000, Paul Mackerras wrote:
> > Does anyone have any objection if I make insw/outsw/insl/outsl *not*
> > byte-swap the data?  The reason is that these functions are mostly used
> > for transferring blocks of data, i.e. arrays of bytes.  I haven't found a
> > single instance where they are used for transferring arrays of 16 or
> > 32-bit words.

Go ahead, please. This is the only consistent way. These macros are used
to transfer an unstructured stream (s stands here for stream IMNSHO) of
bytes. The order of the bytes in memory after an insl/before an outsl
should be independant of the endianness of the platform (that's the only
way to be compatible between PIO and DMA modes). If this stream contains
scalars which are multibyte fields then you can access them with the
proper [bl]e{16,32,64}_to_cpu/cpu_to_[bl]e{16,32,64} macros.

> > This would mean that we wouldn't need the kludge in the ide stuff where we
> > redefine insw as ide_insw (which doesn't byte-swap).  There is currently a
> > bug there because insl does still byte-swap, which means that if you set
> > the -c1 flag with hdparm, you get byte-swapped data. :-(
>
> Hmm... This is indeed ambiguous. Is e.g. insl() used to (a) read n 32-bit words
> from (little endian) ISA I/O space, or (b) used to read n*4 bytes from ISA I/O
> space, using 32-bit accesses?

Don't forget that it reads repeatedly from the same port, {in,out}[bwl]
transfer scalars so it makes sense to convert by default between device
anc cpu byte orderings. The `s' versions are most often used to tranfer
data from a FIFO and there it does not make sense at all, especially when
you hit a packed structure with unaligned fields.

This is the same problem as some Ethernet chip SROM which are read by
chunks of 16 bits, and have streams of bytes and 16 bit LE fields: each 16
bit value is stored in memory in LE order to avoid crazyness when parsing
the SROM (the pointer increment and 16 bit access macros would be
otherwise very fun to write).

The exceptional case is the other one, when you know that you actually
transfer a series of 16 bit items with insw/outsw or of 32 bit items
with insl/outsl. But in this case, you know the endianness of the device
and if the need arises we might define {in,out}s[wl]_[bl]e

> What about moving this to linux-kernel? It affects all big endian platforms.

I think Paul shouuld go ahead, there are pretty convincing arguments (at
least for me) that show that this is the Right Way (TM).

	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
