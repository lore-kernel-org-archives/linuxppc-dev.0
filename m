Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell/axon-msi: retry on missing interrupt
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200811171710.24521.arnd@arndb.de>
References: <200811171710.24521.arnd@arndb.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-8myRpQs4Ho7kCaDzfRe1"
Date: Fri, 21 Nov 2008 11:50:36 +1100
Message-Id: <1227228636.7948.15.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	GBIRAN@il.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8myRpQs4Ho7kCaDzfRe1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-11-17 at 17:10 +0100, Arnd Bergmann wrote:
> The MSI capture logic for the axon bridge can sometimes
> lose interrupts in case of high DMA and interrupt load,
> when it signals an MSI interrupt to the MPIC interrupt
> controller while we are already handling another MSI.
>=20
8< 8< 8<

> Index: linux-2.6/arch/powerpc/platforms/cell/axon_msi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/cell/axon_msi.c	2008-11-17 10:2=
9:05.000000000 -0500
> +++ linux-2.6/arch/powerpc/platforms/cell/axon_msi.c	2008-11-17 10:29:08.=
000000000 -0500
> @@ -95,6 +95,7 @@
>  	struct axon_msic *msic =3D get_irq_data(irq);
>  	u32 write_offset, msi;
>  	int idx;
> +	int retry =3D 0;
> =20
>  	write_offset =3D dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG);
>  	pr_debug("axon_msi: original write_offset 0x%x\n", write_offset);
> @@ -102,7 +103,7 @@
>  	/* write_offset doesn't wrap properly, so we have to mask it */
>  	write_offset &=3D MSIC_FIFO_SIZE_MASK;
> =20
> -	while (msic->read_offset !=3D write_offset) {
> +	while (msic->read_offset !=3D write_offset && retry < 100) {
>  		idx  =3D msic->read_offset / sizeof(__le32);
>  		msi  =3D le32_to_cpu(msic->fifo_virt[idx]);
>  		msi &=3D 0xFFFF;
> @@ -110,13 +111,37 @@
>  		pr_debug("axon_msi: woff %x roff %x msi %x\n",
>  			  write_offset, msic->read_offset, msi);
> =20
> +		if (msi < NR_IRQS && irq_map[msi].host =3D=3D msic->irq_host) {
> +			generic_handle_irq(msi);
> +			msic->fifo_virt[idx] =3D cpu_to_le32(0xffffffff);
> +		} else {
> +			/*
> +			 * Reading the MSIC_WRITE_OFFSET_REG does not
> +			 * reliably flush the outstanding DMA to the
> +			 * FIFO buffer. Here we were reading stale
> +			 * data, so we need to retry.
> +			 */
> +			udelay(1);
> +			retry++;
> +			pr_debug("axon_msi: invalid irq 0x%x!\n", msi);
> +			continue;
> +		}
> +
> +		if (retry) {
> +			pr_debug("axon_msi: late irq 0x%x, retry %d\n",
> +				 msi, retry);
> +			retry =3D 0;
> +		}
> +
>  		msic->read_offset +=3D MSIC_FIFO_ENTRY_SIZE;
>  		msic->read_offset &=3D MSIC_FIFO_SIZE_MASK;
> +	}
> =20
> -		if (msi < NR_IRQS && irq_map[msi].host =3D=3D msic->irq_host)
> -			generic_handle_irq(msi);
> -		else
> -			pr_debug("axon_msi: invalid irq 0x%x!\n", msi);
> +	if (retry) {
> +		printk(KERN_WARNING "axon_msi: irq timed out\n");
> +
> +		msic->read_offset +=3D MSIC_FIFO_ENTRY_SIZE;
> +		msic->read_offset &=3D MSIC_FIFO_SIZE_MASK;
>  	}

By incrementing the offset we're dropping the irq. Would it be better to
just return, and hope that the next time we come in the MSI will have
landed in the fifo and then we can deliver it? It might be late, really
late I guess, but that might be better then dropping it altogether.

We'd still need an ultimate fallback case, where we drop it altogether.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8myRpQs4Ho7kCaDzfRe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkmBdsACgkQdSjSd0sB4dIU2wCffDJwJmjP75ejXQHk7WMGDzlw
YD0An1pfn0tRKPrwqBtErWM9st/7F7tg
=VXYy
-----END PGP SIGNATURE-----

--=-8myRpQs4Ho7kCaDzfRe1--
