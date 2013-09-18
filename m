Return-Path: <B36685@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 157632C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 15:43:48 +1000 (EST)
Received: from mail138-co9 (localhost [127.0.0.1])	by
 mail138-co9-R.bigfish.com (Postfix) with ESMTP id E87D52E012C	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 05:43:43 +0000 (UTC)
Received: from CO9EHSMHS006.bigfish.com (unknown [10.236.132.232])	by
 mail138-co9.bigfish.com (Postfix) with ESMTP id 15E9232004C	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 05:43:43 +0000 (UTC)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Zhao Qiang-B45475 <B45475@freescale.com>
Subject: RE: [PATCH v3] powerpc/p1010rdb-pb:make a new dts for p1010rdb-pb
Date: Wed, 18 Sep 2013 05:43:41 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021ADAA42@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1379480097-11698-1-git-send-email-B45475@freescale.com>
In-Reply-To: <1379480097-11698-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Zhao Qiang-B45475
> Sent: Wednesday, September 18, 2013 12:55 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Zhao Qiang-B45475; Liu Shengzhou-B36685
> Subject: [PATCH v3] powerpc/p1010rdb-pb:make a new dts for p1010rdb-pb
>=20
> P1010RDB-PA and P1010RDB-PB boards use different external PHY interrupt s=
ignals.
> So make a new dts for P1010RDB-PB.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	-Remove phy interrupts for p1010rdb-pb
> Changes for v3:
> 	-Maintain the phy interrupts p1010rdb-pa and make a new device
> 	tree for p1010rdb-pb
>=20
>  arch/powerpc/boot/dts/p1010rdb-pa.dtsi | 11 ++++++
> arch/powerpc/boot/dts/p1010rdb-pb.dts  | 67 +++++++++++++++++++++++++++++=
+++++
>  arch/powerpc/boot/dts/p1010rdb-pb.dtsi | 11 ++++++
>  arch/powerpc/boot/dts/p1010rdb.dts     |  1 +
>  arch/powerpc/boot/dts/p1010rdb.dtsi    |  3 --
>  arch/powerpc/platforms/85xx/p1010rdb.c | 29 +++++++++++++++
>  6 files changed, 119 insertions(+), 3 deletions(-)  create mode 100644
> arch/powerpc/boot/dts/p1010rdb-pa.dtsi
>  create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
>  create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dtsi
>=20

Don't touch p1010rdb.c, create two p1010rdb-pa.dts and p1010rdb-pb.dts, whi=
ch include the common p1010rdb.dtsi.
Combine original p1010rdb.dts and p1010rdb.dtsi into new p1010rdb.dtsi with=
 removing compatible part.
Place phy node and following part in p1010rdb-pa.dts and p1010rdb-pb.dts.
/ {
        model =3D "fsl,P1010RDB-PA";
        compatible =3D "fsl,P1010RDB";
  }

/ {
        model =3D "fsl,P1010RDB-PB";
        compatible =3D "fsl,P1010RDB";
  }

-Shengzhou
