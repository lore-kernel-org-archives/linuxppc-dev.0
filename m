Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F22B2B7123
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 21:18:29 +1100 (EST)
Received: from mail13-va3 (localhost.localdomain [127.0.0.1])	by
	mail13-va3-R.bigfish.com (Postfix) with ESMTP id 554A1EB8281	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 10:18:23 +0000 (UTC)
Received: from VA3EHSMHS025.bigfish.com (unknown [10.7.14.245])	by
	mail13-va3.bigfish.com (Postfix) with ESMTP id D83251668050	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 10:18:22 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oABAIJcG017276	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 03:18:19 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oABAIHtv014987	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 04:18:18 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Thu, 11 Nov 2010 18:19:04 +0800
Message-ID: <9FCE46230501DF4D9461B9ACC152FD7104DDA26D@zmy16exm20.fsl.freescale.net>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E55201538B08@CORPEXCH1.na.ads.idt.com>
References: <1288777018-24259-1-git-send-email-b21989@freescale.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201538B08@CORPEXCH1.na.ads.idt.com>
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	<akpm@linux-foundation.org>
Cc: Zang Roy-R61911 <R61911@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Li Yang-R58472 <R58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




Best Regards,=20
Shaohui Xie=20


> -----Original Message-----
> From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]
> Sent: Thursday, November 11, 2010 6:55 AM
> To: Xie Shaohui-B21989; akpm@linux-foundation.org
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Li
Yang-
> R58472; Gala Kumar-B11780; Zang Roy-R61911
> Subject: RE: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
> machine_check_e500 & machine_check_e500mc
>=20
> Shaohui Xie <b21989@freescale.com> wrote:
> >
> > diff --git a/arch/powerpc/kernel/traps.c
b/arch/powerpc/kernel/traps.c
> > index a45a63c..2a5fb9d 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -55,6 +55,7 @@
> >  #endif
> >  #include <asm/kexec.h>
> >  #include <asm/ppc-opcode.h>
> > +#include <linux/rio.h>
> >
> >  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)  int
> > (*__debugger)(struct pt_regs *regs) __read_mostly; @@ -500,6 +501,13
> > @@ int machine_check_e500mc(struct pt_regs *regs)
> >  		       reason & MCSR_MEA ? "Effective" : "Physical",
> addr);
> >  	}
> >
> > +	if (reason & MCSR_BUS_RBERR) {
> > +		printk("Bus - Read Data Bus Error\n"); #ifdef
CONFIG_RAPIDIO
> > +		recoverable =3D fsl_rio_mcheck_exception(regs); #endif
> > +	}
> > +
> >  	mtspr(SPRN_MCSR, mcsr);
> >  	return mfspr(SPRN_MCSR) =3D=3D 0 && recoverable;  } @@ -527,8
+535,12
> @@
> > int machine_check_e500(struct pt_regs *regs)
> >  		printk("Bus - Write Address Error\n");
> >  	if (reason & MCSR_BUS_IBERR)
> >  		printk("Bus - Instruction Data Error\n");
> > -	if (reason & MCSR_BUS_RBERR)
> > +	if (reason & MCSR_BUS_RBERR) {
> >  		printk("Bus - Read Data Bus Error\n");
> > +#ifdef CONFIG_RAPIDIO
> > +		fsl_rio_mcheck_exception(regs);
> > +#endif
> > +	}
> >  	if (reason & MCSR_BUS_WBERR)
> >  		printk("Bus - Read Data Bus Error\n");
> >  	if (reason & MCSR_BUS_IPERR)
>=20
> This implementation breaks an intended use of
> fsl_rio_mcheck_exception():
> 1. for e500 it does not check the return value of the rio handler and
> crashes the system even after RIO Mchk was serviced. Looks like e500mc
> version handles it better but I have no HW to test it.
> 2. the RIO Mchk is expected to be handled quietly but here it has many
> printk's. May be it is better to call the fsl_rio_mcheck_exception()
> handler in very beginning and simply exit if it returns 1.
>=20
> Alex.
[Xie Shaohui-B21989] Hi Alex, seems your suggestion is some kind of
conflict with Kumar, you can have a look at=20
http://patchwork.ozlabs.org/patch/67774/

Thanks
Shaohui

>=20
>=20
