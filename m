Return-Path: <xenidis@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A4343B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 01:47:44 +1100 (EST)
Received: by ywn1 with SMTP id 1so7683065ywn.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:47:40 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH v2] powerpc: book3e: WSP: Add Chroma as a new WSP/PowerEN
 platform.
Date: Tue, 11 Oct 2011 09:47:36 -0500
Message-Id: <DD04A5E8-2850-4DDC-9E7A-B899B0EEEF11@pobox.com>
To: Scott Wood <scottwood@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue Oct 4 05:02:41 EST 2011, Scott Wood wrote:

Looking at your comments below, will the following be acceptable

> On 09/29/2011 09:27 PM, Jimi Xenidis wrote:
> > diff --git a/arch/powerpc/platforms/wsp/Kconfig =
b/arch/powerpc/platforms/wsp/Kconfig
> > index ea2811c..a3eef8e 100644
> > --- a/arch/powerpc/platforms/wsp/Kconfig
> > +++ b/arch/powerpc/platforms/wsp/Kconfig
> > @@ -1,6 +1,7 @@
> >  config PPC_WSP
> >  	bool
> >  	select PPC_A2
> > +	select GENERIC_TBSYNC
> >  	select PPC_ICSWX
> >  	select PPC_SCOM
> >  	select PPC_XICS
> > @@ -8,14 +9,20 @@ config PPC_WSP
> >  	select PCI
> >  	select PPC_IO_WORKAROUNDS if PCI
> >  	select PPC_INDIRECT_PIO if PCI
> > +	select PPC_WSP_COPRO
> >  	default n
> > =20
> >  menu "WSP platform selection"
> >  	depends on PPC_BOOK3E_64

add "&& SMP"

> > =20
> >  config PPC_PSR2
> > -	bool "PSR-2 platform"
> > -	select GENERIC_TBSYNC
> > +	bool "PowerEN System Reference Platform 2"
> > +	select EPAPR_BOOT
> > +	select PPC_WSP
> > +	default y

Make these "default n"

Will that address everything?
-jx

> > +
> > +config PPC_CHROMA
> > +	bool "PowerEN PCIe Chroma Card"
> >  	select EPAPR_BOOT
> >  	select PPC_WSP
> >  	default y
>=20
> This is an existing problem with PSR2, but please don't hide "default =
y"
> in a menu (at least make it a menuconfig).
>  As is, it's not obvious from
> looking at the toplevel platforms menu that these platforms are =
enabled
> at all.
>=20
> Further, PPC_WSP doesn't build on non-SMP (undefined references to
> boot_cpuid and get_hard_smp_processor_id in ics.c), but the platforms
> that select it don't depend on SMP.

this I can solve with=20

>=20
> -Scott
>=20
