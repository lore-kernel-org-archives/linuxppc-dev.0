Return-Path: <michael@ellerman.id.au>
Subject: Re: powerpc/cell/axon-msi: fix MSI after kexec
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200812122019.51191.arnd@arndb.de>
References: <200812122019.51191.arnd@arndb.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5t6+J21KYP4+mZ/i3Vd7"
Date: Mon, 15 Dec 2008 15:30:26 +1100
Message-Id: <1229315426.7118.59.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5t6+J21KYP4+mZ/i3Vd7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-12-12 at 20:19 +0100, Arnd Bergmann wrote:
> Commit d015fe995 'powerpc/cell/axon-msi: Retry on missing interrupt'
> has turned a rare failure to kexec on QS22 into a reproducible
> error, which we have now analysed.
>=20
> The problem is that after a kexec, the MSIC hardware still points
> into the middle of the old ring buffer. We set up the ring buffer
> during reboot, but not the offset into it. On older kernels, this
> would cause a storm of thousands of spurious interrupts after a
> kexec, which would most of the time get dropped silently.
>=20
> With the new code, we time out on each interrupt, waiting for
> it to become valid. If more interrupts come in that we time
> out on, this goes on indefinitely, which eventually leads to
> a hard crash.
>=20
> The solution in this patch is to read the current offset from
> the MSIC when reinitializing it. This now works correctly, as
> expected.
>=20
> Reported-by: Dirk Herrendoerfer <d.herrendoerfer@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>=20
> Please apply when Dirk and Michael have given their Ack.
> Should we have it in 2.6.28? Not sure if going from 'works sometimes'
> to 'works never' counts as a regression. Most users won't be impacted,
> because they don't use kexec on QS22.

I think it does count, it's a pretty small fix.

> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platfo=
rms/cell/axon_msi.c
> index 442cf36..548fa4e 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -413,6 +422,9 @@ static int axon_msi_probe(struct of_device *device,
>  			MSIC_CTRL_IRQ_ENABLE | MSIC_CTRL_ENABLE |
>  			MSIC_CTRL_FIFO_SIZE);
> =20
> +	msic->read_offset =3D dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG)
> +				& MSIC_FIFO_SIZE_MASK;
> +

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-5t6+J21KYP4+mZ/i3Vd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklF3WIACgkQdSjSd0sB4dJtqwCfVUSN0oEygcqP8MJwAWoFIxSJ
XToAoJpswxgEzd4fzo/uc7b8CrTrvmPw
=Fyfl
-----END PGP SIGNATURE-----

--=-5t6+J21KYP4+mZ/i3Vd7--
