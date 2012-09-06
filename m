Return-Path: <balbi@ti.com>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
 [74.125.149.240])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C10D02C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 23:21:41 +1000 (EST)
Received: by lbao2 with SMTP id o2so1004710lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2012 06:21:31 -0700 (PDT)
Date: Thu, 6 Sep 2012 16:17:10 +0300
From: Felipe Balbi <balbi@ti.com>
To: Chen Peter-B29397 <B29397@freescale.com>
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime
 STATUS for IN xfer
Message-ID: <20120906131708.GJ29202@arwen.pp.htv.fi>
References: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C67DA2@039-SN2MPN1-023.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C67DA2@039-SN2MPN1-023.039d.mgd.msft.net>
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "balbi@ti.com" <balbi@ti.com>,
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


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2012 at 02:10:39AM +0000, Chen Peter-B29397 wrote:
> =20
> >=20
> > Because the fsl_udc_core driver shares one 'status_req' object for the
> > complete ep0 control transfer, it is not possible to prime the final
> > STATUS phase immediately after the IN transaction.  E.g. ch9getstatus()
> > executed:
> >=20
> > | req =3D udc->status_req;
> > | ...
> > | list_add_tail(&req->queue, &ep->queue);
> > | if (ep0_prime_status(udc, EP_DIR_OUT))
> > |       ....
> > |       struct fsl_req *req =3D udc->status_req;
> > |       list_add_tail(&req->queue, &ep->queue);
> >=20
> > which corrupts the ep->queue list by inserting 'status_req' twice.  This
> > causes a kernel oops e.g. when 'lsusb -v' is executed on the host.
> >=20
> > Patch delays the final 'ep0_prime_status(udc, EP_DIR_OUT))' by moving it
> > into the ep0 completion handler.
> >=20
> Enrico, thanks for pointing this problem.
>=20
> As "prime STATUS phase immediately after the IN transaction" is followed
> USB 2.0 spec, to fix this problem, it is better to add data_req for ep0.
> In fact, it is already at FSL i.mx internal code, just still not mainline=
d.

so, do I get an Acked-by to this patch ? Does it need to go on v3.6-rc
or can it wait until v3.7 merge window ?

--=20
balbi

--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSKJUAAoJEIaOsuA1yqREjfIP/jq8ZeTUI0RuYecp2LsjxjJ8
7nHxCHNzPNshSgXTv1f0vBKywLFKsA+C+Lv2UyPZknuek4nUigZCgN8lnPIvHTZC
lgePn2vQn7YOK1ADCS9qRz2xpyGYQsb0cKtcwVgi8WYg+ZN4vuZkag/4mLFuqcfm
MU4ASTO8daGsp82fK641gMecLHPub5DO5hV0isESBhJ92h9kO03PEomZzISmMHRe
GSW8f+hmVYS90X7Ca2KJ+hHtI0eDTXxcEmtM8FPqsBarixCAlMLtJ2v23zUZzMos
dFi6y6jW0egPKq0Pw7G9DUePHijE/W3JrmEEYAoICrBkq2mHqgsijrhiCRu8gx4R
4Ezv/iQVsl7h9CsEzuItv96HyXxDtNDYAmriV7NKV2wXXV0MwKBwlYlRFx5b8bIp
ZICC2WC6uYHncEf/IFjZ6PMkO79OznqiMzAJNj64LA8tQCQcBSXBJ1m02grr1Iy3
gpAl4H0hJcHL12VePPonzrqNqvkX/ruLIlfcmTHOFFVcJMSZCI2TEf/QGfwXKTF0
WA/CNEiF1WcAV6w64txR4/46E0DgpYvUGNOEfTZIlT8TDFliGsV6lYzsnbNsdV8B
J3R+RWzWeoeNWDw1onKlCYePmcj0jTVgrPUkEeQu49pGwLJjw2S/dTTobXvsMgDq
zES84LDCtnDset76bd3f
=H7WT
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--
