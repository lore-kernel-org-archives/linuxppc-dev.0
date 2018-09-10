Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427wX15h36zF379
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 14:47:45 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8A4eTqH107209
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 00:47:43 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mdff0cw7b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 00:47:42 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 10 Sep 2018 05:47:41 +0100
Date: Mon, 10 Sep 2018 14:47:36 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Subject: Re: [PATCH v2 2/5] powerpc/pci: Create pci_dn on demand
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-3-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
In-Reply-To: <20180906115752.29316-3-s.miroshnichenko@yadro.com>
Message-Id: <20180910044735.GB14370@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Thu, Sep 06, 2018 at 02:57:49PM +0300, Sergey Miroshnichenko wrote:
> The pci_dn structures can be created not only from DT, but also
> directly from newly discovered PCIe devices, so allocate them
> dynamically.
>=20
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/kernel/pci_dn.c | 76 ++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index ab147a1909c8..48ec16407835 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -33,6 +33,8 @@
>  #include <asm/firmware.h>
>  #include <asm/eeh.h>
> =20
> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn *pa=
rent);
> +
>  /*
>   * The function is used to find the firmware data of one
>   * specific PCI device, which is attached to the indicated
> @@ -58,6 +60,9 @@ static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bu=
s)
>  		pbus =3D pbus->parent;
>  	}
> =20
> +	if (!pbus->self && !pci_is_root_bus(pbus))
> +		return NULL;
> +
>  	/*
>  	 * Except virtual bus, all PCI buses should
>  	 * have device nodes.
> @@ -65,13 +70,15 @@ static struct pci_dn *pci_bus_to_pdn(struct pci_bus *=
bus)
>  	dn =3D pci_bus_to_OF_node(pbus);
>  	pdn =3D dn ? PCI_DN(dn) : NULL;
> =20
> +	if (!pdn && pbus->self)
> +		pdn =3D pbus->self->dev.archdata.pci_data;
> +
>  	return pdn;
>  }
> =20
>  struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
>  				    int devfn)
>  {
> -	struct device_node *dn =3D NULL;
>  	struct pci_dn *parent, *pdn;
>  	struct pci_dev *pdev =3D NULL;
> =20
> @@ -80,17 +87,10 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *b=
us,
>  		if (pdev->devfn =3D=3D devfn) {
>  			if (pdev->dev.archdata.pci_data)
>  				return pdev->dev.archdata.pci_data;
> -
> -			dn =3D pci_device_to_OF_node(pdev);
>  			break;
>  		}
>  	}
> =20
> -	/* Fast path: fetch from device node */
> -	pdn =3D dn ? PCI_DN(dn) : NULL;
> -	if (pdn)
> -		return pdn;
> -

Why is it necessary to remove the above fast-path?

>  	/* Slow path: fetch from firmware data hierarchy */
>  	parent =3D pci_bus_to_pdn(bus);
>  	if (!parent)
> @@ -128,16 +128,9 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>  	if (!parent)
>  		return NULL;
> =20
> -	list_for_each_entry(pdn, &parent->child_list, list) {
> -		if (pdn->busno =3D=3D pdev->bus->number &&
> -		    pdn->devfn =3D=3D pdev->devfn)
> -			return pdn;
> -	}

Could you explain why the above block was removed? Is it now impossible
for it to find a pdn?

> -
> -	return NULL;
> +	return create_pdn(pdev, parent);
>  }
> =20
> -#ifdef CONFIG_PCI_IOV
>  static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>  					   int vf_index,
>  					   int busno, int devfn)
> @@ -156,7 +149,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci=
_dn *parent,
>  	pdn->parent =3D parent;
>  	pdn->busno =3D busno;
>  	pdn->devfn =3D devfn;
> +	#ifdef CONFIG_PCI_IOV
>  	pdn->vf_index =3D vf_index;
> +	#endif /* CONFIG_PCI_IOV */
>  	pdn->pe_number =3D IODA_INVALID_PE;
>  	INIT_LIST_HEAD(&pdn->child_list);
>  	INIT_LIST_HEAD(&pdn->list);

I can see that this change allows you to re-use this to set up a pdn in
create_pdn(). Perhaps you should refactor pci_add_device_node_info() to
use it as well, now that it's possible?

> @@ -164,7 +159,54 @@ static struct pci_dn *add_one_dev_pci_data(struct pc=
i_dn *parent,
> =20
>  	return pdn;
>  }
> -#endif
> +
> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn *pa=
rent)
> +{
> +	struct pci_dn *pdn =3D NULL;
> +
> +	pdn =3D add_one_dev_pci_data(parent, 0, pdev->bus->number, pdev->devfn);
> +	dev_info(&pdev->dev, "Create a new pdn for devfn %2x\n", pdev->devfn / =
8);
> +
> +	if (pdn) {
> +		#ifdef CONFIG_EEH
> +		struct eeh_dev *edev;
> +		#endif /* CONFIG_EEH */
> +		u32 class_code;
> +		u16 device_id;
> +		u16 vendor_id;
> +
> +		#ifdef CONFIG_EEH
> +		edev =3D eeh_dev_init(pdn);
> +		if (!edev) {
> +			kfree(pdn);
> +			dev_err(&pdev->dev, "%s: Failed to allocate edev\n", __func__);
> +			return NULL;
> +		}
> +		#endif /* CONFIG_EEH */
> +
> +		pdn->busno =3D pdev->bus->busn_res.start;

It seems strange that pdn->busno is set by the call to
add_one_dev_pci_data() above (to pdev->bus->number) and then overwritten
here with a different value. Should add_one_dev_pci_data() use
pdev->bus->busn_res.start and this line be removed?

> +
> +		pci_bus_read_config_word(pdev->bus, pdev->devfn,
> +					 PCI_VENDOR_ID, &vendor_id);
> +		pdn->vendor_id =3D vendor_id;
> +
> +		pci_bus_read_config_word(pdev->bus, pdev->devfn,
> +					 PCI_DEVICE_ID, &device_id);
> +		pdn->device_id =3D device_id;
> +
> +		pci_bus_read_config_dword(pdev->bus, pdev->devfn,
> +					  PCI_CLASS_REVISION, &class_code);
> +		class_code >>=3D 8;
> +		pdn->class_code =3D class_code;
> +
> +		pdn->pci_ext_config_space =3D 0;
> +		pdev->dev.archdata.pci_data =3D pdn;
> +	} else {
> +		dev_err(&pdev->dev, "%s: Failed to allocate pdn\n", __func__);
> +	}
> +
> +	return pdn;
> +}


> =20
>  struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>  {
> --=20
> 2.17.1
>=20

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAluV918ACgkQMX8w6AQl
/iLrXwf/ej4jkf1JyTIhcGfGsZxITfE2m2CBHfQXxi3ysI9namDiZGLi9uv0Lnmp
Ydp8IGRSn6VOWuxIuAqbcT3K+3i6tbShgiR3otygekgweKmUYlemXsFuJLGI7tXb
KjAeQma6kXEGXKtNPmClGeNJsTm5R3TuS7/SZ2DXFq4AWdbNGfQll7c9XtBsEqoC
56MwM5Ixaovzv7qCSywd6iz9Y2ohfSxFNgz14Ea/uU97pUgq835G+7iyWFbu10Z4
/Uh2TES2Wj59lWrKuyJdVsSmw4Vd0m5jtHhO38kZ60mIvFjM5Vs/gzJglXRGq0HN
5521L6U12E/2xBzro8xq/U8TPybUPA==
=bdEL
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
