Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 058422C02A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 16:41:19 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id y11so1693928pdj.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 23:41:17 -0700 (PDT)
Date: Fri, 31 May 2013 14:41:05 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
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


--XF85m9dhOBO43t/C
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

Hi Ben,

Could you shed some light on this issue? Do we really has the restriction
that we have to pick one bus controller as primary even there is no
ISA bus on the board? I did check the current code and found no code
has a requirement for this. I also searched the archives and but found
nothing useful. :-(

Thanks,
Kevin

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
>=20
> -Scott

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRqEX+AAoJEJNY7TDerrFxOEQIALmjy8hVNwLPbLTuoZMfQB5s
vC5JAqXw6e/FX4Tt2Eg+CFaioqPr6Se3q3p4XxCSpQxiOHzyNXvzdHDSi7qxlKVu
2Bi+gJxHbUEg5QgB+urnhvHisTaPgmiT2/GUJMe4+WymEdUdfcXLpIO7d0fBe8l2
U8BkuLtunnfAkbxR7Yit3hyVhW89cVjgY6qGXM2tZVp6xQEo72Xd2CMpqBNN2anX
dUPZBNUsAiHkJsL0MbJTpfKTnh10KaNJgtCD7MpzmPWzTUzjtAgGrTwrVyDyU4JY
RhfEE/2d5cZ5tRFghPcfJpGEULQqAszMenknaKIVWA1hscdatmqMCGjNpgdfFQw=
=hjvH
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
