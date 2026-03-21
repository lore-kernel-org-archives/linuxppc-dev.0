Return-Path: <linuxppc-dev+bounces-18531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553301093170
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:23:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd7B33Ztvz2yYq;
	Sat, 21 Mar 2026 16:23:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774070587;
	cv=none; b=aI5S97nV3TDzUHNSfhJEBZpHR9vBoI1L3DzyOi5KBaXo2xns59Id7Sl5HmM9X8JKKZyepGn8+LX/PxlQhbWQ2nkFhFYlAIlOSb54ciEV5ggUyz/Rcy6bbAXNpytYiJahmyW9ur5+QTsIPOT/caj96w/dJzj/xpk5wqpMubqv9AYC2FUgRcRZBcWlmsbRmb16KT8XqNM7u4c1/3OXTaWU4HJb11lwiyKlI1ZRKhFG3SZbpglWEKaiqg/1KSljThxUpM/7QT/L5eCiPJNMhoGCO5RlqypQIFuw+UHUVuTFIUAIwRzr85AbSFxv8EChrvTzFD7OffPvtCYgY1kxE+S5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774070587; c=relaxed/relaxed;
	bh=PcTvfZxxxHTOO8PPQsyM51dY96hQcI/WjTannbuBJtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PD3tGOgXypp80VrdfPORQoXGWTsZHLUzbMrTLD65r8DDRDjuspcrQ0xO0bQZnuYUCFClpPZa3+so3HlY7jVh0nW03MhMpR34s5VHy96hULWB/dxbmikGiEiFs2127LcCvfmuRn8F7R1AvTXwKSPdoEd9yYFLI010UDuimWug7k/4oJT4RvkcySQbR/Rz97tEbxCpUhDAdDa80RyiDVq7x4wtQVS2msGKVPs68/t+TXpHJp1iqTjxnVY/dRqdLVaGJ7j/Tc8iKPnyqbnMIN8yQNuIaSRPzvOTomjZTvN3luUHaZdqLxpAG41P0V10BLBl0uHMOutT1JjT5XlXWdZsyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QB2NpBLo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QB2NpBLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd79y6YcPz2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 16:23:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774070575; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PcTvfZxxxHTOO8PPQsyM51dY96hQcI/WjTannbuBJtg=;
	b=QB2NpBLoqG5Crb3aZk79xMM4k0qroaojnJ192NzCjvMrCkbuAFUKExQ6o0R9Qjtt+r2tx0Y1YAwQm2cqaq6xgvHVTS/DzmsBtPLMfFOBGWVnTYfM5cPFA+ZyX2G/g+w2yJ6aVcb3/5lH3xt3rWJr5LaGUVNJ54D+usGTPzJF25s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.O-uAP_1774070572;
Received: from 30.42.98.36(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.O-uAP_1774070572 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 13:22:53 +0800
Message-ID: <a9c48aca-fd2b-4b01-95d2-62607594d236@linux.alibaba.com>
Date: Sat, 21 Mar 2026 13:22:52 +0800
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
Subject: Re: [PATCH 1/6] mm: change to return bool for
 ptep_test_and_clear_young()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
 <ikarxctf.ritesh.list@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ikarxctf.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/26 1:57 PM, Ritesh Harjani (IBM) wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Callers use ptep_test_and_clear_young() to clear the young flag and check
>> whether it was set. Change the return type to bool to make the intention
>> clearer.
>>
> 
> Right I checked all callers of ptep_test_and_clear_young(). I agree, we
> only need bool here.
> 
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h             |  8 ++++----
>>   arch/arm64/mm/contpte.c                      |  4 ++--
>>   arch/microblaze/include/asm/pgtable.h        |  2 +-
>>   arch/parisc/include/asm/pgtable.h            |  6 +++---
>>   arch/powerpc/include/asm/book3s/32/pgtable.h |  4 ++--
>>   arch/powerpc/include/asm/book3s/64/pgtable.h |  6 +++---
>>   arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++--
> 
> I looked at it because of powerpc changes, but ended up looking into all
> call sites anyways. So overall it LGTM (and I agree that we can remove
> the unnecessary externs from function declarations)
> 
> With that please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for reviewing. Will remove externs:)

