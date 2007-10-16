Return-Path: <shemminger@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD6CDDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 04:54:00 +1000 (EST)
Date: Tue, 16 Oct 2007 11:53:18 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi poll
Message-ID: <20071016115318.0fc36af3@freepuppy.rosehill>
In-Reply-To: <1192513792.19073.23.camel@pasglop>
References: <1192513792.19073.23.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Dreier <rdreier@cisco.com>, Roland,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Oct 2007 15:49:52 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> net: Add __napi_sycnhronize() to sync with napi poll
> 
> The EMAC driver which needs to handle multiple devices with one
> NAPI instance implements its own per-channel disable bit. However,
> when setting such a bit, it needs to synchronize with the poller
> (that is make sure that any pending poller instance has completed,
> or is started late enough to see that disable bit).
> 
> This implements a low level __napi_synchronize() function to acheive
> that. The underscores are to emphasis the low level aspect of it and
> to discourage driver writers who don't know what they are doing to
> use it (to please DaveM :-)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> (Use correct address for Stephen this time)
> 
> If the approach is accepted, I would like to have this merged now
> so the EMAC patch to make it work again can follow :-)
> 
> Note: I use msleep_interruptible(1); just like napi_disable(). However
> I'm not too happy that the "hot" loop that results of a pending signal
> here will spin without even a cpu_relax ... what do you guys think would
> be the best way to handle this ?


So this is really just like synchronize_irq()?  Using msleep is bogus
because you want to spin, you are only waiting for a softirq on the other
cpu to finish. If you wait for a whole millisecond and sleep that
is far longer than the napi routine should take.

You could even optimize it like synchronize_irq() for the non-SMP case.



-- 
Stephen Hemminger <shemminger@linux-foundation.org>
