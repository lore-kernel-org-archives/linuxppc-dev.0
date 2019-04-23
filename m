Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CDC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCEA20843
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fXXLYPZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCEA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pJ660W21zDqDq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:28:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="fXXLYPZR"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pJ481l0dzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 19:26:46 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44pJ401klQz9v0sV;
 Tue, 23 Apr 2019 11:26:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=fXXLYPZR; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dcXsdNJd-ocU; Tue, 23 Apr 2019 11:26:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44pJ400ZD5z9v0sN;
 Tue, 23 Apr 2019 11:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556011600; bh=xI7IThQ7+DmQeJrdqSOU3ghoRqGDIfHXUVxgmi7bLNs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fXXLYPZR3626eXWtP6vuRXKfCKY8cQAepp0mZDGbKpbm7TkkTOuwGcQMMNhceAk34
 gOmD+KFbXvbHMDTfg/aMdBTsvnjHWeq0d4VkpgO9xtFk8a/GKcqvtNLEBQqy2qo8zV
 BPG0f/epfRLXkUiwqnaUKAlOp35YIbBhQn47rxiM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EC158B8C7;
 Tue, 23 Apr 2019 11:26:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id nl9mGBsdaIrc; Tue, 23 Apr 2019 11:26:40 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7573F8B8C4;
 Tue, 23 Apr 2019 11:26:40 +0200 (CEST)
Subject: Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel Userspace Access
 Protection
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
 <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
 <87ftqfu7j1.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e297ba05-e82d-d269-20d2-5bd3914b1d14@c-s.fr>
Date: Tue, 23 Apr 2019 11:26:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ftqfu7j1.fsf@concordia.ellerman.id.au>
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



Le 18/04/2019 à 08:55, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
>> index 5f97c742ca71..b3560b2de435 100644
>> --- a/arch/powerpc/include/asm/book3s/32/kup.h
>> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
>> @@ -37,6 +37,113 @@
> ...
>> +
>> +static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
>> +{
>> +	u32 addr = (__force u32)to;
>> +	u32 end = min(addr + size, TASK_SIZE);
>> +
>> +	if (!addr || addr >= TASK_SIZE || !size)
>> +		return;
>> +
>> +	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
>> +	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
>> +}
> 
> When rebasing on my v6 I changed the above to:
> 
> static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
> {
> 	u32 addr, end;
> 
> 	if (__builtin_constant_p(to) && to == NULL)
> 		return;

Good point, it avoids keeping the test compiled in when the 'to' is not 
NULL.

> 
> 	addr = (__force u32)to;
> 
> 	if (!addr || addr >= TASK_SIZE || !size)
> 		return;

Then the !addr test isn't needed anymore I think.

Christophe

> 
> 	end = min(addr + size, TASK_SIZE);
> 	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
> 	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
> }
> 
> Which I think achieves the same result. It does boot :)
> 
>> +
>> +static inline void prevent_user_access(void __user *to, const void __user *from, u32 size)
>> +{
>> +	u32 addr = (__force u32)to;
>> +	u32 end = min(addr + size, TASK_SIZE);
>> +
>> +	if (!addr || addr >= TASK_SIZE || !size)
>> +		return;
>> +
>> +	current->thread.kuap = 0;
>> +	kuap_update_sr(mfsrin(addr) | SR_KS, addr, end);	/* set Ks */
>> +}
>> +
>> +static inline void allow_read_from_user(const void __user *from, unsigned long size)
>> +{
>> +}
> 
> And I dropped that.
> 
> cheers
> 
