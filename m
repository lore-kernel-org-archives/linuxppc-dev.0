Date: Tue, 23 Nov 1999 21:16:38 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Cort Dougan <cort@fsmlabs.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
In-Reply-To: <19991123121629.A16956@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.05.9911232115090.12629-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Nov 1999, Cort Dougan wrote:
> Do you keep the list around after the initialization?  We do something
> similar with the prep residual data but after we grab what we want we free
> the RAM.  
> 
> } The idea is to pass the bootinfo not as a fixed (inherently back/forewards
> } incompatible) struct, but as a concatenation of records. Each record contains
> } a tag ID, a size, and data:
> } 
> } struct bi_record {
> }     unsigned short tag;                 /* tag ID */
> }     unsigned short size;                /* size of record (in bytes) */
> }     unsigned long data[0];              /* data */
> } };

No we don't. The structure isn't that large, and the kernel is padded to a multiple
of the page size anyway (the structure is after the kernel in memory).

Gr{oetje,eeting}s,
P.S. How much Belgian Beer do I have to send you to convince you to put your
     comments _below_ the text you quote, like all other people do? ;-)
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
