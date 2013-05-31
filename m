Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31CD12C02A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 16:44:00 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id 14so1673337pdc.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 23:43:58 -0700 (PDT)
Date: Fri, 31 May 2013 14:43:49 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130531064348.GC16514@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
In-Reply-To: <1369940099.14679.14@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2013 at 01:54:59PM -0500, Scott Wood wrote:
> On 05/30/2013 05:20:34 AM, Kevin Hao wrote:
> >On Tue, May 28, 2013 at 05:52:09PM -0500, Scott Wood wrote:
> >> On 05/21/2013 07:04:58 AM, Kevin Hao wrote:
> >> >It also seems that we don't support ISA on all the current
> >corenet ds
> >> >boards. So picking a primary bus seems useless, remove that
> >function
> >> >too.
> >>
> >> IIRC that was due to some bugs in the PPC PCI code in the absence of
> >> any primary bus.
> >
> >Do you know more about these bugs?
>=20
> Not off the top of my head -- either search the archives or ask Ben.
>=20
> >>  fsl_pci_assign_primary() will arbitrarily pick one
> >> to be primary if there's no ISA.  Have the bugs been fixed?
> >
> >I know there should be some reason that we put the
> >fsl_pci_assign_primary()
> >here. But frankly I am not sure what bugs this workaround try to
> >fix. For these
> >corenet boards picking one to be primary has no effect to the
> >64bit kernel.
> >And for 32bit kernel, the only effect of this is that isa_io_base
> >is set to the
> >io virtual base of the primary bus. But the isa_io_base only make
> >sense when
> >we do have a isa bus, so that we can access some well-known io
> >ports directly
> >by using outx/inx. But if we don't have isa bus on the board, the
> >value of
> >isa_io_base should make no sense at all. So we really don't need
> >to pick a
> >fake primary bus. Of course I may miss something, correct me if I
> >am wrong. :-)
>=20
> outx/inx can also be used for PCI I/O BARs.

Yes, I know there is also PIO. But the value of isa_io_base doesn't
have any effect for this.

Thanks,
Kevin

>=20
> -Scott

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRqEakAAoJEJNY7TDerrFxd9oIAIvNMMUEiV1LOmMIzYNjpO7I
ThOVr7YobqeLuegE++KwHA1SjgOZJWADbYSg0mx8+RGXf4CJf/7o6UAFV4DCtFpj
ExXFc1MhDjEV0AKtwzzQ2Lq8fNShgSDWaZUNCOzUYt75i2dMzUgQZ3bSiYKVs1Fz
c/nztLkLi2GpFaxdSOVmBHCCxDGj86A+TDgrGev9GN6eIWIbNgJm906sFCFtCCyd
NG5S8sf7WI3WOdxc8PuTMSz9qpDwZ6vvLiw2tMqjdqlaOgPNzM0yIOwQITvJ8NGZ
Qu+3MhkJOOYiuR6f1DU28HjRt7I58XojP3jpKsnyeMAQWy54+OHC2rcS3iUFQ1s=
=eSmZ
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
