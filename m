Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F240DECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 11:16:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C22D2150D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 11:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C22D2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZqP82vpgzF3Z8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 22:16:12 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZqLy3T9LzF3Xp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 22:14:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42ZqLq2Vfbz9ttFL;
 Wed, 17 Oct 2018 13:14:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id LDEN7I_JHYek; Wed, 17 Oct 2018 13:14:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42ZqLq1m84z9ttBq;
 Wed, 17 Oct 2018 13:14:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 88FA68B7FA;
 Wed, 17 Oct 2018 13:14:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ezw1CVoaURvd; Wed, 17 Oct 2018 13:14:11 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C86A8B7F2;
 Wed, 17 Oct 2018 13:14:11 +0200 (CEST)
Subject: Re: Crash on FSL Book3E due to pte_pgprot()? (was Re: [PATCH v3
 12/24] powerpc/mm: use pte helpers in generic code)
To: Michael Ellerman <mpe@ellerman.id.au>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr>
 <87va61jsma.fsf@concordia.ellerman.id.au>
 <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr>
 <87efcoeudx.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6ec9cf4b-abd2-8244-4780-4564a7ffb1ad@c-s.fr>
Date: Wed, 17 Oct 2018 11:12:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87efcoeudx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 10/17/2018 10:32 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> On 10/17/2018 12:59 AM, Michael Ellerman wrote:
> ...
>>> The question is what's the right way to fix it? Should pte_pgprot() not
>>> be filtering those bits out on book3e?
>>
>> I think we should not use pte_pggrot() for that then. What about the
>> below fix ?
> 
> Thanks, that almost works.
> 
> pte_mkprivileged() also needs to not strip _PAGE_BAP_SR.

Oops, I missed it allthough I knew it. Patch below.

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 17 Oct 2018 10:46:24 +0000
Subject: [PATCH] powerpc/book3e: redefine pte_mkprivileged() and 
pte_mkuser()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras 
<paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Book3e defines both _PAGE_USER and _PAGE_PRIVILEGED, so the nohash
default pte_mkprivileged() and pte_mkuser() are not usable.

This patch redefines them for book3e.

Fixes: a0da4bc166f2 ("powerpc/mm: Allow platforms to redefine some helpers")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
  arch/powerpc/include/asm/nohash/pte-book3e.h | 14 ++++++++++++++
  1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h 
b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 58eef8cb569d..fb4297dff3e2 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -109,5 +109,19 @@
  #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
  #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)

+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
+}
+
+#define pte_mkprivileged pte_mkprivileged
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
+}
+
+#define pte_mkuser pte_mkuser
+
  #endif /* __KERNEL__ */
  #endif /*  _ASM_POWERPC_NOHASH_PTE_BOOK3E_H */
-- 
2.13.3



> 
> 
> But there's also a use of pte_pgprot() in mm/memory.c, and I think that
> is also broken now that we don't add PAGE_KERNEL back in.
> 
> Aneesh is going to do a patch to make pte_pgprot() only mask the PFN
> which is what other arches do.

Yes I saw it, that's ok for me.

Christophe

> 
> cheers
> 
>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>> Date: Wed, 17 Oct 2018 05:56:25 +0000
>> Subject: [PATCH] powerpc/mm: don't use pte_pgprot() in ioremap_prot()
>>
>> pte_pgprot() filters out some required flags like _PAGE_PRESENT.
>>
>> This patch replaces pte_pgprot() by __pgprot(pte_val())
>> in ioremap_prot()
>>
>> Fixes: 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>    arch/powerpc/mm/pgtable_32.c | 3 ++-
>>    arch/powerpc/mm/pgtable_64.c | 4 ++--
>>    2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index 5877f5aa8f5d..a606e2f4937b 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -122,7 +122,8 @@ ioremap_prot(phys_addr_t addr, unsigned long size,
>> unsigned long flags)
>>    	pte = pte_exprotect(pte);
>>    	pte = pte_mkprivileged(pte);
>>
>> -	return __ioremap_caller(addr, size, pte_pgprot(pte),
>> __builtin_return_address(0));
>> +	return __ioremap_caller(addr, size, __pgprot(pte_val(pte)),
>> +				__builtin_return_address(0));
>>    }
>>    EXPORT_SYMBOL(ioremap_prot);
>>
>> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
>> index fb1375c07e8c..836bf436cabb 100644
>> --- a/arch/powerpc/mm/pgtable_64.c
>> +++ b/arch/powerpc/mm/pgtable_64.c
>> @@ -245,8 +245,8 @@ void __iomem * ioremap_prot(phys_addr_t addr,
>> unsigned long size,
>>    	pte = pte_mkprivileged(pte);
>>
>>    	if (ppc_md.ioremap)
>> -		return ppc_md.ioremap(addr, size, pte_pgprot(pte), caller);
>> -	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
>> +		return ppc_md.ioremap(addr, size, __pgprot(pte_val(pte)), caller);
>> +	return __ioremap_caller(addr, size, __pgprot(pte_val(pte)), caller);
>>    }
>>
>>
>> -- 
>> 2.13.3
