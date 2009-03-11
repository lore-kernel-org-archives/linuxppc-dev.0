Return-Path: <timur.tabi@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id CCB1EDDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 08:34:26 +1100 (EST)
Received: by ewy9 with SMTP id 9so160473ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 14:34:24 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305B1A61D@LONMLVEM04.e2k.ad.ge.com>
References: <FF6D174B07759740B0259F914CE6D7D305B1A61D@LONMLVEM04.e2k.ad.ge.com>
Date: Wed, 11 Mar 2009 16:34:24 -0500
Message-ID: <ed82fe3e0903111434u264217b5o1f8a0e6811d55308@mail.gmail.com>
Subject: Re: fsldma driver questions
From: Timur Tabi <timur@freescale.com>
To: "Crossley, Malcolm (GE EntSol,
	Intelligent Platforms)" <Malcolm.Crossley2@gefanuc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 10:52 AM, Crossley, Malcolm (GE EntSol,
Intelligent Platforms) <Malcolm.Crossley2@gefanuc.com> wrote:
> I have noticed that append_ld_queue() changes the next link descriptor
> address field in the last link descriptor of the chain. The
> append_ld_queue function is called from the fsl_dma_tx_submit() which
> can called at any time by a kernel module using that channel. This could
> result in the link descriptor being changed whilst the DMA engine is
> running. Could this issue cause unexpected behavior of the DMA engine or
> the driver?

I would need to study the code more thoroughly, but keep in mind that
a DMA descriptor is read by the DMA controller only when it is about
to be processed.  It's okay to change the descriptor contents while
the DMA buffer it references is being transferred.  The new values in
the descriptor won't be used until the DMA engine tries to use it the
next time.

> A second question I have is to do with the dma_halt() routine setting
> the channel abort flag. The dma_halt() routine is called from
> fsl_chan_xfer_ld_queue() after the dma engine has been detected as idle.
> The dma_halt() routine sets the channel stop flag and the channel abort
> flag. Whilst the dma engine could be idle, it may not have completed a
> transfer AFAICT. Or if the engine is has no more transactions then a
> channel abort does not need to be issued anyway?

I would need to study the code to answer this question.  I wrote a
different driver that uses this DMA controller, so I'm familiar with
the controller but not the code.

-- 
Timur Tabi
Linux kernel developer at Freescale
