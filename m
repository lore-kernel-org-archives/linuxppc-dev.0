Date: Thu, 25 Nov 1999 18:13:28 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Malek <dan@netx4.com>
cc: Christian Zankel <chris@mvista.com>, cort@fsmlabs.com,
        linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
In-Reply-To: <383AF6FE.68C8CFA@netx4.com>
Message-ID: <Pine.LNX.4.05.9911251809390.7807-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Nov 1999, Dan Malek wrote:
> There are already "machine" dependent files at the lowest
> levels, just not in separate directories.  The complexity of
> the "#ifdefs" at the PPC level is mostly to ensure we get to
> the proper lower level dependent files.
> 
> Further, because of the integrated nature of some PPC processors,
> the line between processor and machine is a little fuzzy.  For
> example, the 8240 is a 603/MPC106/CHRP...but not exactly.  You
> can leverage lots of existing code, but need to twist it just
> a little in a couple of places.  It doesn't fit the processor
> and machine model very well.

Alternatively, you can base your decisions on specific features that are shared
among different machine types, and say

    if (has_feature_a) {
	...
    }

instead of

    #if defined(CONFIG_x) || defined(CONFIG_y) || defined(CONFIG_z)
    ...
    #endif

This way you can also easily create common kernel images that run on various
types of machines, since has_feature_a is just a variable that's set up
dynamically on kernel startup.

If you want to create an optimized kernel for a specific machine type, say

    #if defined(CONFIG_x) || defined(CONFIG_y) || defined(CONFIG_z)
    #define has_feature_a	1
    #else
    #define has_feature_a	0
    #endif

and gcc will optimize away the unused parts.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
