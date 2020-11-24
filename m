Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F40AC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:54:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A467208DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="toS9Mx3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A467208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgZTs1v2FzDqXd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:54:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgZL473pszDqVB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 06:47:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=toS9Mx3K; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4CgZL439C0z8w8R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 06:47:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4CgZL40mPcz9sVM; Wed, 25 Nov 2020 06:47:24 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=toS9Mx3K; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CgZL35S1fz9sVD;
 Wed, 25 Nov 2020 06:47:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=xLC8NkYKlHLtPiUjqPu35yweVAcFogAHIrJi9DNTj9I=; b=toS9Mx3KdaeoQu4JAZUfUOs8F0
 HATWb8wlEkXblsSAE7HWSKi903pFa/KGjFmLG8+kYrI2lezwyQB47kwVhyGlJn6At2j6OdbcL+YCH
 rnZAbmVaJMlb7IxRtKuPL9zvyIHfTy2dHRNSRPIh3wdPU/NAqEC/4lPogAZeJja2ZiA+hf1aHO/hN
 C/1hc4xTEAuhuuUG2iMh699FVWUEwKBzzYWXYDyaPDEhIRWzR2IaDRtD6iG77DWZt8Zf/4nV4hNzH
 vckRJhpOD9nbw7JxPCPFI1Oyi458BIgPREYzU9W+YINlWH+JHBylJFnr1qYZPbgvbnKWQWzIie+Ah
 pcCOFgHQ==;
Received: from [2601:1c0:6280:3f0::cc1f]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kheHX-0000hg-WA; Tue, 24 Nov 2020 19:47:20 +0000
Subject: Re: [PATCH 3/3] powerpc: Update NUMA Kconfig description & help text
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20201124120547.1940635-1-mpe@ellerman.id.au>
 <20201124120547.1940635-3-mpe@ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4765821c-2886-6420-f03c-94ace136ee8e@infradead.org>
Date: Tue, 24 Nov 2020 11:47:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124120547.1940635-3-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: srikar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/24/20 4:05 AM, Michael Ellerman wrote:
> Update the NUMA Kconfig description to match other architectures, and
> add some help text. Shamelessly borrowed from x86/arm64.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/powerpc/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4d688b426353..7f4995b245a3 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -659,9 +659,15 @@ config IRQ_ALL_CPUS
>  	  reported with SMP Power Macintoshes with this option enabled.
>  
>  config NUMA
> -	bool "NUMA support"
> +	bool "NUMA Memory Allocation and Scheduler Support"
>  	depends on PPC64 && SMP
>  	default y if PPC_PSERIES || PPC_POWERNV
> +	help
> +	  Enable NUMA (Non-Uniform Memory Access) support.
> +
> +	  The kernel will try to allocate memory used by a CPU on the
> +	  local memory controller of the CPU and add some more
> +	  NUMA awareness to the kernel.
>  
>  config NODES_SHIFT
>  	int
> 


-- 
~Randy

