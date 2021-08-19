Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E764C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:56:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F178561101
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F178561101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gr0Xg3qv1z3ck2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 19:56:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Gr0XB6B9Rz2xnf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2021 19:56:09 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2EDE1FB;
 Thu, 19 Aug 2021 02:56:05 -0700 (PDT)
Received: from [10.163.69.73] (unknown [10.163.69.73])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 947EA3F70D;
 Thu, 19 Aug 2021 02:55:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] powerpc: rectify selection to
 ARCH_ENABLE_SPLIT_PMD_PTLOCK
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20210819093226.13955-1-lukas.bulwahn@gmail.com>
 <20210819093226.13955-3-lukas.bulwahn@gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <12a996cb-5c54-afab-f095-708a08931cad@arm.com>
Date: Thu, 19 Aug 2021 15:26:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210819093226.13955-3-lukas.bulwahn@gmail.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 8/19/21 3:02 PM, Lukas Bulwahn wrote:
> Commit 66f24fa766e3 ("mm: drop redundant ARCH_ENABLE_SPLIT_PMD_PTLOCK")
> selects the non-existing config ARCH_ENABLE_PMD_SPLIT_PTLOCK in
> ./arch/powerpc/platforms/Kconfig.cputype, but clearly it intends to select
> ARCH_ENABLE_SPLIT_PMD_PTLOCK here (notice the word swapping!), as this
> commit does select that for all other architectures.

Right, indeed the words here got swapped. They look very similar and also
a cross compile would not even detect the problem because the non-existent
config option would simply evaluate to 0. Thanks for catching this.

> 
> Rectify selection to ARCH_ENABLE_SPLIT_PMD_PTLOCK instead.
> 
> Fixes: 66f24fa766e3 ("mm: drop redundant ARCH_ENABLE_SPLIT_PMD_PTLOCK")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/powerpc/platforms/Kconfig.cputype | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 6794145603de..a208997ade88 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -98,7 +98,7 @@ config PPC_BOOK3S_64
>  	select PPC_HAVE_PMU_SUPPORT
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> -	select ARCH_ENABLE_PMD_SPLIT_PTLOCK
> +	select ARCH_ENABLE_SPLIT_PMD_PTLOCK
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>  	select ARCH_SUPPORTS_HUGETLBFS
>  	select ARCH_SUPPORTS_NUMA_BALANCING
> 
