Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0BE0B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 May 2010 02:36:20 +1000 (EST)
Subject: Re: [PATCH 3/3] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100429092005.GA6727@riccoc20.at.omicron.at>
Date: Sat, 1 May 2010 11:36:12 -0500
Message-Id: <FFD6BE31-AF2B-4D44-9751-61DB06327DBD@kernel.crashing.org>
References: <20100429092005.GA6727@riccoc20.at.omicron.at>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 29, 2010, at 4:20 AM, Richard Cochran wrote:

> The eTSEC includes a PTP clock with quite a few features. This patch =
adds
> support for the basic clock adjustment functions.
>=20
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> ---
> arch/powerpc/boot/dts/mpc8313erdb.dts |   14 ++
> arch/powerpc/boot/dts/p2020ds.dts     |   13 ++
> arch/powerpc/boot/dts/p2020rdb.dts    |   14 ++
> drivers/net/Makefile                  |    1 +
> drivers/net/gianfar_ptp.c             |  308 =
+++++++++++++++++++++++++++++++++
> drivers/net/gianfar_ptp_reg.h         |  107 ++++++++++++
> drivers/ptp/Kconfig                   |   13 ++
> 7 files changed, 470 insertions(+), 0 deletions(-)
> create mode 100644 drivers/net/gianfar_ptp.c
> create mode 100644 drivers/net/gianfar_ptp_reg.h
>=20
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts =
b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index 183f2aa..b760aee 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -208,6 +208,20 @@
> 			sleep =3D <&pmc 0x00300000>;
> 		};
>=20
> +		ptp_clock@24E00 {
> +			device_type =3D "ptp_clock";
> +			model =3D "eTSEC";
> +			reg =3D <0x24E00 0xB0>;
> +			interrupts =3D <0x0C 2 0x0D 2>;
> +			interrupt-parent =3D < &ipic >;
> +			tclk_period =3D <10>;
> +			tmr_prsc    =3D <100>;
> +			tmr_add     =3D <0x999999A4>;
> +			cksel       =3D <0x1>;
> +			tmr_fiper1  =3D <0x3B9AC9F6>;
> +			tmr_fiper2  =3D <0x00018696>;
> +		};
> +
> 		enet0: ethernet@24000 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;

Is there a binding document that describes this node you are adding?

- k=
