Date: Tue, 23 Nov 1999 19:34:13 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Cort Dougan <cort@fsmlabs.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
In-Reply-To: <19991123104858.E16540@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.05.9911231925370.369-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Nov 1999, Cort Dougan wrote:
> That was the plan with the bootinfo in machdep.h in 2.3  Give it a look and
> let me know how possible it would be modify bootx to use it.
> 
> } Define some kind of bootx-like bootinfo structure (will all addresses
> } relative to the beginning of the structure) and move out of the kernel

Before you walk into the same traps as we did on the m68k many years ago
(zillions of kernel and bootloader versions that where incompatible with each
other), you may want to look at the bootinfo stuff in
include/asm-m68k/bootinfo.h.

The idea is to pass the bootinfo not as a fixed (inherently back/forewards
incompatible) struct, but as a concatenation of records. Each record contains
a tag ID, a size, and data:

struct bi_record {
    unsigned short tag;                 /* tag ID */
    unsigned short size;                /* size of record (in bytes) */
    unsigned long data[0];              /* data */
};

The parsing of the bootinfo is done in m68k_parse_bootinfo() in
arch/m68k/kernel/setup.c. If you add new fields in the booter, older kernels
still work fine because they just skip bi_records with unknown tag IDs.

Gr{oetje,eeting}s,

P.S. As a sidenote: we did our job that well that we never had to change the
     bootinfo on Amiga later anyway, see the `2.0' bootinfo version (`1.x' was
     pre-bi_record) as a testimony :-)
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
