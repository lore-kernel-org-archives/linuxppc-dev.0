Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Anton Blanchard <anton@samba.org>
Subject: Re: why isync in atomic icc and return and atomic dec and return for CONFIG_SMP
Date: Sat, 3 Aug 2002 10:28:20 -0400
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
References: <200207231725.30067.kevin.hendricks@sympatico.ca> <200207240804.36472.kevin.hendricks@sympatico.ca> <20020728022655.GA19087@krispykreme>
In-Reply-To: <20020728022655.GA19087@krispykreme>
MIME-Version: 1.0
Message-Id: <200208031028.20491.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi ,

One followup question please.

In userland code, say with a fully pre-emptible kernel, if a signal comes
in to thread A and before returning another thread (call it B)  is run,
couldn't the same problem happen with prefetching data being old since
thread B may in fact be the one holding the lock and allowed to change the
data.

I guess what I am asking is would we need the isync for a userland version
of this code if threads could actually be pre-empted even for a UP
machine?

Thanks for your help.

Kevin

On July 27, 2002 10:26, Anton Blanchard wrote:
> > So the atomic increment and decrement awith return are being used  in
> > locks to protect extended criticial regions?
>
> Yes, and so are test_and_set_bit etc. In fact I just found a bug in 2.5
> where we were using bitops as spinlocks and were missing a memory
> barrier on the lock drop (notice how clear_bit doesnt have a barrier and
> we have smp_mb__before_clear_bit()).
>
> > If so, a lock (of any sort) does require an isync (according to the
> > manual) immediately after gaining the lock to make sure all
> > speculative prefetching of instructions and data (possibly stale since
> > someone else could have changed them before dropping the lock) should
> > be done for pboth cases.
>
> Yes.
>
> > Why doesn't the same problem happen from the processor's speculative
> > prefetching of instructions in the uniprocessor case?  Since that
> > routine is inlined, the single processor could have loaded and started
> > to process instructions past the "lock" before it actually aaquires
> > the lock.
>
> The big difference here is that there are no other cpus that can modify
> memory. The cpu is free to prefetch the load but it must present
> everything in program order to the program. Imagine what would happen if
> we had int i = 0; i++; printf("%d\n", i); and we got 0 :)
>
> There are two cases:
>
> 1. The prefetched load ends up conflicting with a previous store. The
> load and all instructions after it depending on this load must be
> flushed and retried.
>
> 2. The load has no previous dependencies. Since no other CPU could
> modify memory then the prefetch is valid.
>
> On a UP build the spinlocks disappear, all that is left is the interrupt
> disable/enable if using the _irq and _irqsave versions. Having said this
> you may ask we we need the the lwarx/stcwx. in the atomics and bitops at
> all in a UP build. The reason is that we could get an interrupt and we
> need to ensure that we are atomic wrt them.
>
> BTW inlining isnt enough to avoid prefetching, the cpu is free to
> prefetch both into a function and out of it.
>
> Anton


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
