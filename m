Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3140C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589912084B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="f6N/R7qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589912084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YdFD2b39zDqPG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:35:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="f6N/R7qA"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YdCP0M5jzDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:34:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44YdCK4GR0z9v06L;
 Tue,  2 Apr 2019 20:34:05 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=f6N/R7qA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Ng-VYe-XEIkf; Tue,  2 Apr 2019 20:34:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44YdCK2j6wz9v06J;
 Tue,  2 Apr 2019 20:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554230045; bh=Cb3YnIlBkdMUGzh4FhtvAFv5AjuPTjhDxQUmbIVPXuU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=f6N/R7qAMOB8H/AVLFrCdlRgj7FI6unmQQojDC2xmd8KnlXJFhjLcxN3HaVaxovaz
 6kJAjcgdULgMz4f+1y7KKyYxIZI5QrHtvTtQVZT8D2VaIB8quKGF1jYag7MTHTmnzf
 glF1aI0Y7XB72dK4KHjMESyKBcNS3kgF+Lm/M2U0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 603368B8D2;
 Tue,  2 Apr 2019 20:34:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ixfx3RV0oav3; Tue,  2 Apr 2019 20:34:05 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DF2308B8CD;
 Tue,  2 Apr 2019 20:34:04 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc/mm: Reduce memory usage for mm_context_t for
 radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20190402143424.7075-1-aneesh.kumar@linux.ibm.com>
 <80f34a0e-2bbe-8751-6571-3f844103fc37@c-s.fr>
 <200e5a1a-9475-8d43-666c-1845f9d95d1b@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <aa7b67cb-8dc7-3352-213d-0fdc0c7159b5@c-s.fr>
Date: Tue, 2 Apr 2019 20:34:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <200e5a1a-9475-8d43-666c-1845f9d95d1b@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 02/04/2019 à 17:42, Aneesh Kumar K.V a écrit :
> On 4/2/19 9:06 PM, Christophe Leroy wrote:
>>
>>
>> Le 02/04/2019 à 16:34, Aneesh Kumar K.V a écrit :
>>> Currently, our mm_context_t on book3s64 include all hash specific
>>> context details like slice mask, subpage protection details. We
>>> can skip allocating those on radix. This will help us to save
>>> 8K per mm_context with radix translation.
>>>
>>> With the patch applied we have
>>>
>>> sizeof(mm_context_t)  = 136
>>> sizeof(struct hash_mm_context)  = 8288
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>> NOTE:
>>>
>>> If we want to do this, I am still trying to figure out how best we 
>>> can do this
>>> without all the #ifdef and other overhead for 8xx book3e
>>
>> Did you have a look at my series 
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=98170 ?
>>
>> It tries to reduce as much as feasible the #ifdefs and stuff.
>>
>>
> 
> Not yet. But a cursory look tell me introducing hash_mm_context 
> complicates this further unless I introduce something similar for nohash 
> 32? Are you ok with that?

Have a look at my review in the other mail, I think we can limit the 
changes and avoid introducing the hash_mm_context for 8xx.

Otherwise, we should call it something else, for instance 
extended_mm_context, but that looks unnecessary from my point of view.

Christophe
