Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x232.google.com (mail-pb0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6011C2C0114
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 18:30:00 +1000 (EST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so10210555pbc.23
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 01:29:57 -0700 (PDT)
Date: Sun, 14 Jul 2013 16:29:47 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] powerpc/math-emu: move the flush FPU state
 function into do_mathemu
Message-ID: <20130714082947.GB13793@pek-khao-d1.corp.ad.wrs.com>
References: <1373607402-21738-1-git-send-email-haokexin@gmail.com>
 <1373607402-21738-2-git-send-email-haokexin@gmail.com>
 <1373618233.19894.143.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
In-Reply-To: <1373618233.19894.143.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2013 at 06:37:13PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-07-12 at 13:36 +0800, Kevin Hao wrote:
> > +       /*
> > +        * If we support a HW FPU, we need to ensure the FP state
> > +        * if flushed into the thread_struct before attempting
> > +        * emulation
> > +        */
> > +#ifdef CONFIG_PPC_FPU
> > +       flush_fp_to_thread(current);
> > +#endif
> > +
>=20
> While at it, care to send a patch that defined an empty
> flush_fp_to_thread() in the header instead ?
>=20
> ie, switch_to.h
>=20
> #ifdef CONFIG_PPC_FPU
> extern void flush_fp_to_thread(struct task-struct *);
> #else
> static inline void flush_fp_to_thread(struct task-struct *) { };
> #endif
>=20
> And get rid of the ifdef's here (and elsewhere if any) ?

Sure. Matt also pointed out a typo in the comments of this patch.
So I will respin a v3 for this. But since I also have some similar
clean up patches as the change you just suggested, I will send them
as a separate patch series instead of messing the v3.

Thanks,
Kevin

>=20
> Thanks !
>=20
> Cheers,
> Ben.
>=20
>=20

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR4mF7AAoJEJNY7TDerrFxw08IAKSQ5fpVvj0s0VKE83VQK4KL
sRw5dtaf2i+6sScHauGoMe43MP/AYkuuH1+umuGz1M1JTmx81CafZBUZoxNjTZfR
Fh4WWEn0kU44N7UJy3tW0dvaTh1ixKd5uUK+5TBrS6PCxYqaI8bxBdLPVEXBjwuP
4ZN7moKVKXejWnEsALzOzJ6B2Pzhyn84SZYQ9UR1/s7S7iH8L/wRnyumRwrSP/2G
kjp/aqYjajayez6sNCqWg5dxqFGYFKdkFOo6oZXAG98vVh18eVn9TMcRyOQqPnG0
TpQunztN+E+LGhf8p19MZvGQcVTNdYVmcJ2aeFlXJ/t1vyIyrh3lCIppNSqNLDk=
=cWc9
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
