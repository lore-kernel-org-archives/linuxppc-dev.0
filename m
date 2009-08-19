Return-Path: <torvalds@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6F756B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 12:41:35 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE86FDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 12:41:34 +1000 (EST)
Date: Tue, 18 Aug 2009 19:40:16 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
In-Reply-To: <BB2762BC-C760-4D4C-BDCF-76EFD3E1B18D@kernel.crashing.org>
Message-ID: <alpine.LFD.2.01.0908181937400.3158@localhost.localdomain>
References: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
	<alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908181931180.28398@gandalf.stny.rr.com>
	<alpine.LFD.2.01.0908181640120.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908182003430.18648@gandalf.stny.rr.com>
	<BB2762BC-C760-4D4C-BDCF-76EFD3E1B18D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tue, 18 Aug 2009, Kumar Gala wrote:
> 
> I agree its a little too easy to abuse spin_is_locked.  However we should be
> consistent between spin_is_locked on UP between with and without
> CONFIG_DEBUG_SPINLOCK enabled.

No we shouldn't.

With CONFIG_DEBUG_SPINLOCK, you have an actual lock variable for debugging 
purposes, so spin_is_locked() can clearly return a _valid_ answer, and 
should do so.

Without DEBUG_SPINLOCK, there isn't any answer to return.

So there's no way we can or should be consistent. In one case an answer 
exists, in another one the answer is meaningless and doesn't exist.

> How much of this do we want to try and address in .31?

Absolutely nothing.

> The PPC test really should be using assert_spin_locked and I'll send a patch
> to Ben for that.

Yes, that's the correct fix.

		Linus
