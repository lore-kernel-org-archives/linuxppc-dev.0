Return-Path: <SRS0=7zcf=FS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CFC4361B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Dec 2020 07:12:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFC522597
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Dec 2020 07:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFC522597
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CvXdg4HFRzDqVF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Dec 2020 18:12:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=WLHgQn2c; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CvXTR6lYZzDqBL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2020 18:05:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=11D97b/WzRvk1qsJoszULXXa+WJR+vJxLMi5GNzHEEQ=; b=WLHgQn2cE+BA9xy+NIPDUPOgv+
 432s5Ln61W039LzswQHoMLWquHa6/jqpfuQRqVxcEmqKfCnT+hkyE2CVHUXEEwGFKO1rVcBaYcp2v
 VgFeeiJSLzFVu1Y1h5t/GYvGmjCuiU42tK3GgcekfVC3HgHgzpGhSjcFV539rGgs7W20DF1ny1CRM
 P0vKv8xRNXt7bKxZlPip3dAfRRPuGInt42pYGnkuNSaxpSLJjiVndJ7776L02vNwfaBO0N8ceXAIL
 BSAzbFybWkME+Cwljjsm5Gr3vyhTGhN0DfKLztgnP5ozDHK8k3ktyjeW5elwtQW+wuZdrQ1TYP64o
 Rn9HK7OQ==;
Received: from [2601:1c0:6280:3f0::1494]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kohun-0005qn-Bh; Mon, 14 Dec 2020 07:05:01 +0000
Subject: Re: [PATCH v2 3/5] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
To: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
References: <20201214065312.270062-1-npiggin@gmail.com>
 <20201214065312.270062-4-npiggin@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de068125-7d95-b3f0-2de9-71923e3c3651@infradead.org>
Date: Sun, 13 Dec 2020 23:04:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201214065312.270062-4-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/13/20 10:53 PM, Nicholas Piggin wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 84faaba66364..e69c974369cc 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -443,9 +443,22 @@ config MMU_LAZY_TLB
>  config MMU_LAZY_TLB_REFCOUNT
>  	def_bool y
>  	depends on MMU_LAZY_TLB
> +	depends on !MMU_LAZY_TLB_SHOOTDOWN
>  	help
> -	  This must be enabled if MMU_LAZY_TLB is enabled until the next
> -	  patch.
> +	  This refcounts the mm that is used as the lazy TLB mm when switching
> +	  switching to a kernel thread.

duplicate "switching".

> +
> +config MMU_LAZY_TLB_SHOOTDOWN
> +	bool
> +	depends on MMU_LAZY_TLB
> +	help
> +	  Instead of refcounting the "lazy tlb" mm struct, which can cause
> +	  contention with multi-threaded apps on large multiprocessor systems,
> +	  this option causes __mmdrop to IPI all CPUs in the mm_cpumask and
> +	  switch to init_mm if they were using the to-be-freed mm as the lazy
> +	  tlb. To implement this, architectures must use _lazy_tlb variants of
> +	  mm refcounting, and mm_cpumask must include at least all possible
> +	  CPUs in which mm might be lazy.
>  
>  config ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	bool


-- 

