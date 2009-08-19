Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8F729B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 11:18:34 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC869DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 11:18:33 +1000 (EST)
Message-Id: <BB2762BC-C760-4D4C-BDCF-76EFD3E1B18D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.2.00.0908182003430.18648@gandalf.stny.rr.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
Date: Tue, 18 Aug 2009 20:17:28 -0500
References: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
	<alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908181931180.28398@gandalf.stny.rr.com>
	<alpine.LFD.2.01.0908181640120.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908182003430.18648@gandalf.stny.rr.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 18, 2009, at 7:07 PM, Steven Rostedt wrote:

> On Tue, 18 Aug 2009, Linus Torvalds wrote:
>>
>>> Thinking about it, UP probably should have spin_is_locked always  
>>> return
>>> false, but if you want to make sure you are not in a critical  
>>> section
>>> with the lock not held, then use assert_spin_locked, which on UP  
>>> should be
>>> a nop.
>>
>> That's what we do. That said, I also think we should generally try to
>> avoid the kind of code that depends on spin_is_locked always  
>> returning
>> false, for the same reason we should try to avoid any code that  
>> depends on
>> it always returning true.
>
> Perhaps we can deprecate spin_is_locked and replace it with
> "expect_spin_locked" and "expect_spin_unlocked" which on SMP would  
> return
> true and false respectively if the lock was locked. But both would  
> always
> return true on UP.
>
> Or do some thing similar, that would remove the ambiguity on UP.

I agree its a little too easy to abuse spin_is_locked.  However we  
should be consistent between spin_is_locked on UP between with and  
without CONFIG_DEBUG_SPINLOCK enabled.  How much of this do we want to  
try and address in .31?

The PPC test really should be using assert_spin_locked and I'll send a  
patch to Ben for that.

- k
