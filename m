Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85E5D2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 13:42:52 +1100 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kq14so1219354pab.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jan 2014 18:42:48 -0800 (PST)
Date: Wed, 8 Jan 2014 10:42:35 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20140108024235.GA20739@pek-khao-d1.corp.ad.wrs.com>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
 <20131218234825.GA6959@home.buserror.net>
 <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
 <1388796549.11795.100.camel@snotra.buserror.net>
 <20140104063452.GA11548@pek-khao-d1.corp.ad.wrs.com>
 <1389138364.11795.205.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <1389138364.11795.205.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 05:46:04PM -0600, Scott Wood wrote:
> On Sat, 2014-01-04 at 14:34 +0800, Kevin Hao wrote:
> > Actually there still have one limitation that we have to make sure
> > that the kernel and dtb are in the 64M memory mapped by the init tlb en=
try.
> > I booted the kernel successfully by using the following u-boot commands:
> >   setenv fdt_high 0xffffffff
> >   dhcp 6000000 128.224.162.196:/vlm-boards/p5020/uImage
> >   tftp 6f00000 128.224.162.196:/vlm-boards/p5020/p5020ds.dtb
> >   bootm 6000000 - 6f00000                                              =
                                                                           =
               =20
>=20
> OK, that was it -- I hadn't set fdt_high and thus U-Boot was relocating
> the fdt under 64M.
>=20
> We should probably be using ioremap_prot() (or some other mechanism) to

It is too early to use ioremap_prot() for this case.

> create a special mapping, rather than assuming the fdt is covered by the
> initial TLB entry.  That doesn't need to happen as part of this
> patchset, of course, as it's not a new limitation.

In order to fix this limitation we would have to create a separate map for
the dtb if it is not covered by the init 64M tlb. I would like to give it
a try if I can get some time.

>=20
> > > I'm having a hard time following the logic here.  What is PAGE_OFFSET=
 -
> > > offset supposed to be?  Why would we map anything belowe PAGE_OFFSET?
> >=20
> > No, we don't map the address below PAGE_OFFSET.
> >     memstart_addr is the physical start address of RAM.
> >     start is the kernel running physical address aligned with 64M.
> >=20
> >     offset =3D memstart_addr - start
> >=20
> > So if memstart_addr < start, the offset is negative. The PAGE_OFFSET - =
offset
> > is the virtual start address we should use for the init 64M map. It's a=
bove
> > the PAGE_OFFSET instead of below.
>=20
> Oh.  I think it'd be more readable to do "offset =3D start -
> memstart_addr" and add offset instead of subtracting it.

Yes, I agree. The reason that I use "offset =3D memstart_addr - start" is t=
hat
it seems "memstart_addr" is always greater than "start" when we are booting
a kdump kernel with a kernel option like "crashkernel=3D64M@80M". :-)

>=20
> Also, offset should be phys_addr_t -- even if you don't expect to
> support offsets greater than 4G on 32-bit, it's semantically the right
> type to use.  Plus, "int" would break if this code were ever used with
> 64-bit.

I thought about using phy_addr_t for the "offset" originally but gave it up
for the following reasons:
  * It will not be greater than 4G.
  * We have to use the ugly #ifdef CONFIG_PHYS_64BIT in restore_to_as0().
  * Need more registers for arguments for restore_to_as0().

Of course you can change it to phys_addr_t if you prefer.

Thanks,
Kevin
>=20
> If you're OK with these changes, I can fix it while applying.
>=20
> -Scott
>=20
>=20

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJSzLsbAAoJEJNY7TDerrFx+t0H/jZGASrNLYnpHOzQts6qTVAe
n9R9uTuEheSA2+OQAr2e535PLEulLB4VtVxXEpdBht4AZJx03bxjxzBdlqjtoxYJ
QSr+5uG0V5TCOhLdN9+F8CAtHNWW5ICehP8W9WPMbkIxg/ZKjqjfKi9KlG1iq8sw
GLdAKApO3npjuErl5+ZSpUOJYF04TqAZjpY+4dHlsSy94oYX3nf7Cx07J+8tKbK6
IshcTzyyYq8xRwb0AqWOIPxTvKjlXa5xfzXPrJaWs6k+GZODlmwI44En9Z4FF+Zk
y+TxPTWQQgpUEFXU4ev/ljQpaRnKTIeqTos674AoeUbOzt9Pt2fNxi2HutMHFuw=
=u7KB
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
