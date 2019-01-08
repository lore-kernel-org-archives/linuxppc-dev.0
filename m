Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A4C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:21:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BD12087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BD12087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YmwS2JgpzDqQQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:21:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YmtJ04wxzDqRm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:19:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43YmtC0fRTz9v1Hq;
 Tue,  8 Jan 2019 10:19:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CrTFeaVsou8b; Tue,  8 Jan 2019 10:19:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43YmtC04Qmz9v1Hn;
 Tue,  8 Jan 2019 10:19:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C3DA8B7CA;
 Tue,  8 Jan 2019 10:19:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1gR2IyzXtbgC; Tue,  8 Jan 2019 10:19:31 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 75B708B7C9;
 Tue,  8 Jan 2019 10:19:31 +0100 (CET)
Subject: Re: [PATCH v2 2/2] powerpc: use probe_user_read()
To: David Hildenbrand <david@redhat.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Rapoport <rppt@linux.ibm.com>
References: <0b0db24e18063076e9d9f4e376994af83da05456.1546932949.git.christophe.leroy@c-s.fr>
 <e939991366b784ef13c7afcab51749e3b46327ac.1546932949.git.christophe.leroy@c-s.fr>
 <8a52b522-7b9d-e3d4-9c04-98292db11d85@redhat.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7317788a-c92d-661a-a405-b726d8054bad@c-s.fr>
Date: Tue, 8 Jan 2019 10:19:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <8a52b522-7b9d-e3d4-9c04-98292db11d85@redhat.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 08/01/2019 à 10:04, David Hildenbrand a écrit :
> On 08.01.19 08:37, Christophe Leroy wrote:
>> Instead of opencoding, use probe_user_read() to failessly
>> read a user location.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   v2: Using probe_user_read() instead of probe_user_address()
>>
>>   arch/powerpc/kernel/process.c   | 12 +-----------
>>   arch/powerpc/mm/fault.c         |  6 +-----
>>   arch/powerpc/perf/callchain.c   | 20 +++-----------------
>>   arch/powerpc/perf/core-book3s.c |  8 +-------
>>   arch/powerpc/sysdev/fsl_pci.c   | 10 ++++------
>>   5 files changed, 10 insertions(+), 46 deletions(-)
>>

[snip]

>> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>> index 918be816b097..c8a1b26489f5 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -1068,13 +1068,11 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
>>   	addr += mfspr(SPRN_MCAR);
>>   
>>   	if (is_in_pci_mem_space(addr)) {
>> -		if (user_mode(regs)) {
>> -			pagefault_disable();
>> -			ret = get_user(inst, (__u32 __user *)regs->nip);
>> -			pagefault_enable();
>> -		} else {
>> +		if (user_mode(regs))
>> +			ret = probe_user_read(&inst, (void __user *)regs->nip,
>> +					      sizeof(inst));
> 
> What about also adding probe_user_address ?

Michael doesn't like it, see https://patchwork.ozlabs.org/patch/1007117/

Christophe

> 
>> +		else
>>   			ret = probe_kernel_address((void *)regs->nip, inst);
>> -		}
>>   
>>   		if (!ret && mcheck_handle_load(regs, inst)) {
>>   			regs->nip += 4;
>>
> 
> 
