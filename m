Date: Mon, 22 Nov 1999 14:37:32 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness
Message-ID: <19991122143732.B12973@hq.fsmlabs.com>
References: <19991122120429.031138@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991122120429.031138@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Mon, Nov 22, 1999 at 12:04:29PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Not always.  Keep in mind we have several machine types that follow the
same patch there.  We don't always enter with OF and OF doesn't always give
1:1 mappings, either.

} The kernel enters from OF, with the MMU in whatever state OF set it and
} the guarantee that at least it's mapped 1:1 with some memory (1Mb) also
} mapped just after it so that it can expand itself. This guarantees are
} the responsibility of the bootloader.

I don't care for it much but it gives us a foothold and OF doesn't seem to
use bat1 ever...

} At this point, it hacks a BAT to map the first 16Mb of memory to
} KERNELBASE. That I don't like since it means playing with mapping of
} potentially running code with MMU enabled (and you don't know if OF
} didn't use a BAT itself for mappping the RAM you are running from, future

Not dependent on the bootloader, just dependent on the current running
address and whether MSR_DR is set in the MSR or not.

} OF versions may do). It will then do all sort of weird guesses depending
} on the bootloader to know if it must translate or not the source address,
} do the copy and flush (which will usually default catch to OF with my
} bootloader, depending on where I loaded the kernel, etc...)

at 0x10000 on chrp when running quik.

} Quik tries to load the kernel at 0, which avoids most of those head.S
} issues, but the way it does is broken, since OF won't allow to CLAIM
} memory from 0 (at least not on my machine), that means potentially
} overriding bits of OF (I know OF tends to use high memory, but OF low
} memory vectors are still needed, at least on 603 for prom_entry to work).

We only do that after we've called prom_entry() for the last time, though.

} Also, the bootloader can't turn MMU off and clean TLB & BATs since
} prom_entry must have the correct OF mappings in order to work.
} 
} Instead of trying to find out the magical address to load the kernel,
} potentially breaking with future OF versions, and hacks like that, I
} finally decided to give a try at fixing head.S (I'm still using 2.2.x
} kernels, I beleive head.S did change with 2.3.x, I'll look into this later).
} 
} Basically, what I'm doing is, after bl prom_entry, and before filling the
} BAT, I turn the MMU off, clear all bats (in a 601-compatible way unlike
} the current kernel source tree), flush TLBs, and then continue to the
} code that sets up the BAT and moves down the kernel to 0. I also had to
} comment out the code that translates the source address on CHRP.

That's a good way to do it but shutting it down isn't always that easy.  On
some PReP's (the IBM 830 I think) we come into the kernel with MSR_IR on
and MSR_DR off and we're running with some odd I mappings (not D mappings, though).

} I'll post a patch later today, but I wanted to know if my way of doing
} things is broken or will break CHRP machines or not. Basically, I feel
} the "good way" is to shut down the MMU upon exit from prom_entry, and
} then play with BATs, copy&flush, etc...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
