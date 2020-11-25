Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD11C5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 14:31:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50998206F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 14:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50998206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ch3Gg2YpXzDq5n
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 01:31:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ch2hW6Yy7zDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 01:04:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Ch2hL2v0rzB09ZG;
 Wed, 25 Nov 2020 15:04:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hIDiaJvGWZok; Wed, 25 Nov 2020 15:04:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Ch2hL1HSjzB09ZM;
 Wed, 25 Nov 2020 15:04:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A6F568B7DB;
 Wed, 25 Nov 2020 15:04:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZNdoWASKes0M; Wed, 25 Nov 2020 15:04:51 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4ACA48B7D3;
 Wed, 25 Nov 2020 15:04:51 +0100 (CET)
Subject: Re: [PATCH v6 16/22] powerpc/book3s64/kuap: Improve error reporting
 with KUAP
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20201125051634.509286-1-aneesh.kumar@linux.ibm.com>
 <20201125051634.509286-17-aneesh.kumar@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <bd854266-6cb5-3a04-ae80-a53e03f1e1d3@csgroup.eu>
Date: Wed, 25 Nov 2020 15:04:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125051634.509286-17-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/11/2020 à 06:16, Aneesh Kumar K.V a écrit :
> With hash translation use DSISR_KEYFAULT to identify a wrong access.
> With Radix we look at the AMR value and type of fault.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/32/kup.h     |  4 +--
>   arch/powerpc/include/asm/book3s/64/kup.h     | 27 ++++++++++++++++----
>   arch/powerpc/include/asm/kup.h               |  4 +--
>   arch/powerpc/include/asm/nohash/32/kup-8xx.h |  4 +--
>   arch/powerpc/mm/fault.c                      |  2 +-
>   5 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
> index 32fd4452e960..b18cd931e325 100644
> --- a/arch/powerpc/include/asm/book3s/32/kup.h
> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
> @@ -177,8 +177,8 @@ static inline void restore_user_access(unsigned long flags)
>   		allow_user_access(to, to, end - addr, KUAP_READ_WRITE);
>   }
>   
> -static inline bool
> -bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
> +static inline bool bad_kuap_fault(struct pt_regs *regs, unsigned long address,
> +				  bool is_write, unsigned long error_code)
>   {
>   	unsigned long begin = regs->kuap & 0xf0000000;
>   	unsigned long end = regs->kuap << 28;
> diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
> index 4a3d0d601745..2922c442a218 100644
> --- a/arch/powerpc/include/asm/book3s/64/kup.h
> +++ b/arch/powerpc/include/asm/book3s/64/kup.h
> @@ -301,12 +301,29 @@ static inline void set_kuap(unsigned long value)
>   	isync();
>   }
>   
> -static inline bool
> -bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
> +#define RADIX_KUAP_BLOCK_READ	UL(0x4000000000000000)
> +#define RADIX_KUAP_BLOCK_WRITE	UL(0x8000000000000000)
> +
> +static inline bool bad_kuap_fault(struct pt_regs *regs, unsigned long address,
> +				  bool is_write, unsigned long error_code)
>   {
> -	return WARN(mmu_has_feature(MMU_FTR_KUAP) &&
> -		    (regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ)),
> -		    "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");
> +	if (!mmu_has_feature(MMU_FTR_KUAP))
> +		return false;
> +
> +	if (radix_enabled()) {
> +		/*
> +		 * Will be a storage protection fault.
> +		 * Only check the details of AMR[0]
> +		 */
> +		return WARN((regs->kuap & (is_write ? RADIX_KUAP_BLOCK_WRITE : RADIX_KUAP_BLOCK_READ)),
> +			    "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");

I think it is pointless to keep the WARN() here.

I have a series aiming at removing them. See 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/cc9129bdda1dbc2f0a09cf45fece7d0b0e690784.1605541983.git.christophe.leroy@csgroup.eu/

> +	}
> +	/*
> +	 * We don't want to WARN here because userspace can setup
> +	 * keys such that a kernel access to user address can cause
> +	 * fault
> +	 */
> +	return !!(error_code & DSISR_KEYFAULT);
>   }
>   
>   static __always_inline void allow_user_access(void __user *to, const void __user *from,
> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
> index a06e50b68d40..952be0414f43 100644
> --- a/arch/powerpc/include/asm/kup.h
> +++ b/arch/powerpc/include/asm/kup.h
> @@ -59,8 +59,8 @@ void setup_kuap(bool disabled);
>   #else
>   static inline void setup_kuap(bool disabled) { }
>   
> -static inline bool
> -bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
> +static inline bool bad_kuap_fault(struct pt_regs *regs, unsigned long address,
> +				  bool is_write, unsigned long error_code)
>   {
>   	return false;
>   }
> diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
> index 567cdc557402..7bdd9e5b63ed 100644
> --- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
> @@ -60,8 +60,8 @@ static inline void restore_user_access(unsigned long flags)
>   	mtspr(SPRN_MD_AP, flags);
>   }
>   
> -static inline bool
> -bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
> +static inline bool bad_kuap_fault(struct pt_regs *regs, unsigned long address,
> +				  bool is_write, unsigned long error_code)
>   {
>   	return WARN(!((regs->kuap ^ MD_APG_KUAP) & 0xff000000),
>   		    "Bug: fault blocked by AP register !");
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 0add963a849b..c91621df0c61 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -227,7 +227,7 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
>   
>   	// Read/write fault in a valid region (the exception table search passed
>   	// above), but blocked by KUAP is bad, it can never succeed.
> -	if (bad_kuap_fault(regs, address, is_write))
> +	if (bad_kuap_fault(regs, address, is_write, error_code))
>   		return true;
>   
>   	// What's left? Kernel fault on user in well defined regions (extable
> 
