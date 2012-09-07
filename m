Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A3D52C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 15:27:14 +1000 (EST)
Received: from mail185-co1 (localhost [127.0.0.1])	by
 mail185-co1-R.bigfish.com (Postfix) with ESMTP id 053A88C00AB	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 05:27:10 +0000 (UTC)
Received: from CO1EHSMHS007.bigfish.com (unknown [10.243.78.245])	by
 mail185-co1.bigfish.com (Postfix) with ESMTP id D81C19E0043	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 05:27:06 +0000 (UTC)
Received: from [43.194.30.231] ([43.194.30.231]:23960 "EHLO
 pdmx1.eu.sony.com")	by mx3.eu.sony.com with ESMTP id S54205Ab2IGF1F (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);	Fri, 7 Sep 2012 06:27:05 +0100
Received: from gb-bas-dc-dx1.eu.sony.com ([43.194.30.31]:44462 "EHLO
 gbise0weymsx02.eu.sony.com") by pdmx1.eu.sony.com with ESMTP	id
 S60061Ab2IGF1F convert rfc822-to-8bit (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);	Fri, 7 Sep 2012 06:27:05 +0100
Date: Fri, 7 Sep 2012 07:26:29 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: <geert@sonytel.be>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 4/5] powerpc: Rework set_dabr so it can take a DABRX
 value as well
In-Reply-To: <15813.1346989072@neuling.org>
Message-ID: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
References: <1346908671-7464-1-git-send-email-mikey@neuling.org>
 <1346908671-7464-4-git-send-email-mikey@neuling.org>
 <CAMuHMdU=UjkU3BRV7Aouu-m=vKaSPWH93Rkh6L3RWev4oM5jYA@mail.gmail.com>
 <15813.1346989072@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hi Mikey,

On Fri, 7 Sep 2012, Michael Neuling wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Sep 6, 2012 at 7:17 AM, Michael Neuling <mikey@neuling.org> w=
rote:
> > > Rework set_dabr to take a DABRX value as well. We are not actually
> > > changing any functionality at this stage, just preparing for that.
> >=20
> > You are changing functionality.
>=20
> You are right.. I'll fix that up.. Sorry.
>=20
> > >  #define   DABRX_USER   (1UL << 0)
> > >  #define   DABRX_KERNEL (1UL << 1)
> > > +#define   DABRX_HYP    (1UL << 2)
> > > +#define   DABRX_BTI    (1UL << 3)
> > > +#define   DABRX_ALL     (DABRX_BTI | DABRX_HYP | DABRX_KERNEL | DA=
BRX_USER)
> >=20
> > > --- a/arch/powerpc/platforms/cell/beat.c
> > > +++ b/arch/powerpc/platforms/cell/beat.c
> > > @@ -136,9 +136,9 @@ ssize_t beat_nvram_get_size(void)
> > >         return BEAT_NVRAM_SIZE;
> > >  }
> > >
> > > -int beat_set_xdabr(unsigned long dabr)
> > > +int beat_set_xdabr(unsigned long dabr, unsigned long dabrx)
> > >  {
> > > -       if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
> > > +       if (beat_set_dabr(dabr, dabrx))
> > >                 return -1;
> > >         return 0;
> > >  }
> >=20
> > > --- a/arch/powerpc/platforms/ps3/setup.c
> > > +++ b/arch/powerpc/platforms/ps3/setup.c
> > > @@ -184,11 +184,9 @@ early_param("ps3flash", early_parse_ps3flash);
> > >  #define prealloc_ps3flash_bounce_buffer()      do { } while (0)
> > >  #endif
> > >
> > > -static int ps3_set_dabr(unsigned long dabr)
> > > +static int ps3_set_dabr(unsigned long dabr, unsigned long dabrx)
> > >  {
> > > -       enum {DABR_USER =3D 1, DABR_KERNEL =3D 2,};
> > > -
> > > -       return lv1_set_dabr(dabr, DABR_KERNEL | DABR_USER) ? -1 : 0=
;
> > > +       return lv1_set_dabr(dabr, dabrx) ? -1 : 0;
> > >  }
> >=20
> > > -               set_dabr(dabr.address | (dabr.enabled & 7));
> > > +               set_dabr(dabr.address | (dabr.enabled & 7), DABRX_A=
LL);
> >=20
> > Before, beat_set_dabr() and lv1_set_dabr() would have been called wit=
h dabrx =3D 3
> > (DABRX_KERNEL | DABRX_USER). Now they're called with dabrx =3D 15
> > (DABRX_ALL =3D DABRX_BTI | DABRX_HYP | DABRX_KERNEL | DABRX_USER).
> >=20
> > No idea what's the impact of this...
>=20
> Do you know if the ps3 hypervisor will allow us to set DABRX_BTI or
> DABRX_HYP?  phyp wont. =20

According to the documenation, all bits but DABRX_USER, DABRX_KERNEL, and
DABRX_BTI must be zero.  This implies DABRX_HYP cannot be set.

BTW, the requirement that DABRX_USER and DABRX_KERNEL cannot both be zero
at the same time is also there, cfr. your comment and check in
pseries_set_xdabr().

Unfortunately, I cannot test it.

With kind regards,

Geert Uytterhoeven
Software Architect
Technology and Software Centre Europe

Sony Belgium, bijkantoor van Sony Europe Limited.
Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=B7 Belgium

Phone:  +32 (0)2 700 8453
Fax:    +32 (0)2 700 8622
E-mail: Geert.Uytterhoeven@sonycom.com

Sony Europe Limited. A company registered in England and Wales.
Registered office: The Heights, Brooklands, Weybridge, Surrey. KT13 0XW.
                   United Kingdom
