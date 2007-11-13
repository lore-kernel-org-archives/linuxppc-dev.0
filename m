Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9EA84DDE0C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 13:09:47 +1100 (EST)
Date: Mon, 12 Nov 2007 18:09:46 -0800 (PST)
Message-Id: <20071112.180946.150182058.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] sungem: fix suspend regression due to NAPI changes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1194906766.18185.79.camel@pasglop>
References: <1194889547.4456.4.camel@johannes.berg>
	<1194906766.18185.79.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, johannes@sipsolutions.net,
	shemminger@linux-foundation.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Nov 2007 09:32:46 +1100

> 
> On Mon, 2007-11-12 at 18:45 +0100, Johannes Berg wrote:
> > Commit bea3348e (the NAPI changes) made sungem unconditionally enable
> > NAPI when resuming and unconditionally disable when suspending, this,
> > however, makes napi_disable() hang when suspending when the interface
> > was taken down before suspend because taking the interface down also
> > disables NAPI. This patch makes touching the napi struct in
> > suspend/resume code paths depend on having the interface up, thereby
> > fixing the hang on suspend.
> > 
> > The patch also moves the napi_disable() in gem_close() under the lock so
> > that the NAPI state is always modified atomically together with the
> > "opened" variable.
> > 
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Thanks for fixing that !
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Indeed, thanks a lot Johannes.

Patch applied.
