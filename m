Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 01/18] powerpc: Make decrementer interrupt robust
	against offlined CPUs
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-2-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
	<1299566250-10516-2-git-send-email-benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Ljvsphoi5SOGnDgyhoAJ"
Date: Thu, 10 Mar 2011 19:01:08 +1100
Message-ID: <1299744068.6272.186.camel@concordia>
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


--=-Ljvsphoi5SOGnDgyhoAJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-03-08 at 17:37 +1100, Benjamin Herrenschmidt wrote:
> With some implementations, it is possible that a timer interrupt
> occurs every few seconds on an offline CPU. In this case, just
> re-arm the decrementer and return immediately
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/time.c |   15 +++++++++++----
>  1 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 09d31db..ecebc7c 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -577,14 +577,21 @@ void timer_interrupt(struct pt_regs * regs)
>  	struct clock_event_device *evt =3D &decrementer->event;
>  	u64 now;
> =20
> +	/* Ensure a positive value is written to the decrementer, or else
> +	 * some CPUs will continuue to take decrementer exceptions
                                  ^

Seeing as you're moving it anyway, and maybe a full-stop.

cheers


--=-Ljvsphoi5SOGnDgyhoAJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk14hUQACgkQdSjSd0sB4dJWQgCdF0IwDFlyHUeAASDxdiiaLMeS
RssAoK4qWR9IP8Fi/Si5UNkQVW8NCfoV
=G1FU
-----END PGP SIGNATURE-----

--=-Ljvsphoi5SOGnDgyhoAJ--
