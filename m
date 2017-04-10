Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1ZwX0Q6WzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 13:11:56 +1000 (AEST)
Date: Mon, 10 Apr 2017 13:11:39 +1000
From: Anton Blanchard <anton@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/mm/radix: Remove unnecessary ptesync
Message-ID: <20170410131139.7ecc926a@kryten>
In-Reply-To: <1491057708-15934-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1491057708-15934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1491057708-15934-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Sat,  1 Apr 2017 20:11:48 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> For a tlbiel with pid, we need to issue tlbiel with set number
> encoded. We don't need to do ptesync for each of those. Instead we
> need one for the entire tlbiel pid operation.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks Aneesh.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> ---
>  arch/powerpc/mm/tlb-radix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index f3e58bd60d1a..b68b5219cf45 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -34,10 +34,8 @@ static inline void __tlbiel_pid(unsigned long pid,
> int set, prs = 1; /* process scoped */
>  	r = 1;   /* raidx format */
>  
> -	asm volatile("ptesync": : :"memory");
>  	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>  		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric),
> "r"(rs) : "memory");
> -	asm volatile("ptesync": : :"memory");
>  }
>  
>  /*
> @@ -47,9 +45,11 @@ static inline void _tlbiel_pid(unsigned long pid,
> unsigned long ric) {
>  	int set;
>  
> +	asm volatile("ptesync": : :"memory");
>  	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
>  		__tlbiel_pid(pid, set, ric);
>  	}
> +	asm volatile("ptesync": : :"memory");
>  	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
>  }
>  
