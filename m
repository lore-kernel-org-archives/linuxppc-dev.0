Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/kexec: Switch to a static PACA on the way out
From: Michael Ellerman <michael@ellerman.id.au>
To: Matt Evans <matt@ozlabs.org>
In-Reply-To: <4C358479.1090502@ozlabs.org>
References: <4C358479.1090502@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-YrR8b+g8/rkhZEuG3i01"
Date: Fri, 23 Jul 2010 23:12:03 +1000
Message-ID: <1279890723.13008.2.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-YrR8b+g8/rkhZEuG3i01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-08 at 17:55 +1000, Matt Evans wrote:
> With dynamic PACAs, the kexecing CPU's PACA won't lie within the kernel
> static data and there is a chance that something may stomp it when prepar=
ing
> to kexec.  This patch switches this final CPU to a static PACA just befor=
e
> we pull the switch.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
> v2:	Changes from Milton's review:
> 	- Use setup_paca() and move from setup_64.c,
> 	- SLB cache inval. not required,
> 	- Adjust 'paca' (oops..), and
> 	- Poison data_offset/per_cpu_offset
>=20
>  arch/powerpc/include/asm/paca.h        |    2 +-
>  arch/powerpc/kernel/machine_kexec_64.c |   20 ++++++++++++++++++++
>  arch/powerpc/kernel/paca.c             |   10 ++++++++++
>  arch/powerpc/kernel/setup_64.c         |   10 ----------
>  4 files changed, 31 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/p=
aca.h
> index 8ce7963..1ff6662 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -146,7 +146,7 @@ struct paca_struct {
>  extern struct paca_struct *paca;
>  extern __initdata struct paca_struct boot_paca;
>  extern void initialise_paca(struct paca_struct *new_paca, int cpu);
> -
> +extern void setup_paca(struct paca_struct *new_paca);
>  extern void allocate_pacas(void);
>  extern void free_unused_pacas(void);
> =20
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel=
/machine_kexec_64.c
> index 26f9900..c4d0123 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -273,6 +273,12 @@ static void kexec_prepare_cpus(void)
>  static union thread_union kexec_stack __init_task_data =3D
>  	{ };
> =20
> +/*
> + * For similar reasons to the stack above, the kexecing CPU needs to be =
on a
> + * static PACA; we switch to kexec_paca.
> + */
> +struct paca_struct kexec_paca;
> +

Hopelessly late probably but .. we could use boot_paca which already
exists and is static.

cheers


--=-YrR8b+g8/rkhZEuG3i01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxJlR4ACgkQdSjSd0sB4dLwCgCfRz2KS5EvMUO1kShvwFy9xcKc
4XcAni4v9oFeIeQu7PoHTnzmdJ5C0g+r
=VJMk
-----END PGP SIGNATURE-----

--=-YrR8b+g8/rkhZEuG3i01--
