Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts36-srv.bellnexxia.net (tomts36.bellnexxia.net
	[209.226.175.93]) by ozlabs.org (Postfix) with ESMTP id 4E794DDE40
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 07:21:36 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts36-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070205202130.YYJT1862.tomts36-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 15:21:30 -0500
Date: Mon, 5 Feb 2007 15:21:30 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h
Message-ID: <20070205202130.GB13694@Krystal>
References: <20070205193310.GA12412@Krystal>
	<1170706715.2620.126.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1170706715.2620.126.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> On Mon, 2007-02-05 at 14:33 -0500, Mathieu Desnoyers wrote:
> > Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h
> >=20
> > A missing structure forward declaration causes a lot of warnings when
> > compiling for a powerpc 405. Because this header is used for assembly
> > too, the declaration must be put within #ifndef __ASSEMBLY__, as should
> > be the function prototypes.
> >=20
> > This patch applies on 2.6.20.
> >=20
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
>=20
> Out of curiosity, are you working on 405 support for arch/powerpc ?
>=20
> Ben.
>=20

I am just trying to compile for my LTTng tracer regression tests. I guess
I'm better off using arch/pcc instead.

> > --- a/include/asm-powerpc/dcr.h
> > +++ b/include/asm-powerpc/dcr.h
> > @@ -33,10 +33,13 @@
> >   * base from the device-tree
> >   */
> >  #ifdef CONFIG_PPC_MERGE
> > +#ifndef __ASSEMBLY__
> > +struct device_node;
> >  extern unsigned int dcr_resource_start(struct device_node *np,
> >  				       unsigned int index);
> >  extern unsigned int dcr_resource_len(struct device_node *np,
> >  				     unsigned int index);
> > +#endif
> >  #endif /* CONFIG_PPC_MERGE */
> > =20
> >  #endif /* CONFIG_PPC_DCR */
>=20

--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
