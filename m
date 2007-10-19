Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1D4EDDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 14:27:35 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <1192767073.7367.84.camel@pasglop>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
	<1192749449.7367.51.camel@pasglop>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
	<20071019023219.GB8453@gondor.apana.org.au>
	<alpine.LFD.0.999.0710181941020.26902@woody.linux-foundation.org>
	<alpine.LFD.0.999.0710182007170.26902@woody.linux-foundation.org>
	<1192767073.7367.84.camel@pasglop>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 14:26:54 +1000
Message-Id: <1192768014.7367.96.camel@pasglop>
Mime-Version: 1.0
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The whole lock/set IRQ_INPROGRESS/unlock path can then only happen
> before the locked section above, in which case we see and wait nicely
> and all is good, or after, in which case the store to foo will be
> visible to the IRQ handler as it will be ordered with the unlock in the
> code above.

Note that napi_synchronize needs a slightly different treatement.

Here, the situation boils down to:

one CPU does:

	foo = 1;
	while(test_bit(bar))
		barrier();

and the other:

	if (!test_and_set_bit(bar)) {
		read & use foo
		smp_mb__before_clear_bit();
		clear_bit(bar);
	}

The good thing here is that read & use foo is part of the critical
section (I hate hand-made locks ...) defined by bar which makes
things somewhat easier than the synchronize_irq() case.

I think a simple smp_mb(); here after foo = 1; is enough, which means
basically just having an smp_mp(); inside napi_synchronize(), before
the test_bit(). Or do I miss something ?

Cheers,
Ben.
