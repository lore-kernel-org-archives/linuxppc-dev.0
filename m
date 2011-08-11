Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5C5FB7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 03:41:40 +1000 (EST)
Subject: Re: [PATCH v11 6/6] powerpc: Add flexcan device support for p1010rdb.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1313078831-2511-7-git-send-email-holt@sgi.com>
Date: Thu, 11 Aug 2011 12:41:34 -0500
Message-Id: <9C81E6C0-D278-40BF-8F32-445F870F845A@kernel.crashing.org>
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
	<1313078831-2511-7-git-send-email-holt@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 11, 2011, at 11:07 AM, Robin Holt wrote:

> Allow the p1010 processor to select the flexcan network driver.
>=20
> Signed-off-by: Robin Holt <holt@sgi.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>,
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>,
> Cc: U Bhaskar-B22300 <B22300@freescale.com>
> Cc: socketcan-core@lists.berlios.de,
> Cc: netdev@vger.kernel.org,
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/p1010rdb.dts  |    8 ++++++++
> arch/powerpc/platforms/85xx/Kconfig |    2 ++
> 2 files changed, 10 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p1010rdb.dts =
b/arch/powerpc/boot/dts/p1010rdb.dts
> index d6c669c..df89b60 100644
> --- a/arch/powerpc/boot/dts/p1010rdb.dts
> +++ b/arch/powerpc/boot/dts/p1010rdb.dts
> @@ -171,6 +171,14 @@
> 			};
> 		};
>=20
> +		can@1c000 {
> +			clock-frequency =3D <0x0bebc1fc>;
> +		};
> +
> +		can1: can@1d000 {
> +			clock-frequency =3D <0x0bebc1fc>;
> +		};
> +

set them to 0, as we expect u-boot to fill them in.

> 		usb@22000 {
> 			phy_type =3D "utmi";
> 		};
> diff --git a/arch/powerpc/platforms/85xx/Kconfig =
b/arch/powerpc/platforms/85xx/Kconfig
> index 498534c..c4304ae 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -70,6 +70,8 @@ config MPC85xx_RDB
> config P1010_RDB
> 	bool "Freescale P1010RDB"
> 	select DEFAULT_UIMAGE
> +	select HAVE_CAN_FLEXCAN if NET && CAN
> +	select PPC_CLOCK if CAN_FLEXCAN

Can you move this to arch/powerpc/Kconfig & FSL_SOC instead.

> 	help
> 	  This option enables support for the MPC85xx RDB (P1010 RDB) =
board
>=20
> --=20
> 1.7.2.1
