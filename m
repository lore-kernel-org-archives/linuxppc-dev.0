Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id D0C8ADDE2A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 13:26:35 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1083498rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 20:26:34 -0700 (PDT)
Date: Thu, 3 Jul 2008 21:26:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Tim Yamin <plasm@roo.me.uk>
Subject: Re: [PATCH]: [MPC5200] (v2) Add ATA DMA support
Message-ID: <20080704032601.GD12945@secretlab.ca>
References: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
	<20080701234943.GA16391@secretlab.ca>
	<792f5f410807020548m107cd6a5xf0360e07053e104c@mail.gmail.com>
	<20080702173040.GB23846@secretlab.ca>
	<792f5f410807030835q4589a27eh4b7d13e93e922a5e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <792f5f410807030835q4589a27eh4b7d13e93e922a5e@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 04:35:27PM +0100, Tim Yamin wrote:
> There's also what I believe to be a hardware bug if you have high levels
> of BestComm ATA DMA activity along with heavy LocalPlus Bus activity;
> the address bus seems to sometimes get corrupted with ATA commands while
> the LocalPlus Bus operation is still active (i.e. Chip Select is asserted).
> 
> I've asked Freescale about this but have not received a reply yet -- if
> anybody from Freescale has any ideas please contact me; I can supply some
> analyzer traces if needed. Therefore, for now, do not enable DMA if you
> need reliable LocalPlus Bus unless you do a fixup in your driver as
> follows:
> 
> Locking example:
> 
>         while (test_and_set_bit(0, &pata_mpc52xx_ata_dma_lock) != 0)
>         {
>                 struct bcom_task_2 *tsk = pata_mpc52xx_ata_dma_task;
> 
>                 if(bcom_buffer_done_2(tsk))
>                         return 1;
>         }
> 
> 	return 0;
> 
> (Save the return value to `flags`)
> 
> Unlocking example:
> 
>         if(flags == 0)
>                 clear_bit(0, &pata_mpc52xx_ata_dma_lock);
> 

One more thing.  For this description to be of any use, it needs to be
documented where somebody will actually see it.  The commit message is
great for describing *why* a change is needed, but it's not seen
so much after the change is merged.

This description should probably be added to the header comment block of
the ATA driver, and it should be talked about in the Kconfig help text
too.

g.
