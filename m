Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428CGH4TCfzF39g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 01:51:51 +1000 (AEST)
Subject: Re: [PATCH v2 2/5] powerpc/pci: Create pci_dn on demand
To: Sam Bobroff <sbobroff@linux.ibm.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux@yadro.com>
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-3-s.miroshnichenko@yadro.com>
 <20180910044735.GB14370@tungsten.ozlabs.ibm.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Message-ID: <28f92990-0529-561c-1030-7615a3f2034c@yadro.com>
Date: Mon, 10 Sep 2018 18:51:46 +0300
MIME-Version: 1.0
In-Reply-To: <20180910044735.GB14370@tungsten.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9saqOaLqF8IrkSRAERUcck5EOqyBLOwyp"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--9saqOaLqF8IrkSRAERUcck5EOqyBLOwyp
Content-Type: multipart/mixed; boundary="nkifyfzv7PebY89RUkBR3njf1vdG0rc3r";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Message-ID: <28f92990-0529-561c-1030-7615a3f2034c@yadro.com>
Subject: Re: [PATCH v2 2/5] powerpc/pci: Create pci_dn on demand
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-3-s.miroshnichenko@yadro.com>
 <20180910044735.GB14370@tungsten.ozlabs.ibm.com>
In-Reply-To: <20180910044735.GB14370@tungsten.ozlabs.ibm.com>

--nkifyfzv7PebY89RUkBR3njf1vdG0rc3r
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Sam,

On 9/10/18 7:47 AM, Sam Bobroff wrote:
> Hi Sergey,
>=20
> On Thu, Sep 06, 2018 at 02:57:49PM +0300, Sergey Miroshnichenko wrote:
>> The pci_dn structures can be created not only from DT, but also
>> directly from newly discovered PCIe devices, so allocate them
>> dynamically.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  arch/powerpc/kernel/pci_dn.c | 76 ++++++++++++++++++++++++++++-------=
-
>>  1 file changed, 59 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn=
=2Ec
>> index ab147a1909c8..48ec16407835 100644
>> --- a/arch/powerpc/kernel/pci_dn.c
>> +++ b/arch/powerpc/kernel/pci_dn.c
>> @@ -33,6 +33,8 @@
>>  #include <asm/firmware.h>
>>  #include <asm/eeh.h>
>> =20
>> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn =
*parent);
>> +
>>  /*
>>   * The function is used to find the firmware data of one
>>   * specific PCI device, which is attached to the indicated
>> @@ -58,6 +60,9 @@ static struct pci_dn *pci_bus_to_pdn(struct pci_bus =
*bus)
>>  		pbus =3D pbus->parent;
>>  	}
>> =20
>> +	if (!pbus->self && !pci_is_root_bus(pbus))
>> +		return NULL;
>> +
>>  	/*
>>  	 * Except virtual bus, all PCI buses should
>>  	 * have device nodes.
>> @@ -65,13 +70,15 @@ static struct pci_dn *pci_bus_to_pdn(struct pci_bu=
s *bus)
>>  	dn =3D pci_bus_to_OF_node(pbus);
>>  	pdn =3D dn ? PCI_DN(dn) : NULL;
>> =20
>> +	if (!pdn && pbus->self)
>> +		pdn =3D pbus->self->dev.archdata.pci_data;
>> +
>>  	return pdn;
>>  }
>> =20
>>  struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
>>  				    int devfn)
>>  {
>> -	struct device_node *dn =3D NULL;
>>  	struct pci_dn *parent, *pdn;
>>  	struct pci_dev *pdev =3D NULL;
>> =20
>> @@ -80,17 +87,10 @@ struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus=
 *bus,
>>  		if (pdev->devfn =3D=3D devfn) {
>>  			if (pdev->dev.archdata.pci_data)
>>  				return pdev->dev.archdata.pci_data;
>> -
>> -			dn =3D pci_device_to_OF_node(pdev);
>>  			break;
>>  		}
>>  	}
>> =20
>> -	/* Fast path: fetch from device node */
>> -	pdn =3D dn ? PCI_DN(dn) : NULL;
>> -	if (pdn)
>> -		return pdn;
>> -
>=20
> Why is it necessary to remove the above fast-path?
>=20

It is not, actually - this had leaked from early stages of debugging,
when I've found that after hotplug+rescan or hotplug+kexec the kernel
took pdns from device nodes that do not represent the actual PCIe
topology anymore. But after patches 3 and 4 the PCI_DN() is NULL for
every PCIe device except root on PowerNV, so this block is safe.

It will remain in version 3 of this patchset.

>>  	/* Slow path: fetch from firmware data hierarchy */
>>  	parent =3D pci_bus_to_pdn(bus);
>>  	if (!parent)
>> @@ -128,16 +128,9 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>>  	if (!parent)
>>  		return NULL;
>> =20
>> -	list_for_each_entry(pdn, &parent->child_list, list) {
>> -		if (pdn->busno =3D=3D pdev->bus->number &&
>> -		    pdn->devfn =3D=3D pdev->devfn)
>> -			return pdn;
>> -	}
>=20
> Could you explain why the above block was removed? Is it now impossible=

> for it to find a pdn?
>=20

I see now that this block was also removed too early: on PowerNV with
this patchset it is impossible to have pdn being present in
parent->child_list but not in pdev->dev.archdata.pci_data; but this may
be not the case for pSeries.

>> -
>> -	return NULL;
>> +	return create_pdn(pdev, parent);
>>  }
>> =20
>> -#ifdef CONFIG_PCI_IOV
>>  static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>  					   int vf_index,
>>  					   int busno, int devfn)
>> @@ -156,7 +149,9 @@ static struct pci_dn *add_one_dev_pci_data(struct =
pci_dn *parent,
>>  	pdn->parent =3D parent;
>>  	pdn->busno =3D busno;
>>  	pdn->devfn =3D devfn;
>> +	#ifdef CONFIG_PCI_IOV
>>  	pdn->vf_index =3D vf_index;
>> +	#endif /* CONFIG_PCI_IOV */
>>  	pdn->pe_number =3D IODA_INVALID_PE;
>>  	INIT_LIST_HEAD(&pdn->child_list);
>>  	INIT_LIST_HEAD(&pdn->list);
>=20
> I can see that this change allows you to re-use this to set up a pdn in=

> create_pdn(). Perhaps you should refactor pci_add_device_node_info() to=

> use it as well, now that it's possible?
>=20

Sure, will do.

>> @@ -164,7 +159,54 @@ static struct pci_dn *add_one_dev_pci_data(struct=
 pci_dn *parent,
>> =20
>>  	return pdn;
>>  }
>> -#endif
>> +
>> +static struct pci_dn *create_pdn(struct pci_dev *pdev, struct pci_dn =
*parent)
>> +{
>> +	struct pci_dn *pdn =3D NULL;
>> +
>> +	pdn =3D add_one_dev_pci_data(parent, 0, pdev->bus->number, pdev->dev=
fn);
>> +	dev_info(&pdev->dev, "Create a new pdn for devfn %2x\n", pdev->devfn=
 / 8);
>> +
>> +	if (pdn) {
>> +		#ifdef CONFIG_EEH
>> +		struct eeh_dev *edev;
>> +		#endif /* CONFIG_EEH */
>> +		u32 class_code;
>> +		u16 device_id;
>> +		u16 vendor_id;
>> +
>> +		#ifdef CONFIG_EEH
>> +		edev =3D eeh_dev_init(pdn);
>> +		if (!edev) {
>> +			kfree(pdn);
>> +			dev_err(&pdev->dev, "%s: Failed to allocate edev\n", __func__);
>> +			return NULL;
>> +		}
>> +		#endif /* CONFIG_EEH */
>> +
>> +		pdn->busno =3D pdev->bus->busn_res.start;
>=20
> It seems strange that pdn->busno is set by the call to
> add_one_dev_pci_data() above (to pdev->bus->number) and then overwritte=
n
> here with a different value. Should add_one_dev_pci_data() use
> pdev->bus->busn_res.start and this line be removed?
>=20

Thanks for capturing that! I'll prepare v3 with the fixes.

>> +
>> +		pci_bus_read_config_word(pdev->bus, pdev->devfn,
>> +					 PCI_VENDOR_ID, &vendor_id);
>> +		pdn->vendor_id =3D vendor_id;
>> +
>> +		pci_bus_read_config_word(pdev->bus, pdev->devfn,
>> +					 PCI_DEVICE_ID, &device_id);
>> +		pdn->device_id =3D device_id;
>> +
>> +		pci_bus_read_config_dword(pdev->bus, pdev->devfn,
>> +					  PCI_CLASS_REVISION, &class_code);
>> +		class_code >>=3D 8;
>> +		pdn->class_code =3D class_code;
>> +
>> +		pdn->pci_ext_config_space =3D 0;
>> +		pdev->dev.archdata.pci_data =3D pdn;
>> +	} else {
>> +		dev_err(&pdev->dev, "%s: Failed to allocate pdn\n", __func__);
>> +	}
>> +
>> +	return pdn;
>> +}
>=20
>=20
>> =20
>>  struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>  {
>> --=20
>> 2.17.1
>>

Best regards,
Serge


--nkifyfzv7PebY89RUkBR3njf1vdG0rc3r--

--9saqOaLqF8IrkSRAERUcck5EOqyBLOwyp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAluWkxIACgkQDHQ+aNFT
s7WiQRAAh4wPePrO8diKlwxE0KdGK052Yv18eWruowqS8LHMge3BCzV4oYNNQNCv
IsACHnli9c7s4DJmsYaW2EUEl2zFzn4YcD9SbqgThZhoXqOOCi2AEHPzpy9ZpEdP
6UypjUq3wTP3twWzplvpiGu2FTuMUowRQjwtwsdPyDmTF5tKZCX02ShRsmGlDFjD
AbsInqiN3Ett+zqxsToue/ZMFN4bLRvcY8g2CA7zYWz+M34qmFKmh2IHN3L24Rdx
Y5n5/5q4PC2AG6EfDcQLXT1zklpfydcJlJtxyB5a6nMV/pQhodMxPEq17CloJSPH
IfYth1yCBKqzHdlHJsVb3V/66Mvqbhplh3snTQJeNLlXuEtTAAVw9rPu2eJTJW13
XRnGsG6uZHcx6kuJ575AOt01dLLyxNRf9syVtZM/PvMtTW3dN5eCJKDRqNcXr7CC
K/R8gnJx0HTOqDyplK8pQencyBsrNdmPKU5xDTdoHJ1Mf8UO9L5cHEJwRm7Q6fLl
L/QpAO5zzJwjDQy6jNakvObI7lpnu6eV4wl/LblBvjde5Bg6McmwTtfYFtca4tqt
XKvaX/DOHrFrfR2lSI7EgQq/yLZIM7v02GDUF5RhVKA67pjTJ5SDAG1ufFmWZWBG
TeIQ5GSgWJAuBmCoRRJz9rMH9+azZOPN09zKCoujHpMP6gNeE1E=
=vH7H
-----END PGP SIGNATURE-----

--9saqOaLqF8IrkSRAERUcck5EOqyBLOwyp--
