Date: Sun, 28 Jul 2002 12:26:56 +1000
From: Anton Blanchard <anton@samba.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: Re: why isync in atomic icc and return and atomic dec and return for CONFIG_SMP
Message-ID: <20020728022655.GA19087@krispykreme>
References: <200207231725.30067.kevin.hendricks@sympatico.ca> <20020724003040.GE6355@krispykreme> <200207240804.36472.kevin.hendricks@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200207240804.36472.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> So the atomic increment and decrement awith return are being used  in locks
> to protect extended criticial regions?

Yes, and so are test_and_set_bit etc. In fact I just found a bug in 2.5
where we were using bitops as spinlocks and were missing a memory
barrier on the lock drop (notice how clear_bit doesnt have a barrier and
we have smp_mb__before_clear_bit()).

> If so, a lock (of any sort) does require an isync (according to the manual)
> immediately after gaining the lock to make sure all speculative
> prefetching of instructions and data (possibly stale since someone else
> could have changed them before dropping the lock) should be done for pboth
> cases.

Yes.

> Why doesn't the same problem happen from the processor's speculative
> prefetching of instructions in the uniprocessor case?  Since that routine
> is inlined, the single processor could have loaded and started to process
> instructions past the "lock" before it actually aaquires the lock.

The big difference here is that there are no other cpus that can modify
memory. The cpu is free to prefetch the load but it must present
everything in program order to the program. Imagine what would happen if
we had int i = 0; i++; printf("%d\n", i); and we got 0 :)

There are two cases:

1. The prefetched load ends up conflicting with a previous store. The
load and all instructions after it depending on this load must be
flushed and retried.

2. The load has no previous dependencies. Since no other CPU could
modify memory then the prefetch is valid.

On a UP build the spinlocks disappear, all that is left is the interrupt
disable/enable if using the _irq and _irqsave versions. Having said this
you may ask we we need the the lwarx/stcwx. in the atomics and bitops at
all in a UP build. The reason is that we could get an interrupt and we
need to ensure that we are atomic wrt them.

BTW inlining isnt enough to avoid prefetching, the cpu is free to
prefetch both into a function and out of it.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
