Return-Path: <marc.pignat@hevs.ch>
Received: from mail.hevs.ch (mail.hevs.ch [153.109.23.10])
	by ozlabs.org (Postfix) with ESMTP id 7612FDDFBA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 20:42:53 +1000 (EST)
From: Marc Pignat <marc.pignat@hevs.ch>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] mmc: change .get_ro() callback semantics
Date: Tue, 3 Jun 2008 12:07:49 +0200
References: <20080523154204.GA19803@polina.dev.rtsoft.ru>
	<20080523154347.GC24862@polina.dev.rtsoft.ru>
In-Reply-To: <20080523154347.GC24862@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806031207.49843.marc.pignat@hevs.ch>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all!

On Friday 23 May 2008, Anton Vorontsov wrote:
> get_ro() callback must return values >= 0 for its logical state, and
...
>  static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f2e9885..ef3b773 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -55,6 +55,9 @@ struct mmc_host_ops {
>  	 * Avoid calling these three functions too often or in a "fast path",
>  	 * since underlaying controller might implement them in an expensive
>  	 * and/or slow way.
> +	 *
> +	 * .get_ro and .get_cd should return >= 0 for their logical values,
> +	 * or negative errno value in case of error.
>  	 */

I would suggest to use something more strict (bulletproof), something like:

/*
 * get_ro will return:
 *   0 for a read/write card
 *   1 for a read-only card 
 *   -ENOSYS when not supported
 *   or a negative errno when something bad happened
 * 
 * get_cd will return:
 *   0 for a absent card
 *   1 for a present card 
 *   -ENOSYS when not supported
 *   or a negative errno when something bad happened
 */

I think we have missed one important information: which context these callbacks
can rely on (hard_irq, soft_irq, ...).



Best regards

Marc
