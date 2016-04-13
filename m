Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlGKV1tTmzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 17:54:22 +1000 (AEST)
Received: by mail-wm0-f67.google.com with SMTP id y144so11476695wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 00:54:22 -0700 (PDT)
Date: Wed, 13 Apr 2016 09:54:17 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, hughd@google.com,
 kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH 01/10] mm/mmap: Replace SHM_HUGE_MASK with MAP_HUGE_MASK
 inside mmap_pgoff
Message-ID: <20160413075417.GA14356@dhcp22.suse.cz>
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1460007464-26726-2-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460007464-26726-2-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 07-04-16 11:07:35, Anshuman Khandual wrote:
> The commit 091d0d55b286 ("shm: fix null pointer deref when userspace
> specifies invalid hugepage size") had replaced MAP_HUGE_MASK with
> SHM_HUGE_MASK. Though both of them contain the same numeric value of
> 0x3f, MAP_HUGE_MASK flag sounds more appropriate than the other one
> in the context. Hence change it back.

Yes, SHM_HUGE_MASK mixing with MAP_HUGE_SHIFT is not only misleading
it might bite us later should any of the two change.

> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bd2e1a53..7d730a4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1315,7 +1315,7 @@ SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
>  		struct user_struct *user = NULL;
>  		struct hstate *hs;
>  
> -		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & SHM_HUGE_MASK);
> +		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
>  		if (!hs)
>  			return -EINVAL;
>  
> -- 
> 2.1.0
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
Michal Hocko
SUSE Labs
