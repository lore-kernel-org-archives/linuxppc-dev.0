Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGyNL6F2HzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 14:34:26 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id s2so3119578pge.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 20:34:26 -0700 (PDT)
Date: Wed, 18 Oct 2017 14:34:14 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 06/25] powerpc: cleaup AMR,iAMR when a key is allocated
 or freed
Message-ID: <20171018143414.125b6e0f@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-15-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-15-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  8 Sep 2017 15:44:54 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> cleanup the bits corresponding to a key in the AMR, and IAMR
> register, when the key is newly allocated/activated or is freed.
> We dont want some residual bits cause the hardware enforce
> unintended behavior when the key is activated or freed.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 5a83ed7..53bf13b 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -54,6 +54,8 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  		mm_set_pkey_is_allocated(mm, pkey));
>  }
>  
> +extern void __arch_activate_pkey(int pkey);
> +extern void __arch_deactivate_pkey(int pkey);
>  /*
>   * Returns a positive, 5-bit key on success, or -1 on failure.
>   */
> @@ -80,6 +82,12 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
>  
>  	ret = ffz((u32)mm_pkey_allocation_map(mm));
>  	mm_set_pkey_allocated(mm, ret);
> +
> +	/*
> +	 * enable the key in the hardware
> +	 */
> +	if (ret > 0)
> +		__arch_activate_pkey(ret);
>  	return ret;
>  }
>  
> @@ -91,6 +99,10 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
>  	if (!mm_pkey_is_allocated(mm, pkey))
>  		return -EINVAL;
>  
> +	/*
> +	 * Disable the key in the hardware
> +	 */
> +	__arch_deactivate_pkey(pkey);
>  	mm_set_pkey_free(mm, pkey);
>  
>  	return 0;

I think some of these patches can be merged, too much fine granularity
is hurting my ability to see the larger function/implementation.

Balbir Singh.
