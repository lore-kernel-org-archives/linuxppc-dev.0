Date: Fri, 18 Feb 2000 13:17:03 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Paul Mackerras <paulus@linuxcare.com>
cc: Cort Dougan <cort@fsmlabs.com>, Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: insw/outsw/insl/outsl (was: Re: your mail)
In-Reply-To: <00021714275405.25243@argo.linuxcare.com.au>
Message-ID: <Pine.GSO.4.10.10002181314290.22332-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 17 Feb 2000, Paul Mackerras wrote:
> Does anyone have any objection if I make insw/outsw/insl/outsl *not*
> byte-swap the data?  The reason is that these functions are mostly used
> for transferring blocks of data, i.e. arrays of bytes.  I haven't found a
> single instance where they are used for transferring arrays of 16 or
> 32-bit words.
>
> This would mean that we wouldn't need the kludge in the ide stuff where we
> redefine insw as ide_insw (which doesn't byte-swap).  There is currently a
> bug there because insl does still byte-swap, which means that if you set
> the -c1 flag with hdparm, you get byte-swapped data. :-(

Hmm... This is indeed ambiguous. Is e.g. insl() used to (a) read n 32-bit words
from (little endian) ISA I/O space, or (b) used to read n*4 bytes from ISA I/O
space, using 32-bit accesses?

What about moving this to linux-kernel? It affects all big endian platforms.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
