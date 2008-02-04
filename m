Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] ehea: add memory remove hotplug support
From: Michael Ellerman <michael@ellerman.id.au>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200802041624.31228.ossthema@de.ibm.com>
References: <200802041404.49960.ossthema@de.ibm.com>
	<1202136362.7672.5.camel@concordia>
	<200802041624.31228.ossthema@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iipiDIJciz2breTnx5if"
Date: Tue, 05 Feb 2008 10:14:21 +1100
Message-Id: <1202166861.7672.11.camel@concordia>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iipiDIJciz2breTnx5if
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Mon, 2008-02-04 at 16:24 +0100, Jan-Bernd Themann wrote:
> On Monday 04 February 2008 15:46, Michael Ellerman wrote:
> > On Mon, 2008-02-04 at 14:04 +0100, Jan-Bernd Themann wrote:
> > > Add memory remove hotplug support
>=20
> > > @@ -3559,6 +3578,10 @@ int __init ehea_module_init(void)
> > >  	if (ret)
> > >  		ehea_info("failed registering reboot notifier");
> > > =20
> > > +	ret =3D register_memory_notifier(&ehea_mem_nb);
> > > +	if (ret)
> > > +		ehea_info("failed registering memory remove notifier");
> > >=20
> > >  	ret =3D crash_shutdown_register(&ehea_crash_handler);
> > >  	if (ret)
> > >  		ehea_info("failed registering crash handler");
> >=20
> > You don't do anything except print a message if the registration fails.
> > What happens when someone tries to remove memory but the memory notifie=
r
> > wasn't registered properly? Bang?
>=20
> In case the registration fails and somebody tries to free memory:
> - Driver will not remove the affected memory from the eHEA memory region
>   --> Firmware (phyp) can not free that memory (as marked as used)
>   --> Therefore the removed memory could not be used in an other partitio=
n
>=20
> It makes sense to allow the driver to work anyway. Having no ethernet
> would not really be a good alternative.

Yeah I agree. I wasn't clear from the patch that no notifier -> no
memory removed. Rather than, no notifier -> memory removed and ehea
isn't told about it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-iipiDIJciz2breTnx5if
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHp5xNdSjSd0sB4dIRAiwaAJ92Njb5iA7hlwLtIey0a+wqOxaoGQCffA8q
+zpHkSlLUqJ9i1aMOFOhKTg=
=N88B
-----END PGP SIGNATURE-----

--=-iipiDIJciz2breTnx5if--
