Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 31CFBDDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 17:44:31 +1000 (EST)
Date: Tue, 16 Oct 2007 00:44:34 -0700 (PDT)
Message-Id: <20071016.004434.106264901.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi poll
From: David Miller <davem@davemloft.net>
In-Reply-To: <1192520223.7205.5.camel@pasglop>
References: <E1IhfZr-0002FE-00@gondolin.me.apana.org.au>
	<1192520223.7205.5.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, rdreier@cisco.com, shemminger@linux-foundation.org,
	herbert@gondor.apana.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 16 Oct 2007 17:37:03 +1000

> 
> On Tue, 2007-10-16 at 14:06 +0800, Herbert Xu wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > >
> > > Note: I use msleep_interruptible(1); just like napi_disable(). However
> > > I'm not too happy that the "hot" loop that results of a pending signal
> > > here will spin without even a cpu_relax ... what do you guys think would
> > > be the best way to handle this ?
> > 
> > Well since the loop does not check signals at all, it should
> > just use msleep.
> > 
> > Granted the process will end up in the D state and contribute
> > to the load average.  But if this loop executes long enough
> > for that to be noticed then we've got bigger problems to worry
> > about.
> 
> If Dave & Stephen agree, I'll send a patch changing napi_disable() too
> then.

I agree with the msleep() change.
