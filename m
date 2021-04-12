Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04BBC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 12:00:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68FC611C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 12:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68FC611C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJnP74rP4z3c14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 22:00:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de;
 receiver=<UNKNOWN>)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJnNb6HTvz2yxP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 21:59:59 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9AAEEAE5C;
 Mon, 12 Apr 2021 11:59:55 +0000 (UTC)
Date: Mon, 12 Apr 2021 13:59:52 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 4/6] mm: Drop redundant
 ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION
Message-ID: <20210412115952.GC27818@linux>
References: <1617259448-22529-1-git-send-email-anshuman.khandual@arm.com>
 <1617259448-22529-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617259448-22529-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>,
 akpm@linux-foundation.org, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 01, 2021 at 12:14:06PM +0530, Anshuman Khandual wrote:
> ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION configs have duplicate definitions on
> platforms that subscribe them. Drop these reduntant definitions and instead
> just select them appropriately.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Catalin Marinas <catalin.marinas@arm.com> (arm64)
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Hi Anshuman, 

X86 needs fixing, see below:

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 503d8b2e8676..10702ef1eb57 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -60,8 +60,10 @@ config X86
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ARCH_32BIT_OFF_T			if X86_32
>  	select ARCH_CLOCKSOURCE_INIT
> +	select ARCH_ENABLE_HUGEPAGE_MIGRATION if x86_64 && HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
> +	select ARCH_ENABLE_THP_MIGRATION if x86_64 && TRANSPARENT_HUGEPAGE

you need s/x86_64/X86_64/, otherwise we are left with no migration :-)

-- 
Oscar Salvador
SUSE L3
