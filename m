Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLXgW22swzDqkj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 15:28:23 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id di3so5048898pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 22:28:23 -0700 (PDT)
Received: from balbir.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id c206sm4744965pfc.40.2016.06.02.22.28.19
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 02 Jun 2016 22:28:20 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm/radix: Make the pid unsigned long
To: linuxppc-dev@lists.ozlabs.org
References: <1464860688-2085-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <1afe3307-7bc3-fa0e-911a-7552143494bf@gmail.com>
Date: Fri, 3 Jun 2016 15:28:16 +1000
MIME-Version: 1.0
In-Reply-To: <1464860688-2085-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/06/16 19:44, Aneesh Kumar K.V wrote:
> Semantic Issue: comparison of constant 18446744073709551615 with
> expression of type 'unsigned int' is always false.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/tlb-radix.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 7f2fa82bd155..0484fcdca00a 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -115,7 +115,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
>   */
>  void radix__local_flush_tlb_mm(struct mm_struct *mm)
>  {
> -	unsigned int pid;
> +	unsigned long pid;
>  
>  	preempt_disable();
>  	pid = mm->context.id;
> @@ -128,7 +128,7 @@ EXPORT_SYMBOL(radix__local_flush_tlb_mm);
>  void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
>  			    unsigned long ap, int nid)
>  {
> -	unsigned int pid;
> +	unsigned long pid;
>  
>  	preempt_disable();
>  	pid = mm ? mm->context.id : 0;
> @@ -158,7 +158,7 @@ static int mm_is_core_local(struct mm_struct *mm)
>  
>  void radix__flush_tlb_mm(struct mm_struct *mm)
>  {
> -	unsigned int pid;
> +	unsigned long pid;
>  
>  	preempt_disable();
>  	pid = mm->context.id;
> @@ -207,7 +207,7 @@ EXPORT_SYMBOL(radix__flush_tlb_mm_pwc);
>  void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
>  		       unsigned long ap, int nid)
>  {
> -	unsigned int pid;
> +	unsigned long pid;
>  
>  	preempt_disable();
>  	pid = mm ? mm->context.id : 0;
> 

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
