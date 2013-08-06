Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1099D2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 11:45:36 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id u10so3942055pdi.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 18:45:34 -0700 (PDT)
Date: Tue, 6 Aug 2013 09:45:23 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 7/8] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
Message-ID: <20130806014523.GD24317@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-8-git-send-email-haokexin@gmail.com>
 <1375748040.13074.111.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
In-Reply-To: <1375748040.13074.111.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2013 at 07:14:00PM -0500, Scott Wood wrote:
> On Thu, 2013-07-04 at 20:54 +0800, Kevin Hao wrote:
> > @@ -1222,6 +1266,9 @@ _GLOBAL(switch_to_as1)
> >  /*
> >   * Restore to the address space 0 and also invalidate the tlb entry cr=
eated
> >   * by switch_to_as1.
> > + * r3 - the tlb entry which should be invalidated
> > + * r4 - __pa(PAGE_OFFSET in AS0) - pa(PAGE_OFFSET in AS1)
> > + * r5 - device tree virtual address
> >  */
> >  _GLOBAL(restore_to_as0)
> [snip]
> > diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> > index 3a65644..8280dbb 100644
> > --- a/arch/powerpc/mm/mmu_decl.h
> > +++ b/arch/powerpc/mm/mmu_decl.h
> > @@ -149,7 +149,7 @@ extern void MMU_init_hw(void);
> >  extern unsigned long mmu_mapin_ram(unsigned long top);
> >  extern void adjust_total_lowmem(void);
> >  extern int switch_to_as1(void);
> > -extern void restore_to_as0(int);
> > +extern void restore_to_as0(int, int, void *);
>=20
> "int" seems wrong for the second argument. Shouldn't it be phys_addr_t?

This is the offset between __pa(PAGE_OFFSET in AS0) and __pa(PAGE_OFFSET in=
 AS1).
And the max offset should never exceed 768M. So a int type is safe here and
using this type also avoid the ugly #ifdef CONFIG_PHYS_64BIT.

>=20
> Also, please use parameter names.

Sure.

Thanks,
Kevin
>=20
> -Scott
>=20
>=20
>=20

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSAFUzAAoJEJNY7TDerrFxawQIALbi0eNulyV8bAwV55ww4+4z
fzUtguOjSjFd7dL8E+4Tgmd/cpTGje8o4MRpUg2gjV30mkOSHtzcsbM5A9UUN2HW
A96ZkoPQn2ZaIvFAePK7tEP5DVyzfEKpq1hrIQPMLsw9R5wcL4Ji8sdp5D6mH3fI
1mYEFlfBxd7ChSwI5wL51lFDnT1HjTzYouFtDY3lx2zCGZ946+nL1diryNqVgdX0
B9NASdrG6QcbSBVb208Xs9HrDzEIX7uX6GnlG5QT5i07/9vRZPosSHbG0xZyR3y1
tMe63LXszaqHw/cZ8+liFu8J6iI5i4AylO8ufTOLhh7cZ9hQ/VbJp01kfpUG83s=
=9wpF
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
