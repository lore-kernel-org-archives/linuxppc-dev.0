Return-Path: <B07421@freescale.com>
Date: Mon, 15 Jul 2013 12:57:05 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/2] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
To: <hongbo.zhang@freescale.com>
References: <1373884499-24079-1-git-send-email-hongbo.zhang@freescale.com>
 <1373884499-24079-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1373884499-24079-2-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Mon Jul 15 05:34:58 2013)
Message-ID: <1373911025.8183.308@snotra>
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

On 07/15/2013 05:34:58 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this =20
> patch add
> the device tree nodes for them.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/dma.txt        |    8 +-
>  arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   90 =20
> ++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   90 =20
> ++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
>  4 files changed, 187 insertions(+), 5 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt =20
> b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> index 2a4b4bc..8ee5732 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> @@ -76,10 +76,10 @@ Freescale PowerPC 85xx/86xx have on chip general =20
> purpose DMA controllers.
>=20
>  Required properties:
>=20
> -- compatible        : compatible list, contains 2 entries, first is
> +- compatible        : compatible list, contains 3 entries, first is
>  		 "fsl,CHIP-dma", where CHIP is the processor
>  		 (mpc8540, mpc8540, etc.) and the second is
> -		 "fsl,eloplus-dma"
> +		 "fsl,eloplus-dma", the third is "fsl,elo3-dma"

The new device tree nodes have only one compatible in the list, not =20
three.  And if you were to both fsl,eloplus-dma and fsl,elo3-dma on the =20
same node, fsl,elo3-dma should come first.

>  - reg               : <registers mapping for DMA general status reg>
>  - cell-index        : controller index.  0 for controller @ 0x21000,
>                                           1 for controller @ 0xc000
> @@ -100,7 +100,7 @@ Example:
>  	dma@21300 {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;
> -		compatible =3D "fsl,mpc8540-dma", "fsl,eloplus-dma";
> +		compatible =3D "fsl,mpc8540-dma", "fsl,eloplus-dma", =20
> "fsl,elo3-dma";

In addition to the above issue about ordering, mpc8540 does not have =20
elo3.

-Scott=
