Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 166C22C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 12:39:56 +1100 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kq14so2605120pab.34
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jan 2014 17:39:54 -0800 (PST)
Date: Thu, 9 Jan 2014 09:39:43 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20140109013943.GA2811@pek-khao-d1.corp.ad.wrs.com>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
 <20131218234825.GA6959@home.buserror.net>
 <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
 <1388796549.11795.100.camel@snotra.buserror.net>
 <20140104063452.GA11548@pek-khao-d1.corp.ad.wrs.com>
 <1389138364.11795.205.camel@snotra.buserror.net>
 <20140108024235.GA20739@pek-khao-d1.corp.ad.wrs.com>
 <20140109000219.GA6884@home.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
In-Reply-To: <20140109000219.GA6884@home.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 06:02:19PM -0600, Scott Wood wrote:
> On Wed, Jan 08, 2014 at 10:42:35AM +0800, Kevin Hao wrote:
> > On Tue, Jan 07, 2014 at 05:46:04PM -0600, Scott Wood wrote:
> > > Oh.  I think it'd be more readable to do "offset =3D start -
> > > memstart_addr" and add offset instead of subtracting it.
> >=20
> > Yes, I agree. The reason that I use "offset =3D memstart_addr - start" =
is that
> > it seems "memstart_addr" is always greater than "start" when we are boo=
ting
> > a kdump kernel with a kernel option like "crashkernel=3D64M@80M". :-)
> >=20
> > >=20
> > > Also, offset should be phys_addr_t -- even if you don't expect to
> > > support offsets greater than 4G on 32-bit, it's semantically the right
> > > type to use.  Plus, "int" would break if this code were ever used with
> > > 64-bit.
> >=20
> > I thought about using phy_addr_t for the "offset" originally but gave i=
t up
> > for the following reasons:
> >   * It will not be greater than 4G.
> >   * We have to use the ugly #ifdef CONFIG_PHYS_64BIT in restore_to_as0(=
).
> >   * Need more registers for arguments for restore_to_as0().
> >=20
> > Of course you can change it to phys_addr_t if you prefer.
>=20
> Here's the diff I made when applying (also changed the subf in patch 9 to
> add)

Looks fine to me. I also done a boot test and it works pretty well.
Thanks Scott.

Kevin

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJSzf3fAAoJEJNY7TDerrFxd70IAK5XD207/yPUcy44jDrviF31
+RAGwv+16pV0T9ybodDjdLsdv5vJU+7UX9wPvQvZVzD5Ug9sDABaxPfnpZvGsV/G
KEAfNXWmrOv8JhRlxnlbfKDvbD3F7Qhw07t+IrudBDXmHtg2ZS282zu9zNRTFGOd
pVYq9P2zy4f9RctxIqumzsqBXiAIUYUxdhWzrch2buWnf8kgRj4sr+57NJj5GH1Y
CS/4mW7gbZLZ/SYV7zKizJqIkvKW2E1jefjpQFVqXNNx/Y1FLKAOdFy9EkQv5cVF
WpR4sWdwoaH7qyPy34HIWVWgQUEUqqYcz/YvCZWMpsdJ5YBhY1S/LcLSuf6mPGg=
=QacR
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
