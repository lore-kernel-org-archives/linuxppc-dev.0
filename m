Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 352D91A0673
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 16:49:08 +1000 (AEST)
Date: Mon, 1 Jun 2015 16:34:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 18/34] vfio:
 powerpc/spapr/iommu/powernv/ioda2: Rework IOMMU ownership control
Message-ID: <20150601063444.GK22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-19-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
In-Reply-To: <1432889098-22924-19-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:42PM +1000, Alexey Kardashevskiy wrote:
> This adds tce_iommu_take_ownership() and tce_iommu_release_ownership
> which call in a loop iommu_take_ownership()/iommu_release_ownership()
> for every table on the group. As there is just one now, no change in
> behaviour is expected.
>=20
> At the moment the iommu_table struct has a set_bypass() which enables/
> disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
> which calls this callback when external IOMMU users such as VFIO are
> about to get over a PHB.
>=20
> The set_bypass() callback is not really an iommu_table function but
> IOMMU/PE function. This introduces a iommu_table_group_ops struct and
> adds take_ownership()/release_ownership() callbacks to it which are
> called when an external user takes/releases control over the IOMMU.
>=20
> This replaces set_bypass() with ownership callbacks as it is not
> necessarily just bypass enabling, it can be something else/more
> so let's give it more generic name.
>=20
> The callbacks is implemented for IODA2 only. Other platforms (P5IOC2,
> IODA1) will use the old iommu_take_ownership/iommu_release_ownership API.
> The following patches will replace iommu_take_ownership/
> iommu_release_ownership calls in IODA2 with full IOMMU table release/
> create.
>=20
> As we here and touching bypass control, this removes
> pnv_pci_ioda2_setup_bypass_pe() as it does not do much
> more compared to pnv_pci_ioda2_set_bypass. This moves tce_bypass_base
> initialization to pnv_pci_ioda2_setup_dma_pe.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa/0EAAoJEGw4ysog2bOSHssQANMUI3xe6RZ8wE4lizI0z7lI
YHGWYRMn482KxKfwD8riZhMFp3ngKawne/esvyUdIaPJJKbLcSMq3fVeQ4eseqK1
e/0IBr3Njj5bSqKZpbNyCZvS6a1ZdtRgv00jcg/OL7Db0g0nYVnNmnA+Y+X+YDgc
9OWMSb0ByDVhBptTFGxfevFzP3wLsn7nWaTy0MPr7Tjdo7DqcXH5To8l7ei82gzK
+2fWA3x2v348kl2Moc/MU/m9qC3P94zUeiVq5amFn+JAr9izpVv4LSVRNwp2l9O/
efRq0hjMIna14ncSh6r0gETtv7eWkIT5bVkr99SvFj8yoF33ci//O6rUSQhAAPvw
NWM8LSEMiIUrApA4D26wKgsORJHD46rrRsCAAFOWmsCA8nl8RWECbkphZ3kKa9pU
aWJcxR5Tz11uUqiwY1e6Jnp2kD7bWiZ1dQPBmccPNt5gpogyY1sJCLOMcqko13Qo
bzbQUWX+zuxhB++SDUbuG9IsxR1mT+ufeFBfXm/QMrqzzmbe9ACCPww9tSen8LxD
ohszjWdMjQBTol59A9nXm/bQOEwPdcQvcyrebYMvsUpWqsvrmDo9o9D7Od2Xt24p
LN9n//MyIj+CU7/n8IWJylc19X90Dswosmaj8oVLXdc/SvTzY0925iqFRZlDLuTE
p6ZEqeTIcI7g25ABekwN
=l2qa
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--
