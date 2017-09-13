Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsc0D6gcPzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 19:33:00 +1000 (AEST)
Received: by mail-vk0-x244.google.com with SMTP id t10so3338442vke.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 02:33:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504910713-7094-3-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-3-git-send-email-linuxram@us.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 13 Sep 2017 19:32:57 +1000
Message-ID: <CAKTCnz=SYo5NbVWuXWE8+fapW_v65rrEJDWShwofDR6x-X8Wyw@mail.gmail.com>
Subject: Re: [PATCH 2/7] powerpc: introduce pte_get_hash_gslot() helper
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
> Introduce pte_get_hash_gslot()() which returns the slot number of the
> HPTE in the global hash table.
>
> This function will come in handy as we work towards re-arranging the
> PTE bits in the later patches.
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h |    3 +++
>  arch/powerpc/mm/hash_utils_64.c           |   18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index f884520..060c059 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -166,6 +166,9 @@ static inline int hash__pte_none(pte_t pte)
>         return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
>  }
>
> +unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
> +               int ssize, real_pte_t rpte, unsigned int subpg_index);
> +
>  /* This low level function performs the actual PTE insertion
>   * Setting the PTE depends on the MMU type and other factors. It's
>   * an horrible mess that I'm not going to try to clean up now but
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 67ec2e9..e68f053 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1591,6 +1591,24 @@ static inline void tm_flush_hash_page(int local)
>  }
>  #endif
>
> +/*
> + * return the global hash slot, corresponding to the given
> + * pte, which contains the hpte.

Does this work with native/guest page tables? I guess both.
The comment sounds trivial, could you please elaborate more.
Looking at the code, it seems like given a real pte, we use
the hash value and hidx to figure out the slot value in the global
slot information. This uses information in the software page
tables. Is that correct? Do we have to consider validity and
present state here or is that guaranteed?

> + */
> +unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
> +               int ssize, real_pte_t rpte, unsigned int subpg_index)
> +{
> +       unsigned long hash, slot, hidx;
> +
> +       hash = hpt_hash(vpn, shift, ssize);
> +       hidx = __rpte_to_hidx(rpte, subpg_index);
> +       if (hidx & _PTEIDX_SECONDARY)
> +               hash = ~hash;
> +       slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> +       slot += hidx & _PTEIDX_GROUP_IX;
> +       return slot;
> +}
> +
>  /* WARNING: This is called from hash_low_64.S, if you change this prototype,
>   *          do not forget to update the assembly call site !
>   */

Balbir Singh.
