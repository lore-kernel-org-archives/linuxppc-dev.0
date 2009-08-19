Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D60BCB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 19:41:23 +1000 (EST)
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 856B5DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 19:41:23 +1000 (EST)
Subject: Re: spin_is_locked() broken for uniprocessor?
From: Peter Zijlstra <peterz@infradead.org>
To: David Howells <dhowells@redhat.com>
In-Reply-To: <7099.1250674686@redhat.com>
References: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
	<DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
	<7099.1250674686@redhat.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 11:41:10 +0200
Message-Id: <1250674870.7583.334.camel@twins>
Mime-Version: 1.0
Cc: Steven Rostedt <rostedt@goodmis.org>,
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

On Wed, 2009-08-19 at 10:38 +0100, David Howells wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > which implies to me that spin_is_locked() will always return false.  Is this
> > > expected behavior.
> > 
> > That's wrong. spin_is_locked should always return true on UP.
> 
> Surely it's not that simple?  Maybe spin_is_lock() should be undefined on UP.

#define spin_is_locked(l) panic()

should sort things out quickly ;-)
