Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427w0h31T1zF3Ck
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 14:24:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8A4JeKe072928
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 00:23:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mdefv5xet-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 00:23:58 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 10 Sep 2018 05:23:52 +0100
Date: Mon, 10 Sep 2018 14:23:45 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Subject: Re: [PATCH v2 1/5] powerpc/pci: Access PCI config space directly w/o
 pci_dn
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-2-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <20180906115752.29316-2-s.miroshnichenko@yadro.com>
Message-Id: <20180910042344.GA14370@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Thu, Sep 06, 2018 at 02:57:48PM +0300, Sergey Miroshnichenko wrote:
> The pci_dn structures are retrieved from a DT, but hot-plugged PCIe
> devices don't have them. Don't stop PCIe I/O in absence of pci_dn, so
> it is now possible to discover new devices.
>=20
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/kernel/rtas_pci.c       | 97 +++++++++++++++++++---------
>  arch/powerpc/platforms/powernv/pci.c | 64 ++++++++++++------
>  2 files changed, 109 insertions(+), 52 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pc=
i.c
> index c2b148b1634a..0611b46d9b5f 100644
> --- a/arch/powerpc/kernel/rtas_pci.c
> +++ b/arch/powerpc/kernel/rtas_pci.c
> @@ -55,10 +55,26 @@ static inline int config_access_valid(struct pci_dn *=
dn, int where)
>  	return 0;
>  }
> =20
> -int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
> +static int rtas_read_raw_config(unsigned long buid, int busno, unsigned =
int devfn,
> +				int where, int size, u32 *val)
>  {
>  	int returnval =3D -1;
> -	unsigned long buid, addr;
> +	unsigned long addr =3D rtas_config_addr(busno, devfn, where);
> +	int ret;
> +
> +	if (buid) {
> +		ret =3D rtas_call(ibm_read_pci_config, 4, 2, &returnval,
> +				addr, BUID_HI(buid), BUID_LO(buid), size);
> +	} else {
> +		ret =3D rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
> +	}
> +	*val =3D returnval;
> +
> +	return ret;
> +}
> +
> +int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
> +{
>  	int ret;
> =20
>  	if (!pdn)
> @@ -71,16 +87,8 @@ int rtas_read_config(struct pci_dn *pdn, int where, in=
t size, u32 *val)
>  		return PCIBIOS_SET_FAILED;
>  #endif
> =20
> -	addr =3D rtas_config_addr(pdn->busno, pdn->devfn, where);
> -	buid =3D pdn->phb->buid;
> -	if (buid) {
> -		ret =3D rtas_call(ibm_read_pci_config, 4, 2, &returnval,
> -				addr, BUID_HI(buid), BUID_LO(buid), size);
> -	} else {
> -		ret =3D rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
> -	}
> -	*val =3D returnval;
> -
> +	ret =3D rtas_read_raw_config(pdn->phb->buid, pdn->busno, pdn->devfn,
> +				   where, size, val);
>  	if (ret)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> =20
> @@ -98,18 +106,44 @@ static int rtas_pci_read_config(struct pci_bus *bus,
> =20
>  	pdn =3D pci_get_pdn_by_devfn(bus, devfn);
> =20
> -	/* Validity of pdn is checked in here */
> -	ret =3D rtas_read_config(pdn, where, size, val);
> -	if (*val =3D=3D EEH_IO_ERROR_VALUE(size) &&
> -	    eeh_dev_check_failure(pdn_to_eeh_dev(pdn)))
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> +	if (pdn && eeh_enabled()) {
> +		/* Validity of pdn is checked in here */
> +		ret =3D rtas_read_config(pdn, where, size, val);
> +
> +		if (*val =3D=3D EEH_IO_ERROR_VALUE(size) &&
> +		    eeh_dev_check_failure(pdn_to_eeh_dev(pdn)))
> +			ret =3D PCIBIOS_DEVICE_NOT_FOUND;
> +	} else {
> +		struct pci_controller *phb =3D pci_bus_to_host(bus);
> +
> +		ret =3D rtas_read_raw_config(phb->buid, bus->number, devfn,
> +					   where, size, val);
> +	}

In the above block, if pdn is valid but EEH isn't enabled,
rtas_read_raw_config() will be used instead of rtas_read_config(), so
config_access_valid() won't be tested. Is that correct?

> =20
>  	return ret;
>  }
> =20
> +static int rtas_write_raw_config(unsigned long buid, int busno, unsigned=
 int devfn,
> +				 int where, int size, u32 val)
> +{
> +	unsigned long addr =3D rtas_config_addr(busno, devfn, where);
> +	int ret;
> +
> +	if (buid) {
> +		ret =3D rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
> +				BUID_HI(buid), BUID_LO(buid), size, (ulong)val);
> +	} else {
> +		ret =3D rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val=
);
> +	}
> +
> +	if (ret)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
>  int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
>  {
> -	unsigned long buid, addr;
>  	int ret;
> =20
>  	if (!pdn)
> @@ -122,15 +156,8 @@ int rtas_write_config(struct pci_dn *pdn, int where,=
 int size, u32 val)
>  		return PCIBIOS_SET_FAILED;
>  #endif
> =20
> -	addr =3D rtas_config_addr(pdn->busno, pdn->devfn, where);
> -	buid =3D pdn->phb->buid;
> -	if (buid) {
> -		ret =3D rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
> -			BUID_HI(buid), BUID_LO(buid), size, (ulong) val);
> -	} else {
> -		ret =3D rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val=
);
> -	}
> -
> +	ret =3D rtas_write_raw_config(pdn->phb->buid, pdn->busno, pdn->devfn,
> +				    where, size, val);
>  	if (ret)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> =20
> @@ -141,12 +168,20 @@ static int rtas_pci_write_config(struct pci_bus *bu=
s,
>  				 unsigned int devfn,
>  				 int where, int size, u32 val)
>  {
> -	struct pci_dn *pdn;
> +	struct pci_dn *pdn =3D pci_get_pdn_by_devfn(bus, devfn);
> +	int ret;
> =20
> -	pdn =3D pci_get_pdn_by_devfn(bus, devfn);
> +	if (pdn && eeh_enabled()) {
> +		/* Validity of pdn is checked in here. */
> +		ret =3D rtas_write_config(pdn, where, size, val);
> +	} else {
> +		struct pci_controller *phb =3D pci_bus_to_host(bus);

Same comment as rtas_pci_read_config() above.

> =20
> -	/* Validity of pdn is checked in here. */
> -	return rtas_write_config(pdn, where, size, val);
> +		ret =3D rtas_write_raw_config(phb->buid, bus->number, devfn,
> +					    where, size, val);
> +	}
> +
> +	return ret;
>  }
> =20
>  static struct pci_ops rtas_pci_ops =3D {
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 13aef2323bbc..3f87a2dc6578 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -654,30 +654,29 @@ static void pnv_pci_config_check_eeh(struct pci_dn =
*pdn)
>  	}
>  }
> =20
> -int pnv_pci_cfg_read(struct pci_dn *pdn,
> -		     int where, int size, u32 *val)
> +int pnv_pci_cfg_read_raw(u64 phb_id, int busno, unsigned int devfn,
> +			 int where, int size, u32 *val)
>  {
> -	struct pnv_phb *phb =3D pdn->phb->private_data;
> -	u32 bdfn =3D (pdn->busno << 8) | pdn->devfn;
> +	u32 bdfn =3D (busno << 8) | devfn;
>  	s64 rc;
> =20
>  	switch (size) {
>  	case 1: {
>  		u8 v8;
> -		rc =3D opal_pci_config_read_byte(phb->opal_id, bdfn, where, &v8);
> +		rc =3D opal_pci_config_read_byte(phb_id, bdfn, where, &v8);
>  		*val =3D (rc =3D=3D OPAL_SUCCESS) ? v8 : 0xff;
>  		break;
>  	}
>  	case 2: {
>  		__be16 v16;
> -		rc =3D opal_pci_config_read_half_word(phb->opal_id, bdfn, where,
> -						   &v16);
> +		rc =3D opal_pci_config_read_half_word(phb_id, bdfn, where,
> +						    &v16);
>  		*val =3D (rc =3D=3D OPAL_SUCCESS) ? be16_to_cpu(v16) : 0xffff;
>  		break;
>  	}
>  	case 4: {
>  		__be32 v32;
> -		rc =3D opal_pci_config_read_word(phb->opal_id, bdfn, where, &v32);
> +		rc =3D opal_pci_config_read_word(phb_id, bdfn, where, &v32);
>  		*val =3D (rc =3D=3D OPAL_SUCCESS) ? be32_to_cpu(v32) : 0xffffffff;
>  		break;
>  	}
> @@ -686,27 +685,28 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
>  	}
> =20
>  	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
> -		 __func__, pdn->busno, pdn->devfn, where, size, *val);
> +		 __func__, busno, devfn, where, size, *val);
> +
>  	return PCIBIOS_SUCCESSFUL;
>  }
> =20
> -int pnv_pci_cfg_write(struct pci_dn *pdn,
> -		      int where, int size, u32 val)
> +int pnv_pci_cfg_write_raw(u64 phb_id, int busno, unsigned int devfn,
> +			  int where, int size, u32 val)
>  {
> -	struct pnv_phb *phb =3D pdn->phb->private_data;
> -	u32 bdfn =3D (pdn->busno << 8) | pdn->devfn;
> +	u32 bdfn =3D (busno << 8) | devfn;
> =20
>  	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
> -		 __func__, pdn->busno, pdn->devfn, where, size, val);
> +		 __func__, busno, devfn, where, size, val);
> +
>  	switch (size) {
>  	case 1:
> -		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
> +		opal_pci_config_write_byte(phb_id, bdfn, where, val);
>  		break;
>  	case 2:
> -		opal_pci_config_write_half_word(phb->opal_id, bdfn, where, val);
> +		opal_pci_config_write_half_word(phb_id, bdfn, where, val);
>  		break;
>  	case 4:
> -		opal_pci_config_write_word(phb->opal_id, bdfn, where, val);
> +		opal_pci_config_write_word(phb_id, bdfn, where, val);
>  		break;
>  	default:
>  		return PCIBIOS_FUNC_NOT_SUPPORTED;
> @@ -715,6 +715,24 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
>  	return PCIBIOS_SUCCESSFUL;
>  }
> =20
> +int pnv_pci_cfg_read(struct pci_dn *pdn,
> +		     int where, int size, u32 *val)
> +{
> +	struct pnv_phb *phb =3D pdn->phb->private_data;
> +
> +	return pnv_pci_cfg_read_raw(phb->opal_id, pdn->busno, pdn->devfn,
> +				    where, size, val);
> +}
> +
> +int pnv_pci_cfg_write(struct pci_dn *pdn,
> +		      int where, int size, u32 val)
> +{
> +	struct pnv_phb *phb =3D pdn->phb->private_data;
> +
> +	return pnv_pci_cfg_write_raw(phb->opal_id, pdn->busno, pdn->devfn,
> +				     where, size, val);
> +}
> +
>  #if CONFIG_EEH
>  static bool pnv_pci_cfg_check(struct pci_dn *pdn)
>  {
> @@ -750,13 +768,15 @@ static int pnv_pci_read_config(struct pci_bus *bus,
>  			       int where, int size, u32 *val)
>  {
>  	struct pci_dn *pdn;
> -	struct pnv_phb *phb;
> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
> +	struct pnv_phb *phb =3D hose->private_data;
>  	int ret;
> =20
>  	*val =3D 0xFFFFFFFF;
>  	pdn =3D pci_get_pdn_by_devfn(bus, devfn);
>  	if (!pdn)
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> +		return pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
> +					    where, size, val);
> =20
>  	if (!pnv_pci_cfg_check(pdn))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -779,12 +799,14 @@ static int pnv_pci_write_config(struct pci_bus *bus,
>  				int where, int size, u32 val)
>  {
>  	struct pci_dn *pdn;
> -	struct pnv_phb *phb;
> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
> +	struct pnv_phb *phb =3D hose->private_data;
>  	int ret;
> =20
>  	pdn =3D pci_get_pdn_by_devfn(bus, devfn);
>  	if (!pdn)
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> +		return pnv_pci_cfg_write_raw(phb->opal_id, bus->number, devfn,
> +					     where, size, val);
> =20
>  	if (!pnv_pci_cfg_check(pdn))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> --=20
> 2.17.1
>=20

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAluV8cEACgkQMX8w6AQl
/iKdxQf/TSrxr2AAKgpCHJyjKtZDTINl6ln3CIf8VJHPyZLzjWC96rmokRazH39p
5UUVNWQrK0QbvAURrbMyfNdqln4kAr5hSxYrr+cOY0wU3SJbS3uUinn/OzA4tmeA
PU4oRtQbGss+cmukNI0DPl9n8uTOe0Wj+nZp3y1onJ0K9U5SpmnwxG96LVL4jjN7
FudV1NjuLSrz75bJaCGLEvfm1yMUoFqz8qDYG84poga22UXirS7K7+2BJKzke7hQ
e7ki3E9yZExJDBkqsLWY+vdwOKr7rOTn5kPjw6o8NXvGu8NJrHHBYRqhTIVIBsbw
RJASscTLvAWffGKfdIu6U1jEYtGhiQ==
=d+4a
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
