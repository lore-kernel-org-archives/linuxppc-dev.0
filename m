Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 549B51A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 14:56:59 +1000 (AEST)
Date: Tue, 9 Jun 2015 14:21:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v12 33/34] vfio: powerpc/spapr: Register memory
 and define IOMMU v2
Message-ID: <20150609042125.GD11000@voom.redhat.com>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
 <1433486126-23551-34-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
In-Reply-To: <1433486126-23551-34-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 04:35:25PM +1000, Alexey Kardashevskiy wrote:
> The existing implementation accounts the whole DMA window in
> the locked_vm counter. This is going to be worse with multiple
> containers and huge DMA windows. Also, real-time accounting would requite
> additional tracking of accounted pages due to the page size difference -
> IOMMU uses 4K pages and system uses 4K or 64K pages.
>=20
> Another issue is that actual pages pinning/unpinning happens on every
> DMA map/unmap request. This does not affect the performance much now as
> we spend way too much time now on switching context between
> guest/userspace/host but this will start to matter when we add in-kernel
> DMA map/unmap acceleration.
>=20
> This introduces a new IOMMU type for SPAPR - VFIO_SPAPR_TCE_v2_IOMMU.
> New IOMMU deprecates VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE and introduces
> 2 new ioctls to register/unregister DMA memory -
> VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY -
> which receive user space address and size of a memory region which
> needs to be pinned/unpinned and counted in locked_vm.
> New IOMMU splits physical pages pinning and TCE table update
> into 2 different operations. It requires:
> 1) guest pages to be registered first
> 2) consequent map/unmap requests to work only with pre-registered memory.
> For the default single window case this means that the entire guest
> (instead of 2GB) needs to be pinned before using VFIO.
> When a huge DMA window is added, no additional pinning will be
> required, otherwise it would be guest RAM + 2GB.
>=20
> The new memory registration ioctls are not supported by
> VFIO_SPAPR_TCE_IOMMU. Dynamic DMA window and in-kernel acceleration
> will require memory to be preregistered in order to work.
>=20
> The accounting is done per the user process.
>=20
> This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
> can do with v1 or v2 IOMMUs.
>=20
> In order to support memory pre-registration, we need a way to track
> the use of every registered memory region and only allow unregistration
> if a region is not in use anymore. So we need a way to tell from what
> region the just cleared TCE was from.
>=20
> This adds a userspace view of the TCE table into iommu_table struct.
> It contains userspace address, one per TCE entry. The table is only
> allocated when the ownership over an IOMMU group is taken which means
> it is only used from outside of the powernv code (such as VFIO).
>=20
> As v2 IOMMU supports IODA2 and pre-IODA2 IOMMUs (which do not support
> DDW API), this creates a default DMA window for IODA2 for consistency.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVdmnFAAoJEGw4ysog2bOSa1sP/RiaFxoEcF85dD1haIDWN2ZX
aD3E7BAX8pT2EPFSI1a7fflbpzOSGD/B6N7lC9+UO48ERWkSqroRrUW6kOB8cMZV
Pvnz6H7FrhCi+VjKsz1Zq572YgtR3aKw3EqgCpjH4adNgIpJqznjtXWxpiIZZm3W
LVqxsTPC30cBDifMhC/myvzHuCXbsdxD32cx1YmJbxBx6kwXnxm5cgIjoAjqvsLo
tZcfg8pv4Xe5Bx+r/zq0v3OamisN3BGfpFaUS4Bqs9aWjxs1SnXvdi2/wcThZm6a
VIQSvETvMr4gRm57Ov2GFFPTalpd5SQQVuD9iLroeM9XDvNfrJMtW/ltAg8qVzfO
VbesEfMuNZFJsW8CoWk1er9WcY+UbZZBFvu+/sXpQs5mGVH10oAs4WCO2vbF2IZq
UQQpRD9OH9yzuFkmTB5Ldigexz+1p44UAqjjnS8UG/5LHYUt5C+BcisOriAFPTOJ
/p4ms5Oh6GR+z+0Y1LceFA0Vmf7YmZTwV5mmp3vHoDumceLl7+vXTmZRTwWBB1ws
GslzJslufq8MGdRI082B8AryoofTGpQrTUtmmjI+mexXvakpoZKEJQvVS9OvtKx2
T2dqbrKx7so77yT7DWeH2koRMpghGHnK//YjH3+mINab8/L7Vx2t1PJQg+Lr8Qno
1w6TmvedHmo8XSwTamIW
=CQgA
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
