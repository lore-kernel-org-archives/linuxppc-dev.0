Return-Path: <B29237@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CA6C11007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 19:12:34 +1100 (EST)
From: Shi Xuelin-B29237 <B29237@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: RE: [PATCH][RFC] fsldma: fix performance degradation by optimizing
 spinlock use.
Date: Thu, 24 Nov 2011 08:12:25 +0000
Message-ID: <DBB740589CE8814680DECFE34BE197AB148CDD@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1321937705-19587-1-git-send-email-b29237@freescale.com>
 <20111122185924.GA23323@ovro.caltech.edu>
In-Reply-To: <20111122185924.GA23323@ovro.caltech.edu>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira,

Thanks for your review.

After second thought, I think your scenario may not occur.
Because the cookie 20 we query must be returned by fsl_dma_tx_submit(...) i=
n practice.=20
We never query a cookie not returned by fsl_dma_tx_submit(...).

When we call fsl_tx_status(20), the chan->common.cookie is definitely wrote=
 as 20 and cpu2 could not read as 19.

How do you think?=20

Happy Thanks Giving day,
Forrest

-----Original Message-----
From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]=20
Sent: 2011=1B$BG/=1B(B11=1B$B7n=1B(B23=1B$BF|=1B(B 2:59
To: Shi Xuelin-B29237
Cc: dan.j.williams@intel.com; Li Yang-R58472; zw@zh-kernel.org; vinod.koul@=
intel.com; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] fsldma: fix performance degradation by optimizing=
 spinlock use.

On Tue, Nov 22, 2011 at 12:55:05PM +0800, b29237@freescale.com wrote:
> From: Forrest Shi <b29237@freescale.com>
>=20
>     dma status check function fsl_tx_status is heavily called in
>     a tight loop and the desc lock in fsl_tx_status contended by
>     the dma status update function. this caused the dma performance
>     degrades much.
>=20
>     this patch releases the lock in the fsl_tx_status function.
>     I believe it has no neglect impact on the following call of
>     dma_async_is_complete(...).
>=20
>     we can see below three conditions will be identified as success
>     a)  x < complete < use
>     b)  x < complete+N < use+N
>     c)  x < complete < use+N
>     here complete is the completed_cookie, use is the last_used
>     cookie, x is the querying cookie, N is MAX cookie
>=20
>     when chan->completed_cookie is being read, the last_used may
>     be incresed. Anyway it has no neglect impact on the dma status
>     decision.
>=20
>     Signed-off-by: Forrest Shi <xuelin.shi@freescale.com>
> ---
>  drivers/dma/fsldma.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c index=20
> 8a78154..1dca56f 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -986,15 +986,10 @@ static enum dma_status fsl_tx_status(struct dma_cha=
n *dchan,
>  	struct fsldma_chan *chan =3D to_fsl_chan(dchan);
>  	dma_cookie_t last_complete;
>  	dma_cookie_t last_used;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&chan->desc_lock, flags);
> =20

This will cause a bug. See below for a detailed explanation. You need this =
instead:

	/*
	 * On an SMP system, we must ensure that this CPU has seen the
	 * memory accesses performed by another CPU under the
	 * chan->desc_lock spinlock.
	 */
	smp_mb();
>  	last_complete =3D chan->completed_cookie;
>  	last_used =3D dchan->cookie;
> =20
> -	spin_unlock_irqrestore(&chan->desc_lock, flags);
> -
>  	dma_set_tx_state(txstate, last_complete, last_used, 0);
>  	return dma_async_is_complete(cookie, last_complete, last_used);  }

Facts:
- dchan->cookie is the same member as chan->common.cookie (same memory loca=
tion)
- chan->common.cookie is the "last allocated cookie for a pending transacti=
on"
- chan->completed_cookie is the "last completed transaction"

I have replaced "dchan->cookie" with "chan->common.cookie" in the below exp=
lanation, to keep everything referenced from the same structure.

Variable usage before your change. Everything is used locked.
- RW chan->common.cookie		(fsl_dma_tx_submit)
- R  chan->common.cookie		(fsl_tx_status)
- R  chan->completed_cookie		(fsl_tx_status)
- W  chan->completed_cookie		(dma_do_tasklet)

Variable usage after your change:
- RW chan->common.cookie		LOCKED
- R  chan->common.cookie		NO LOCK
- R  chan->completed_cookie		NO LOCK
- W  chan->completed_cookie             LOCKED

What if we assume that you have a 2 CPU system (such as a P2020). After you=
r changes, one possible sequence is:

=3D=3D=3D CPU1 - allocate + submit descriptor: fsl_dma_tx_submit() =3D=3D=
=3D spin_lock_irqsave
descriptor->cookie =3D 20		(x in your example)
chan->common.cookie =3D 20	(used in your example)
spin_unlock_irqrestore

=3D=3D=3D CPU2 - immediately calls fsl_tx_status() =3D=3D=3D
chan->common.cookie =3D=3D 19
chan->completed_cookie =3D=3D 19
descriptor->cookie =3D=3D 20

Since we don't have locks anymore, CPU2 may not have seen the write to
chan->common.cookie yet.

Also assume that the DMA hardware has not started processing the transactio=
n yet. Therefore dma_do_tasklet() has not been called, and
chan->completed_cookie has not been updated.

In this case, dma_async_is_complete() (on CPU2) returns DMA_SUCCESS, even t=
hough the DMA operation has not succeeded. The DMA operation has not even s=
tarted yet!

The smp_mb() fixes this, since it forces CPU2 to have seen all memory opera=
tions that happened before CPU1 released the spinlock. Spinlocks are implic=
it SMP memory barriers.

Therefore, the above example becomes:
smp_mb();
chan->common.cookie =3D=3D 20
chan->completed_cookie =3D=3D 19
descriptor->cookie =3D=3D 20

Then dma_async_is_complete() returns DMA_IN_PROGRESS, which is correct.

Thanks,
Ira
