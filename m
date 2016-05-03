Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzb991MWwzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 19:14:53 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 May 2016 19:14:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1C4572BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 19:14:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u439Eft132112862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 19:14:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u439EFFc020330
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 19:14:16 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Valentin Rothberg <valentinrothberg@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Valentin Rothberg <valentinrothberg@gmail.com>
Subject: Re: [PATCH] powerpc/mm/radix: fix STD_MMU_64 typo
In-Reply-To: <1462258767-83025-1-git-send-email-valentinrothberg@gmail.com>
References: <1462258767-83025-1-git-send-email-valentinrothberg@gmail.com>
Date: Tue, 03 May 2016 14:43:48 +0530
Message-ID: <87zis7y04z.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Valentin Rothberg <valentinrothberg@gmail.com> writes:

> s/MMU_STD_64/STD_MMU_64/
>
> Fixes: 11ffc1cfa4c2 ("powerpc/mm/radix: Use STD_MMU_64 to properly
>                       isolate hash related code")
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>
> I only compile tested this change.  The issue has been detected with
> scripts/checkkconfigsymbols.py
>
>  arch/powerpc/kernel/mce_power.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index bec70338672e..7353991c4ece 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -80,7 +80,7 @@ void __flush_tlb_power9(unsigned int action)
>
>
>  /* flush SLBs and reload */
> -#ifdef CONFIG_PPC_MMU_STD_64
> +#ifdef CONFIG_PPC_STD_MMU_64
>  static void flush_and_reload_slb(void)
>  {
>  	struct slb_shadow *slb;
> @@ -125,7 +125,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
>  	 * reset the error bits whenever we handle them so that at the end
>  	 * we can check whether we handled all of them or not.
>  	 * */
> -#ifdef CONFIG_PPC_MMU_STD_64
> +#ifdef CONFIG_PPC_STD_MMU_64
>  	if (dsisr & slb_error_bits) {
>  		flush_and_reload_slb();
>  		/* reset error bits */
> @@ -157,7 +157,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
>  	switch (P7_SRR1_MC_IFETCH(srr1)) {
>  	case 0:
>  		break;
> -#ifdef CONFIG_PPC_MMU_STD_64
> +#ifdef CONFIG_PPC_STD_MMU_64
>  	case P7_SRR1_MC_IFETCH_SLB_PARITY:
>  	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
>  		/* flush and reload SLBs for SLB errors. */
> @@ -184,7 +184,7 @@ static long mce_handle_ierror_p7(uint64_t srr1)
>
>  	handled = mce_handle_common_ierror(srr1);
>
> -#ifdef CONFIG_PPC_MMU_STD_64
> +#ifdef CONFIG_PPC_STD_MMU_64
>  	if (P7_SRR1_MC_IFETCH(srr1) == P7_SRR1_MC_IFETCH_SLB_BOTH) {
>  		flush_and_reload_slb();
>  		handled = 1;
> @@ -332,7 +332,7 @@ static long mce_handle_ierror_p8(uint64_t srr1)
>
>  	handled = mce_handle_common_ierror(srr1);
>
> -#ifdef CONFIG_PPC_MMU_STD_64
> +#ifdef CONFIG_PPC_STD_MMU_64
>  	if (P7_SRR1_MC_IFETCH(srr1) == P8_SRR1_MC_IFETCH_ERAT_MULTIHIT) {
>  		flush_and_reload_slb();
>  		handled = 1;
> -- 
> 2.7.4
