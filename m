Return-Path: <SRS0=Nfv6=VJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D17C742A5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 06:28:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B18208E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 06:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B18208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45lNJx5cghzDqsH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 16:28:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45lNFr4rtnzDqLc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2019 16:25:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45lNFp4MPRz9sBF;
 Fri, 12 Jul 2019 16:25:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 paulus@samba.org
Subject: Re: [PATCH v2] powerpc/book3s/mm: Update Oops message to print the
 correct translation in use
In-Reply-To: <20190711145814.17970-1-aneesh.kumar@linux.ibm.com>
References: <20190711145814.17970-1-aneesh.kumar@linux.ibm.com>
Date: Fri, 12 Jul 2019 16:25:18 +1000
Message-ID: <8736jbg46p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Avoids confusion when printing Oops message like below
>
>  Faulting instruction address: 0xc00000000008bdb4
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  LE PAGE_SIZE=64K MMU=Radix MMU=Hash SMP NR_CPUS=2048 NUMA PowerNV
>
> This was because we never clear the MMU_FTR_HPTE_TABLE feature flag
> even if we run with radix translation. It was discussed that we should
> look at this feature flag as an indication of the capability to run
> hash translation and we should not clear the flag even if we run in
> radix translation. All the code paths check for radix_enabled() check and
> if found true consider we are running with radix translation. Follow the
> same sequence for finding the MMU translation string to be used in Oops
> message.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>
> Changes from V1:
> * Don't clear the HPTE feature flag.
>
>  arch/powerpc/kernel/traps.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 11caa0291254..b181d6860f28 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -250,15 +250,22 @@ static void oops_end(unsigned long flags, struct pt_regs *regs,
>  }
>  NOKPROBE_SYMBOL(oops_end);
>  
> +static char *get_mmu_str(void)
> +{
> +	if (early_radix_enabled())
> +		return " MMU=Radix";
> +	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +		return " MMU=Hash";
> +	return "";
> +}

We don't change MMU once we're up, so just do this logic once and stash
it into a static string, rather than rechecking on every oops.

cheers

>  static int __die(const char *str, struct pt_regs *regs, long err)
>  {
>  	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
>  
> -	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s%s %s\n",
> +	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
>  	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
> -	       PAGE_SIZE / 1024,
> -	       early_radix_enabled() ? " MMU=Radix" : "",
> -	       early_mmu_has_feature(MMU_FTR_HPTE_TABLE) ? " MMU=Hash" : "",
> +	       PAGE_SIZE / 1024, get_mmu_str(),
>  	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
>  	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
>  	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
> -- 
> 2.21.0
