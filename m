Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B1D72C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 03:53:32 +1000 (EST)
Date: Mon, 22 Jul 2013 12:53:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v4 1/3] DMA: Freescale: revise device tree binding document
To: <hongbo.zhang@freescale.com>
In-Reply-To: <1374472540-21177-2-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Mon Jul 22 00:55:38 2013)
Message-ID: <1374515600.15592.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: vinod.koul@intel.com, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, vakul@freescale.com,
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

On 07/22/2013 12:55:38 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> This updates the discription of each type of DMA controller and its =20
> channels,
> it is preparation for adding another new DMA controller binding, also =20
> fixes
> some defects of indent for text alignment at the same time.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/dma.txt        |   56 =20
> +++++++++++---------
>  1 file changed, 30 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt =20
> b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> index 2a4b4bc..0650171 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> @@ -1,33 +1,33 @@
> -* Freescale 83xx DMA Controller
> +* Freescale DMA Controllers
>=20
> -Freescale PowerPC 83xx have on chip general purpose DMA controllers.
> +** Freescale ELO DMA Controller
> +   This is a little-endian DMA controller.
> +   Used in Freescale PowerPC 83xx series, such as:
> +   mpc8313, mpc8315, mpc8323, mpc8347, mpc8349, mpc8360, mpc8377, =20
> mpc8378, mpc8379.

You don't need to list every single chip...  What happens when new =20
chips come out (not so likely with mpc83xx, but more likely for =20
eloplus/elo3)?  Do we keep updating this, or have a list that looks =20
complete but isn't?

My point in suggesting that some examples be given is just so that the =20
reader knows where to find a manual that documents a particular version =20
of "elo", and to give a rough idea of what product families use it.

> -Freescale PowerPC 85xx/86xx have on chip general purpose DMA =20
> controllers.
> +** Freescale ELOPLUS DMA Controller
> +   This is DMA controller with extended addresses and chaining.
> +   Used in Freescale PowerPC 85xx/86xx and pxxx series chips, such =20
> as:
> +   [1] mpc8540, mpc8541, mpc8555, mpc8560, mpc8610, mpc8641,
> +   [2] mpc8536, mpc8544, mpc8548, mpc8568, mpc8569, mpc8572, p1010, =20
> p1020, p1021,
> +       p1022, p1023, p2020, p2041, p3041, p4080, p5020, p5040, and =20
> also bsc9131.

What do [1] and [2] signify here?

Oh, I see.  It's weird for footnotes to come before the place they're =20
referenced...

>  Required properties:
>=20
> -- compatible        : compatible list, contains 2 entries, first is
> -		 "fsl,CHIP-dma", where CHIP is the processor
> -		 (mpc8540, mpc8540, etc.) and the second is
> -		 "fsl,eloplus-dma"
> +- compatible        : compatible list, contains 2 entries for chips =20
> in above
> +                      list[1], the first is "fsl,CHIP-dma", where =20
> CHIP is the
> +                      processor and the second is "fsl,eloplus-dma". =20
> contains
> +                      only one "fsl,eloplus-dma" for chips in above =20
> list[2]

Don't encode this difference in the binding document.  It wasn't on =20
purpose, but rather an artifact of factoring things out into dtsi =20
files.  Just make it optional.

Why can't we just talk about what compatible must include, as I =20
suggested earlier, rather than what it must *be*?

>  - reg               : <registers mapping for DMA general status reg>
>  - cell-index        : controller index.  0 for controller @ 0x21000,
>                                           1 for controller @ 0xc000
> -- ranges		: Should be defined as specified in 1) to =20
> describe the
> -		  DMA controller channels.
> +- ranges            : physical address range of DMA controller =20
> channels

ranges will not have physical addresses at this level.  They'll only =20
become physical addresses when translated by the ccsr node's ranges.

-Scott=
