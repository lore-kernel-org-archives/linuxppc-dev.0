Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D4C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 07:43:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EACF2173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 07:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Mf9scPfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EACF2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447rQZ4gckzDqTb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 18:43:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Mf9scPfn"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447rNq5ZPwzDqP0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 18:41:46 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 447rNh1F9pz9v4sW;
 Tue, 26 Feb 2019 08:41:40 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Mf9scPfn; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Cd1Gi_BCb91v; Tue, 26 Feb 2019 08:41:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 447rNg73TSz9v4sS;
 Tue, 26 Feb 2019 08:41:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551166900; bh=WGRK7XUOculPeJLrz4JzavGSjbEwTXAS4iVpUNRRB/k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Mf9scPfnJq09iY94lCFQ4KLoJsu5oZjihynYNCNo0d4O0zHKSHG2imdiP1aNhn1iT
 Ifj4GwyDtCF9LCXiD7brdSw9C+UzOdMC6wKC3+TeaD8qCDiHLMAbbKB/VZYammHSMJ
 odpD4WN1Bx8dRVCx8EjBema8ZUAKvwA40SLmBCFE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DBBD08B90F;
 Tue, 26 Feb 2019 08:41:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 3gTK6PjDqmLx; Tue, 26 Feb 2019 08:41:40 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BEEB88B794;
 Tue, 26 Feb 2019 08:41:39 +0100 (CET)
Subject: Re: [PATCH 1/5] mm/resource: return real error codes from walk
 failures
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20190225185727.BCBD768C@viggo.jf.intel.com>
 <20190225185730.D8AA7812@viggo.jf.intel.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <87f914ce-c9e8-7fc5-d048-702fa809013f@c-s.fr>
Date: Tue, 26 Feb 2019 08:41:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225185730.D8AA7812@viggo.jf.intel.com>
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
Cc: thomas.lendacky@amd.com, mhocko@suse.com, dave.jiang@intel.com,
 linux-nvdimm@lists.01.org, tiwai@suse.de, vishal.l.verma@intel.com,
 ying.huang@intel.com, keith.busch@intel.com, linux-mm@kvack.org,
 jglisse@redhat.com, fengguang.wu@intel.com, paulus@samba.org,
 baiyaowei@cmss.chinamobile.com, zwisler@kernel.org, bhelgaas@google.com,
 dan.j.williams@intel.com, bp@suse.de, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/02/2019 à 19:57, Dave Hansen a écrit :
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> walk_system_ram_range() can return an error code either becuase
> *it* failed, or because the 'func' that it calls returned an
> error.  The memory hotplug does the following:
> 
> 	ret = walk_system_ram_range(..., func);
>          if (ret)
> 		return ret;
> 
> and 'ret' makes it out to userspace, eventually.  The problem
> s, walk_system_ram_range() failues that result from *it* failing
> (as opposed to 'func') return -1.  That leads to a very odd
> -EPERM (-1) return code out to userspace.
> 
> Make walk_system_ram_range() return -EINVAL for internal
> failures to keep userspace less confused.
> 
> This return code is compatible with all the callers that I
> audited.
> 
> This changes both the generic mm/ and powerpc-specific
> implementations to have the same return value.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Keith Busch <keith.busch@intel.com>
> ---
> 
>   b/arch/powerpc/mm/mem.c |    2 +-

walk_system_ram_range() was droped in commit 
https://git.kernel.orghttps://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=26b523356f49a0117c8f9e32ca98aa6d6e496e1a

Christophe

>   b/kernel/resource.c     |    4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff -puN arch/powerpc/mm/mem.c~memory-hotplug-walk_system_ram_range-returns-neg-1 arch/powerpc/mm/mem.c
> --- a/arch/powerpc/mm/mem.c~memory-hotplug-walk_system_ram_range-returns-neg-1	2019-02-25 10:56:47.452908034 -0800
> +++ b/arch/powerpc/mm/mem.c	2019-02-25 10:56:47.458908034 -0800
> @@ -189,7 +189,7 @@ walk_system_ram_range(unsigned long star
>   	struct memblock_region *reg;
>   	unsigned long end_pfn = start_pfn + nr_pages;
>   	unsigned long tstart, tend;
> -	int ret = -1;
> +	int ret = -EINVAL;
>   
>   	for_each_memblock(memory, reg) {
>   		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
> diff -puN kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1 kernel/resource.c
> --- a/kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1	2019-02-25 10:56:47.454908034 -0800
> +++ b/kernel/resource.c	2019-02-25 10:56:47.459908034 -0800
> @@ -382,7 +382,7 @@ static int __walk_iomem_res_desc(resourc
>   				 int (*func)(struct resource *, void *))
>   {
>   	struct resource res;
> -	int ret = -1;
> +	int ret = -EINVAL;
>   
>   	while (start < end &&
>   	       !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
> @@ -462,7 +462,7 @@ int walk_system_ram_range(unsigned long
>   	unsigned long flags;
>   	struct resource res;
>   	unsigned long pfn, end_pfn;
> -	int ret = -1;
> +	int ret = -EINVAL;
>   
>   	start = (u64) start_pfn << PAGE_SHIFT;
>   	end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
> _
> 
