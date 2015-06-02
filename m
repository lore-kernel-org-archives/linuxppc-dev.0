Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99E5F1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:40:17 +1000 (AEST)
Date: Tue, 2 Jun 2015 11:40:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 32/34] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Message-ID: <20150602014033.GE3186@voom.fritz.box>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-33-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
In-Reply-To: <1432889098-22924-33-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:56PM +1000, Alexey Kardashevskiy wrote:
> We are adding support for DMA memory pre-registration to be used in
> conjunction with VFIO. The idea is that the userspace which is going to
> run a guest may want to pre-register a user space memory region so
> it all gets pinned once and never goes away. Having this done,
> a hypervisor will not have to pin/unpin pages on every DMA map/unmap
> request. This is going to help with multiple pinning of the same memory.
>=20
> Another use of it is in-kernel real mode (mmu off) acceleration of
> DMA requests where real time translation of guest physical to host
> physical addresses is non-trivial and may fail as linux ptes may be
> temporarily invalid. Also, having cached host physical addresses
> (compared to just pinning at the start and then walking the page table
> again on every H_PUT_TCE), we can be sure that the addresses which we put
> into TCE table are the ones we already pinned.
>=20
> This adds a list of memory regions to mm_context_t. Each region consists
> of a header and a list of physical addresses. This adds API to:
> 1. register/unregister memory regions;
> 2. do final cleanup (which puts all pre-registered pages);
> 3. do userspace to physical address translation;
> 4. manage usage counters; multiple registration of the same memory
> is allowed (once per container).
>=20
> This implements 2 counters per registered memory region:
> - @mapped: incremented on every DMA mapping; decremented on unmapping;
> initialized to 1 when a region is just registered; once it becomes zero,
> no more mappings allowe;
> - @used: incremented on every "register" ioctl; decremented on
> "unregister"; unregistration is allowed for DMA mapped regions unless
> it is the very last reference. For the very last reference this checks
> that the region is still mapped and returns -EBUSY so the userspace
> gets to know that memory is still pinned and unregistration needs to
> be retried; @used remains 1.
>=20
> Host physical addresses are stored in vmalloc'ed array. In order to
> access these in the real mode (mmu off), there is a real_vmalloc_addr()
> helper. In-kernel acceleration patchset will move it from KVM to MMU code.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

There's a bunch of ways this could be cleaned up, but those can be
done later.  So,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbQmRAAoJEGw4ysog2bOSzMsQAJlZUNMtTLvs1OHxMBvGXqu7
BTp+djsOO7pbWjT7DJZ4MhXGqAFdZSksyfAZ6q7Bi4IOnZPp7JuanwzlsnT+3n+M
iANNbyq7wLoktOdj6cQjcOGRt2FZRD9HVmQyppUreYAytfH/SVBlhda/Xj5cXaTk
U8QVs3HEoXYvZJN/0MQVCyLDzstHQMKg16U/4vrn/0No7vQTi3k+pEfF19FV8DsQ
a/bhQsuu2+tfYOvQlSfD3KE6SQxYt6eM3n6fq8fejVYqulgS5gFvvCzXlhRDS9f3
uCIG9R4XHtwKHBINLf4v3RboBXRy24BmVT/+Tj7ECicbUzH7v0vfAHM6+crPa8OY
Bs9lhNlQNPcOBvHGzgaV9B0w1BGhrdEmnW3b+fLHZnJpywCHZnVFra11/+fJFEX1
boMI8RAUxmtmxThb4hW0ITFj7bNwOfi6cj6/zcwYtHANpkd97R2CaBikNWXcTVol
qERenPGDk6ighx8QekybKL2334hTZig3IIyYDbeGNfa3lfam7G7v5bVK7qjyXWTZ
Qxu2aR34R4Z40QMRaGaTKzNkT2OrweOZrlo+hDJNDR+h7qHZn2KOy1mF34XDuhPB
xz6AFq8SSPw+0XfxBfScaZuXMQf7oEXjjf2urr2C82G3QCcGQPw9VhwUztcMDCD1
ZrH/o4UHYoHcI3Vnu7W6
=xHH3
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
