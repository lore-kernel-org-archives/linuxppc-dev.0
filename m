Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5FB932C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 18:50:10 +1000 (EST)
Subject: Re: [PATCH 4/4] kvm: powerpc: set cache coherency only for RAM pages
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1374827190.6142.124.camel@pasglop>
Date: Fri, 26 Jul 2013 10:50:02 +0200
Message-Id: <6CF0D65E-76B6-4CDD-BADC-44DCCC8CAFF6@suse.de>
References: <1374817613-20169-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1374817613-20169-4-git-send-email-Bharat.Bhushan@freescale.com>
 <1374827190.6142.124.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Bharat Bhushan <r65777@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26.07.2013, at 10:26, Benjamin Herrenschmidt wrote:

> On Fri, 2013-07-26 at 11:16 +0530, Bharat Bhushan wrote:
>> If the page is RAM then map this as cacheable and coherent (set "M" =
bit)
>> otherwise this page is treated as I/O and map this as cache inhibited
>> and guarded (set  "I + G")
>>=20
>> This helps setting proper MMU mapping for direct assigned device.
>>=20
>> NOTE: There can be devices that require cacheable mapping, which is =
not yet supported.
>=20
> Why don't you do like server instead and enforce the use of the same I
> and M bits as the corresponding qemu PTE ?

Specifically, Ben is talking about this code:


                /* Translate to host virtual address */
                hva =3D __gfn_to_hva_memslot(memslot, gfn);

                /* Look up the Linux PTE for the backing page */
                pte_size =3D psize;
                pte =3D lookup_linux_pte(pgdir, hva, writing, =
&pte_size);
                if (pte_present(pte)) {
                        if (writing && !pte_write(pte))
                                /* make the actual HPTE be read-only */
                                ptel =3D hpte_make_readonly(ptel);
                        is_io =3D hpte_cache_bits(pte_val(pte));
                        pa =3D pte_pfn(pte) << PAGE_SHIFT;
                }


Alex
