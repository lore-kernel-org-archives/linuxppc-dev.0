Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76DBE2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 09:13:25 +1000 (EST)
Date: Tue, 2 Jul 2013 18:13:06 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] DMA: Freescale: update driver to support 8-channel
 DMA engine
To: <hongbo.zhang@freescale.com>
In-Reply-To: <1372650378-2936-2-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Sun Jun 30 22:46:18 2013)
Message-ID: <1372806786.8183.127@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, vakul@freescale.com,
 Hongbo Zhang <hongbo.zhang@freescale.com>, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2013 10:46:18 PM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> This patch adds support to 8-channel DMA engine, thus the driver =20
> works for both
> the new 8-channel and the legacy 4-channel DMA engines.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  drivers/dma/fsldma.c |   48 =20
> ++++++++++++++++++++++++++++++++++--------------
>  drivers/dma/fsldma.h |    4 ++--
>  2 files changed, 36 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 4fc2980..0f453ea 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1119,27 +1119,33 @@ static irqreturn_t fsldma_ctrl_irq(int irq, =20
> void *data)
>  	struct fsldma_device *fdev =3D data;
>  	struct fsldma_chan *chan;
>  	unsigned int handled =3D 0;
> -	u32 gsr, mask;
> +	u8 chan_sr[round_up(FSL_DMA_MAX_CHANS_PER_DEVICE, 4)];
> +	u32 gsr;
>  	int i;
>=20
> -	gsr =3D (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
> -						   : =20
> in_le32(fdev->regs);
> -	mask =3D 0xff000000;
> -	dev_dbg(fdev->dev, "IRQ: gsr 0x%.8x\n", gsr);
> +	memset(&chan_sr, 0, sizeof(chan_sr));
> +	gsr =3D (fdev->feature & FSL_DMA_BIG_ENDIAN) ? =20
> in_be32(fdev->regs0)
> +						   : =20
> in_le32(fdev->regs0);
> +	memcpy(&chan_sr[0], &gsr, 4);
> +	dev_dbg(fdev->dev, "IRQ: gsr0 0x%.8x\n", gsr);
> +
> +	if (of_device_is_compatible(fdev->dev->of_node, =20
> "fsl,eloplus-dma2")) {

NACK; Figure out what sort of device you've got when you first probe =20
the device, and store the information for later.  Do not call device =20
tree stuff in an interrupt handler.

> +		gsr =3D (fdev->feature & FSL_DMA_BIG_ENDIAN) ?
> +			in_be32(fdev->regs1) : in_le32(fdev->regs1);
> +		memcpy(&chan_sr[4], &gsr, 4);
> +		dev_dbg(fdev->dev, "IRQ: gsr1 0x%.8x\n", gsr);
> +	}

Do these memcpy()s get inlined?  If not (and maybe even if they do), =20
it'd be better to use a union instead.

Wait a second -- how are we even getting into this code on these new =20
DMA controllers?  All 85xx-family DMA controllers use fsldma_chan_irq =20
directly.

> @@ -1341,13 +1349,22 @@ static int fsldma_of_probe(struct =20
> platform_device *op)
>  	INIT_LIST_HEAD(&fdev->common.channels);
>=20
>  	/* ioremap the registers for use */
> -	fdev->regs =3D of_iomap(op->dev.of_node, 0);
> -	if (!fdev->regs) {
> -		dev_err(&op->dev, "unable to ioremap registers\n");
> +	fdev->regs0 =3D of_iomap(op->dev.of_node, 0);
> +	if (!fdev->regs0) {
> +		dev_err(&op->dev, "unable to ioremap register0\n");
>  		err =3D -ENOMEM;
>  		goto out_free_fdev;
>  	}
>=20
> +	if (of_device_is_compatible(op->dev.of_node, =20
> "fsl,eloplus-dma2")) {

Not "fsl,eloplusplus-dma"? :-)

More seriously, if we're sticking with this "elo" naming, maybe =20
"fsl,elo3-dma" would be better.  It would be odd to have "2" in the =20
name of the third generation of this hardware.

> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> index f5c3879..880664d 100644
> --- a/drivers/dma/fsldma.h
> +++ b/drivers/dma/fsldma.h
> @@ -112,10 +112,10 @@ struct fsldma_chan_regs {
>  };
>=20
>  struct fsldma_chan;
> -#define FSL_DMA_MAX_CHANS_PER_DEVICE 4
> +#define FSL_DMA_MAX_CHANS_PER_DEVICE 8
>=20
>  struct fsldma_device {
> -	void __iomem *regs;	/* DGSR register base */
> +	void __iomem *regs0, *regs1;	/* DGSR registers */

Either give these meaningful names, or use an array.  Or both (dgsr[2]).

Or just get rid of this, since I don't see why we need DGSR1 at all, as =20
previously noted.

-Scott=
