Return-Path: <SRS0=TBQx=FN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F443C433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 11:58:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFCD233F8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 11:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFCD233F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrbDT6jdPzDqnp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 22:58:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Crb3m3zR6zDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 22:51:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Crb3W3LDYz9vBMV;
 Wed,  9 Dec 2020 12:51:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id PpTAKL4yDMRD; Wed,  9 Dec 2020 12:51:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Crb3W2CJGz9vBMT;
 Wed,  9 Dec 2020 12:51:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CC498B7E6;
 Wed,  9 Dec 2020 12:51:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id NZt4qmfxD-eb; Wed,  9 Dec 2020 12:51:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6657E8B7DB;
 Wed,  9 Dec 2020 12:51:03 +0100 (CET)
Subject: Re: [PATCH v1 2/6] powerpc/8xx: Always pin kernel text TLB
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
 <203b89de491e1379f1677a2685211b7c32adfff0.1606231483.git.christophe.leroy@csgroup.eu>
 <87lfe7s1j3.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a726961f-f440-b553-6c46-341a860dc90a@csgroup.eu>
Date: Wed, 9 Dec 2020 12:50:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87lfe7s1j3.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 09/12/2020 à 11:43, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> There is no big poing in not pinning kernel text anymore, as now
>> we can keep pinned TLB even with things like DEBUG_PAGEALLOC.
>>
>> Remove CONFIG_PIN_TLB_TEXT, making it always right.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/Kconfig               |  3 +--
>>   arch/powerpc/kernel/head_8xx.S     | 20 +++-----------------
>>   arch/powerpc/mm/nohash/8xx.c       |  3 +--
>>   arch/powerpc/platforms/8xx/Kconfig |  7 -------
>>   4 files changed, 5 insertions(+), 28 deletions(-)
>>
> ...
>> diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
>> index 231ca95f9ffb..19a3eec1d8c5 100644
>> --- a/arch/powerpc/mm/nohash/8xx.c
>> +++ b/arch/powerpc/mm/nohash/8xx.c
>> @@ -186,8 +186,7 @@ void mmu_mark_initmem_nx(void)
>>   	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, false);
>>   	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
>>   
>> -	if (IS_ENABLED(CONFIG_PIN_TLB_TEXT))
>> -		mmu_pin_tlb(block_mapped_ram, false);
>> +	mmu_pin_tlb(block_mapped_ram, false);
>>   }
> 
> This broke mpc885_ads_defconfig with:

:surprise:

How did I get it working ? Anyway, thanks for fixing it.

Christophe


> 
>    ld: arch/powerpc/mm/nohash/8xx.o: in function `mmu_mark_initmem_nx':
>    /home/michael/linux/arch/powerpc/mm/nohash/8xx.c:189: undefined reference to `mmu_pin_tlb'
>    make[1]: *** [/home/michael/linux/Makefile:1164: vmlinux] Error 1
>    make: *** [Makefile:185: __sub-make] Error 2
> 
> Fixed by:
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 35707e86c5f3..52702f3db6df 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -702,7 +702,6 @@ FixupDAR:/* Entry point for dcbx workaround. */
>   	mtspr	SPRN_DER, r8
>   	blr
>   
> -#ifdef CONFIG_PIN_TLB
>   _GLOBAL(mmu_pin_tlb)
>   	lis	r9, (1f - PAGE_OFFSET)@h
>   	ori	r9, r9, (1f - PAGE_OFFSET)@l
> @@ -802,7 +801,6 @@ _GLOBAL(mmu_pin_tlb)
>   	mtspr	SPRN_SRR1, r10
>   	mtspr	SPRN_SRR0, r11
>   	rfi
> -#endif /* CONFIG_PIN_TLB */
>   
>   /*
>    * We put a few things here that have to be page-aligned.
> 
> 
> cheers
> 
