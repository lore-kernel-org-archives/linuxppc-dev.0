Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FF2EDDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:50:14 +1000 (EST)
From: Herbert Xu <herbert@gondor.apana.org.au>
To: benh@kernel.crashing.org
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi poll
In-Reply-To: <1192513792.19073.23.camel@pasglop>
Message-Id: <E1IhfZr-0002FE-00@gondolin.me.apana.org.au>
Date: Tue, 16 Oct 2007 14:06:51 +0800
Cc: netdev@vger.kernel.org, rdreier@cisco.com, shemminger@linux-foundation.org,
	davem@davemloft.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Note: I use msleep_interruptible(1); just like napi_disable(). However
> I'm not too happy that the "hot" loop that results of a pending signal
> here will spin without even a cpu_relax ... what do you guys think would
> be the best way to handle this ?

Well since the loop does not check signals at all, it should
just use msleep.

Granted the process will end up in the D state and contribute
to the load average.  But if this loop executes long enough
for that to be noticed then we've got bigger problems to worry
about.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
