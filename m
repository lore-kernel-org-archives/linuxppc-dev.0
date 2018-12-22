Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD85C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 13:10:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6252421A99
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 13:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6252421A99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MQp90CcnzDqf9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 00:10:09 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MQlp6tL0zDqTb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Dec 2018 00:08:06 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43MQlh20Cyz9v1df;
 Sat, 22 Dec 2018 14:08:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ykcfT3dcLq6j; Sat, 22 Dec 2018 14:08:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43MQlh1LvBz9v1dc;
 Sat, 22 Dec 2018 14:08:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C2928B785;
 Sat, 22 Dec 2018 14:08:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kKNcHBx26aqy; Sat, 22 Dec 2018 14:08:03 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BD8F08B74B;
 Sat, 22 Dec 2018 14:08:02 +0100 (CET)
Subject: Re: [PATCH] powerpc/4xx/ocm: fix compiler error
To: Christian Lamparter <chunkeey@gmail.com>
References: <20181222100934.8051-1-chunkeey@gmail.com>
 <abadbc68-c612-94c3-3248-dc6b55cf6822@c-s.fr> <2160350.91F9KbYz58@debian64>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <06576f55-e31f-2554-255d-d10f8576c7ab@c-s.fr>
Date: Sat, 22 Dec 2018 14:08:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <2160350.91F9KbYz58@debian64>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 181222-0, 22/12/2018), Outbound message
X-Antivirus-Status: Clean
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Markus Elfring <elfring@users.sourceforge.net>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 22/12/2018 à 12:27, Christian Lamparter a écrit :
> On Saturday, December 22, 2018 11:59:04 AM CET christophe leroy wrote:
>>
>> Le 22/12/2018 à 11:09, Christian Lamparter a écrit :
>>> This patch fixes a recent regression in ocm:
>>>
>>> ocm.c: In function ‘ocm_init_node’:
>>> ocm.c:182:18: error: invalid operands to binary |
>>> ocm.c:197:17: error: invalid operands to binary |
>>>
>>> Fixes: 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in ioremap()")
>>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>>
>> What's the problem here ? Is PAGE_KERNEL_NCG undefined ? If that's the
>> case, wouldn't it be better for fix that by including asm/pgtable.h ?
> 
> PAGE_KERNEL[_NCG] type is a struct of pgprot_t, whereas _PAGE_EXEC is
> considered an int.

Oops, I missed that.

Could you put the entire error message in the commit log ?

> 
> arch/powerpc/platforms/4xx/ocm.c: In function ‘ocm_init_node’:
> arch/powerpc/platforms/4xx/ocm.c:182:18: error: invalid operands to binary | (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
>         _PAGE_EXEC | PAGE_KERNEL_NCG);

Usually, Guarded implies no exec (at least on 6xx and 8xx). Does the 4xx 
accept guarded exec ?

>                    ^
> arch/powerpc/platforms/4xx/ocm.c:197:17: error: invalid operands to binary | (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
>         _PAGE_EXEC | PAGE_KERNEL);

That's PAGE_KERNEL_X

>                    ^
> 
> I think pgprot_val(PAGE_KERNEL[_NCG]) could be an option too.

Yes I may have a preference for that.

> 
> Christian
>>> ---
>>>    arch/powerpc/platforms/4xx/ocm.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
>>> index 561b09de69bf..04ff69ddac09 100644
>>> --- a/arch/powerpc/platforms/4xx/ocm.c
>>> +++ b/arch/powerpc/platforms/4xx/ocm.c
>>> @@ -179,7 +179,8 @@ static void __init ocm_init_node(int count, struct device_node *node)
>>>    	/* ioremap the non-cached region */
>>>    	if (ocm->nc.memtotal) {
>>>    		ocm->nc.virt = __ioremap(ocm->nc.phys, ocm->nc.memtotal,
>>> -					 _PAGE_EXEC | PAGE_KERNEL_NCG);
>>> +			_PAGE_EXEC | _PAGE_BASE_NC |
>>> +			_PAGE_KERNEL_RW | _PAGE_NO_CACHE | _PAGE_GUARDED);

Could be _PAGE_BASE_NC | _PAGE_KERNEL_RWX | _PAGE_NO_CACHE | _PAGE_GUARDED

Or pgprot_val(PAGE_KERNEL_NCG) | _PAGE_EXEC

Or pgprot_val(pgprot_noncached(PAGE_KERNEL_RWX)) (that's my preference)

>>>    
>>>    		if (!ocm->nc.virt) {
>>>    			printk(KERN_ERR
>>> @@ -194,7 +195,8 @@ static void __init ocm_init_node(int count, struct device_node *node)
>>>    
>>>    	if (ocm->c.memtotal) {
>>>    		ocm->c.virt = __ioremap(ocm->c.phys, ocm->c.memtotal,
>>> -					_PAGE_EXEC | PAGE_KERNEL);
>>> +					_PAGE_EXEC | _PAGE_BASE |
>>> +					_PAGE_KERNEL_RW);

What about _PAGE_BASE | _PAGE_KERNEL_RWX instead ?

Or pgprot_val(PAGE_KERNEL_RWX) (that's my preference)

Christophe

>>>    
>>>    		if (!ocm->c.virt) {
>>>    			printk(KERN_ERR
>>>
>>

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

