Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 765A7DDF11
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 13:22:24 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l262MKcM027467
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Mar 2007 19:22:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l262MJA0015499
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Mar 2007 20:22:19 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [patch 1/1] ppc: Possible bug fix for FCC driver
Date: Tue, 6 Mar 2007 10:23:43 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DA97B@zch01exm26.fsl.freescale.net>
In-Reply-To: <00B1F4365DDBE745B091C67A1CCFCB43070CE21E@zctfhxm1>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Cedric Pontois" <cpontois@nortel.com>, <dmalek@jlc.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Cedric,

For ppc embedded related patches, please also cc:
linuxppc-embedded@ozlabs.org.

> We use a kernel 2.6.14 on PPC platform (MPC 8555). The FCC driver
works

To submit a kernel patch upstream, the patch should be against the
latest kernel version which is 2.6.21-rc now.
> well with a 100Mbps link. But it doesn't with a 10Mbps link. To solve
> it, I modified the GFMR register init: removed TCI bit and set CRC32
bit
> instead of.

I don't know how these bits caused the 10M link issue.  Do you have any
reasoning?

> 	Signed-off-by: Cedric Pontois <cpontois@nortel.com>
>=20
>
------------------------------------------------------------------------
> -----
>=20
> diff -ruN pa-original/arch/ppc/8260_io/fcc_enet.c
> pa-patched/arch/ppc/8260_io/fcc_enet.c
> --- pa-original/arch/ppc/8260_io/fcc_enet.c	2007-03-02
> 14:57:07.000197000 +0100
> +++ pa-patched/arch/ppc/8260_io/fcc_enet.c	2007-03-02
> 14:57:08.000038000 +0100
> @@ -2232,7 +2232,7 @@
>=20
>  	/* Set GFMR to enable Ethernet operating mode.
>  	 */
> -	fccp->fcc_gfmr =3D (FCC_GFMR_TCI | FCC_GFMR_MODE_ENET);
> +	fccp->fcc_gfmr =3D (FCC_GFMR_TCRC_32 | FCC_GFMR_MODE_ENET);
>=20
>  	/* Set sync/delimiters.
>  	*/
>=20
