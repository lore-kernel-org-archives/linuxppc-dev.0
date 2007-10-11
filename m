Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] Fix regression. Make hot unlplug of CPU0 work again.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20071011073040.GD9814@bakeyournoodle.com>
References: <20071005070519.GQ9814@bakeyournoodle.com>
	<200710051716.l95HG1cV019434@sullivan.realtime.net>
	<20071011073040.GD9814@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Lq/RTzFLik5EeYGSV7dY"
Date: Fri, 12 Oct 2007 09:33:50 +1000
Message-Id: <1192145630.6274.5.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Lq/RTzFLik5EeYGSV7dY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-10-11 at 17:30 +1000, Tony Breeds wrote:
> Early in the 2.6.23 cycle we broke the ability to offline cpu0
> (7ccb4a662462616f6be5053e26b79580e02f1529).  This patch fixes that by
> ensuring that the (xics)  default irq server, will not be 0 when taking
> cpu0 offline.
>=20
> Also catches a use of irq, when virq should be used (I think that's the
> last one).
>=20
> This patch also include the fix from Milton which makes JS21 work
> aswell. In the commit message for that patch Milton writes:
> 	xics_set_affinity no longer looks at the cpu_mask arg, instead
> 	get_irq_server reads it from the irq descriptor.
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> Signed-off-by: Milton Miller <miltonm@bga.com>
>=20
> ---
> Milton also says in his patch:
> > A more complete fix might be to pass the cpu_mask struct to get_irq_ser=
ver,
> > but kernel/irq/manage.c currently sets the descriptor first.
>=20
>  arch/powerpc/platforms/pseries/xics.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platfor=
ms/pseries/xics.c
> index f0b5ff1..217ae5d 100644
> --- a/arch/powerpc/platforms/pseries/xics.c
> +++ b/arch/powerpc/platforms/pseries/xics.c
> @@ -837,6 +837,15 @@ void xics_migrate_irqs_away(void)
>  	/* Allow IPIs again... */
>  	xics_set_cpu_priority(cpu, DEFAULT_PRIORITY);
> =20
> +	/* It would be bad to migrate any IRQs to the CPU we're taking down */
> +	if (default_server =3D=3D cpu) {
> +		unsigned int new_server =3D first_cpu(cpu_online_map);
> +
> +		default_server =3D get_hard_smp_processor_id(new_server);
> +		printk(KERN_WARNING "%s: default server was %d, reset to %d\n",
> +		       __func__, cpu, default_server);

WARNING? It's not like the user can do anything about it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Lq/RTzFLik5EeYGSV7dY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHDrLddSjSd0sB4dIRAnykAKCHM2wiEeNSSnLzV0zUN5cTt+RmsQCbBT1e
kVhQK3ithMEtkdXx1ARCPIA=
=HmUF
-----END PGP SIGNATURE-----

--=-Lq/RTzFLik5EeYGSV7dY--
