Return-Path: <johannes@sipsolutions.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 14E27B7BA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 00:56:27 +1000 (EST)
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CFCDDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 00:56:26 +1000 (EST)
Subject: Re: [PATCH 5/5] sound/aoa: Add kmalloc NULL tests
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
References: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-1aAgYaYXl+i4hAkpYGaf"
Date: Thu, 30 Jul 2009 16:17:00 +0200
Message-Id: <1248963420.16129.0.camel@johannes.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-1aAgYaYXl+i4hAkpYGaf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-30 at 16:11 +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
>=20
> Check that the result of kzalloc is not NULL before a dereference.

>  		irq_client =3D kzalloc(sizeof(struct pmf_irq_client),
>  				     GFP_KERNEL);
> +		if (!irq_client) {
> +			err =3D -ENOMEM;
> +			printk(KERN_ERR "snd-aoa: gpio layer failed to"
> +				" register %s irq (%d)\n", name, err);
> +			goto out_unlock;
> +		}

Looks good, thanks, but I'd really drop the printk if only to not have
the string there, that doesn't really seem interesting.

johannes

--=-1aAgYaYXl+i4hAkpYGaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKcatZAAoJEODzc/N7+QmaC/kP/1WQTpl1VPuF4Gxnf9ihDUe0
U0Oo+Zi0PZy87OMRTXTXEEwhzDEH6lC1wETlI3NIofQ5Md13G9/jJUR9fUMDWi7O
j7EKy+1iwrNmGeif8Yaicx3ZSUj+/hKDQFc6mg1NyxB3V2Cf1L7PJEE6fqqXLpHA
tt/irChip+rpWaFBy+r1yD0wUw2rGwB/CVsN9zasH91fbzg6pU6xU3dwQpaUPzt9
bIxNd7ucne/TtYKRYSpEYSCjy/XfKctgNspyD2O1MmnrotpaW33YcGo5PAZekvJj
LKoc0ScM7XxrBjT/W6oKmueQzrSu4PFqenKgJlBZI6O1fmPZig2GkFDdcfIW3qXK
13A9TBAofWd4p4uQRAUVRJ/25RBKLdSZ3J0SlB3Pd7jDB7lcl0dfFI9ofO8OqHCP
rlklAyAv9GEtns2oqq3IIkgAnz6g5eJgsuaeh+ZNfbvLvmFjGU8D41FMeidW4BNW
/1iww2ENSafqe8hkR1LYmcP+OOlIqHebKywqp/9Fw3V69fwy0gSYhFsqZDj3MW7o
q3VksjHoMI333dwg/A/+5kR+xiijFORYNfRJ4esaEpvG7eTVB3CBqbnR7aYn7GYa
mcZLW5aZ+hG4glkC6ijGwm3gyQwZLkqBFt2ohv4fC0XQvgie2XyiAdn9oEQlBXgB
hZSmSHQCTc/yGIA7+O5h
=sGsV
-----END PGP SIGNATURE-----

--=-1aAgYaYXl+i4hAkpYGaf--
