Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] PS3: System manager support
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45C8FFF7.7090805@am.sony.com>
References: <45C8FFF7.7090805@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1b5WypvX9nzyKNUPleng"
Date: Wed, 07 Feb 2007 11:00:35 +1100
Message-Id: <1170806435.4640.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1b5WypvX9nzyKNUPleng
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-06 at 14:23 -0800, Geoff Levand wrote:
> Add PS3 system manager support and the ppc_md routines restart() and
> power_off().
>=20
> The system manager provides an event notification mechanism for reporting
> events like thermal alert and button presses.  It also provides support t=
o
> control system shutdown and startup.
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
> ---
>  arch/powerpc/platforms/ps3/Kconfig |   10=20
>  arch/powerpc/platforms/ps3/setup.c |   27 +
>  drivers/ps3/Makefile               |    1=20
>  drivers/ps3/sys-manager.c          |  621 ++++++++++++++++++++++++++++++=
+++++++
>  include/asm-powerpc/ps3.h          |    5=20
>  5 files changed, 660 insertions(+), 4 deletions(-)
>=20
> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/Kconfig
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/Kconfig
> @@ -61,4 +61,14 @@ config PS3_PS3AV
>  	  This support is required for graphics and sound. In
>  	  general, all users will say Y or M.
> =20
> +config PS3_SYS_MANAGER
> +	tristate "PS3 System Manager driver"
> +	select PS3_VUART
> +	default y
> +	help
> +	  Include support for the PS3 System Manager.
> +
> +	  This support is required for system control.  In
> +	  general, all users will say Y or M.
> +
>  endmenu
> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
> @@ -42,6 +42,10 @@
>  #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
>  #endif
> =20
> +#if !defined(CONFIG_SMP)
> +static void smp_send_stop(void) {}
> +#endif
> +
>  int ps3_get_firmware_version(union ps3_firmware_version *v)
>  {
>  	int result =3D lv1_get_version_info(&v->raw);
> @@ -66,22 +70,35 @@ static void ps3_power_save(void)
>  	lv1_pause(0);
>  }
> =20
> +static void ps3_restart(char *cmd)
> +{
> +	DBG("%s:%d cmd '%s'\n", __func__, __LINE__, cmd);
> +
> +	smp_send_stop();
> +	ps3_sys_manager_restart(); /* never returns */
> +}
> +
> +static void ps3_power_off(void)
> +{
> +	DBG("%s:%d\n", __func__, __LINE__);
> +
> +	smp_send_stop();
> +	ps3_sys_manager_power_off(); /* never returns */
> +}

What happens here when the sys manager stuff is built as a module ?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1b5WypvX9nzyKNUPleng
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFyRaidSjSd0sB4dIRAowCAJ9HSJ0ADvHU8QfDB91gLZ04shbWjgCgkzm3
Mo7cJ3ufCK7Zkahwk/o9q9I=
=l7u2
-----END PGP SIGNATURE-----

--=-1b5WypvX9nzyKNUPleng--
