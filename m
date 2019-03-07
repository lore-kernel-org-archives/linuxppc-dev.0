Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2147C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 19:12:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BB420449
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 19:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Yesw0lRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB420449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FgHX08D7zDqFY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 06:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Yesw0lRi"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FgFh4K9pzDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 06:10:45 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44FgFW6Kxfz9tyQ1;
 Thu,  7 Mar 2019 20:10:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Yesw0lRi; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7O4mVB8x-SqD; Thu,  7 Mar 2019 20:10:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44FgFW4tHgz9tyPy;
 Thu,  7 Mar 2019 20:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551985839; bh=r98bFk+0JeAa5RHG+w4EX7hnDlIY+Lzi9W22ay+2kXs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Yesw0lRiQU1cDz7sH6Gdn3uZgIbFIWwQiOik4khGArTWUzLN5T+JgJuXxZxDbI1mQ
 unjxGOvxhrEoeYY18k+zDfrAGms0Lsa8W2AvIjdHaWP0XOKOo87d5nWJeysibJQ/vA
 fsWLeFp/o3Zs/f1z+QCJbIzSOvqmd1m/wZqMufNo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AE9588BF27;
 Thu,  7 Mar 2019 20:10:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id knXBY3POHDIy; Thu,  7 Mar 2019 20:10:39 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1090F8BEE3;
 Thu,  7 Mar 2019 20:10:39 +0100 (CET)
Subject: Re: [PATCH v2 03/10] powerpc/6xx: Store PGDIR physical address in a
 SPRG
To: Guenter Roeck <linux@roeck-us.net>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
 <297f30d8ba75cb0e9ebe0a776d96c19750105570.1550745320.git.christophe.leroy@c-s.fr>
 <20190307141143.GA26761@roeck-us.net>
 <2acc1691-0f74-8843-ecdd-64ba8705de20@c-s.fr>
 <20190307190748.GA21622@roeck-us.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <18f2d49d-4f3e-8e60-a6c5-6d305b3b17cb@c-s.fr>
Date: Thu, 7 Mar 2019 20:10:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307190748.GA21622@roeck-us.net>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 07/03/2019 à 20:07, Guenter Roeck a écrit :
> On Thu, Mar 07, 2019 at 06:14:09PM +0000, Christophe Leroy wrote:
>> Hi,
>>
>> On 03/07/2019 02:11 PM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Thu, Feb 21, 2019 at 10:37:55AM +0000, Christophe Leroy wrote:
>>>> Use SPRN_SPRG2 to store the current thread PGDIR and
>>>> avoid reading thread_struct.pgdir at every TLB miss.
>>>>
>>> This patch causes a number of silent (no crash) qemu boot stalls
>>> in -next. See
>>> https://kerneltests.org/builders/qemu-ppc-next/builds/1080/steps/qemubuildcommand/logs/stdio
>>> for an example.
>>
>> Oops.
>> Could you try the fix below ?
>>
> 
> Yes, that does the trick. With this patch applied on top of next-20190306,
> all my ppc qemu boot tests pass.
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for testing.

I'll send a proper patch tomorrow morning, sorry for that.

Christophe

> 
> Guenter
> 
>> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S
>> b/arch/powerpc/kernel/cpu_setup_6xx.S
>> index 6f1c11e0691f..7534ecff5e92 100644
>> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
>> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
>> @@ -24,9 +24,6 @@ BEGIN_MMU_FTR_SECTION
>>   	li	r10,0
>>   	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
>>   END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
>> -	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
>> -	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
>> -	mtspr	SPRN_SPRG_PGDIR, r10
>>
>>   BEGIN_FTR_SECTION
>>   	bl	__init_fpu_registers
>> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
>> index ce6a972f2584..48051c8977c5 100644
>> --- a/arch/powerpc/kernel/head_32.S
>> +++ b/arch/powerpc/kernel/head_32.S
>> @@ -855,6 +855,9 @@ __secondary_start:
>>   	li	r3,0
>>   	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
>>   #endif
>> +	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
>> +	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
>> +	mtspr	SPRN_SPRG_PGDIR, r4
>>
>>   	/* enable MMU and jump to start_secondary */
>>   	li	r4,MSR_KERNEL
>> @@ -942,6 +945,9 @@ start_here:
>>   	li	r3,0
>>   	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
>>   #endif
>> +	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
>> +	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
>> +	mtspr	SPRN_SPRG_PGDIR, r4
>>
>>   	/* stack */
>>   	lis	r1,init_thread_union@ha
>> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
>> index 1f13494efb2b..587e4550d83e 100644
>> --- a/arch/powerpc/mm/hash_low_32.S
>> +++ b/arch/powerpc/mm/hash_low_32.S
>> @@ -70,12 +70,12 @@ _GLOBAL(hash_page)
>>   	lis	r0,KERNELBASE@h		/* check if kernel address */
>>   	cmplw	0,r4,r0
>>   	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
>> -	mfspr	r5, SPRN_SPRG_PGDIR	/* virt page-table root */
>> +	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
>>   	blt+	112f			/* assume user more likely */
>> -	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
>> -	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
>> +	lis	r5, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
>> +	addi	r5 ,r5 , (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
>>   	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
>> -112:	tophys(r5, r5)
>> +112:
>>   #ifndef CONFIG_PTE_64BIT
>>   	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
>>   	lwz	r8,0(r5)		/* get pmd entry */
>>
>>
>> Thanks
>> Christophe
>>
>>>
>>> Unfortunately, it is not possible to revert the patch due to subsequent
>>> patches, so I was unable to test a revert.
>>>
>>> Bisect log is attached.
>>>
>>> Guenter
>>>
>>> ---
>>> # bad: [cf08baa29613dd899954089e7cc7dba1d478b365] Add linux-next specific files for 20190306
>>> # good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
>>> git bisect start 'HEAD' 'v5.0'
>>> # bad: [6cc8f3499ec8d31904ab9083980a91736512cb37] Merge remote-tracking branch 'vfs/for-next'
>>> git bisect bad 6cc8f3499ec8d31904ab9083980a91736512cb37
>>> # good: [63bdf4284c38a48af21745ceb148a087b190cd21] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
>>> git bisect good 63bdf4284c38a48af21745ceb148a087b190cd21
>>> # good: [520b5fc601ab760fee7ea0c403b42d04e8ebfd93] Merge remote-tracking branch 'arm-soc/for-next'
>>> git bisect good 520b5fc601ab760fee7ea0c403b42d04e8ebfd93
>>> # bad: [d7f54e4e0d4e90f5df78da8d6a830bafad3b535a] Merge remote-tracking branch 'xtensa/xtensa-for-next'
>>> git bisect bad d7f54e4e0d4e90f5df78da8d6a830bafad3b535a
>>> # good: [0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f] Merge remote-tracking branch 'clk/clk-next'
>>> git bisect good 0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f
>>> # bad: [fb0b0a73b223fc113e961b1d921322844e9c30d9] powerpc: Enable kcov
>>> git bisect bad fb0b0a73b223fc113e961b1d921322844e9c30d9
>>> # good: [d0055df0c9c1471c389197a69f43e300185a75aa] Merge branch 'topic/dma' into next
>>> git bisect good d0055df0c9c1471c389197a69f43e300185a75aa
>>> # good: [0df977eafc792a5365a7f81d8d5920132e03afad] powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS
>>> git bisect good 0df977eafc792a5365a7f81d8d5920132e03afad
>>> # bad: [665bed2386e5dc29844ad78c7ef1464664b103ec] powerpc/8xx: replace most #ifdef by IS_ENABLED() in 8xx_mmu.c
>>> git bisect bad 665bed2386e5dc29844ad78c7ef1464664b103ec
>>> # bad: [78ca1108b10927b3d068c8da91352b0f4cd01fc5] powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB handling
>>> git bisect bad 78ca1108b10927b3d068c8da91352b0f4cd01fc5
>>> # bad: [a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee] powerpc/603: Don't handle kernel page TLB misses when not need
>>> git bisect bad a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee
>>> # bad: [2c12393f577396a51b7e0537bd3eb29dcc26dc1b] powerpc/603: use physical address directly in TLB miss handlers.
>>> git bisect bad 2c12393f577396a51b7e0537bd3eb29dcc26dc1b
>>> # bad: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
>>> git bisect bad 93c4a162b014d238a287f8264adb25c009c79e61
>>> # first bad commit: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
>>>
