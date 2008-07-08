Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B6F93DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 14:52:45 +1000 (EST)
Date: Tue, 8 Jul 2008 14:52:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: [PATCHv3] Power5,Power6 BSR driver
Message-Id: <20080708145234.998082ad.sfr@canb.auug.org.au>
In-Reply-To: <20080708025812.GC15821@us.ibm.com>
References: <20080616185344.GB16192@gamma> <20080617223952.GA9594@localdomain>
	<20080617224443.GD7552@localhost.localdomain>
	<20080618065123.GB13318@localhost.localdomain>
	<1215406775.8970.57.camel@pasglop>
	<20080707211740.GA15821@us.ibm.com>
	<1215469617.8970.146.camel@pasglop>
	<20080708025812.GC15821@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jul_2008_14_52_34_+1000_Sd7LxJ/98zTu9XSs"
Cc: jschopp@us.ibm.com, Nathan, sonnyrao@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jul_2008_14_52_34_+1000_Sd7LxJ/98zTu9XSs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sonny,

On Mon, 7 Jul 2008 21:58:12 -0500 Sonny Rao <sonnyrao@us.ibm.com> wrote:
>
> +static int bsr_create_devs(struct device_node *bn)
> +{

> +		cur->bsr_device =3D device_create(bsr_class, NULL,
> +						cur->bsr_dev,
> +						cur->bsr_name);
> +		if (!cur->bsr_device) {
> +			printk(KERN_ERR "device_create failed for %s\n",
> +			       cur->bsr_name);
> +			cdev_del(&cur->bsr_cdev);
> +			goto out_err;
> +		}
> +		dev_set_drvdata(cur->bsr_device, cur);

device_create() is being removed in 2.6.27 because the above introduces a
race, use device_create_drvdata() instead.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jul_2008_14_52_34_+1000_Sd7LxJ/98zTu9XSs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkhy8pIACgkQjjKRsyhoI8zCUwCeOnG1Wzr7Pd5CyI+jpKxcLFGT
8OQAmPAIpfN9WtLmKzNlgofc3F8GUr4=
=gWgj
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jul_2008_14_52_34_+1000_Sd7LxJ/98zTu9XSs--
