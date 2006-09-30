Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CB64767A33
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 21:39:03 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8UCx2qS026610
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 06:59:02 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8UBcxpg009524
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 06:39:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 7/9] Add MPC8360EMDS board support
Date: Sat, 30 Sep 2006 19:39:38 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19DB37@zch01exm20.fsl.freescale.net>
In-Reply-To: <BCC8A2FA-B29A-4D87-A3EB-820F3336E1B0@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +
> > +static u8 *bcsr_regs =3D NULL;
> > +
> > +u8 *get_bcsr(void)
> > +{
> > +	return bcsr_regs;
> > +}
>=20
> Does anything outside of this file use this?  If so, its broken since
> you iounmap(bcsr_regs) when you reset the enet phy.  If nothings
> using it, than drop the header extern and the header file.

Oops, this is a bug introduced in bcsr change.  I have fixed it in the
latest patch.  Current external user of bcsr is a workaround in ucc_geth
phy code.

- Leo
