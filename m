Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1b1f3qRYzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 13:16:22 +1000 (AEST)
Date: Mon, 10 Apr 2017 13:16:08 +1000
From: Anton Blanchard <anton@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm/radix: Don't do page walk cache flush
 when doing full mm flush
Message-ID: <20170410131608.2f821c59@kryten>
In-Reply-To: <1491057708-15934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1491057708-15934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Sat,  1 Apr 2017 20:11:47 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> For fullmm tlb flush, we do a flush with RIC_FLUSH_ALL which will
> invalidate all related caches (radix__tlb_flush()). Hence the pwc
> flush is not needed.

Thanks Aneesh. I see a 3x improvement in exec performance with these
2 patches.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/tlb-radix.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 83dc1ccc2fa1..f3e58bd60d1a 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -129,6 +129,12 @@ void radix__local_flush_tlb_pwc(struct
> mmu_gather *tlb, unsigned long addr) {
>  	unsigned long pid;
>  	struct mm_struct *mm = tlb->mm;
> +	/*
> +	 * If we are doing a full mm flush, we will do a tlb flush
> +	 * with RIC_FLUSH_ALL later.
> +	 */
> +	if (tlb->fullmm)
> +		return;
>  
>  	preempt_disable();
>  
> @@ -195,6 +201,12 @@ void radix__flush_tlb_pwc(struct mmu_gather
> *tlb, unsigned long addr) unsigned long pid;
>  	struct mm_struct *mm = tlb->mm;
>  
> +	/*
> +	 * If we are doing a full mm flush, we will do a tlb flush
> +	 * with RIC_FLUSH_ALL later.
> +	 */
> +	if (tlb->fullmm)
> +		return;
>  	preempt_disable();
>  
>  	pid = mm->context.id;
