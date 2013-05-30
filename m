Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB7C32C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 20:20:46 +1000 (EST)
Received: by mail-pd0-f172.google.com with SMTP id 10so93726pdi.31
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 03:20:44 -0700 (PDT)
Date: Thu, 30 May 2013 18:20:34 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <1369781529.18630.25@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 05:52:09PM -0500, Scott Wood wrote:
> On 05/21/2013 07:04:58 AM, Kevin Hao wrote:
> >It also seems that we don't support ISA on all the current corenet ds
> >boards. So picking a primary bus seems useless, remove that function
> >too.
>=20
> IIRC that was due to some bugs in the PPC PCI code in the absence of
> any primary bus.

Do you know more about these bugs?

>  fsl_pci_assign_primary() will arbitrarily pick one
> to be primary if there's no ISA.  Have the bugs been fixed?

I know there should be some reason that we put the fsl_pci_assign_primary()
here. But frankly I am not sure what bugs this workaround try to fix. For t=
hese
corenet boards picking one to be primary has no effect to the 64bit kernel.
And for 32bit kernel, the only effect of this is that isa_io_base is set to=
 the
io virtual base of the primary bus. But the isa_io_base only make sense when
we do have a isa bus, so that we can access some well-known io ports direct=
ly
by using outx/inx. But if we don't have isa bus on the board, the value of
isa_io_base should make no sense at all. So we really don't need to pick a
fake primary bus. Of course I may miss something, correct me if I am wrong.=
 :-)

Thanks,
Kevin


>=20
> -Scott

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRpyfyAAoJEJNY7TDerrFx8aEH/3EAsFlMB7jCVHjDEzWPi2W8
JeTCBj1+dKDOsYiamCBh2Wt/iAbji6FXd4iA4daJCfQFZdtBZFMi5ZtvBrlyG+RM
u0QbEO+jIXiB1oX7TY93k6MzLsYyQjlyeXW86OgubSHsyNTr+w6C9Thh/gYALT2p
34l2mmuNHMj/Lq2e04qaN418RbqWVxpsljs6+NqanaW27rk68ipSmimzDJ9oZe8z
Rw2dSr8v6+0YoI830t3mFYrT6T9UXbIPLKLu55DMDBnGtP5Yjd9Z/2F6uzoAN8id
dS8Bll5NVLsnrV8XCAPy/Zr18aNrpT+OyvvjfS6VOT4281LaVZ3RvQWz8jAkzUE=
=VSTw
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
