Return-Path: <torvalds@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78583B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 09:21:24 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA34EDDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 09:21:23 +1000 (EST)
Date: Tue, 18 Aug 2009 16:20:43 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
In-Reply-To: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
Message-ID: <alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
References: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de
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
> For some reason __raw_spin_is_locked() has been returning false for the
> uni-processor, non-CONFIG_DEBUG_SPINLOCK.  The UP + CONFIG_DEBUG_SPINLOCK
> handles this correctly.
> 
> Found this by enabling CONFIG_DEBUG_VM on PPC and hitting always hitting
> a BUG_ON that was testing to make sure the pte_lock was held.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Linus, a fix for 2.6.31

This really isn't all that clear.

The thing is, some people may assert that a lock is held, but others could 
easily be looping until it's not held using something like

	while (spin_is_locked(lock))
		cpu_relax();

so it's hard to tell whether it should return true or false in the case 
where spin-locking simply doesn't exist.

		Linus
