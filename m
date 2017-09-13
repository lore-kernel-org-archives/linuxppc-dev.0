Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsYrF1NyFzDr2L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:55:56 +1000 (AEST)
Received: by mail-vk0-x242.google.com with SMTP id j189so3295880vka.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 00:55:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504910713-7094-2-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-2-git-send-email-linuxram@us.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 13 Sep 2017 17:55:53 +1000
Message-ID: <CAKTCnzmBhDzYiKtieV-7RKAXRqpjwvcw6J+9wdX_8d1_PBvEZw@mail.gmail.com>
Subject: Re: [PATCH 1/7] powerpc: introduce pte_set_hash_slot() helper
To: Ram Pai <linuxram@us.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 "Haren Myneni/Beaverton/IBM" <hbabu@us.ibm.com>,
 Michal Hocko <mhocko@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 9, 2017 at 8:44 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> Introduce pte_set_hash_slot().It  sets the (H_PAGE_F_SECOND|H_PAGE_F_GIX)
> bits at  the   appropriate   location   in   the   PTE  of  4K  PTE.  For
> 64K PTE, it  sets  the  bits  in  the  second  part  of  the  PTE. Though
> the implementation  for the former just needs the slot parameter, it does
> take some additional parameters to keep the prototype consistent.
>
> This function  will  be  handy  as  we   work   towards  re-arranging the
> bits in the later patches.
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |   15 +++++++++++++++
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |   25 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index 0c4e470..8909039 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -48,6 +48,21 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
>  }
>  #endif
>
> +/*
> + * 4k pte format is  different  from  64k  pte  format.  Saving  the
> + * hash_slot is just a matter of returning the pte bits that need to
> + * be modified. On 64k pte, things are a  little  more  involved and
> + * hence  needs   many   more  parameters  to  accomplish  the  same.
> + * However we  want  to abstract this out from the caller by keeping
> + * the prototype consistent across the two formats.
> + */
> +static inline unsigned long pte_set_hash_slot(pte_t *ptep, real_pte_t rpte,
> +                       unsigned int subpg_index, unsigned long slot)
> +{
> +       return (slot << H_PAGE_F_GIX_SHIFT) &
> +               (H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
>  static inline char *get_hpte_slot_array(pmd_t *pmdp)
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 9732837..6652669 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -74,6 +74,31 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>         return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
>  }
>
> +/*
> + * Commit the hash slot and return pte bits that needs to be modified.
> + * The caller is expected to modify the pte bits accordingly and
> + * commit the pte to memory.
> + */
> +static inline unsigned long pte_set_hash_slot(pte_t *ptep, real_pte_t rpte,
> +               unsigned int subpg_index, unsigned long slot)
> +{
> +       unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> +
> +       rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> +       *hidxp = rpte.hidx  | (slot << (subpg_index << 2));
> +       /*
> +        * Commit the hidx bits to memory before returning.
> +        * Anyone reading  pte  must  ensure hidx bits are
> +        * read  only  after  reading the pte by using the

Can you lose the only and make it "read after reading the pte"
read only is easy to confuse as read-only

> +        * read-side  barrier  smp_rmb(). __real_pte() can
> +        * help ensure that.
> +        */
> +       smp_wmb();
> +
> +       /* no pte bits to be modified, return 0x0UL */
> +       return 0x0UL;

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.
