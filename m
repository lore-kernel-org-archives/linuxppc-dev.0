Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 7 Jul 2008 15:24:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: Re: [patch 01/11] powerpc/cell: add support for power button of
	future IBM cell blades
Message-Id: <20080707152445.d76bea70.sfr@canb.auug.org.au>
In-Reply-To: <20080704190805.638836822@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<20080704190805.638836822@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__7_Jul_2008_15_24_45_+1000_SlMrxX=Ip9p/RImc"
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__7_Jul_2008_15_24_45_+1000_SlMrxX=Ip9p/RImc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Fri, 04 Jul 2008 21:05:36 +0200 arnd@arndb.de wrote:
>
> This patch adds support for the power button on future IBM cell blades.
> It actually doesn't shut down the machine. Instead it exposes an
> input device /dev/input/event0 to userspace which sends KEY_POWER
> if power button has been pressed.
> haldaemon actually recognizes the button, so a plattform independent acpid
> replacement should handle it correctly.
>=20
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Was this written by you or Christian?

> @@ -105,10 +110,21 @@ static int cbe_system_reset_exception(struct pt_reg=
s *regs)
>  		 */
>  		if (sysreset_hack && (cpu =3D smp_processor_id()) =3D=3D 0) {
>  			pmd =3D cbe_get_cpu_pmd_regs(cpu);
> -			if (in_be64(&pmd->ras_esc_0) & 0xffff) {
> +			if (in_be64(&pmd->ras_esc_0) & 0x0000ffff) {
>  				out_be64(&pmd->ras_esc_0, 0);
>  				return 0;
>  			}
> +			if (in_be64(&pmd->ras_esc_0) & 0x00010000) {

Do we really want to read that register twice?  (Just asking, I don't
know how the hardware works ...)  Also, do we want to recognise this bit
even if some lower order bits are set?  (this code won't)

> +static int __init cbe_power_button_init(void)
> +{
> +	int ret;
> +	struct input_dev *dev;
> +
> +	if (!sysreset_hack)
> +		return 0;
> +
> +	dev =3D input_allocate_device();
> +        if (!dev) {
> +		ret =3D -ENOMEM;
> +                printk(KERN_ERR "%s: Not enough memory\n", __func__);
> +                goto out;
> +        }

Some white space damage here.

> +	ret =3D input_register_device(dev);
> +	if (ret) {
> +                printk(KERN_ERR "%s: Failed to register device\n", __fun=
c__);
> +		goto out_free_pdev;
> +        }

And here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_15_24_45_+1000_SlMrxX=Ip9p/RImc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxqJ0ACgkQjjKRsyhoI8wE5ACfds/6o8rGvLtOm/Q/azNkNczA
Qg0AoLV3RwMqfT+lISvK5uyWU98Y+gj2
=IWqe
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_15_24_45_+1000_SlMrxX=Ip9p/RImc--
