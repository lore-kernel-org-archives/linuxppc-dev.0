Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4wTv45ZRzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 11:32:51 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r4wTt6vGsz9t0t
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 11:32:50 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y7so4971325pfb.0
 for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2016 18:32:50 -0700 (PDT)
Date: Thu, 12 May 2016 11:32:36 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, alistair@popple.id.au,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] powerpc: Fix crash at boot with CONFIG_PPC_RADIX_MMU=n
Message-ID: <20160512113236.58c0783d@cotter.ozlabs.ibm.com>
In-Reply-To: <1462949231-28355-2-git-send-email-mpe@ellerman.id.au>
References: <1462949231-28355-1-git-send-email-mpe@ellerman.id.au>
 <1462949231-28355-2-git-send-email-mpe@ellerman.id.au>
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

On Wed, 11 May 2016 16:47:11 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Currently a kernel that is built with CONFIG_PPC_RADIX_MMU=n, and then
> booted on a 64-bit Hash MMU system will crash on the first SLB miss,
> typically with an oops something like:
> 
>   Unrecoverable exception 4100 at c000000000969504
>   cpu 0x0: Vector: 4100  at [c000000000de78e0]
>       pc: c000000000969504: memmap_init_zone+0x160/0x2dc
>       lr: c0000000009694b0: memmap_init_zone+0x10c/0x2dc
>   ...
>   [c000000000de7b60] c000000000968ec8 init_currently_empty_zone+0x3c/0x11c (unreliable)
>   [c000000000de7bf0] c000000000969bc0 free_area_init_node+0x540/0x688
>   [c000000000de7cf0] c000000000c4b3b4 free_area_init_nodes+0x7b4/0x864
>   [c000000000de7df0] c000000000c2fce0 paging_init+0x88/0xa4
>   [c000000000de7e60] c000000000c2b49c setup_arch+0x29c/0x2ec
>   [c000000000de7f00] c000000000c23b7c start_kernel+0x88/0x524
>   [c000000000de7f90] c000000000008c60 start_here_common+0x20/0xa0
> 
> This is caused by the branch in slb_miss_realmode() that jumps directly
> to the unrecoverable case when MMU_FTR_RADIX is set:
> 
>   BEGIN_MMU_FTR_SECTION
>   	b	2f
>   END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
> 

This makes sense and its a good way to avoid plenty of #ifdefs around code

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
