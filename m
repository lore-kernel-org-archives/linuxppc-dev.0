Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9E5DBB7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 10:07:39 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 15295DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 10:07:38 +1000 (EST)
Date: Tue, 18 Aug 2009 20:07:36 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
In-Reply-To: <alpine.LFD.2.01.0908181640120.3158@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.0908182003430.18648@gandalf.stny.rr.com>
References: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
	<alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908181931180.28398@gandalf.stny.rr.com>
	<alpine.LFD.2.01.0908181640120.3158@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Aug 2009, Linus Torvalds wrote:
> 
> > Thinking about it, UP probably should have spin_is_locked always return 
> > false, but if you want to make sure you are not in a critical section 
> > with the lock not held, then use assert_spin_locked, which on UP should be 
> > a nop.
> 
> That's what we do. That said, I also think we should generally try to 
> avoid the kind of code that depends on spin_is_locked always returning 
> false, for the same reason we should try to avoid any code that depends on 
> it always returning true. 

Perhaps we can deprecate spin_is_locked and replace it with 
"expect_spin_locked" and "expect_spin_unlocked" which on SMP would return 
true and false respectively if the lock was locked. But both would always 
return true on UP.

Or do some thing similar, that would remove the ambiguity on UP.

-- Steve
