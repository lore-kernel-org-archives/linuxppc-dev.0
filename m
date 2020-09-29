Return-Path: <SRS0=xLud=DG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D8C4346E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 04:10:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124412083B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 04:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="BAU6wL2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124412083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0mCD5f0NzDqV7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 14:10:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=BAU6wL2C; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0lvs2rKPzDqSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2020 13:57:29 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id y14so2740511pgf.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2020 20:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yyATRf7br0Ugu+VwODUnKr+6nvbT7UfZB663g3M2lK4=;
 b=BAU6wL2ClUNZO8RdTuD4v8Pcr/uRf9XW2tLV8FzkpjZpUnqL+Yi76XTFO8pGu87mvl
 ZDmgz4Q0krzfpUIHXpRgDe7aEKdqo8ZrIVK0S/TIr6ZKp65MGh1TD7AboQobr0tQP3Ci
 E00KbehXa2EOqsKhq/bU7zxMYc+bs0pTg2yZY727lyHWW4G+xqhyJvi5rLEjbbm1Piai
 lVAuK3QH/DFrBJx+CvZ6TUX1CpkjMiLarlc7jfdtZ/H0CrGx3aolp7lSlXT1+93ny8J0
 2DrA7MUDjptHXKM3HciM5Tkacc3wzxknJkNzjL8jMGhsbfknpJtYiTq+b4q/H1EQsTO8
 aCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yyATRf7br0Ugu+VwODUnKr+6nvbT7UfZB663g3M2lK4=;
 b=A0cBEKfrpIT4veCqPjJg6mR79n2ox+x0i+goVonVc04YIs51X7rlJ8FPqTbyNgLLV2
 LGadNP4ELZguob0JUL6MZcSOX7p0drqezYfmNvPmiomaU8VDYBvSCLBep/Y9F/v7EFH6
 c5+Ab2jfmEHyGwWo0M5SKWZmZ4rWmx+3/f0xuBRcyrZflJA1A1pFy/BSIL0ZRpUqcUVq
 lA7XkLC14M3lNlTj475XNJ0KyxNBxiKK3Vs040vVMN/2b7gI/vz1xGWdHq9w6Em7jcfa
 oE14rX1CXpsQgga2XwhAVuIHT6Si2n/kSwxCZvE8P1T5+JFfW3Y4rMUG6SWVqHCwoiMd
 nmZg==
X-Gm-Message-State: AOAM532CIrDqtZ9oBGkdlTHY7BL1zOqpVzdVZuHA4z+09m7Dw6ktLRU0
 wchBjjnELC+MeEdUoKgug4mVBSz2TNmn0FZB
X-Google-Smtp-Source: ABdhPJyhcUjhwDz79T0CnnOEmGsZUOMfeNe5hZTJyii74FQoPcqtWKRi1GcLph70A7CdN55rL6Bq0w==
X-Received: by 2002:a17:902:74cc:b029:d2:ab25:543f with SMTP id
 f12-20020a17090274ccb02900d2ab25543fmr693647plt.32.1601351846997; 
 Mon, 28 Sep 2020 20:57:26 -0700 (PDT)
Received: from [192.168.10.88] (124-171-83-152.dyn.iinet.net.au.
 [124.171.83.152])
 by smtp.gmail.com with UTF8SMTPSA id in10sm2690025pjb.11.2020.09.28.20.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 20:57:26 -0700 (PDT)
Subject: Re: [PATCH v2 02/14] powerpc/pseries/iommu: Makes sure
 IOMMU_PAGE_SIZE <= PAGE_SIZE
To: Leonardo Bras <leobras.c@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, Ram Pai
 <linuxram@us.ibm.com>, Brian King <brking@linux.vnet.ibm.com>,
 Murilo Fossa Vicentini <muvic@linux.ibm.com>,
 David Dai <zdai@linux.vnet.ibm.com>
References: <20200911170738.82818-1-leobras.c@gmail.com>
 <20200911170738.82818-3-leobras.c@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f11c674c-6964-d3e0-f914-1fd7137c499b@ozlabs.ru>
Date: Tue, 29 Sep 2020 13:57:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20200911170738.82818-3-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 12/09/2020 03:07, Leonardo Bras wrote:
> Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
> 
> Having System pagesize < IOMMU pagesize may cause a page owned by another
> process/VM to be written by a buggy driver / device.
> 
> As it's intended to use DDW for indirect mapping, it's possible to get
> a configuration where (PAGE_SIZE = 4k) < (IOMMU_PAGE_SIZE() = 64k).


Have you tried 4K VM kernel under phyp with 64K iommu pages? phyp may 
assume it is still correct as it knows that it allocates memory in 256MB 
contiguous chunks and for DMA purposes phyp may assume that there just a 
VM kernel which owns all the VM physical memory and can align size in 
iommu_range_alloc() to the IOMMU page size. Not sure.


> 
> To avoid this, make sure create_ddw() can only use pagesize <= PAGE_SIZE.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 9db3927607a4..4eff3a6a441e 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1206,17 +1206,20 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   			goto out_failed;
>   		}
>   	}
> -	if (query.page_size & 4) {
> -		page_shift = 24; /* 16MB */
> -	} else if (query.page_size & 2) {
> +
> +	/* Choose the biggest pagesize available <= PAGE_SHIFT */
> +	if ((query.page_size & 4)) {


This just doubles braces.

Also I believe for the indirect case you should not even try 16MB.


> +		page_shift = 24; /* 16MB - Hugepages */
> +	} else if ((query.page_size & 2) && PAGE_SHIFT >= 16) {


PAGE_SHIFT == 16

>   		page_shift = 16; /* 64kB */
> -	} else if (query.page_size & 1) {
> +	} else if ((query.page_size & 1) && PAGE_SHIFT >= 12) {


Kind of useless check, if it is not 64K, it is 4K.

I understand you are trying to be safe here but this give a new reader 
an idea of more flexibility that there is :) BUILD_BUG_ON() would do 
here imho.



>   		page_shift = 12; /* 4kB */
>   	} else {
>   		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
>   			  query.page_size);
>   		goto out_failed;
>   	}
> +

Unrelated.

>   	/* verify the window * number of ptes will map the partition */
>   	/* check largest block * page size > max memory hotplug addr */
>   	max_addr = ddw_memory_hotplug_max();
> 

-- 
--
Alexey
