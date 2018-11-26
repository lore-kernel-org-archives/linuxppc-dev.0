Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895CDC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 07:06:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC7220664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 07:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC7220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Hy25qRNzDqLx
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 18:06:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433Hvr0ZyqzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 18:04:08 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 433Hvl3vJ8z9vF7M;
 Mon, 26 Nov 2018 08:04:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id pZ8NDTZPOyfG; Mon, 26 Nov 2018 08:04:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 433Hvl36lqz9vF7K;
 Mon, 26 Nov 2018 08:04:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 03DA48B77B;
 Mon, 26 Nov 2018 08:04:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gcSdqzHHraiK; Mon, 26 Nov 2018 08:04:03 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 863318B74B;
 Mon, 26 Nov 2018 08:04:03 +0100 (CET)
Subject: Re: [PATCH 5/5] arch: simplify several early memory allocations
To: Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7a92357c-6251-fe84-d724-16fdc49d03a3@c-s.fr>
Date: Mon, 26 Nov 2018 08:03:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/11/2018 à 22:44, Mike Rapoport a écrit :
> There are several early memory allocations in arch/ code that use
> memblock_phys_alloc() to allocate memory, convert the returned physical
> address to the virtual address and then set the allocated memory to zero.
> 
> Exactly the same behaviour can be achieved simply by calling
> memblock_alloc(): it allocates the memory in the same way as
> memblock_phys_alloc(), then it performs the phys_to_virt() conversion and
> clears the allocated memory.
> 
> Replace the longer sequence with a simpler call to memblock_alloc().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/arm/mm/mmu.c                     |  4 +---
>   arch/c6x/mm/dma-coherent.c            |  9 ++-------
>   arch/nds32/mm/init.c                  | 12 ++++--------
>   arch/powerpc/kernel/setup-common.c    |  4 ++--
>   arch/powerpc/mm/pgtable_32.c          |  4 +---
>   arch/powerpc/mm/ppc_mmu_32.c          |  3 +--
>   arch/powerpc/platforms/powernv/opal.c |  3 +--
>   arch/sparc/kernel/prom_64.c           |  7 ++-----
>   arch/sparc/mm/init_64.c               |  9 +++------
>   arch/unicore32/mm/mmu.c               |  4 +---
>   10 files changed, 18 insertions(+), 41 deletions(-)
> 
[...]

> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index bda3c6f..9931e68 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -50,9 +50,7 @@ __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
>   	if (slab_is_available()) {
>   		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
>   	} else {
> -		pte = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> -		if (pte)
> -			clear_page(pte);
> +		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);

memblock_alloc() uses memset to zeroize the block.

clear_page() is more performant than memset().


Christophe

[...]
