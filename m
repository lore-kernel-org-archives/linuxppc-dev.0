Date: Tue, 23 Nov 1999 10:48:58 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
Message-ID: <19991123104858.E16540@hq.fsmlabs.com>
References: <19991122144054.C12973@hq.fsmlabs.com> <19991123114001.002761@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991123114001.002761@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Tue, Nov 23, 1999 at 11:40:01AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Check out include/asm/machdep.h for the minimal bootloader structure I have
there.  I have some early work with quik (for the rs6000, haven't tested on
pmac yet) to pass info via that structure.

} I'd really like to see this happen. There is really an urgent need to
} cleanup the mess with initrd and the way the command line is passed to
} the kernel too and this would get rid of those.
} 
} There is one idea suggested to me by Gabriel Paubert which would be worth
} considering:

That was the plan with the bootinfo in machdep.h in 2.3  Give it a look and
let me know how possible it would be modify bootx to use it.

} Define some kind of bootx-like bootinfo structure (will all addresses
} relative to the beginning of the structure) and move out of the kernel

Some of this is substantial work that we'd have to move into the
bootloader.  I'm not against it, but it'd be nice of all the bootloaders
did it the same way.

} _all_ those head.S hacks AND all the prom_init code (reading the OF tree,
} initing the display, instanciating RTAS, ...).
} 
} All this would be done from a head-appended bootloader which would built
} a device tree when OF is available, and then enter the kernel with a
} unified entry point based on a structure, known mappings.

It is 2.3, after all :)

} I don't know if it's worth doing that _now_ (it involves almost breaking
} everything), but I like the idea of cleaning all this up.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
