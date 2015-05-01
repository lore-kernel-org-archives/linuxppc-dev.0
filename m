Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21CAB1A0D10
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 13:55:57 +1000 (AEST)
Date: Fri, 1 May 2015 13:39:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel v9 28/32] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Message-ID: <20150501033953.GJ24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-29-git-send-email-aik@ozlabs.ru>
 <20150430063455.GA24886@voom.redhat.com>
 <20150430082525.GA22373@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
In-Reply-To: <20150430082525.GA22373@iris.ozlabs.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 06:25:25PM +1000, Paul Mackerras wrote:
> On Thu, Apr 30, 2015 at 04:34:55PM +1000, David Gibson wrote:
> > On Sat, Apr 25, 2015 at 10:14:52PM +1000, Alexey Kardashevskiy wrote:
> > > We are adding support for DMA memory pre-registration to be used in
> > > conjunction with VFIO. The idea is that the userspace which is going =
to
> > > run a guest may want to pre-register a user space memory region so
> > > it all gets pinned once and never goes away. Having this done,
> > > a hypervisor will not have to pin/unpin pages on every DMA map/unmap
> > > request. This is going to help with multiple pinning of the same memo=
ry
> > > and in-kernel acceleration of DMA requests.
> > >=20
> > > This adds a list of memory regions to mm_context_t. Each region consi=
sts
> > > of a header and a list of physical addresses. This adds API to:
> > > 1. register/unregister memory regions;
> > > 2. do final cleanup (which puts all pre-registered pages);
> > > 3. do userspace to physical address translation;
> > > 4. manage a mapped pages counter; when it is zero, it is safe to
> > > unregister the region.
> > >=20
> > > Multiple registration of the same region is allowed, kref is used to
> > > track the number of registrations.
> >=20
> > [snip]
> > > +long mm_iommu_alloc(unsigned long ua, unsigned long entries,
> > > +		struct mm_iommu_table_group_mem_t **pmem)
> > > +{
> > > +	struct mm_iommu_table_group_mem_t *mem;
> > > +	long i, j;
> > > +	struct page *page =3D NULL;
> > > +
> > > +	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_=
list,
> > > +			next) {
> > > +		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries))
> > > +			return -EBUSY;
> > > +
> > > +		/* Overlap? */
> > > +		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
> > > +				(ua < (mem->ua + (mem->entries << PAGE_SHIFT))))
> > > +			return -EINVAL;
> > > +	}
> > > +
> > > +	mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> > > +	if (!mem)
> > > +		return -ENOMEM;
> > > +
> > > +	mem->hpas =3D vzalloc(entries * sizeof(mem->hpas[0]));
> > > +	if (!mem->hpas) {
> > > +		kfree(mem);
> > > +		return -ENOMEM;
> > > +	}
> >=20
> > So, I've thought more about this and I'm really confused as to what
> > this is supposed to be accomplishing.
> >=20
> > I see that you need to keep track of what regions are registered, so
> > you don't double lock or unlock, but I don't see what the point of
> > actualy storing the translations in hpas is.
> >=20
> > I had assumed it was so that you could later on get to the
> > translations in real mode when you do in-kernel acceleration.  But
> > that doesn't make sense, because the array is vmalloc()ed, so can't be
> > accessed in real mode anyway.
>=20
> We can access vmalloc'd arrays in real mode using real_vmalloc_addr().

Ah, ok.

> > I can't think of a circumstance in which you can use hpas where you
> > couldn't just walk the page tables anyway.
>=20
> The problem with walking the page tables is that there is no guarantee
> that the page you find that way is the page that was returned by the
> gup_fast() we did earlier.  Storing the hpas means that we know for
> sure that the page we're doing DMA to is one that we have an elevated
> page count on.
>=20
> Also, there are various points where a Linux PTE is made temporarily
> invalid for a short time.  If we happened to do a H_PUT_TCE on one cpu
> while another cpu was doing that, we'd get a spurious failure returned
> by the H_PUT_TCE.

I think we want this explanation in the commit message.  Anr/or in a
comment somewhere, I'm not sure.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQvWJAAoJEGw4ysog2bOSpakP/2IOLF57JwJN3EGsv/BMKTll
DM46DVph7O8+GusMz2uoolRfmnYcifY+lpYv/NJ+sfQ1ByZN6QKFgEpOuSdq4FC3
PbckNVLeTABRBIHfrV4np4Q1ur51KGE7pG9wj+iuz82Cd9Pg3+yJsgFQvk7rpu/7
WShDjHS75Z2Yc3N4JuWDunmzOIljKsYsDm/5FMNwDbp1Atx/TFtalT4LXRNc1605
onKV61YjatywCKbI2ILuLyPoLFsZVF/ZtZK8FLJiQ6LkTZ14lr9a17oi9emfu7Pk
d43HyE+6eK3vAKSdvmRFreXwlwrxegZPyM2Y/bDmH4Wwgj1smts7mrRzqVnSGxgy
brAfq0SYmym35NejMu/2u/T13XBEQjIVaMXgH0w9htu2vvJLVSYf+6StB/+Wy1f/
ynpb/tpL5kNLyztK8Un/VLFCkYevdyY7L7kSAaCkOmeiQTAyWInGTGxCQAlh8eOs
JeO4Qu5k/u75A0JeGOFyJS7jplHroyoqNhhvfzlgl86KutbFhFP9ydOz3XW5Px1k
+G8W3hw9Dw31or2G3HbKMw1Y1Kq+/ya82Kf9w98pJ4SC8ABBHml36NeV5XThTQ+v
CvGKYkb8qS0kxVzsEREPyOlqjXBrNBJfLb1YLjMEPXyC2PYgZLa8GsfXQ+CWbmZy
0VtYid2/+tHG6ixsZZfv
=o3fh
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
