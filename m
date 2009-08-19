Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CC823B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 20:52:33 +1000 (EST)
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16B47DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 20:52:32 +1000 (EST)
Date: Wed, 19 Aug 2009 11:53:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Subject: Re: spin_is_locked() broken for uniprocessor?
Message-ID: <20090819115301.563be6da@lxorguk.ukuu.org.uk>
In-Reply-To: <7099.1250674686@redhat.com>
References: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
	<DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
	<7099.1250674686@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Aug 2009 10:38:06 +0100
David Howells <dhowells@redhat.com> wrote:

> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > which implies to me that spin_is_locked() will always return false.  Is this
> > > expected behavior.
> > 
> > That's wrong. spin_is_locked should always return true on UP.
> 
> Surely it's not that simple?  Maybe spin_is_lock() should be undefined on UP.

That would lead to a lot of

#ifdef CONFIG_SMP

#endif

in drivers because there is driver code that uses spin_is_locked() in
fairly sensible fashion when dealing with locking.
