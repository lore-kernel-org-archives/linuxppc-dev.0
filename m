Message-ID: <38AD4EB4.8870713@fadata.bg>
Date: Fri, 18 Feb 2000 14:52:52 +0100
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Paul Mackerras <paulus@linuxcare.com>, Cort Dougan <cort@fsmlabs.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: insw/outsw/insl/outsl (was: Re: your mail)
References: <Pine.GSO.4.10.10002181314290.22332-100000@dandelion.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Thu, 17 Feb 2000, Paul Mackerras wrote:
> > Does anyone have any objection if I make insw/outsw/insl/outsl *not*
> > byte-swap the data?  The reason is that these functions are mostly used
> > for transferring blocks of data, i.e. arrays of bytes.  I haven't found a
> > single instance where they are used for transferring arrays of 16 or
> > 32-bit words.
> >
> > This would mean that we wouldn't need the kludge in the ide stuff where we
> > redefine insw as ide_insw (which doesn't byte-swap).  There is currently a
> > bug there because insl does still byte-swap, which means that if you set
> > the -c1 flag with hdparm, you get byte-swapped data. :-(
>
> Hmm... This is indeed ambiguous. Is e.g. insl() used to (a) read n 32-bit words
> from (little endian) ISA I/O space, or (b) used to read n*4 bytes from ISA I/O
> space, using 32-bit accesses?
>
> What about moving this to linux-kernel? It affects all big endian platforms.

How about {ins|outs}_{be|le}{16|32} ?

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
