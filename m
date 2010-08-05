Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 43F72B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Aug 2010 03:25:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
Date: Thu, 5 Aug 2010 10:25:18 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011935BD@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <26581.1280979260@neuling.org>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
	<AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
	<4381.1280815590@neuling.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520114309D@CORPEXCH1.na.ads.idt.com>
	<AANLkTinpwYnyc1oN1VbtBgUF6bk6E5q_Gq1Dj3WXV3wc@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011430BC@CORPEXCH1.na.ads.idt.com>
	<26581.1280979260@neuling.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Michael Neuling" <mikey@neuling.org>
Cc: Li Yang-R58472 <r58472@freescale.com>, linux-kernel@vger.kernel.org,
	Alexandre Bounine <abounine@tundra.com>, thomas.moll@sysgo.com,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Below is a copy of Leo's message with pointers to the patches.

Alex.
=20
>Subject: [PATCH] RapidIO,powerpc/85xx: remove MCSR_MASK in fsl_rio
>
>Fixes compile problem caused by MCSR_MASK removal from book-E
definitions.

Hi Alex,

Only with your patch, there will still be problem on SRIO platforms
other than MPC85xx.

I have posted a patch series to fix this together with several
compatibility issues a month before.

http://patchwork.ozlabs.org/patch/56135/
http://patchwork.ozlabs.org/patch/56136/
http://patchwork.ozlabs.org/patch/56138/
http://patchwork.ozlabs.org/patch/56137/


Can anyone pick the patch series quickly as currently there is a compile
error when SRIO is enabled.

- Leo


> -----Original Message-----
> From: Michael Neuling [mailto:mikey@neuling.org]
> Sent: Wednesday, August 04, 2010 11:34 PM
> To: Bounine, Alexandre
> Cc: Timur Tabi; Alexandre Bounine; linuxppc-dev@lists.ozlabs.org;
linux-kernel@vger.kernel.org;
> thomas.moll@sysgo.com; Kumar Gala
> Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO
port
>=20
>=20
>=20
> In message
<0CE8B6BE3C4AD74AB97D9D29BD24E552011430BC@CORPEXCH1.na.ads.idt.com> you
wrote:
> > Yang Li pointed to these patches in his post from July 23, 2010.
> > It would be nice to have these patches in mainline code.=3D20
>=20
> This is still broken in Kumar's latest tree.  Do you guys wanna repost
> them so Kumar can pick them up easily?
>=20
> Mikey
>=20
> >
> > > -----Original Message-----
> > > From: timur.tabi@gmail.com [mailto:timur.tabi@gmail.com] On Behalf
Of
> > Timur Tabi
> > > Sent: Tuesday, August 03, 2010 9:02 AM
> > > To: Bounine, Alexandre
> > > Cc: Michael Neuling; Alexandre Bounine;
linuxppc-dev@lists.ozlabs.org;
> > linux-kernel@vger.kernel.org;
> > > thomas.moll@sysgo.com; Kumar Gala
> > > Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for
SRIO
> > port
> > >=3D20
> > > On Tue, Aug 3, 2010 at 7:17 AM, Bounine, Alexandre
> > > <Alexandre.Bounine@idt.com> wrote:
> > > > This happened after change to book-e definitions.
> > > > There are patches that address this issue.
> > >=3D20
> > > And those patches should have been applied before 2.6.35 was
released.
> > >  Someone dropped the ball.  2.6.35 is broken for a number of
PowerPC
> > > boards:
> > >=3D20
> > > $ make mpc85xx_defconfig
> > > ....
> > > $ make
> > > ....
> > >   CC      arch/powerpc/sysdev/fsl_rio.o
> > > arch/powerpc/sysdev/fsl_rio.c: In function
'fsl_rio_mcheck_exception':
> > > arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared
> > > (first use in this function)
> > > arch/powerpc/sysdev/fsl_rio.c:248: error: (Each undeclared
identifier
> > > is reported only once
> > > arch/powerpc/sysdev/fsl_rio.c:248: error: for each function it
appears
> > in.)
> > > make[1]: *** [arch/powerpc/sysdev/fsl_rio.o] Error 1
> > >=3D20
> > > --
> > > Timur Tabi
> > > Linux kernel developer at Freescale
> >
