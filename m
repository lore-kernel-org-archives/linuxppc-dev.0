Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D4BBDDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 16:23:16 +1000 (EST)
Date: Fri, 19 Oct 2007 13:53:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] synchronize_irq needs a barrier
Message-ID: <20071019055333.GA10748@gondor.apana.org.au>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
	<1192749449.7367.51.camel@pasglop>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
	<20071019023219.GB8453@gondor.apana.org.au>
	<alpine.LFD.0.999.0710181941020.26902@woody.linux-foundation.org>
	<alpine.LFD.0.999.0710182007170.26902@woody.linux-foundation.org>
	<1192767073.7367.84.camel@pasglop>
	<1192768014.7367.96.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192768014.7367.96.camel@pasglop>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 02:26:54PM +1000, Benjamin Herrenschmidt wrote:
>
> I think a simple smp_mb(); here after foo = 1; is enough, which means
> basically just having an smp_mp(); inside napi_synchronize(), before
> the test_bit(). Or do I miss something ?

Yes I think you're right.  In this case we do have barriers
everywhere else so this should work.

Although if you want napi_synchronize to have the property that
when it returns all NAPI processing effects are visible then
you'd need another smp_mb() after the loop.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
