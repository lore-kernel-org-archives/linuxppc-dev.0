Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D47AC2C0098
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Jul 2013 04:28:29 +1000 (EST)
Date: Tue, 30 Jul 2013 13:28:11 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for C293
To: Po Liu <Po.Liu@freescale.com>
References: <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-1-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-2-git-send-email-Po.Liu@freescale.com>
In-Reply-To: <1375174163-19246-2-git-send-email-Po.Liu@freescale.com> (from
 Po.Liu@freescale.com on Tue Jul 30 03:49:22 2013)
Message-ID: <1375208891.30721.74@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.Hu@freescale.com>,
 afleming@freescale.com, Po Liu <Po.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 03:49:22 AM, Po Liu wrote:
> From: Mingkai Hu <Mingkai.Hu@freescale.com>
>=20
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Signed-off-by: Po Liu <Po.Liu@freescale.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
>=20
>  arch/powerpc/boot/dts/fsl/c293si-post.dtsi | 193 =20
> +++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/c293si-pre.dtsi  |  63 ++++++++++
>  2 files changed, 256 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/fsl/c293si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/c293si-pre.dtsi
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/c293si-post.dtsi =20
> b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
> new file mode 100644
> index 0000000..bd20832
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
> @@ -0,0 +1,193 @@
> +/*
> + * C293 Silicon/SoC Device Tree Source (post include)
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following =20
> conditions are met:
> + *     * Redistributions of source code must retain the above =20
> copyright
> + *       notice, this list of conditions and the following =20
> disclaimer.
> + *     * Redistributions in binary form must reproduce the above =20
> copyright
> + *       notice, this list of conditions and the following =20
> disclaimer in the
> + *       documentation and/or other materials provided with the =20
> distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote =20
> products
> + *       derived from this software without specific prior written =20
> permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms =20
> of the
> + * GNU General Public License ("GPL") as published by the Free =20
> Software
> + * Foundation, either version 2 of that License or (at your option) =20
> any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' =20
> AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE =20
> IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR =20
> PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE =20
> FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR =20
> CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS =20
> OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER =20
> CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT =20
> LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =20
> USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +&ifc {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <1>;
> +	compatible =3D "fsl,ifc", "simple-bus";
> +	interrupts =3D <19 2 0 0>;
> +};
> +
> +/* controller at 0xa000 */
> +&pci0 {
> +	compatible =3D "fsl,qoriq-pcie-v2.2", "fsl,qoriq-pcie";
> +	device_type =3D "pci";
> +	#size-cells =3D <2>;
> +	#address-cells =3D <3>;
> +	bus-range =3D <0 255>;
> +	clock-frequency =3D <33333333>;
> +	interrupts =3D <16 2 0 0>;

Remove clock-frequency (surely PCIe is not running at 33 MHz).

> +	crypto@80000 {
> +/include/ "qoriq-sec6.0-0.dtsi"
> +	};
> +
> +	crypto@80000 {
> +		reg =3D <0x80000 0x20000>;
> +		ranges =3D <0x0 0x80000 0x20000>;
> +
> +		jr@1000{
> +			interrupts =3D <45 2 0 0>;
> +		};
> +		jr@2000{
> +			interrupts =3D <57 2 0 0>;
> +		};
> +	};

Do these inline the way the example shows.

-Scott=
