Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25E6CDDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 13:17:07 +1000 (EST)
Message-ID: <47157EA4.1000500@garzik.org>
Date: Tue, 16 Oct 2007 23:16:52 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi	poll
References: <1192513792.19073.23.camel@pasglop>	
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop>
In-Reply-To: <1192589522.11899.130.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
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

Benjamin Herrenschmidt wrote:
> net: Add __napi_synchronize() to sync with napi poll
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
> Switched to do a cpu_relax() spin instead and only on SMP. Not that
> we have an smp_mb() in there which synchronize_irq() lacks. I believe
> this is a bug in synchronize_irq() which I'll handle separately.
> 
> Note: unfortunately, Jeff already picked up the EMAC patch without
> waiting for this to be sorted out (oops...). So if you agree with
> this patch, it would be nice to have it go in quickly or maybe via
> Jeff's tree to avoid breakage ? Not terribly important tho.


Sorry, I thought that was the way everybody was headed.  With the driver 
broken /anyway/, I just sorta threw it into the pile of fixes.

It's upstream now, so let me know if you want to revert or move forward 
from here...

	Jeff
