Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 380B71A02D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 14:56:59 +1000 (AEST)
Date: Tue, 9 Jun 2015 14:05:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v12 32/34] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Message-ID: <20150609040507.GC11000@voom.redhat.com>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
 <1433486126-23551-33-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
In-Reply-To: <1433486126-23551-33-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 04:35:24PM +1000, Alexey Kardashevskiy wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVdmXzAAoJEGw4ysog2bOS6yIQAKBS6rFGXhGxzRJi0zVC5TB0
skWh5ogsgqJAosPtEDyn43dXX3UotC/n4Gayi9nfT2OW9MQz2ONa6/3Nq3v0eY+G
M5AFw92gR55dXilUC8g1JlO9rbVxgSwQf0lHCDrPUbmm/Vm6QsyweXL4MzBiWEtJ
L3GROz4IUMiWqRD/lstBPLsobgIQp8Io03LRq7z0T5fMznlEm1JDaDcilS/4ZZtZ
cX66jrbDU7ITtXeJQwoEZIRn5GEiXeG5v+SXZc7wBACecPuOoskYN+NqHSimdgOT
CtCAdFeyhCE0cf1iq7jtvgYIELQ7VozfBkpsTaCloINmcKUpiFIg9uT/6jVutTIS
Wh1yegZ8rrNLR4dGJYU7dJhsOcCjsWQDw40vodxZZuRuL4cgVdLgaSUc5/dfKwmz
CldEBY7nWSlVd/oio6RdnZtIX45W0kpLDLFbb/saKOKd5zZCR0xBMm5X2EJb25IB
tn8ETKDHYRdnq4SpaUCMaF3jyWSKGO4p8/tTGmtVVrPmFAaJ0AMriG5PNSpYMQPS
wAFGRc6XEuuNqTYEdxDiavUHy7jkWTMU2VKBBvHd0u/9I27vv1JR7T+aqFXQeyhq
dgjV3NA2WBkB4v5/2jwYYA/mfLw8Rl88VnAH0ik/EUXMfHvyQoL/u5Kjisn53KMT
Upe4BCfZe1CBKLwJdsW3
=Rl10
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
