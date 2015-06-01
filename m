Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEEFF1A0673
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 14:17:53 +1000 (AEST)
Date: Mon, 1 Jun 2015 13:47:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 02/34] powerpc/iommu/powernv: Get rid of
 set_iommu_table_base_and_group
Message-ID: <20150601034734.GD22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
In-Reply-To: <1432889098-22924-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:26PM +1000, Alexey Kardashevskiy wrote:
> The set_iommu_table_base_and_group() name suggests that the function
> sets table base and add a device to an IOMMU group.
>=20
> The actual purpose for table base setting is to put some reference
> into a device so later iommu_add_device() can get the IOMMU group
> reference and the device to the group.
>=20
> At the moment a group cannot be explicitly passed to iommu_add_device()
> as we want it to work from the bus notifier, we can fix it later and
> remove confusing calls of set_iommu_table_base().
>=20
> This replaces set_iommu_table_base_and_group() with a couple of
> set_iommu_table_base() + iommu_add_device() which makes reading the code
> easier.
>=20
> This adds few comments why set_iommu_table_base() and iommu_add_device()
> are called where they are called.
>=20
> For IODA1/2, this essentially removes iommu_add_device() call from
> the pnv_pci_ioda_dma_dev_setup() as it will always fail at this particular
> place:
> - for physical PE, the device is already attached by iommu_add_device()
> in pnv_pci_ioda_setup_dma_pe();
> - for virtual PE, the sysfs entries are not ready to create all symlinks
> so actual adding is happening in tce_iommu_bus_notifier.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa9XWAAoJEGw4ysog2bOSxIMP/A+fqG7499M9wQYWT7q7HUKV
jFsI8AjukSRLb2BMShDWaAkNUJPW0tF7KIdZKGl6LTZsGj2QdsTQCcmwk+Lt8z81
HDU54OFofWNB7zn+WzmuwLWFoZcnjoopJLb8dElQOVxUXu0wwbYb+X7nIJP9Dl8b
/IYT/632kJax3BCb1Vs+idHUuwJOdoVdE6Xw31lmyTYOs4qES03SJC5P6TwGBxIR
Zca4ZWVEcpcgGFRMUQ4lNaF18RdrviRPhLS7vEgM6fFcXH6UqAfVJFLxXB8MRwou
MjS3yvQaB7M1s7b6x85rNqB51dcIgJ5PCTDz1XvIJrn23j8ZEMfFy3+D3q7oV96y
CWwQN/ive6oYBOQroATfpBZkmEAaQGzlbegU346IdZ2gj8SDyBZZtpN5WMo3eEvM
OeeSXzWe3c1UxveA4Gv7ozMIxdwdMmbfdyfwZyEUOkVgw8yzsxDFBBLJQLQpg2u0
GA0JZ05Lzy+jF4Kpbn/J3YpietSAh6lRIMzPJGX2KPetCKGvkcvIc5AhvQmcTnov
nj6P0dTys7sEPRxx4f5dPosVwtCLXf5e2IlacO6el68Rb/NuTjeYIhDYXc2hLOg5
7GBLFAmsGuyqWfpXCAQk3XZR/EbfRH5OQXTBWYCaJAItacjqnDbO4TAtiUCj6bjI
202QgAAvMwcpRbDuGOGw
=nf0X
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
