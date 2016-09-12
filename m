Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXm0V1TPkzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:33:46 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id u124so261195ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 04:33:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 12 Sep 2016 21:33:43 +1000
Message-ID: <CAKTCnz=W4JD2n-Gne2f1WpstPvKnVHRGaB485ibRdmvmGfF0jA@mail.gmail.com>
Subject: Re: [RFC] KVM: PPC: Book3S HV: Fall back to same size HPT in
 allocation ioctl
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 12, 2016 at 9:13 PM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> When the HPT size is explicitly passed on from the userspace, currently
> the KVM_PPC_ALLOCATE_HTAB will try to allocate the requested size of HPT
> from reserved CMA area and if that is not possible, the allocation just
> fails. With the commit 572abd563befd56 ("KVM: PPC: Book3S HV: Don't fall
> back to smaller HPT size in allocation ioctl"), it does not even try to
> allocate the same order pages from the page allocator before failing for
> good. Same order allocation should be attempted from the page allocator
> as a fallback option when the CMA allocation attempt fails.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> - This change saves guests from failing to start after migration
>
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 05f09ae..0a30eb4 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -78,6 +78,14 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>                         --order;
>         }
>
> +       /*
> +        * Fallback in case the userspace has provided a size via ioctl.
> +        * Try allocating the same order pages from the page allocator.
> +        */
> +       if (!hpt && order > PPC_MIN_HPT_ORDER && htab_orderp)
> +               hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
> +                       __GFP_NOWARN, order - PAGE_SHIFT);
> +

How often does this succeed? Please provide data. I presume this for
the case where guest pages are pinned?

Balbir Singh.
