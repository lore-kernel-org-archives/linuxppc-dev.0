Return-Path: <dan.j.williams@gmail.com>
Received: from mail-vw0-f204.google.com (mail-vw0-f204.google.com
	[209.85.212.204]) by ozlabs.org (Postfix) with ESMTP id 133B1B7BA4
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 12:25:16 +1100 (EST)
Received: by vws42 with SMTP id 42so748778vws.17
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 18:25:15 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1255588866-4133-1-git-send-email-Vishnu@freescale.com>
References: <1255588866-4133-1-git-send-email-Vishnu@freescale.com>
Date: Thu, 15 Oct 2009 18:25:14 -0700
Message-ID: <e9c3a7c20910151825o67cd2712id91aead70f84987c@mail.gmail.com>
Subject: Re: [PATCH v0 1/2] DMA: fsldma: Disable DMA_INTERRUPT when Async_tx
	enabled
From: Dan Williams <dan.j.williams@intel.com>
To: Vishnu Suresh <Vishnu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-crypto@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ added Leo and Timur to the Cc ]

On Wed, Oct 14, 2009 at 11:41 PM, Vishnu Suresh <Vishnu@freescale.com> wrot=
e:
> This patch disables the use of DMA_INTERRUPT capability with Async_tx
>
> The fsldma produces a null transfer with DMA_INTERRUPT
> capability when used with Async_tx. When RAID devices queue
> a transaction via Async_tx, this =A0results in a hang.
>
> Signed-off-by: Vishnu Suresh <Vishnu@freescale.com>
> ---
> =A0drivers/dma/fsldma.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 296f9e7..66d9b39 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1200,7 +1200,13 @@ static int __devinit of_fsl_dma_probe(struct of_de=
vice *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0- fdev->reg.start + 1);
>
> =A0 =A0 =A0 =A0dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
> +#ifndef CONFIG_ASYNC_CORE
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The DMA_INTERRUPT async_tx is a NULL transfer, which w=
ill
> + =A0 =A0 =A0 =A0* triger a PE interrupt.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
> +#endif
> =A0 =A0 =A0 =A0dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
> =A0 =A0 =A0 =A0fdev->common.device_alloc_chan_resources =3D fsl_dma_alloc=
_chan_resources;
> =A0 =A0 =A0 =A0fdev->common.device_free_chan_resources =3D fsl_dma_free_c=
han_resources;

You are basically saying that fsl_dma_prep_interrupt() is buggy.  Can
that routine be fixed rather than this piecemeal solution?  If it
cannot be fixed (i.e. hardware issue) then fsl_dma_prep_interrupt()
should just be disabled/deleted altogether.

--
Dan
