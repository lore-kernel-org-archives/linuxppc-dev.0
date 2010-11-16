Return-Path: <B21989@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11A0CB710A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 13:41:41 +1100 (EST)
Received: from mail17-am1 (localhost.localdomain [127.0.0.1])	by
	mail17-am1-R.bigfish.com (Postfix) with ESMTP id 3725A928461	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 16 Nov 2010 02:41:34 +0000 (UTC)
Received: from AM1EHSMHS001.bigfish.com (unknown [10.3.201.244])	by
	mail17-am1.bigfish.com (Postfix) with ESMTP id D334E15B8050	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 16 Nov 2010 02:41:33 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oAG2fVfP022061	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Nov 2010 19:41:31 -0700 (MST)
Received: from az33exm20.fsl.freescale.net (az33exm20.am.freescale.net
	[10.64.32.6])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oAG2fUbQ006348	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Nov 2010 20:41:30 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH][v3] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Mon, 15 Nov 2010 19:42:24 -0700
Message-ID: <267A3B246C22C34A8E574051858E0770E957@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E55201539084@CORPEXCH1.na.ads.idt.com>
References: <1289548520-24110-1-git-send-email-b21989@freescale.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201539084@CORPEXCH1.na.ads.idt.com>
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>, Xie Shaohui-B21989
	<B21989@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: akpm@linux-foundation.org, Gala Kumar-B11780 <B11780@freescale.com>,
	Li Yang-R58472 <r58472@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]
> Sent: Saturday, November 13, 2010 12:30 AM
> To: Xie Shaohui-B21989; linuxppc-dev@lists.ozlabs.org
> Cc: akpm@linux-foundation.org; Li Yang-R58472; Gala Kumar-B11780; Zang
> Roy-R61911
> Subject: RE: [PATCH][v3] fsl_rio: move machine_check handler into
> machine_check_e500 & machine_check_e500mc
>=20
> > int machine_check_e500mc(struct pt_regs *regs)  int
> > machine_check_e500(struct pt_regs *regs)  {
> >  	unsigned long reason =3D get_mc_reason(regs);
> > +	int ret =3D 0;
> > +
> > +	if (reason & MCSR_BUS_RBERR) {
> > +		ret =3D fsl_rio_mcheck_exception(regs);
> > +		if (ret =3D=3D 1)
> > +			return ret;
> > +	}
>=20
> Do we really need 'ret' variable here?
> There is no further use of it by the rest of the code.
> Maybe just return 1 here if fsl_rio_mcheck_exception() returns 1 ?
>=20
> >

Ok, I'll remove the ret, do you have any comment for the error handler
patch?
http://patchwork.ozlabs.org/patch/69962/


Thanks & Best Regards,
Shaohui
