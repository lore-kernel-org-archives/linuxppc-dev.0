Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx:DTS: Fix tbi node location for Px020RDB
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1307501379-3160-1-git-send-email-prabhakar@freescale.com>
Date: Wed, 22 Jun 2011 06:34:11 -0500
Message-Id: <F9CD495E-12BF-467D-BE96-CC11486F70B8@kernel.crashing.org>
References: <1307501379-3160-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 7, 2011, at 9:49 PM, Prabhakar Kushwaha wrote:

> ten-bit interface (TBI) module is part of SoC not board.
>=20
> Move tbi entries from board related dts files to Si dts.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch =
next)
>=20
> arch/powerpc/boot/dts/p1020rdb.dts            |    9 ---------
> arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |    8 --------
> arch/powerpc/boot/dts/p1020si.dtsi            |    6 +++++-
> arch/powerpc/boot/dts/p2020rdb.dts            |    8 --------
> arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    8 --------
> arch/powerpc/boot/dts/p2020si.dtsi            |    6 +++++-
> 6 files changed, 10 insertions(+), 35 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p1020rdb.dts =
b/arch/powerpc/boot/dts/p1020rdb.dts
> index d6a8ae4..a4e5d6c 100644
> --- a/arch/powerpc/boot/dts/p1020rdb.dts
> +++ b/arch/powerpc/boot/dts/p1020rdb.dts
> @@ -211,14 +211,6 @@
> 			};
> 		};
>=20
> -		mdio@25000 {
> -
> -			tbi0: tbi-phy@11 {
> -				reg =3D <0x11>;
> -				device_type =3D "tbi-phy";
> -			};
> -		};
> -
> 		enet0: ethernet@b0000 {
> 			fixed-link =3D <1 1 1000 0 0>;
> 			phy-connection-type =3D "rgmii-id";
> @@ -227,7 +219,6 @@
>=20
> 		enet1: ethernet@b1000 {
> 			phy-handle =3D <&phy0>;
> -			tbi-handle =3D <&tbi0>;
> 			phy-connection-type =3D "sgmii";
>=20
> 		};

I'm not sure we should do this.  The phy address we pick is board =
specific so it should NOT be in .dtsi

- k=
