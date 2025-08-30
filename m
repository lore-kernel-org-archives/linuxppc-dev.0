Return-Path: <linuxppc-dev+bounces-11538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885CECA0EFF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Aug 2025 08:20:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cDSkZ18gwz2xPw;
	Sat, 30 Aug 2025 18:20:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756542038;
	cv=none; b=TUkWIc2qib16PMJEZRcUI+G+3ZACIr1+CV/hxeKZZN/ASDZD0hdF8eUphsToDRzZ3TapqA9zocPNhWbjGgKHu8Dyfwb4PgSBTzhfjMSDSMB6u38TlJw/qAYVgM7kDh7BYePJHEvSnBqJBVFOph89ohirsGS9NDAL2SZgRrKb3tqz6s15ISjbDOtNYxgW0lPj4aVTaqhLEIbXwkk632n8SgNOxYuxdu9wsObsZYxomD2xIXlP/N9e+siG/AwrDPIrreucP5odBX+1dpVu+xxqg8gSqwu+esWNkSDZnLbnleP53W7lWUAXsOPPlZwpjDo3K6QTaNGuiXMBLudMYrmLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756542038; c=relaxed/relaxed;
	bh=Cimto7poyGsZwieKoS33JrwBy8p1e/FuIlZbpM7dXNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNOoRVrmelk6qbueR0udrN7jDQ9JzYiMwSXxs767JG1a8198EeLv7LBfKPwMKBqNzeIHZ8m+fHSnX/HnZ/4HLq5QhmMsYTyZIGhxnLME/tZFGWigGF2ODzvYThg0XETgjCMUFVvlDlqhizHogflnt/YoImv2jDqf1rID/4P0Sa1iuvU7HyQLnzgYTcTvygqMvFGb0AqNGn63lAKSLuX+WSA+uz8cOKzHSZSz9KoRLsfCwVoc0LY03Rs2TYs9axo7duv7MvcHp27RfQ7MLeQ+kFbNm2lKWnC8aeLdAwsQgxD+i+RHhiL3o9zxMMz5CE6tjS2ui5sVoDPcTfw2Cqxi6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cDSkY2kzGz2xgX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Aug 2025 18:20:37 +1000 (AEST)
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cDQJD5QQ9z9sSK;
	Sat, 30 Aug 2025 08:31:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkxJ0ZRl1_8J; Sat, 30 Aug 2025 08:31:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cDQJD4G6xz9sSC;
	Sat, 30 Aug 2025 08:31:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 78C578B778;
	Sat, 30 Aug 2025 08:31:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Lq7yrlFoiZeZ; Sat, 30 Aug 2025 08:31:08 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E40F78B776;
	Sat, 30 Aug 2025 08:31:07 +0200 (CEST)
Message-ID: <12739812-aa4e-4124-8296-b98adecbc6eb@csgroup.eu>
Date: Sat, 30 Aug 2025 08:31:07 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/8] powerpc/ptdump: Dump PXX level info for
 kernel_page_tables
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Donet Tom <donettom@linux.ibm.com>
References: <cover.1756522067.git.ritesh.list@gmail.com>
 <3c3dfc8d2e6c45f9d0fc4a3f969b93a3b7520c46.1756522067.git.ritesh.list@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <3c3dfc8d2e6c45f9d0fc4a3f969b93a3b7520c46.1756522067.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/08/2025 à 05:51, Ritesh Harjani (IBM) a écrit :
> This patch adds PGD/PUD/PMD/PTE level information while dumping kernel
> page tables. Before this patch it was hard to identify which entries
> belongs to which page table level e.g.
> 
> ~ # dmesg |grep -i radix
> [0.000000] radix-mmu: Mapped 0x0000000000000000-0x0000000005400000 with 2.00 MiB pages (exec)
> [0.000000] radix-mmu: Mapped 0x0000000005400000-0x0000000040000000 with 2.00 MiB pages
> [0.000000] radix-mmu: Mapped 0x0000000040000000-0x0000000100000000 with 1.00 GiB pages
> [0.000000] radix-mmu: Initializing Radix MMU
> 
> Before:
> ---[ Start of kernel VM ]---
> 0xc000000000000000-0xc000000003ffffff  XXX   64M   r      X   pte  valid  present  dirty  accessed
> 0xc000000004000000-0xc00000003fffffff  XXX  960M   r  w       pte  valid  present  dirty  accessed
> 0xc000000040000000-0xc0000000ffffffff  XXX    3G   r  w       pte  valid  present  dirty  accessed
> ...
> ---[ vmemmap start ]---
> 0xc00c000000000000-0xc00c0000003fffff  XXX    4M   r  w       pte  valid  present  dirty  accessed
> 
> After:
> ---[ Start of kernel VM ]---
> 0xc000000000000000-0xc000000003ffffff  XXX   64M PMD  r      X   pte  valid  present  dirty  accessed
> 0xc000000004000000-0xc00000003fffffff  XXX  960M PMD  r  w       pte  valid  present  dirty  accessed
> 0xc000000040000000-0xc0000000ffffffff  XXX    3G PUD  r  w       pte  valid  present  dirty  accessed
> ...
> ---[ vmemmap start ]---
> 0xc00c000000000000-0xc00c0000003fffff  XXX    4M PMD  r  w       pte  valid  present  dirty  accessed
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/mm/ptdump/8xx.c      | 5 +++++
>   arch/powerpc/mm/ptdump/book3s64.c | 5 +++++
>   arch/powerpc/mm/ptdump/ptdump.c   | 1 +
>   arch/powerpc/mm/ptdump/ptdump.h   | 1 +
>   arch/powerpc/mm/ptdump/shared.c   | 5 +++++
>   5 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
> index b5c79b11ea3c..1dc0f2438a73 100644
> --- a/arch/powerpc/mm/ptdump/8xx.c
> +++ b/arch/powerpc/mm/ptdump/8xx.c
> @@ -71,18 +71,23 @@ static const struct flag_info flag_array[] = {
> 
>   struct pgtable_level pg_level[5] = {
>   	{ /* pgd */
> +		.name	= "PGD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* p4d */
> +		.name	= "P4D",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pud */
> +		.name	= "PUD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pmd */
> +		.name	= "PMD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pte */
> +		.name	= "PTX",

Why PTX not PTE ?

>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	},
> diff --git a/arch/powerpc/mm/ptdump/book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
> index 5ad92d9dc5d1..79c9a8391042 100644
> --- a/arch/powerpc/mm/ptdump/book3s64.c
> +++ b/arch/powerpc/mm/ptdump/book3s64.c
> @@ -104,18 +104,23 @@ static const struct flag_info flag_array[] = {
> 
>   struct pgtable_level pg_level[5] = {
>   	{ /* pgd */
> +		.name	= "PGD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* p4d */
> +		.name	= "P4D",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pud */
> +		.name	= "PUD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pmd */
> +		.name	= "PMD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pte */
> +		.name	= "PTE",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	},
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index b2358d794855..0d499aebee72 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -178,6 +178,7 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
>   	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
>   	pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
>   	pt_dump_size(st->seq, addr - st->start_address);
> +	pt_dump_seq_printf(st->seq, "%s ", pg_level[st->level].name);
>   }
> 
>   static void note_prot_wx(struct pg_state *st, unsigned long addr)
> diff --git a/arch/powerpc/mm/ptdump/ptdump.h b/arch/powerpc/mm/ptdump/ptdump.h
> index 154efae96ae0..88cf28c4138e 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.h
> +++ b/arch/powerpc/mm/ptdump/ptdump.h
> @@ -13,6 +13,7 @@ struct flag_info {
> 
>   struct pgtable_level {
>   	const struct flag_info *flag;
> +	char name[4];
>   	size_t num;
>   	u64 mask;
>   };
> diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
> index 39c30c62b7ea..92d77f3e5155 100644
> --- a/arch/powerpc/mm/ptdump/shared.c
> +++ b/arch/powerpc/mm/ptdump/shared.c
> @@ -69,18 +69,23 @@ static const struct flag_info flag_array[] = {
> 
>   struct pgtable_level pg_level[5] = {
>   	{ /* pgd */
> +		.name	= "PGD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* p4d */
> +		.name	= "P4D",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pud */
> +		.name	= "PUD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pmd */
> +		.name	= "PMD",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	}, { /* pte */
> +		.name	= "PTE",
>   		.flag	= flag_array,
>   		.num	= ARRAY_SIZE(flag_array),
>   	},
> --
> 2.50.1
> 


