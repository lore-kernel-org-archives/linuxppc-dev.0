Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E52011A0324
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 10:53:24 +1100 (AEDT)
Date: Fri, 11 Mar 2016 10:42:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 3/9] KVM: PPC: Use preregistered memory API to
 access TCE list
Message-ID: <20160310234206.GC22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-4-git-send-email-aik@ozlabs.ru>
 <20160307060014.GL22546@voom.fritz.box>
 <20160310083305.GB1230@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fuiho1aubMFfXcAs"
In-Reply-To: <20160310083305.GB1230@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fuiho1aubMFfXcAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2016 at 07:33:05PM +1100, Paul Mackerras wrote:
> On Mon, Mar 07, 2016 at 05:00:14PM +1100, David Gibson wrote:
> > On Mon, Mar 07, 2016 at 02:41:11PM +1100, Alexey Kardashevskiy wrote:
> > > VFIO on sPAPR already implements guest memory pre-registration
> > > when the entire guest RAM gets pinned. This can be used to translate
> > > the physical address of a guest page containing the TCE list
> > > from H_PUT_TCE_INDIRECT.
> > >=20
> > > This makes use of the pre-registrered memory API to access TCE list
> > > pages in order to avoid unnecessary locking on the KVM memory
> > > reverse map.
> > >=20
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Ok.. so, what's the benefit of not having to lock the rmap?
>=20
> It's not primarily about locking or not locking the rmap.  The point
> is that when memory is pre-registered, we know that all of guest
> memory is pinned and we have a flat array mapping GPA to HPA.  It's
> simpler and quicker to index into that array (even with looking up the
> kernel page tables in vmalloc_to_phys) than it is to find the memslot,
> lock the rmap entry, look up the user page tables, and unlock the rmap
> entry.  We were only locking the rmap entry to stop the page being
> unmapped and reallocated to something else, but if memory is
> pre-registered, it's all pinned, so it can't be reallocated.

Ok, that makes sense.

Alexey, can you fold some of that rationale into the commit message?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fuiho1aubMFfXcAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4gZOAAoJEGw4ysog2bOSDXsQANJr8EXJZ40r5PnAj7iNdrVl
Mnki7QHKV07maAS0c4cVuKcDtW1gYJcocH0ZihNUMXQ/IOgmjscP44OlqU88hNOA
I6sUSSr3fUt+dtIL5ZB0JubC/05n2mynPLqNuxDPgtjK4TeWFA/4tzczGueQIvnt
qzVhhD98ykLRc44pL0QvfCht/nvAx/7eaGIp1O5XkupgF4xhHKGbp/zTtmfD1aPM
D2DnYrCi8Vr77p//E+ShPiehdydBmfYEHciQhBaqfCz69i4YxfplBefMfCMBLA+k
bdqN5izCmfQR5x17Y/iushj9fT3Rsx1iDu4CUvd+njaLI/DyiqWu6pVVJwyNrhry
x2rJmSpcp6gTWD0iGJyMe6YydtXtkGQHqjrmQ5iELVo3OuSgdGBDidgneat1wKnM
iN39f7irjuNyL9yLlUFcpWm3ws6dhCIKYTC8i3qCZ4dDE3c9fXtCsG0lrOMdcqVM
VBjsH8DvUM/+ZitqEMrecgiY0tNXhKSsKAZbCJWOU4yfIiaP5SqgKsLAFGixY3Mv
jGWiNAefFTNc+FTRf7wKkXtJhse3qsvhqPOgUO5bjLetX+QyhxnhvgwM6g5h6UMg
kfdiRw6UEf03AmfTjinhu+NtgjKW3TDDYSclK32FVF466EuYHp6cUKlS+WrbznPa
BLud235Z4CtZJ2bo1gL5
=5nCU
-----END PGP SIGNATURE-----

--fuiho1aubMFfXcAs--
