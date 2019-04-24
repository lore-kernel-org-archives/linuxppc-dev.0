Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2215C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 14:12:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0171221773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 14:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AslU0E22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0171221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q2M15mbmzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 00:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="AslU0E22"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q2J54VDrzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 00:09:39 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44q2Hy3QfJz9v1Lv;
 Wed, 24 Apr 2019 16:09:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=AslU0E22; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id geB8DTC6TZOy; Wed, 24 Apr 2019 16:09:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44q2Hy1mrTz9v1Ls;
 Wed, 24 Apr 2019 16:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556114974; bh=zwwAZWJV1BE8AwI49JQnbFk7+vD7247Kx8wwTVrhxzw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=AslU0E22efgpUvJCJ+mk30KTUlre3aJ81f+Zuj9EcbFgpK0at+iwSSE2GR0SnDtMO
 951JakSrNa7ejQN10hVbLaw6E8plxjM7FmVKTCEPZjfBFMlEjA6oyuQ8xciSJ6o/Cb
 PcP2GaFc5drqQGzynohSSymu9qtZ3TYwi1l+17v0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B8E428B913;
 Wed, 24 Apr 2019 16:09:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 59CSbUfY2pt7; Wed, 24 Apr 2019 16:09:35 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 961908B8FB;
 Wed, 24 Apr 2019 16:09:35 +0200 (CEST)
Subject: Re: [PATCH v1 01/27] powerpc/mm: Don't BUG() in hugepd_page()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
 <9d6b0fe78346ff8e81a969a75a616bab59bc5cf5.1553076180.git.christophe.leroy@c-s.fr>
 <87r2a93xto.fsf@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bdeba4a0-451e-ab57-d844-197d7c8ae761@c-s.fr>
Date: Wed, 24 Apr 2019 16:09:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87r2a93xto.fsf@linux.ibm.com>
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



Le 11/04/2019 à 07:39, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Don't BUG(), just warn and return NULL.
>> If the NULL value is not handled, it will get catched anyway.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/hugetlb.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
>> index 8d40565ad0c3..48c29686c78e 100644
>> --- a/arch/powerpc/include/asm/hugetlb.h
>> +++ b/arch/powerpc/include/asm/hugetlb.h
>> @@ -14,7 +14,8 @@
>>    */
>>   static inline pte_t *hugepd_page(hugepd_t hpd)
>>   {
>> -	BUG_ON(!hugepd_ok(hpd));
>> +	if (WARN_ON(!hugepd_ok(hpd)))
>> +		return NULL;
> 
> We should not find that true. That BUG_ON was there to catch errors
> when changing pte formats. May be switch that VM_BUG_ON()?

Ok, I'll switch to VM_BUG_ON()

Christophe

> 
>>   	/*
>>   	 * We have only four bits to encode, MMU page size
>>   	 */
>> @@ -42,7 +43,8 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
>>   
>>   static inline pte_t *hugepd_page(hugepd_t hpd)
>>   {
>> -	BUG_ON(!hugepd_ok(hpd));
>> +	if (WARN_ON(!hugepd_ok(hpd)))
>> +		return NULL;
>>   #ifdef CONFIG_PPC_8xx
>>   	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
>>   #else
>> -- 
>> 2.13.3
