Return-Path: <balbi@ti.com>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
 [74.125.149.199])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A68392C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 00:32:07 +1000 (EST)
Received: by lags15 with SMTP id s15so1015470lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2012 07:32:03 -0700 (PDT)
Date: Thu, 6 Sep 2012 17:27:42 +0300
From: Felipe Balbi <balbi@ti.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime
 STATUS for IN xfer
Message-ID: <20120906142739.GV29202@arwen.pp.htv.fi>
References: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C67DA2@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120906131708.GJ29202@arwen.pp.htv.fi>
 <lyehmf1b27.fsf@ensc-virt.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JNs4m2JFMNhdiK2v"
In-Reply-To: <lyehmf1b27.fsf@ensc-virt.intern.sigma-chemnitz.de>
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Chen Peter-B29397 <B29397@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, balbi@ti.com,
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


--JNs4m2JFMNhdiK2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 06, 2012 at 04:27:12PM +0200, Enrico Scholz wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> >> > Because the fsl_udc_core driver shares one 'status_req' object for t=
he
> >> > complete ep0 control transfer, it is not possible to prime the final
> >> > STATUS phase immediately after the IN transaction.  E.g. ch9getstatu=
s()
> >> > executed:
> >> >=20
> >> > | req =3D udc->status_req;
> >> > | ...
> >> > | list_add_tail(&req->queue, &ep->queue);
> >> > | if (ep0_prime_status(udc, EP_DIR_OUT))
> >> > |       ....
> >> > |       struct fsl_req *req =3D udc->status_req;
> >> > |       list_add_tail(&req->queue, &ep->queue);
> >> >=20
> >> > which corrupts the ep->queue list by inserting 'status_req' twice.  =
This
> >> > causes a kernel oops e.g. when 'lsusb -v' is executed on the host.
> >> >=20
> >> > Patch delays the final 'ep0_prime_status(udc, EP_DIR_OUT))' by movin=
g it
> >> > into the ep0 completion handler.
> >> >=20
> >> Enrico, thanks for pointing this problem.
> >>=20
> >> As "prime STATUS phase immediately after the IN transaction" is follow=
ed
> >> USB 2.0 spec, to fix this problem, it is better to add data_req for ep=
0.
> >> In fact, it is already at FSL i.mx internal code, just still not mainl=
ined.
> >
> > so, do I get an Acked-by to this patch ? Does it need to go on v3.6-rc
> > or can it wait until v3.7 merge window ?
>=20
> Without this (or the mentioned data_req patch), I can crash a g_multi
> gadget by executing 'lsusb -v' as root on the host.  Should not be
> exploitable (only a BUG_ON() is triggered) but issue should be fixed
> asap.

cool, so I'll apply to my fixes branch as soon as I get Acked-by or
Tested-by from someone.

cheers

--=20
balbi

--JNs4m2JFMNhdiK2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSLLbAAoJEIaOsuA1yqREnEUQAKifw8GQZzdIsMKR3i41TH8S
PRDhcUxxywxZByANtmHF1fH3cmUJgwBtiOculixYZsDP3ACElPcnikzm7sTYXs9F
XV5BNnlPP33EzZefpOnUUoCbkMoB8rQU+6s4LLrzVFP3DEr5zLWoi6SrXcPx6KDc
ou0gpmCwnT6AreXPahPlmyRxMJ8MWYXIWtC3c3fdlibPUJVWARHmC+lbKTnKpkgH
IjKk/W1AUDzeyWTAgCXYkccx0Pj7EAWCWw6foL+xpLXv3LGA8alw0mybzsgVavtD
/o2mLQQ6HVpWgJxuViEbrGzJZbSc12nKxscBjgg940fqBlYwIoCuVG2BYeqQWu10
ZTfHGShdhZ5xIGyXufkGYfm0rOlg6qjz6bOQp/oFxqu8/FS/uVxs1SATIWphTUjo
IPZ1Dzaej+4JHwUMGpuBcvSEYV6XkdgvFnSjA4+RzpIqclNiAZ8Hhkc7vcS30zFR
V/9o5OQVvbIjX+J4oU3jdyu2q7ScLdA2Zf9rtL3ptLhygJ4TBM5OA9tX0dgcZClw
KDarUH1cywS6OmjS+D5WkqckzgCHTeSyX1oXOFrzFkISZ7A3eI4F3bGH70XpD5js
lOSpgZfdkdfsdgBb/XU+zNNXJlQJdsg88E1x3jDiAxTY4Xl4tqBn2QOfOHMkOy7D
ax2CFkKclMafeWTS7DsL
=QL2W
-----END PGP SIGNATURE-----

--JNs4m2JFMNhdiK2v--
