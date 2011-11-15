Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B8BDDB6F84
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 08:51:35 +1100 (EST)
Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6,
 11] to high level sensitive for PCIe
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
Date: Tue, 15 Nov 2011 15:51:26 -0600
Message-Id: <45E28F47-CC83-4059-959F-E890049F416B@kernel.crashing.org>
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 7, 2011, at 2:32 AM, Roy Zang wrote:

> P1023 external IRQ[4:6, 11] do not pin out, but the interrupts are
> shared with PCIe controller.
> The silicon internally ties the interrupts to L, so change the
> IRQ[4:6,11] to high level sensitive for PCIe.
>=20
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/boot/dts/p1023rds.dts |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p1023rds.dts =
b/arch/powerpc/boot/dts/p1023rds.dts
> index d9b7767..66bf804 100644
> --- a/arch/powerpc/boot/dts/p1023rds.dts
> +++ b/arch/powerpc/boot/dts/p1023rds.dts
> @@ -490,9 +490,9 @@
> 			interrupt-map-mask =3D <0xf800 0 0 7>;
> 			interrupt-map =3D <
> 				/* IDSEL 0x0 */
> -				0000 0 0 1 &mpic 4 1
> -				0000 0 0 2 &mpic 5 1
> -				0000 0 0 3 &mpic 6 1
> +				0000 0 0 1 &mpic 4 2
> +				0000 0 0 2 &mpic 5 2
> +				0000 0 0 3 &mpic 6 2
> 				0000 0 0 4 &mpic 7 1
> 				>;
> 			ranges =3D <0x2000000 0x0 0xa0000000
> @@ -532,7 +532,7 @@
> 				0000 0 0 1 &mpic 8 1
> 				0000 0 0 2 &mpic 9 1
> 				0000 0 0 3 &mpic 10 1
> -				0000 0 0 4 &mpic 11 1
> +				0000 0 0 4 &mpic 11 2
> 				>;
> 			ranges =3D <0x2000000 0x0 0x80000000
> 				  0x2000000 0x0 0x80000000
> --=20
> 1.6.0.6
>=20

Should be setting ALL PCIe interrupts to '2'?  As I think in general we =
say these PCIe are 'active high'.  The only reason I would think we =
would NOT do this is if they are shared with some external device that =
is 'active low'.  If so we should comment that somewhere (maybe in the =
.dts, maybe just in the commit message).

- k
