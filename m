Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Anton Blanchard <anton@samba.org>
Subject: Re: why isync in atomic icc and return and atomic dec and return for CONFIG_SMP
Date: Wed, 24 Jul 2002 08:04:36 -0400
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
References: <200207231725.30067.kevin.hendricks@sympatico.ca> <20020724003040.GE6355@krispykreme>
In-Reply-To: <20020724003040.GE6355@krispykreme>
MIME-Version: 1.0
Message-Id: <200207240804.36472.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> > Can anyone tell me the reason why we need to use an isync in the
> > atomic_add_return and atomic_sub_return (see kernel source in
> > asm/atomic.h) only for SMP machiens and only when a value is returned?
>
> We are using isync here as an "import barrier". The stwcx., bne, isync
> sequence ensures that any instructions following the isync are not
> performed until the lock has been taken. Basically it prevents anything
> inside the spinlock protected region from leaking outside.
>
> We dont need this on a UP machine because the local cpu sees everything
> in program order.

So the atomic increment and decrement awith return are being used  in locks
to protect extended criticial regions?

If so, a lock (of any sort) does require an isync (according to the manual)
immediately after gaining the lock to make sure all speculative
prefetching of instructions and data (possibly stale since someone else
could have changed them before dropping the lock) should be done for pboth
cases.

Why doesn't the same problem happen from the processor's speculative
prefetching of instructions in the uniprocessor case?  Since that routine
is inlined, the single processor could have loaded and started to process
instructions past the "lock" before it actually aaquires the lock.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
