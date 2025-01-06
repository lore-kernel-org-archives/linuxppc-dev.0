Return-Path: <linuxppc-dev+bounces-4711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82CFE77188
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2025 13:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRbCn0fRLz30Gm;
	Tue,  7 Jan 2025 00:50:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736171413;
	cv=none; b=DHPA4P09EV4gtASBtFChGG/OpBXgDUpmVbOEENqXaOXJxe2XJN7vfq14ORoH0QSuhQ52hwel4RyTrHbIblOcn6n5LJ5t9dU+eXAbHtEv1Ww69zoc6hPpPBCeD2aB+kl/ELNM/GA+rtq9HyCFbuX2zEsNjjUtXnqsJsPwE0LQUDOr3vjbngyp3oKohor2dJ6I3TXeAQq3s4qgTdIpoVLa63v8YVxKo0CJIR9EkHvkTwWRVNH8S5hFp5jdCbVtTkddnh9a6US2t8Fx4AXZw/hntQjIeZnrG0dojRsd2s8j0vrJyZLl2306NMZu/QKYaB/CepTwa74/OVXs1c8EnA/iXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736171413; c=relaxed/relaxed;
	bh=8hB6u4F+4EsOPZETDvHiT6L1r0IKX3k1eIV9rkmFEdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jan5CWJ5FcwbTgrnxqyVcSUVB3xuK6gSgBMUEVb5Inpw3axy2XG+1U239NPOm8/UHO6QSQF3f3FNBndYGTBo5ybIYAn1qMvCdR2RzCJUaQPk2CLGnX8her1Fpaix/kEzu54paKDr4USuaCxJeMTb9y7J3SwDqgocYcoq07O69BUUgbcpTa1sTmAeUlfkvccVnOLMrneC9VcfJTg3+uKsvyJCuhkSojU+nAKU+LJSPCLDpOg7zKPPE4RYk35c0oHnSZe9LJPSELgQ/0P/9qxvwEz+xRjFQFAwYxML7a1IvIpo4gNXssumkGh8uM0Ojz8CI/+venGfy8nvMG0TwaX8gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRbCl5XNJz30B8
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2025 00:50:10 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YRb140P3jz9sPd;
	Mon,  6 Jan 2025 14:40:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJ3gtH1K1DVt; Mon,  6 Jan 2025 14:40:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YRb136lQPz9rvV;
	Mon,  6 Jan 2025 14:40:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D6ECF8B76D;
	Mon,  6 Jan 2025 14:40:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id mOVSrQxjcbU4; Mon,  6 Jan 2025 14:40:55 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 603748B763;
	Mon,  6 Jan 2025 14:40:55 +0100 (CET)
Message-ID: <ffe7a52b-95cf-4611-b0ee-667272c9e0ee@csgroup.eu>
Date: Mon, 6 Jan 2025 14:40:55 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/pseries/vas: Fix typo
To: Markus Elfring <Markus.Elfring@web.de>,
 Colin Ian King <colin.i.king@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Haren Myneni <haren@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250106123241.161225-1-colin.i.king@gmail.com>
 <484f8c43-2c50-4467-be3f-8fe02f36e6b0@web.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <484f8c43-2c50-4467-be3f-8fe02f36e6b0@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/01/2025 à 14:35, Markus Elfring a écrit :
> …
>> +++ b/arch/powerpc/platforms/book3s/vas-api.c
>> @@ -490,7 +490,7 @@ static void vas_mmap_close(struct vm_area_struct *vma)
>>   	 * address. So it has to be the same VMA that is getting freed.
>>   	 */
>>   	if (WARN_ON(txwin->task_ref.vma != vma)) {
>> -		pr_err("Invalid paste address mmaping\n");
>> +		pr_err("Invalid paste address mmapping\n");
> 
>                                                mapping?


Or mmap-ing , as this is the action of calling mmap() ?

> 
> 
>>   		return;
>>   	}
> 
> 
> Regards,
> Markus


