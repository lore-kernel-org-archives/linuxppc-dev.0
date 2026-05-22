Return-Path: <linuxppc-dev+bounces-21387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E52CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 10:28:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMM1z2ZVqz2yHT;
	Fri, 22 May 2026 20:28:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779445719;
	cv=none; b=VSbniOwDSIkkU/inOv3l0ZHKKaj65bAO/ex1nzTnb9qMhPTgbMXSg0SNCC8cBF70kHy2x9KwPfpO7gEXfzvl7co/spf2Cyj8/RAwRFkfPLQ2jHKsAzrk50Xu24O5P3R5eP8N//bpiuQGFGQEYibxXdEn9CcZf6ARzRF7SOxDr5SUeQ+NVp6OvwabegGvsFZl4Elfmg9LUcoFUxE90YCuZNs1EHIqt1ZiWkSMYe2BvewmT2vvN0s2zDz2OrOr1B+ZmtVSCMBO0CgcPXojHgPGe3CDDCFu/bDunzlq2dFxDctys5va8l9B8a1L8DfV7w48WWEtex/0zMTSHQhPuRdG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779445719; c=relaxed/relaxed;
	bh=VF1GBnDH1TfMHCcLbg1KElBuyNuwHBmP/SstlDxzydw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQwj5c/MhfshkWiyBZN4jtzt5rf1bWJKKrkJdswZWwOGRJHPEskU3a4hpU8BP0WPrNoLxWR2VoTzNGgvnVPyxJPaK7DQHwCyOFuqVrlj03N1foEehNW7QYQb0t90VHpjiWceqsRDpTgODkkN9LYMzqttq6DVr16i2Sr2ot+sQZgdU7My8+YvmIzHTH5eRUFcEbVlhrS0YDJTyRfss8abXp7XHNWMmqPVf0PG3yy33EO7nVkT8MtEViDpycpPVxxbhUQtTiFdSnp7bwrM/atY+3JdZhFQFbF88rzD6fpQ3I5fow81yXA8raFrZ8sR+bluwUfSF2c0nIOwpcUaqBkAbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwVHpPrD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwVHpPrD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMM1t700mz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 20:28:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EDAA42DCD;
	Fri, 22 May 2026 10:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC2A1F000E9;
	Fri, 22 May 2026 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445712;
	bh=VF1GBnDH1TfMHCcLbg1KElBuyNuwHBmP/SstlDxzydw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QwVHpPrD/oEBvQMdU9brmnzYZbSsDOGAkDrk2jb8JZv62X7ESOn0Hfg794hQ/lgRq
	 /HrpWT4d4wRypU8zcgWlRgct6FBay9owLOTL4Vk39+bj2gpUkJD2aEnbOL6qbm0kIN
	 hgjlkD4Y/qT7M7ofxwpgPpCNmej22cCZdjXfhjJD3Nmc3urRr0hIyOiWHM3Od3X1me
	 hKuEZeSzg7Cc/ymL9IugmOxDpXNb4aROr0WkTdGsMYY8OjqoVxUTq1ubNR4kZYgGXH
	 HhNFddlLRiKKm9Co0UCidSBVgx9gxWNBm4zVAowAIIy/yl47noWHWKk00/x4ZrHAtv
	 Wc9N1Ft0418gA==
Message-ID: <227b6ea2-0cae-4f6d-a614-3b0891b5f8a5@kernel.org>
Date: Fri, 22 May 2026 12:28:28 +0200
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
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] char/nvram: Remove redundant nvram_mutex
To: Venkat <venkat88@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani
 <ritesh.list@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Tellakula Yeswanth Krishna <yeswanth@linux.ibm.com>
References: <20260428061540.73668-1-venkat88@linux.ibm.com>
 <FC8BDC39-4627-4532-B6FB-C4B88F4DF80E@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <FC8BDC39-4627-4532-B6FB-C4B88F4DF80E@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/05/2026 à 05:57, Venkat a écrit :
> 
> Hi,
> 
> Gentle ping on this patch.
> 
> This removes the unused global nvram_mutex and relies on the
> existing per-architecture synchronization, as suggested earlier.
> 
> I’ve re-tested the change, and everything continues to work as expected.
> No issues observed in validation.
> 
> Please let me know if any further changes are needed.
> 
> Thanks,
> Venkat
> 
> 
>> On 28 Apr 2026, at 11:45 AM, Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:
>>
>> The global nvram_mutex in drivers/char/nvram.c is redundant and unused,

Redundant with what ?

It is _used_, at least in nvram_misc_ioctl()


>> and this triggers compiler warnings on some configurations.
>>
>> All platform-specific nvram operations already provide their own internal
>> synchronization, meaning the wrapper-level mutex does not provide any
>> additional safety.

Indeed, this is what it is redundant with, I would say that first thing 
in the message.

I think it would also be worth providing the history from Arnd from 
here: 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260323072422.25730-1-venkat88@linux.ibm.com/#3667538


>>
>> Remove the nvram_mutex definition along with all remaining lock/unlock
>> users across PPC32, x86, and m68k code paths, and rely entirely on the
>> per-architecture nvram implementations for locking.
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Tested-by: Tellakula Yeswanth Krishna <yeswanth@linux.ibm.com>
>> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

With the above changes, Reviewed-by: Christophe Leroy (CS GROUP) 
<chleroy@kernel.org>

>> ---
>> Changes since v4:
>> - No code changes
>> - Resent after v7.1-rc1 as suggested by Arnd Bergmann
>>
>> drivers/char/nvram.c | 16 +++-------------
>> 1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
>> index 9eff426a9286..e89cc1f1c89e 100644
>> --- a/drivers/char/nvram.c
>> +++ b/drivers/char/nvram.c
>> @@ -53,7 +53,6 @@
>> #include <asm/nvram.h>
>> #endif
>>
>> -static DEFINE_MUTEX(nvram_mutex);
>> static DEFINE_SPINLOCK(nvram_state_lock);
>> static int nvram_open_cnt; /* #times opened */
>> static int nvram_open_mode; /* special open modes */
>> @@ -310,11 +309,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>> break;
>> #ifdef CONFIG_PPC32
>> case IOC_NVRAM_SYNC:
>> - if (ppc_md.nvram_sync != NULL) {
>> - mutex_lock(&nvram_mutex);
>> + if (ppc_md.nvram_sync)
>> ppc_md.nvram_sync();
>> - mutex_unlock(&nvram_mutex);
>> - }
>> ret = 0;
>> break;
>> #endif
>> @@ -324,11 +320,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>> if (!capable(CAP_SYS_ADMIN))
>> return -EACCES;
>>
>> - if (arch_nvram_ops.initialize != NULL) {
>> - mutex_lock(&nvram_mutex);
>> + if (arch_nvram_ops.initialize)
>> ret = arch_nvram_ops.initialize();
>> - mutex_unlock(&nvram_mutex);
>> - }
>> break;
>> case NVRAM_SETCKS:
>> /* just set checksum, contents unchanged (maybe useful after
>> @@ -336,11 +329,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>> if (!capable(CAP_SYS_ADMIN))
>> return -EACCES;
>>
>> - if (arch_nvram_ops.set_checksum != NULL) {
>> - mutex_lock(&nvram_mutex);
>> + if (arch_nvram_ops.set_checksum)
>> ret = arch_nvram_ops.set_checksum();
>> - mutex_unlock(&nvram_mutex);
>> - }
>> break;
>> #endif /* CONFIG_X86 || CONFIG_M68K */
>> }
>> -- 
>> 2.45.2
>>
> 


