Date: Tue, 23 Nov 1999 12:16:29 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
Message-ID: <19991123121629.A16956@hq.fsmlabs.com>
References: <19991123104858.E16540@hq.fsmlabs.com> <Pine.LNX.4.05.9911231925370.369-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.9911231925370.369-100000@callisto.of.borg>; from Geert Uytterhoeven on Tue, Nov 23, 1999 at 07:34:13PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Do you keep the list around after the initialization?  We do something
similar with the prep residual data but after we grab what we want we free
the RAM.  

} The idea is to pass the bootinfo not as a fixed (inherently back/forewards
} incompatible) struct, but as a concatenation of records. Each record contains
} a tag ID, a size, and data:
} 
} struct bi_record {
}     unsigned short tag;                 /* tag ID */
}     unsigned short size;                /* size of record (in bytes) */
}     unsigned long data[0];              /* data */
} };
} 
} The parsing of the bootinfo is done in m68k_parse_bootinfo() in
} arch/m68k/kernel/setup.c. If you add new fields in the booter, older kernels
} still work fine because they just skip bi_records with unknown tag IDs.
} 
} Gr{oetje,eeting}s,
} 
} P.S. As a sidenote: we did our job that well that we never had to change the
}      bootinfo on Amiga later anyway, see the `2.0' bootinfo version (`1.x' was
}      pre-bi_record) as a testimony :-)
} --
} Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org
} 
} In personal conversations with technical people, I call myself a hacker. But
} when I'm talking to journalists I just say "programmer" or something like that.
} 							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
