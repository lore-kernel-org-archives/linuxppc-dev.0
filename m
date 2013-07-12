Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x235.google.com (mail-pb0-x235.google.com
 [IPv6:2607:f8b0:400e:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B7BC2C033B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 12:25:26 +1000 (EST)
Received: by mail-pb0-f53.google.com with SMTP id xb12so8447060pbc.40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 19:25:23 -0700 (PDT)
Date: Fri, 12 Jul 2013 10:25:12 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
Message-ID: <20130712022512.GB32154@pek-khao-d1.corp.ad.wrs.com>
References: <1373546721.19894.90.camel@pasglop>
 <1373553002.8183.245@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
In-Reply-To: <1373553002.8183.245@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 09:30:02AM -0500, Scott Wood wrote:
> On 07/11/2013 07:45:21 AM, Benjamin Herrenschmidt wrote:
> >On Thu, 2013-07-11 at 20:21 +0800, Kevin Hao wrote:
> >> Some cores (such as Freescale BookE) don't implement all floating
> >> point instructions in ISA. But some gcc versions do use these
> >> instructions. So we would have to enable the math emulation in this
> >> case. Add this to emulated instructions tracking statistics so that
> >> the user has a way to know that its toolcahin emit these
> >unimplemented
> >> floating point instructions.
> >
> >That patch is gross, it makes the function even more nasty than it
> >already is. Besides, CONFIG_PPC_FPU doesn't mean you have a HW FPU,
> >you need to check the CPU feature bits.
> >
> >Also the caller already does PPC_WARN_EMULATED, so this patch makes
> >you call it twice or am I missing something ?
>=20
> Sorry, that was my fault -- for some reason I didn't see that when I
> grepped for PPC_WARN_EMULATED looking for math stuff, and thus
> requested it be added.  In any case, I don't see why it should be
> conditional on having an FPU (and indeed, the warning in the caller
> isn't conditional).

I thought it only made sense to warn only for the case when the core
does have a FPU but some unimplemented floating instructions are emulated.
As for the core which doesn't have a FPU at all and we explicitly enable the
math emulation it may seems a little redundant to warn in this case. But af=
ter
a second thought, this is the statistics of all the emulated instructions,
so it does seem reasonable to warn in all cases. I will remove the dependan=
cy
on FPU.

Thanks,
Kevin

>=20
> -Scott

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR32kIAAoJEJNY7TDerrFxIwkIAJ1CW0QK5FSpKWPojOg/ztpE
VMibm1T48k/hqMp4XUm8xfFotQ2SI6enl8aoIbFiU4x3B/gTiZnnYa4Atnpm4pG3
dvJW1Z5rdc0FlLoy57aPY8cLJ6LiAPdy7oLJi2F5p7ULpn0nZSdrXBWaCL9e9s90
p9WK/qeEeFpX2n97NFlctWBOVQFnVtXW5E7U+g2rtQX6EjTzbSPz72bIdetmhv5F
ZK/f7HyecKsn2YlHOn7ZUqiOtdL8f9CFTpwm3aG7IUizVbotECJYd68510t2yssD
9QV7h4kDZK8zNhaL8XcVEfwTqlkbHXqJcGqJjpmtn6KHkv13IOkozE7hkUB/U+o=
=D0Jl
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
