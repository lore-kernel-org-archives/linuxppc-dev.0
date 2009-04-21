Return-Path: <pku.leo@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 816EDDDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 20:51:13 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so663758anc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 03:51:11 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <49ED859B.30904@denx.de>
References: <49ED859B.30904@denx.de>
Date: Tue, 21 Apr 2009 18:51:11 +0800
Message-ID: <2a27d3730904210351s870f015gb896a4b874b3024b@mail.gmail.com>
Subject: Re: [PATCH] [net, 83xx] ucc_geth.c: Fix upsmr setting in RMII mode
From: Li Yang <leoli@freescale.com>
To: hs@denx.de
Content-Type: text/plain; charset=UTF-8
Cc: Shlomi Gridish <gridish@freescale.com>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 21, 2009 at 4:36 PM, Heiko Schocher <hs@denx.de> wrote:
> If using the UCC on a MPC8360 in RMII mode, don;t set
> UCC_GETH_UPSMR_RPM bit in the upsmr register.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>

Acked-by: Li Yang <leoli@freescale.com>

> ---
> =C2=A0drivers/net/ucc_geth.c | =C2=A0 =C2=A03 ++-
> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index d3f39e8..44f8392 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -1394,7 +1394,8 @@ static int adjust_enet_interface(struct ucc_geth_pr=
ivate *ugeth)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ugeth->phy_interface =3D=3D PHY=
_INTERFACE_MODE_RGMII_RXID) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ugeth->phy_interface =3D=3D PHY=
_INTERFACE_MODE_RGMII_TXID) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ugeth->phy_interface =3D=3D PHY=
_INTERFACE_MODE_RTBI)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upsmr |=3D UCC_GETH_UP=
SMR_RPM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ugeth->phy_interfa=
ce !=3D PHY_INTERFACE_MODE_RMII)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 upsmr |=3D UCC_GETH_UPSMR_RPM;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (ugeth->max=
_speed) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case SPEED_10:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0upsmr |=3D UCC_GETH_UPSMR_R10M;
