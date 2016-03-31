Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb6hg5btgzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 12:42:43 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id e128so35390758pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 18:42:43 -0700 (PDT)
Subject: Re: [PATCH 03/65] powerpc/mm/subpage: Clear RWX bit to indicate no
 access
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56FC808B.7030704@gmail.com>
Date: Thu, 31 Mar 2016 12:42:35 +1100
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/03/16 19:23, Aneesh Kumar K.V wrote:
> Subpage protection used to depend on _PAGE_USER bit to implement no
> access mode. This patch switch that to use _PAGE_RWX. We clear READ,
> Write and Execute access from pte instead of clearing _PAGE_USER now.
> This was done so that we can switch to _PAGE_PRIVILEGED in later patch.
> subpage_protection() returns pte bits that need to be cleared.
Could you please clarify what bit needs to be cleared. I think the underlying
assumption is that when this routine is called access cannot be _PAGE_RWX
> Instead of updating the interface to handle no-access in a separate way,
> it appears simple to clear RWX acecss to indicate no access.
>
> We still don't insert hash pte for no access implied by !_PAGE_RWX.
> Hence we should not get PROT_FAULT with change.
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index ea23403b3fc0..ec37f4b0a8ff 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -917,7 +917,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>   * Userspace sets the subpage permissions using the subpage_prot system call.
>   *
>   * Result is 0: full permissions, _PAGE_RW: read-only,
> - * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
> + * _PAGE_RWX: no access.
>   */
>  static int subpage_protection(struct mm_struct *mm, unsigned long ea)
>  {
> @@ -943,8 +943,13 @@ static int subpage_protection(struct mm_struct *mm, unsigned long ea)
>  	/* extract 2-bit bitfield for this 4k subpage */
>  	spp >>= 30 - 2 * ((ea >> 12) & 0xf);
>  
> -	/* turn 0,1,2,3 into combination of _PAGE_USER and _PAGE_RW */
> -	spp = ((spp & 2) ? _PAGE_USER : 0) | ((spp & 1) ? _PAGE_RW : 0);
> +	/*
> +	 * 0 -> full premission
> +	 * 1 -> Read only
> +	 * 2 -> no access.
> +	 * We return the flag that need to be cleared.
> +	 */
> +	spp = ((spp & 2) ? _PAGE_RWX : 0) | ((spp & 1) ? _PAGE_WRITE : 0);
>  	return spp;
>  }
>  
