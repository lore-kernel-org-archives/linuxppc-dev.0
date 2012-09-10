Return-Path: <balbi@ti.com>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
 [74.125.149.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 25C4C2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 02:26:51 +1000 (EST)
Received: by lbao2 with SMTP id o2so1131940lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 09:26:48 -0700 (PDT)
Date: Mon, 10 Sep 2012 19:22:18 +0300
From: Felipe Balbi <balbi@ti.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime
 STATUS for IN xfer
Message-ID: <20120910162215.GJ7464@arwen.pp.htv.fi>
References: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C67DA2@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120906131708.GJ29202@arwen.pp.htv.fi>
 <lyehmf1b27.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <20120906142739.GV29202@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tAmVnWIZ6lqEAvSf"
In-Reply-To: <20120906142739.GV29202@arwen.pp.htv.fi>
Cc: Chen Peter-B29397 <B29397@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tAmVnWIZ6lqEAvSf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2012 at 05:27:42PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Sep 06, 2012 at 04:27:12PM +0200, Enrico Scholz wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> >=20
> > >> > Because the fsl_udc_core driver shares one 'status_req' object for=
 the
> > >> > complete ep0 control transfer, it is not possible to prime the fin=
al
> > >> > STATUS phase immediately after the IN transaction.  E.g. ch9getsta=
tus()
> > >> > executed:
> > >> >=20
> > >> > | req =3D udc->status_req;
> > >> > | ...
> > >> > | list_add_tail(&req->queue, &ep->queue);
> > >> > | if (ep0_prime_status(udc, EP_DIR_OUT))
> > >> > |       ....
> > >> > |       struct fsl_req *req =3D udc->status_req;
> > >> > |       list_add_tail(&req->queue, &ep->queue);
> > >> >=20
> > >> > which corrupts the ep->queue list by inserting 'status_req' twice.=
  This
> > >> > causes a kernel oops e.g. when 'lsusb -v' is executed on the host.
> > >> >=20
> > >> > Patch delays the final 'ep0_prime_status(udc, EP_DIR_OUT))' by mov=
ing it
> > >> > into the ep0 completion handler.
> > >> >=20
> > >> Enrico, thanks for pointing this problem.
> > >>=20
> > >> As "prime STATUS phase immediately after the IN transaction" is foll=
owed
> > >> USB 2.0 spec, to fix this problem, it is better to add data_req for =
ep0.
> > >> In fact, it is already at FSL i.mx internal code, just still not mai=
nlined.
> > >
> > > so, do I get an Acked-by to this patch ? Does it need to go on v3.6-rc
> > > or can it wait until v3.7 merge window ?
> >=20
> > Without this (or the mentioned data_req patch), I can crash a g_multi
> > gadget by executing 'lsusb -v' as root on the host.  Should not be
> > exploitable (only a BUG_ON() is triggered) but issue should be fixed
> > asap.
>=20
> cool, so I'll apply to my fixes branch as soon as I get Acked-by or
> Tested-by from someone.

No Acks, no Tested-by ?

--=20
balbi

--tAmVnWIZ6lqEAvSf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQThO3AAoJEIaOsuA1yqRE4z0QAKG090oA0pNXuc+uknT6SSYh
hcrGAtdAwxBlomHn3it9XQDWfLfzv+rrMvfD8bCFVYzOaO4PW3Swuzjm2J4qrEgT
1beOcy5y2J9B/N7rSv429DoLIjU//0xvajmaxw2C/XOVQE6Z8facxIxqmkgN/SHU
tfQrax3G0rd2PmqhCVwHjxpMb9V/c2G907ZEOmA+jkls6I30eEb9fD1rSYuxHoDE
FwzULOYm0PCCXs7+xWemI/p8fZA0HPCSNl0bs591xjaJT1gDbscbuBVBtx9XIPdG
jBV/RMF33J6WShkA1hVKXYi4edhxxGbvcaFs64+RXD4rpW385cizO4HfhlZ0iuKD
f373sHXXvpz3HhIb+V1KnTOP7G+NPsbcUl3MZibE8YFgE0fGtHoacpviF8ajO+V1
8Wx0tGT8e4jaraKcJK4BDBqNmDX4pDwjZrif5r4Z4SiaXEdF4snI+4HtxdbfTf0I
KtSJdBv3TW22JZw0WdeNqD+N+DPsGIHJIZqLaiBw4Y93KkQQpW0ASp54SGIHozmI
BZPgMAGklLpWy+hxS2QC8MKpkuiwRatLdNpRKbQHsGARAaiOwllqqRKc9cwEfmoS
eTQavcdhhH0gt65pBSys0v22pxCaAYfbytYalPwLTIvWK4XKr89d1XSDURJZept+
2PwEjGcmKp+JmyqfLtrp
=IK04
-----END PGP SIGNATURE-----

--tAmVnWIZ6lqEAvSf--
