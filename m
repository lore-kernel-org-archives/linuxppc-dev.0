Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CB7C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 14:03:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A5B2064D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 14:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A5B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4390nX6ZsNzDqTg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 01:03:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=james.morse@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 4390kS6VGCzDqtW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 01:00:43 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C7080D;
 Wed,  5 Dec 2018 06:00:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3303F59C;
 Wed,  5 Dec 2018 06:00:36 -0800 (PST)
Subject: Re: [PATCH RFC 6/7] arm64: kexec: no need to ClearPageReserved()
To: David Hildenbrand <david@redhat.com>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-7-david@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <ce6a4c28-3c3b-329e-df01-325294bd9b2e@arm.com>
Date: Wed, 5 Dec 2018 14:00:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205122851.5891-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, Dave Kleikamp <dave.kleikamp@oracle.com>,
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi David,

(CC: +Akashi)

On 05/12/2018 12:28, David Hildenbrand wrote:
> This will already be done by free_reserved_page().

(will already be -> will be ?)

So it does!


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 922add8adb74..0ef4ea73aa54 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -353,7 +353,6 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
>  
>  	for (addr = begin; addr < end; addr += PAGE_SIZE) {
>  		page = phys_to_page(addr);
> -		ClearPageReserved(page);
>  		free_reserved_page(page);
>  	}
>  }
> 

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
