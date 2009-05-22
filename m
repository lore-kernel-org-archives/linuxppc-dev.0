Return-Path: <pku.leo@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id B54ABDE0D1
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 18:03:29 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so810458yxb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 01:03:27 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <4A133DEF.6080604@gmail.com>
References: <4A133DEF.6080604@gmail.com>
Date: Fri, 22 May 2009 16:03:26 +0800
Message-ID: <2a27d3730905220103k12d7f9a6n269fcd079818b168@mail.gmail.com>
Subject: Re: [PATCH] freescale: beyond ARRAY_SIZE of fdev->chan
From: Li Yang <leoli@freescale.com>
To: Roel Kluin <roel.kluin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 7:17 AM, Roel Kluin <roel.kluin@gmail.com> wrote:
> Do not go beyond ARRAY_SIZE of fdev->chan
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Indeed, thanks.

But I would like the title and description of this patch be changed to
like this:

fsldma: fix check on potential fdev->chan[] overflow

Fix the check of potential array overflow when using corrupted channel
device tree nodes.

> ---
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index da8a8ed..391b1bd 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -830,7 +830,7 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dm=
a_device *fdev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0new_fsl_chan->reg.end - new_fsl_chan->reg.start + 1);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0new_fsl_chan->id =3D ((new_fsl_chan->reg.start=
 - 0x100) & 0xfff) >> 7;
> - =C2=A0 =C2=A0 =C2=A0 if (new_fsl_chan->id > FSL_DMA_MAX_CHANS_PER_DEVIC=
E) {
> + =C2=A0 =C2=A0 =C2=A0 if (new_fsl_chan->id >=3D FSL_DMA_MAX_CHANS_PER_DE=
VICE) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(fdev->dev,=
 "There is no %d channel!\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_fsl_chan->id);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -EINVAL;
