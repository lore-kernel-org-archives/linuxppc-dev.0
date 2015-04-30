Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10F101A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 17:11:04 +1000 (AEST)
Date: Thu, 30 Apr 2015 16:34:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 28/32] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Message-ID: <20150430063455.GA24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-29-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
In-Reply-To: <1429964096-11524-29-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:52PM +1000, Alexey Kardashevskiy wrote:
> We are adding support for DMA memory pre-registration to be used in
> conjunction with VFIO. The idea is that the userspace which is going to
> run a guest may want to pre-register a user space memory region so
> it all gets pinned once and never goes away. Having this done,
> a hypervisor will not have to pin/unpin pages on every DMA map/unmap
> request. This is going to help with multiple pinning of the same memory
> and in-kernel acceleration of DMA requests.
>=20
> This adds a list of memory regions to mm_context_t. Each region consists
> of a header and a list of physical addresses. This adds API to:
> 1. register/unregister memory regions;
> 2. do final cleanup (which puts all pre-registered pages);
> 3. do userspace to physical address translation;
> 4. manage a mapped pages counter; when it is zero, it is safe to
> unregister the region.
>=20
> Multiple registration of the same region is allowed, kref is used to
> track the number of registrations.

[snip]
> +long mm_iommu_alloc(unsigned long ua, unsigned long entries,
> +		struct mm_iommu_table_group_mem_t **pmem)
> +{
> +	struct mm_iommu_table_group_mem_t *mem;
> +	long i, j;
> +	struct page *page =3D NULL;
> +
> +	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
> +			next) {
> +		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries))
> +			return -EBUSY;
> +
> +		/* Overlap? */
> +		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
> +				(ua < (mem->ua + (mem->entries << PAGE_SHIFT))))
> +			return -EINVAL;
> +	}
> +
> +	mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	mem->hpas =3D vzalloc(entries * sizeof(mem->hpas[0]));
> +	if (!mem->hpas) {
> +		kfree(mem);
> +		return -ENOMEM;
> +	}

So, I've thought more about this and I'm really confused as to what
this is supposed to be accomplishing.

I see that you need to keep track of what regions are registered, so
you don't double lock or unlock, but I don't see what the point of
actualy storing the translations in hpas is.

I had assumed it was so that you could later on get to the
translations in real mode when you do in-kernel acceleration.  But
that doesn't make sense, because the array is vmalloc()ed, so can't be
accessed in real mode anyway.

I can't think of a circumstance in which you can use hpas where you
couldn't just walk the page tables anyway.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQc0PAAoJEGw4ysog2bOSYvUP/AztiKDuv+I+QqkjUTc/RyMj
9qSVBBCN+v8X45NZ/QMpNP3vo29dbr9nYoDgpGMV7f6bO7wjgHAUFLRNO8q0e7Rp
yumi23XfSUX4YCGFVKrGHOSWIBJTKXrt0CocjJVVyebTwCgKoWdeUZM0MuPy0/Im
qxcaKRqV5/ya5qXqbhaqrHJhJf/6vDZsMnlfQmvZwLDowMWmU6hkiy5zewFlrELD
y2Wi7G8UiQO4ocl9qxBvSYudhG0y012DaVp4FzMLW1COJVp2idIBzw1j0mdLLD0N
AhvMDn/VoGJUQ+JeTllPQhP//9Zc1hDZNdjIsa4pqRbByCHr6ExfiZsfCbh6NyBw
R4c0WsavLEUE/zV/HwDFqWCWtQdSJorqEqUYERA6eUOz4zeUc8jYZ2l2rZ0ElLvg
rgs/WAZhdSsAql386Nt5y5/uhWr7ix2rmbETMmPGaK74Mkc5X9xkvt4oDumt8xoZ
HqjNYmPqtaBAxhIzQW2PH18NG4aQ7BJ/Ris+xeZSQTDV+fLYZmdbta1Y3f1V91U6
KtiUTkry7R6tmI8dl6bqaOe9pfaur2N5kb+pYxwUpUlSvDBpZUmfIhXrGzDoKWMW
IMH6k9nw96s1jeBvpxrsK2GHZJ8Q2fqOmnYmwzF4g3tBKd8e8Z1Zd59onJTnXGaZ
iC9F3IcNiLnHv6uJTi4O
=jnGz
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
