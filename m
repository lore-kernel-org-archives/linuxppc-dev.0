Return-Path: <krafft@de.ibm.com>
Date: Fri, 22 Jun 2007 16:10:39 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Akinobu Mita <mita@fixstars.com>
Subject: Re: [Cbe-oss-dev] [patch 1/5] cell: pmi remove support for mutiple
	devices.
Message-ID: <20070622161039.2d863fd9@localhost>
In-Reply-To: <20070621140731.GA24496@ps3linux.grid.fixstars.com>
References: <20070621130944.083f8fa5@localhost>
	<20070621131644.03a8ec31@localhost>
	<20070621140731.GA24496@ps3linux.grid.fixstars.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_VJ9RKS5jjkd_cPCWBnV6g8s;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_VJ9RKS5jjkd_cPCWBnV6g8s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 21 Jun 2007 23:07:31 +0900
Akinobu Mita <mita@fixstars.com> wrote:

> > =20
> > -	kfree(dev->dev.driver_data);
> > +	kfree(data);
>=20
> Shouldn't it set data =3D NULL here?
>=20
> I guess we will get "pmi: driver has already been initialized" message
> and -EBUSY on reloading pmi driver.
>=20
> > =20
> >  	return 0;
> >  }

That problem did actually not occur.
Anyway, I added the line for completeness and consistency.

But while testing I found another bug that occurred when freeing the irq. T=
he dev_id when requesting the irq was NULL,
but not when freeing the irq. I'm resending the patch as a reply to the fir=
st version.

--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_VJ9RKS5jjkd_cPCWBnV6g8s
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGe9h06rqK4qDx+dcRAvsDAJ4yt2VcQ6ZicKd98kHCmqK2Y1rNCQCggysb
8lmUeivQYc7i6GyZ4LiEBAM=
=yNYD
-----END PGP SIGNATURE-----

--Sig_VJ9RKS5jjkd_cPCWBnV6g8s--
