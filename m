Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B25EC1007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 00:22:47 +1000 (EST)
Subject: Re: [PATCH 3/4] p4080ds-dts: Add two rapidio ports and message units
	support
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1317263341-19010-3-git-send-email-Gang.Liu@freescale.com>
Date: Thu, 29 Sep 2011 09:22:52 -0500
Message-Id: <7DB8223D-7300-4578-B0C0-22B52AFF306D@kernel.crashing.org>
References: <1317263341-19010-1-git-send-email-Gang.Liu@freescale.com>
	<1317263341-19010-3-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: Jin Qing <b24347@freescale.com>, r58472@freescale.com,
	linux-kernel@vger.kernel.org, r61911@freescale.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 28, 2011, at 9:29 PM, Liu Gang wrote:

> Add two message units and number of ports according to the p4080 =
reference manual.

Explain why range size increased.

>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> arch/powerpc/boot/dts/p4080ds.dts  |    4 +-
> arch/powerpc/boot/dts/p4080si.dtsi |   37 =
+++++++++++++++++++++++++++--------
> 2 files changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts =
b/arch/powerpc/boot/dts/p4080ds.dts
> index eb11098..94a0cd4 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -101,9 +101,9 @@
> 		};
> 	};
>=20
> -	rapidio0: rapidio@ffe0c0000 {
> +	rapidio: rapidio@ffe0c0000 {
> 		reg =3D <0xf 0xfe0c0000 0 0x20000>;
> -		ranges =3D <0 0 0xc 0x20000000 0 0x01000000>;
> +		ranges =3D <0 0 0xc 0x20000000 0 0x20000000>;
> 	};
>=20
> 	localbus@ffe124000 {
> diff --git a/arch/powerpc/boot/dts/p4080si.dtsi =
b/arch/powerpc/boot/dts/p4080si.dtsi
> index b71051f..816a629 100644
> --- a/arch/powerpc/boot/dts/p4080si.dtsi
> +++ b/arch/powerpc/boot/dts/p4080si.dtsi
> @@ -69,8 +69,9 @@
> 		rtic_c =3D &rtic_c;
> 		rtic_d =3D &rtic_d;
> 		sec_mon =3D &sec_mon;
> +		rmu =3D &rmu;
>=20
> -		rio0 =3D &rapidio0;
> +		rio =3D &rapidio;
> 	};
>=20
> 	cpus {
> @@ -555,20 +556,38 @@
> 			interrupt-parent =3D <&mpic>;
> 			interrupts =3D <93 2 0 0>;
> 		};
> +
> +		rmu: rmu@d3000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "fsl,rmu";
> +			reg =3D <0xd3000 0x200>;
> +
> +			message-unit@0 {
> +				reg =3D <0x0 0x100>;
> +				interrupts =3D <
> +						60 2 0 0  /* msg1_tx_irq =
*/
> +						61 2 0 0>;/* msg1_rx_irq =
*/
> +			};
> +			message-unit@1 {

message-unit@100

> +				reg =3D <0x100 0x100>;
> +				interrupts =3D <
> +						62 2 0 0  /* msg2_tx_irq =
*/
> +						63 2 0 0>;/* msg2_rx_irq =
*/
> +			};
> +		};
> 	};
>=20
> -	rapidio0: rapidio@ffe0c0000 {
> +	rapidio: rapidio@ffe0c0000 {
> 		#address-cells =3D <2>;
> 		#size-cells =3D <2>;
> 		compatible =3D "fsl,rapidio-delta";

change to 'fsl,srio' per comments on binding patch.

> 		interrupts =3D <
> -			16 2 1 11 /* err_irq */
> -			56 2 0 0  /* bell_outb_irq */
> -			57 2 0 0  /* bell_inb_irq */
> -			60 2 0 0  /* msg1_tx_irq */
> -			61 2 0 0  /* msg1_rx_irq */
> -			62 2 0 0  /* msg2_tx_irq */
> -			63 2 0 0>; /* msg2_rx_irq */
> +				16 2 1 11 /* err_irq */
> +				56 2 0 0  /* bell_outb_irq */
> +				57 2 0 0>;/* bell_inb_irq */
> +		fsl,rio-num-ports =3D <2>;
> +		rmu-handle =3D <&rmu>;
> 	};
>=20
> 	localbus@ffe124000 {
> --=20
> 1.7.3.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
