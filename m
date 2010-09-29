Return-Path: <dan.j.williams@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 37D3EB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 07:19:36 +1000 (EST)
Received: by wyb42 with SMTP id 42so1225557wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 14:19:33 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1285628277-26894-5-git-send-email-iws@ovro.caltech.edu>
References: <1285628277-26894-1-git-send-email-iws@ovro.caltech.edu>
	<1285628277-26894-5-git-send-email-iws@ovro.caltech.edu>
Date: Wed, 29 Sep 2010 14:19:32 -0700
Message-ID: <AANLkTinYG4LqtEXxM5pdA0vavahtqbt6=yV341pnFmZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ste_dma40: implement support for scatterlist to
	scatterlist copy
From: Dan Williams <dan.j.williams@intel.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Per_Frid=E9n?= <per.friden@stericsson.com>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 27, 2010 at 3:57 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote=
:
> Now that the DMAEngine API has support for scatterlist to scatterlist
> copy, implement support for the STE DMA40 DMA controller.
>
> Cc: Linus Walleij <linus.ml.walleij@gmail.com>
> Cc: Per Frid=E9n <per.friden@stericsson.com>
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> =A0drivers/dma/ste_dma40.c | =A0 17 +++++++++++++++++
> =A01 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 17e2600..cd48859 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -1857,6 +1857,18 @@ err:
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +static struct dma_async_tx_descriptor *
> +d40_prep_sg(struct dma_chan *chan,
> + =A0 =A0 =A0 =A0 =A0 struct scatterlist *dst_sg, unsigned int dst_nents,
> + =A0 =A0 =A0 =A0 =A0 struct scatterlist *src_sg, unsigned int src_nents,
> + =A0 =A0 =A0 =A0 =A0 unsigned long dma_flags)
> +{
> + =A0 =A0 =A0 if (dst_nents !=3D src_nents)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;

I suspect you wanted "return NULL;" here.  I can fix that up.

Linus, Per ack?

--
Dan
