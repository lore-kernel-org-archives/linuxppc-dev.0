Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A21B82C007A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 14:54:16 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: RE: [PATCH v5 4/6] fsl-dma: move the function ahead of its invoke
 function
Date: Thu, 2 Aug 2012 04:54:04 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70D1D7E@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1343810983-25412-1-git-send-email-qiang.liu@freescale.com>
 <20120801163125.GB11359@ovro.caltech.edu>
In-Reply-To: <20120801163125.GB11359@ovro.caltech.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Vinod Koul <vinod.koul@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dan.j.williams@gmail.com" <dan.j.williams@gmail.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]
> Sent: Thursday, August 02, 2012 12:31 AM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; dan.j.williams@gmail.com; Vinod Koul;
> herbert@gondor.hengli.com.au; Dan Williams; davem@davemloft.net
> Subject: Re: [PATCH v5 4/6] fsl-dma: move the function ahead of its
> invoke function
>=20
> On Wed, Aug 01, 2012 at 04:49:43PM +0800, qiang.liu@freescale.com wrote:
> > From: Qiang Liu <qiang.liu@freescale.com>
> >
> > Move the function fsldma_cleanup_descriptor() and
> fsl_chan_xfer_ld_queue()
> > ahead of its invoke function for avoiding redundant definition.
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Li Yang <leoli@freescale.com>
> > Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> > ---
> >  drivers/dma/fsldma.c |  252 +++++++++++++++++++++++++-----------------
> --------
> >  1 files changed, 124 insertions(+), 128 deletions(-)
> >
> > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > index 87f52c0..bb883c0 100644
> > --- a/drivers/dma/fsldma.c
> > +++ b/drivers/dma/fsldma.c
> > @@ -400,9 +400,6 @@ out_splice:
> >  	list_splice_tail_init(&desc->tx_list, &chan->ld_pending);
> >  }
> >
> > -static void fsldma_cleanup_descriptor(struct fsldma_chan *chan);
> > -static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan);
> > -
>=20
> Please swap the order of this patch (patch 4/6) and the previous patch
> (patch 3/6).
>=20
> You added these lines in the patch 3/6 and deleted them here. If you
> reverse the order of the patches, this doesn't happen.
>=20
> Adding lines only to delete them in the next patch should be avoided.
I will swap the order in v6. Thanks.

>=20
> >  /**
> >   * fsldma_clean_completed_descriptor - free all descriptors which
> >   * has been completed and acked
> > @@ -519,6 +516,130 @@ fsldma_clean_running_descriptor(struct
> fsldma_chan *chan,
> >  	return 0;
> >  }
> >
> > +/**
> > + * fsl_chan_xfer_ld_queue - transfer any pending transactions
> > + * @chan : Freescale DMA channel
> > + *
> > + * HARDWARE STATE: idle
> > + * LOCKING: must hold chan->desc_lock
> > + */
> > +static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
> > +{
> > +	struct fsl_desc_sw *desc;
> > +
> > +	/*
> > +	 * If the list of pending descriptors is empty, then we
> > +	 * don't need to do any work at all
> > +	 */
> > +	if (list_empty(&chan->ld_pending)) {
> > +		chan_dbg(chan, "no pending LDs\n");
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * The DMA controller is not idle, which means that the interrupt
> > +	 * handler will start any queued transactions when it runs after
> > +	 * this transaction finishes
> > +	 */
> > +	if (!chan->idle) {
> > +		chan_dbg(chan, "DMA controller still busy\n");
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * If there are some link descriptors which have not been
> > +	 * transferred, we need to start the controller
> > +	 */
> > +
> > +	/*
> > +	 * Move all elements from the queue of pending transactions
> > +	 * onto the list of running transactions
> > +	 */
> > +	chan_dbg(chan, "idle, starting controller\n");
> > +	desc =3D list_first_entry(&chan->ld_pending, struct fsl_desc_sw,
> node);
> > +	list_splice_tail_init(&chan->ld_pending, &chan->ld_running);
> > +
> > +	/*
> > +	 * The 85xx DMA controller doesn't clear the channel start bit
> > +	 * automatically at the end of a transfer. Therefore we must clear
> > +	 * it in software before starting the transfer.
> > +	 */
> > +	if ((chan->feature & FSL_DMA_IP_MASK) =3D=3D FSL_DMA_IP_85XX) {
> > +		u32 mode;
> > +
> > +		mode =3D DMA_IN(chan, &chan->regs->mr, 32);
> > +		mode &=3D ~FSL_DMA_MR_CS;
> > +		DMA_OUT(chan, &chan->regs->mr, mode, 32);
> > +	}
> > +
> > +	/*
> > +	 * Program the descriptor's address into the DMA controller,
> > +	 * then start the DMA transaction
> > +	 */
> > +	set_cdar(chan, desc->async_tx.phys);
> > +	get_cdar(chan);
> > +
> > +	dma_start(chan);
> > +	chan->idle =3D false;
> > +}
> > +
> > +/**
> > + * fsldma_cleanup_descriptor - cleanup and free a single link
> descriptor
> > + * @chan: Freescale DMA channel
> > + * @desc: descriptor to cleanup and free
> > + *
> > + * This function is used on a descriptor which has been executed by
> the DMA
> > + * controller. It will run any callbacks, submit any dependencies, and
> then
> > + * free the descriptor.
> > + */
> > +static void fsldma_cleanup_descriptor(struct fsldma_chan *chan)
> > +{
> > +	struct fsl_desc_sw *desc, *_desc;
> > +	dma_cookie_t cookie =3D 0;
> > +	dma_addr_t curr_phys =3D get_cdar(chan);
> > +	int idle =3D dma_is_idle(chan);
> > +	int seen_current =3D 0;
> > +
> > +	fsldma_clean_completed_descriptor(chan);
> > +
> > +	/* Run the callback for each descriptor, in order */
> > +	list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
> > +		/*
> > +		 * do not advance past the current descriptor loaded into the
> > +		 * hardware channel, subsequent descriptors are either in
> > +		 * process or have not been submitted
> > +		 */
> > +		if (seen_current)
> > +			break;
> > +
> > +		/*
> > +		 * stop the search if we reach the current descriptor and the
> > +		 * channel is busy
> > +		 */
> > +		if (desc->async_tx.phys =3D=3D curr_phys) {
> > +			seen_current =3D 1;
> > +			if (!idle)
> > +				break;
> > +		}
> > +
> > +		cookie =3D fsldma_run_tx_complete_actions(desc, chan, cookie);
> > +
> > +		if (fsldma_clean_running_descriptor(chan, desc))
> > +			break;
> > +	}
> > +
> > +	/*
> > +	 * Start any pending transactions automatically
> > +	 *
> > +	 * In the ideal case, we keep the DMA controller busy while we go
> > +	 * ahead and free the descriptors below.
> > +	 */
> > +	fsl_chan_xfer_ld_queue(chan);
> > +
> > +	if (cookie > 0)
> > +		chan->common.completed_cookie =3D cookie;
> > +}
> > +
> >  static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor
> *tx)
> >  {
> >  	struct fsldma_chan *chan =3D to_fsl_chan(tx->chan);
> > @@ -932,131 +1053,6 @@ static int fsl_dma_device_control(struct
> dma_chan *dchan,
> >  }
> >
> >  /**
> > - * fsldma_cleanup_descriptor - cleanup and free a single link
> descriptor
> > - * @chan: Freescale DMA channel
> > - * @desc: descriptor to cleanup and free
> > - *
> > - * This function is used on a descriptor which has been executed by
> the DMA
> > - * controller. It will run any callbacks, submit any dependencies, and
> then
> > - * free the descriptor.
> > - */
> > -static void fsldma_cleanup_descriptor(struct fsldma_chan *chan)
> > -{
> > -	struct fsl_desc_sw *desc, *_desc;
> > -	dma_cookie_t cookie =3D 0;
> > -	dma_addr_t curr_phys =3D get_cdar(chan);
> > -	int idle =3D dma_is_idle(chan);
> > -	int seen_current =3D 0;
> > -
> > -	fsldma_clean_completed_descriptor(chan);
> > -
> > -	/* Run the callback for each descriptor, in order */
> > -	list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
> > -		/*
> > -		 * do not advance past the current descriptor loaded into the
> > -		 * hardware channel, subsequent descriptors are either in
> > -		 * process or have not been submitted
> > -		 */
> > -		if (seen_current)
> > -			break;
> > -
> > -		/*
> > -		 * stop the search if we reach the current descriptor and the
> > -		 * channel is busy
> > -		 */
> > -		if (desc->async_tx.phys =3D=3D curr_phys) {
> > -			seen_current =3D 1;
> > -			if (!idle)
> > -				break;
> > -		}
> > -
> > -		cookie =3D fsldma_run_tx_complete_actions(desc, chan, cookie);
> > -
> > -		if (fsldma_clean_running_descriptor(chan, desc))
> > -			break;
> > -
> > -	}
> > -
> > -	/*
> > -	 * Start any pending transactions automatically
> > -	 *
> > -	 * In the ideal case, we keep the DMA controller busy while we go
> > -	 * ahead and free the descriptors below.
> > -	 */
> > -	fsl_chan_xfer_ld_queue(chan);
> > -
> > -	if (cookie > 0)
> > -		chan->common.completed_cookie =3D cookie;
> > -}
> > -
> > -/**
> > - * fsl_chan_xfer_ld_queue - transfer any pending transactions
> > - * @chan : Freescale DMA channel
> > - *
> > - * HARDWARE STATE: idle
> > - * LOCKING: must hold chan->desc_lock
> > - */
> > -static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
> > -{
> > -	struct fsl_desc_sw *desc;
> > -
> > -	/*
> > -	 * If the list of pending descriptors is empty, then we
> > -	 * don't need to do any work at all
> > -	 */
> > -	if (list_empty(&chan->ld_pending)) {
> > -		chan_dbg(chan, "no pending LDs\n");
> > -		return;
> > -	}
> > -
> > -	/*
> > -	 * The DMA controller is not idle, which means that the interrupt
> > -	 * handler will start any queued transactions when it runs after
> > -	 * this transaction finishes
> > -	 */
> > -	if (!chan->idle) {
> > -		chan_dbg(chan, "DMA controller still busy\n");
> > -		return;
> > -	}
> > -
> > -	/*
> > -	 * If there are some link descriptors which have not been
> > -	 * transferred, we need to start the controller
> > -	 */
> > -
> > -	/*
> > -	 * Move all elements from the queue of pending transactions
> > -	 * onto the list of running transactions
> > -	 */
> > -	chan_dbg(chan, "idle, starting controller\n");
> > -	desc =3D list_first_entry(&chan->ld_pending, struct fsl_desc_sw,
> node);
> > -	list_splice_tail_init(&chan->ld_pending, &chan->ld_running);
> > -
> > -	/*
> > -	 * The 85xx DMA controller doesn't clear the channel start bit
> > -	 * automatically at the end of a transfer. Therefore we must clear
> > -	 * it in software before starting the transfer.
> > -	 */
> > -	if ((chan->feature & FSL_DMA_IP_MASK) =3D=3D FSL_DMA_IP_85XX) {
> > -		u32 mode;
> > -
> > -		mode =3D DMA_IN(chan, &chan->regs->mr, 32);
> > -		mode &=3D ~FSL_DMA_MR_CS;
> > -		DMA_OUT(chan, &chan->regs->mr, mode, 32);
> > -	}
> > -
> > -	/*
> > -	 * Program the descriptor's address into the DMA controller,
> > -	 * then start the DMA transaction
> > -	 */
> > -	set_cdar(chan, desc->async_tx.phys);
> > -	get_cdar(chan);
> > -
> > -	dma_start(chan);
> > -	chan->idle =3D false;
> > -}
> > -
> > -/**
> >   * fsl_dma_memcpy_issue_pending - Issue the DMA start command
> >   * @chan : Freescale DMA channel
> >   */
> > --
> > 1.7.5.1
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
