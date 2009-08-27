Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0EF0AB7B96
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 19:33:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 332DADDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 19:33:05 +1000 (EST)
Subject: Re: spin_is_locked() broken for uniprocessor?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1250674870.7583.334.camel@twins>
References: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
	<DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
	<7099.1250674686@redhat.com>  <1250674870.7583.334.camel@twins>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 19:32:34 +1000
Message-Id: <1251365554.20467.51.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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

On Wed, 2009-08-19 at 11:41 +0200, Peter Zijlstra wrote:
> > > > which implies to me that spin_is_locked() will always return
> false.  Is this
> > > > expected behavior.
> > > 
> > > That's wrong. spin_is_locked should always return true on UP.
> > 
> > Surely it's not that simple?  Maybe spin_is_lock() should be
> undefined on UP.
> 
> #define spin_is_locked(l) panic()
> 
> should sort things out quickly ;-)

Not defining it would sort things out even faster and avoid nasty case
of system panic'ing when a module is loaded :-)

Cheers,
Ben.
