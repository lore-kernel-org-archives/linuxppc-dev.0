Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] ehea: add memory remove hotplug support
From: Michael Ellerman <michael@ellerman.id.au>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200802041404.49960.ossthema@de.ibm.com>
References: <200802041404.49960.ossthema@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-QCqq2JusPKhITC7rc0pv"
Date: Tue, 05 Feb 2008 01:46:02 +1100
Message-Id: <1202136362.7672.5.camel@concordia>
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


--=-QCqq2JusPKhITC7rc0pv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-02-04 at 14:04 +0100, Jan-Bernd Themann wrote:
> Add memory remove hotplug support
>=20
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
>=20
> ---
>  Comment: This patch depends on the following patch that
>  exports the symbols
>   register_memory_notifier()
>   unregister_memory_notifier()
>=20
>  http://lkml.org/lkml/2008/2/1/293
>=20
>=20
>  drivers/net/ehea/ehea_main.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
> index 21af674..b75afcc 100644
> --- a/drivers/net/ehea/ehea_main.c
> +++ b/drivers/net/ehea/ehea_main.c

> @@ -3559,6 +3578,10 @@ int __init ehea_module_init(void)
>  	if (ret)
>  		ehea_info("failed registering reboot notifier");
> =20
> +	ret =3D register_memory_notifier(&ehea_mem_nb);
> +	if (ret)
> +		ehea_info("failed registering memory remove notifier");
>=20
>  	ret =3D crash_shutdown_register(&ehea_crash_handler);
>  	if (ret)
>  		ehea_info("failed registering crash handler");

You don't do anything except print a message if the registration fails.
What happens when someone tries to remove memory but the memory notifier
wasn't registered properly? Bang?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-QCqq2JusPKhITC7rc0pv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHpyUqdSjSd0sB4dIRAlyPAJ9PYmPC9I2vIrITHjtSdFBllbxuvgCfR5+g
vSN9TbNs1YIbuevLozy2Izw=
=WdXK
-----END PGP SIGNATURE-----

--=-QCqq2JusPKhITC7rc0pv--
