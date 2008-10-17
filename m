Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2FD8DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 00:09:09 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9HD6215016580
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 09:06:02 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9HD95n7170464
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 09:09:05 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9HD95d7032667
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 09:09:05 -0400
Date: Fri, 17 Oct 2008 09:09:01 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ibm_newemac: Fix new MAL feature handling
Message-ID: <20081017090901.637c1ea5@zod.rchland.ibm.com>
In-Reply-To: <200810171456.53599.arnd@arndb.de>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<1224133010.8157.543.camel@pasglop>
	<20081016143840.GA29805@yoda.jdub.homelinux.org>
	<200810171456.53599.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Oct 2008 14:56:52 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 16 October 2008, Josh Boyer wrote:
> > +#ifdef CONFIG_PPC_DCR_NATIVE
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mal_has_feature(mal=
, MAL_FTR_CLEAR_ICINTSTAT))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(mfdcri(SDR0, DCRN_SDR_ICIN=
TSTAT) | ICINTSTAT_ICTX));
> > +#endif
> > =C2=A0
>=20
> So what if you have a mmio based DRC implementation and still want to use
> this feature?

You have to have hardware that does that.  When it exists, we can
probably worry about it.  Hopefully that will never happen.  (Axon is
an abomination that should not be repeated.)

> I guess you really should use dcr_read/dcr_write here instead of mtdcr/mf=
dcr.

We can look at that.  It's not going to be high on my TODO list at the
moment though.  (hint, there are other places that do the same thing
here and they should all be cleaned up if we're going to bother.)

josh
