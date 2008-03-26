Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] scanlog_init cleanup, minor fixes
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080323225144.GA7137@localdomain>
References: <20080323225144.GA7137@localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-y4oumjpzSEriDRxpU8v1"
Date: Thu, 27 Mar 2008 09:40:10 +1100
Message-Id: <1206571210.7482.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-y4oumjpzSEriDRxpU8v1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-03-23 at 17:51 -0500, Nathan Lynch wrote:
> scanlog_init() could use some love.

> diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/plat=
forms/pseries/scanlog.c
> index 8e1ef16..e5b0ea8 100644
> --- a/arch/powerpc/platforms/pseries/scanlog.c
> +++ b/arch/powerpc/platforms/pseries/scanlog.c
> @@ -195,31 +195,30 @@ const struct file_operations scanlog_fops =3D {
>  static int __init scanlog_init(void)
>  {
>  	struct proc_dir_entry *ent;
> +	void *data;
> +	int err =3D -ENOMEM;
> =20
>  	ibm_scan_log_dump =3D rtas_token("ibm,scan-log-dump");
> -	if (ibm_scan_log_dump =3D=3D RTAS_UNKNOWN_SERVICE) {
> -		printk(KERN_ERR "scan-log-dump not implemented on this system\n");
> -		return -EIO;
> -	}
> +	if (ibm_scan_log_dump =3D=3D RTAS_UNKNOWN_SERVICE)
> +		return -ENODEV;
> =20
> -        ent =3D create_proc_entry("ppc64/rtas/scan-log-dump",  S_IRUSR, =
NULL);
> -	if (ent) {
> -		ent->proc_fops =3D &scanlog_fops;
> -		/* Ideally we could allocate a buffer < 4G */
> -		ent->data =3D kmalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> -		if (!ent->data) {
> -			printk(KERN_ERR "Failed to allocate a buffer\n");
> -			remove_proc_entry("scan-log-dump", ent->parent);
> -			return -ENOMEM;
> -		}
> -		((unsigned int *)ent->data)[0] =3D 0;
> -	} else {
> -		printk(KERN_ERR "Failed to create ppc64/scan-log-dump proc entry\n");
> -		return -EIO;
> -	}
> +	/* Ideally we could allocate a buffer < 4G */
> +	data =3D kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> +	if (!data)
> +		goto err;

Not your bug, but what happens if data is > 4G? Kaboom?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-y4oumjpzSEriDRxpU8v1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH6tDKdSjSd0sB4dIRAid9AJ4icOEdUwKx2SSm7vTq+lqBmPWB9QCfcX5r
j3mSmHm/SfirxZc8QcKwjKs=
=voew
-----END PGP SIGNATURE-----

--=-y4oumjpzSEriDRxpU8v1--
