Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 4DAD02C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Oct 2013 00:03:55 +1000 (EST)
Subject: Re: [PATCH 0/6 v5] kvm: powerpc: use cache attributes from linux pte
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
Date: Fri, 4 Oct 2013 16:03:50 +0200
Message-Id: <FEE418C8-D0E0-48D3-B951-28D8855CE80B@suse.de>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <bharat.bhushan@freescale.com>, paulus@samba.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 19.09.2013, at 08:02, Bharat Bhushan wrote:

> From: Bharat Bhushan <bharat.bhushan@freescale.com>
>=20
> First patch is a typo fix where book3e define _PAGE_LENDIAN while it
> should be defined as _PAGE_ENDIAN. This seems to show that this is =
never exercised :-)
>=20
> Second and third patch is to allow guest controlling "G"-Guarded and =
"E"-Endian TLB attributes respectively.
>=20
> Fourth patch is moving functions/logic in common code so they can be =
used on booke also.
>=20
> Fifth and Sixth patch is actually setting caching attributes =
(TLB.WIMGE) using corresponding Linux pte.

Thanks, applied 1/6 - 3/6 to kvm-ppc-queue.


Alex

>=20
> v3->v5
> - Fix tlb-reference-flag clearing issue (patch 4/6)
> - There was a patch (4/6 powerpc: move linux pte/hugepte search to =
more generic file)
>   in the last series of this patchset which was moving pte/hugepte =
search functions to
>   generic file. That patch is no more needed as some other patch is =
already applied to fix that :)
>=20
> v2->v3
> - now lookup_linux_pte() only have pte search logic and it does not
>   set any access flags in pte. There is already a function for setting
>   access flag which will be called explicitly where needed.
>   On booke we only need to search for pte to get WIMG.
>=20
> v1->v2
> - Earlier caching attributes (WIMGE) were set based of page is RAM or =
not
>   But now we get these attributes from corresponding Linux PTE.
>=20
> Bharat Bhushan (6):
>  powerpc: book3e: _PAGE_LENDIAN must be _PAGE_ENDIAN
>  kvm: powerpc: allow guest control "E" attribute in mas2
>  kvm: powerpc: allow guest control "G" attribute in mas2
>  kvm: powerpc: keep only pte search logic in lookup_linux_pte
>  kvm: booke: clear host tlb reference flag on guest tlb invalidation
>  kvm: powerpc: use caching attributes as per linux pte
>=20
> arch/powerpc/include/asm/kvm_host.h   |    2 +-
> arch/powerpc/include/asm/pgtable.h    |   24 ++++++++++++++++
> arch/powerpc/include/asm/pte-book3e.h |    2 +-
> arch/powerpc/kvm/book3s_hv_rm_mmu.c   |   36 ++++++++----------------
> arch/powerpc/kvm/booke.c              |    2 +-
> arch/powerpc/kvm/e500.h               |   10 ++++--
> arch/powerpc/kvm/e500_mmu_host.c      |   50 =
+++++++++++++++++++--------------
> 7 files changed, 74 insertions(+), 52 deletions(-)
>=20
>=20
