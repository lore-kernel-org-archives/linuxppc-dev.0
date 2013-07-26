Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F31F2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 01:04:35 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [PATCH 4/4] kvm: powerpc: set cache coherency only for RAM pages
Date: Fri, 26 Jul 2013 15:03:20 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D070E5761@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1374817613-20169-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1374817613-20169-4-git-send-email-Bharat.Bhushan@freescale.com>
 <1374827190.6142.124.camel@pasglop>
 <6CF0D65E-76B6-4CDD-BADC-44DCCC8CAFF6@suse.de>
In-Reply-To: <6CF0D65E-76B6-4CDD-BADC-44DCCC8CAFF6@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-owner@vger.kernel.org=
] On
> Behalf Of Alexander Graf
> Sent: Friday, July 26, 2013 2:20 PM
> To: Benjamin Herrenschmidt
> Cc: Bhushan Bharat-R65777; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Bhushan Bharat-R65777
> Subject: Re: [PATCH 4/4] kvm: powerpc: set cache coherency only for RAM p=
ages
>=20
>=20
> On 26.07.2013, at 10:26, Benjamin Herrenschmidt wrote:
>=20
> > On Fri, 2013-07-26 at 11:16 +0530, Bharat Bhushan wrote:
> >> If the page is RAM then map this as cacheable and coherent (set "M"
> >> bit) otherwise this page is treated as I/O and map this as cache
> >> inhibited and guarded (set  "I + G")
> >>
> >> This helps setting proper MMU mapping for direct assigned device.
> >>
> >> NOTE: There can be devices that require cacheable mapping, which is no=
t yet
> supported.
> >
> > Why don't you do like server instead and enforce the use of the same I
> > and M bits as the corresponding qemu PTE ?
>=20
> Specifically, Ben is talking about this code:
>=20
>=20
>                 /* Translate to host virtual address */
>                 hva =3D __gfn_to_hva_memslot(memslot, gfn);
>=20
>                 /* Look up the Linux PTE for the backing page */
>                 pte_size =3D psize;
>                 pte =3D lookup_linux_pte(pgdir, hva, writing, &pte_size);
>                 if (pte_present(pte)) {
>                         if (writing && !pte_write(pte))
>                                 /* make the actual HPTE be read-only */
>                                 ptel =3D hpte_make_readonly(ptel);
>                         is_io =3D hpte_cache_bits(pte_val(pte));
>                         pa =3D pte_pfn(pte) << PAGE_SHIFT;
>                 }
>=20

Will not searching the Linux PTE is a overkill?

=3DBharat
