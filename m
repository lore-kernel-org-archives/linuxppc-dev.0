Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6013BDDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 07:35:34 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1IiWTY-0000jx-00@gondolin.me.apana.org.au>
References: <E1IiWTY-0000jx-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 07:35:05 +1000
Message-Id: <1192743305.7367.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-18 at 22:35 +0800, Herbert Xu wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > Note that some kind of read barrier or compiler barrier should be needed
> > regardless, or we are just not sync'ing with anything at all (we may
> > have loaded the value ages ago and thus operate on a totally stale
> > value). I prefer a full barrier to also ensure all previous stores are
> > pushed out.
> 
> We already have a compiler barrier there in the form of cpu_relax.

Isn't it too late ? The barrier should be before the test_bit, to
prevent it from moving up.

Ben.
 
