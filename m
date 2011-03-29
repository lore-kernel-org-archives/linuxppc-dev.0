Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 15/18] powerpc/smp: Don't expose per-cpu "cpu_state" array
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-16-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
	<1299566250-10516-16-git-send-email-benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-DEhCck1VH+pqZdQHJFpV"
Date: Tue, 29 Mar 2011 16:37:20 +1100
Message-ID: <1301377040.32738.14.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-DEhCck1VH+pqZdQHJFpV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-03-08 at 17:37 +1100, Benjamin Herrenschmidt wrote:
> Instead, keep it static, expose an accessor and use that from
> the PowerMac code. Avoids easy namespace collisions and will
> make it easier to consolidate with other implementations.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/smp.h        |    2 +-
>  arch/powerpc/kernel/smp.c             |    7 ++++++-
>  arch/powerpc/platforms/powermac/smp.c |   12 ++++++++----
>  3 files changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/sm=
p.h
> index 7e99771..a902a0d 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -45,7 +45,7 @@ extern void migrate_irqs(void);
>  int generic_cpu_disable(void);
>  void generic_cpu_die(unsigned int cpu);
>  void generic_mach_cpu_die(void);
> -DECLARE_PER_CPU(int, cpu_state);
> +void generic_set_cpu_dead(unsigned int cpu);

Takes a cpu parameter ..

> +void generic_set_cpu_dead(unsigned int cpu)
> +{
> +	__get_cpu_var(cpu_state) =3D CPU_DEAD;
> +}

But doesn't use it.

cheers


--=-DEhCck1VH+pqZdQHJFpV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk2RcA8ACgkQdSjSd0sB4dIjrACfaZkmdXNZ0CK5o5tTRF59uuyO
22sAnis9BxmQNGQxikpDAWizlkZ/9PFb
=1O8q
-----END PGP SIGNATURE-----

--=-DEhCck1VH+pqZdQHJFpV--
