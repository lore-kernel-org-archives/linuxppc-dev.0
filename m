Date: Thu, 9 Mar 2000 12:04:34 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, Michel Danzer <michdaen@iiic.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
 cwith r128
In-Reply-To: <00030821502900.00501@localhost.localdomain>
Message-ID: <Pine.HPX.4.10.10003091149520.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




	Hi,

> There are three interesing tidbits about cache flushing.  One I picked up
> recently on the  glibc apha and/or hacker mailing lists.
>
> 1. It seems some (many?) embedded ppc systems running linux do not have a cache
> line size of 32! It is 8 or 16 or something funny.

Indeed, and future processors might have larger cache lines. With DDR
SDRAM it would makes sense to perform 8 beat bursts, wider buses might
also become more mainstream.

> 2. AFAIK, cache flushing should never cause seg-faults since the associative
> array used by the cache will ignore any address ranges not already in the cache.
> If that page was never loaded it will not be in the cache.

Wrong, the address is translated by the MMU for most instructions,
otherwise how could you know whether which cache line to flush on a dcbf
with an n-way cache ?

On SMP cores (601,604,7400), the cache control instructions also broadcast
on the bus if the M attribute bit of the translation is set.

There are exceptions to this rule, mostly for icbi: AFAIR icbi is a nop on
601 and flushes all 8 ways of the icache on 750 (which means that
flush_icache_page could actually be optimized to flush all the cache
through HID0 manipulations instead of looping). But icbi is the only
instruction which has such wildly different implementations. OTOH, the
prefetch instructions dcbt and dcbtst actually never trap for a page fault
but I don't think you were referring to these.

> 3. 601 processors may barf(?) on some of these instructions.

No, it does not. It's just that the cache is unified which makes most
coherency functions irrelevant.

> So here is a piece of code I always steal when needing to do similar cache
> flushing for the jdk and the metrowerks jit.  It is taken from the kernel
> arch/ppc/kernel/head.S
>
> I don't think we can access the machine type register in user space (but I am
> very unsure about that).

No, you can't but a 601 will execute it just perfectly. OTOH some system
services or a user/kernel shared page at a fixed address which  would
exportt this kind of service to userland might be nice.

> I have no idea if the cacheline size and processor values are made available by
> the kernel during runtime so that we could use those values.

They should be according to the SYSV ABI reference but I think this was
never implemented.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
