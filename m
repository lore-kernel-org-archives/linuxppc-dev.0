Return-Path: <john.williams@petalogix.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 099E5B7D1D
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 14:12:20 +1000 (EST)
Received: by vws15 with SMTP id 15so3997510vws.15
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 21:12:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6f264a7a-e5da-494a-a24d-1578ca422807@VA3EHSMHS016.ehs.local>
References: <6f264a7a-e5da-494a-a24d-1578ca422807@VA3EHSMHS016.ehs.local>
Date: Thu, 27 May 2010 14:12:18 +1000
Message-ID: <AANLkTin0Lg8HCpCAmyy_ybPlv6K9_iyE2aFrhifw486D@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: ll_temac: fix interrupt bug when interrupt 0 is
	used
From: John Williams <john.williams@petalogix.com>
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Brian Hill <brian.hill@xilinx.com>, michal.simek@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 27, 2010 at 3:29 AM, John Linn <john.linn@xilinx.com> wrote:
> The code is not checking the interrupt for DMA correctly so that an
> interrupt number of 0 will cause a false error.
>
> Signed-off-by: Brian Hill <brian.hill@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
> =A0drivers/net/ll_temac_main.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/ll_temac_main.c b/drivers/net/ll_temac_main.c
> index fa7620e..0615737 100644
> --- a/drivers/net/ll_temac_main.c
> +++ b/drivers/net/ll_temac_main.c
> @@ -950,7 +950,7 @@ temac_of_probe(struct of_device *op, const struct of_=
device_id *match)
>
> =A0 =A0 =A0 =A0lp->rx_irq =3D irq_of_parse_and_map(np, 0);
> =A0 =A0 =A0 =A0lp->tx_irq =3D irq_of_parse_and_map(np, 1);
> - =A0 =A0 =A0 if (!lp->rx_irq || !lp->tx_irq) {
> + =A0 =A0 =A0 if ((lp->rx_irq =3D=3D NO_IRQ) || (lp->tx_irq =3D=3D NO_IRQ=
)) {

Personally I think this is the right thing to do.  But, I thought the
IRQ 0 =3D=3D NO_IRQ (AKA "all-the-world's-an-x86-and-if-not-it-should-be")
holy war was already fought and won (or lost, depending on your
perspective)?

I seem to recall giving reluctant assent to a patch from Grant a few
months ago that touched MicroBlaze thus?

John
