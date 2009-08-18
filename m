Return-Path: <tglx@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B51BB7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:24:35 +1000 (EST)
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3239DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:24:33 +1000 (EST)
Date: Wed, 19 Aug 2009 00:24:02 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: spin_is_locked() broken for uniprocessor?
In-Reply-To: <DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
Message-ID: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
References: <DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Aug 2009, Kumar Gala wrote:
> I just want to validate that what I'm seeing (for UP, non-debug features):
> 
> spin_is_locked() is defined as:
> 
> include/linux/spinlock.h:#define spin_is_locked(lock)
> __raw_spin_is_locked(&(lock)->raw_lock)
> 
> for UP that should get us:
> 
> include/linux/spinlock_up.h:#define __raw_spin_is_locked(lock)  ((void)(lock),
> 0)
> 
> which implies to me that spin_is_locked() will always return false.  Is this
> expected behavior.

That's wrong. spin_is_locked should always return true on UP.

Thanks,

	tglx
