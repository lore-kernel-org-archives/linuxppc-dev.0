Return-Path: <linuxppc-dev+bounces-21602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3210BCD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 17:29:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQc6y1JTCz2yZc;
	Thu, 28 May 2026 03:29:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c0c:a5b1::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779902954;
	cv=none; b=hTAo1DBHG9EgOBfz3yFpVYwD5moxCMU1pZnDMtPlNaMwubQOSUwO6Hpfo2S+KtGzA/ys2M6SRqgLiQKkZlZycqN+zDnkwyAvXpMWnyaxPOzGGx+/59vHSR3t5MHp0TUaqZpaFPDuviZKQY4yuPm/3k6o6LSxczVwCBAQulfayoJf7iQ55v0YbjRyOq/6VwmYj1f9v1vwn8NJLsSmgnirh1SwEw4wX6CRuq7G0cFremKQJzXC/poZGIuqkdPgfiIpLFaGWpU782Vi1STu2CkjuilDxOTGkWNiflabTBijnh2craYlmZJs3GGH2io1Iq1lGolX5FLhm6QHAoglIdjizg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779902954; c=relaxed/relaxed;
	bh=J/VWqwpEYPWstKg+SpxK80jhJzLxyaQYNnBjeSm9eIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDquGB4vmDPDEyDAHH7hWRiDC5h6+nQ1dA7zJCQ0ULXCARawXqVbByG8Z7C20dGfWGX1Kqbs7Sk4SvNkDK08McS3zmIwgXXZU46u7XrzV5e4TI6p0ADdLLnA1jOqJfVQd745d6hrkyCOG25o8CVrxR6EjQyiYEt5KMFsobAFww6lVmdlSfYa9MPCiBmdK3m80uHKIYpDaypTElVK3D194OxZ2k5YoDx7f+0fMMiM3Q/iXBhXID0lFKm63GbkEPXGIqJZWeOR8jR+dF1cdHb/psjbsXjr3h95RzBvOicoIxH20vjjB3+FBpMzIzK/N3CObrUGnbxAoCPmq+LCvpO5PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; dkim=pass (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.a=rsa-sha256 header.s=default header.b=rLHEumCE; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c0c:a5b1::1; helo=mta.al2klimov.de; envelope-from=grandmaster@al2klimov.de; receiver=lists.ozlabs.org) smtp.mailfrom=al2klimov.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.a=rsa-sha256 header.s=default header.b=rLHEumCE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=al2klimov.de (client-ip=2a01:4f8:c0c:a5b1::1; helo=mta.al2klimov.de; envelope-from=grandmaster@al2klimov.de; receiver=lists.ozlabs.org)
Received: from mta.al2klimov.de (mta.al2klimov.de [IPv6:2a01:4f8:c0c:a5b1::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQc6w0dt4z2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 03:29:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=Pbcm9SAmqJM0
	tqLZipmWlKtIorq5H22yQEpLMbmTlxU=; h=in-reply-to:from:references:cc:to:
	subject:date; d=al2klimov.de; b=rLHEumCEPr3F2j3tc+5XR8S8Nxiyp3hmZ8TNha
	RyJ+xeiNDMzOqZWSa5Hku6DsJov+TYrdh5PtiR2cgCgPVgHgI/HKdcjCzt335GGBeUx6E5
	FNw+42EfTzR/G8HBUtfBIMa530tf+L4Z6lk4oHpBeWQL/T/oCxIl+Fvjkv2enXKB9xWP1Z
	b91Wy9GT+u1xgl3LbbeTMn03iZfBPgmqtMKstXay0h9gMOP/Q0BQZHfme70RpNTwR1L0+K
	2uL5q3geNYbsTGp5DcNT5lFh8uIQNW6BdZ7bE3iIIGzDceaJ8XvWQYsbll41cv6wS2ZW+Z
	GJgy8G0tQk6QpQJ3adim2q+w==
Received: from [192.168.0.101] (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 371e7f99 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 27 May 2026 17:22:27 +0000 (UTC)
Message-ID: <1f859595-eb97-4668-966a-416db417fcbd@al2klimov.de>
Date: Wed, 27 May 2026 19:22:26 +0200
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
Subject: Re: [PATCH] ibmvnic: fix krealloc() memory leak
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Haren Myneni <haren@linux.ibm.com>, Rick Lindsley
 <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
 <20260526184105.18962-6-grandmaster@al2klimov.de>
 <fc74cefb2e0167514f1c3c0c3d6133ec@tipi-net.de>
Content-Language: en-US
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
In-Reply-To: <fc74cefb2e0167514f1c3c0c3d6133ec@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/26/26 22:50, Nicolai Buchwitz wrote:
> Hi Alex
> 
> You patch is missing the prefix with the target tree. Please have
> a look at [1] for more details on the workflow.

Damn. :-)

So far I've always got away with whatever I copied from the majority of
git log --oneline --follow FILE

> 
> On 26.5.2026 20:41, Alexander A. Klimov wrote:
>> Don't just overwrite the original pointer passed to krealloc()
>> with its return value without checking latter:
>>
>>     MEM = krealloc(MEM, SZ, GFP);
>>
>> If krealloc() returns NULL, that erases the pointer
>> to the still allocated memory, hence leaks this memory.
>> Instead, use a temporary variable, check it's not NULL
>> and only then assign it to the original pointer:
>>
>>     TMP = krealloc(MEM, SZ, GFP);
>>     if (!TMP) return;
>>     MEM = TMP;
>>
>> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of Vital Product Data (VPD) for the ibmvnic driver")
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>  drivers/net/ethernet/ibm/ibmvnic.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
>> index 5a510eed335e..25d1d844ad19 100644
>> --- a/drivers/net/ethernet/ibm/ibmvnic.c
>> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
>> @@ -1761,8 +1761,9 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
>>      union ibmvnic_crq crq;
>>      int len = 0;
>>      int rc;
>> +    unsigned char *buff = adapter->vpd->buff;
> 
> Should be reverse x-mas tree (longest to shortest).
> 
>>
>> -    if (adapter->vpd->buff)
>> +    if (buff)
>>          len = adapter->vpd->len;
>>
>>      mutex_lock(&adapter->fw_lock);
>> @@ -1788,17 +1789,17 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
>>      if (!adapter->vpd->len)
>>          return -ENODATA;
>>
>> -    if (!adapter->vpd->buff)
>> -        adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
>> +    if (!buff)
>> +        buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
>>      else if (adapter->vpd->len != len)
>> -        adapter->vpd->buff =
>> -            krealloc(adapter->vpd->buff,
>> -                 adapter->vpd->len, GFP_KERNEL);
>> +        buff = krealloc(buff,
>> +                adapter->vpd->len, GFP_KERNEL);
> 
> Dead branch? The only caller, init_resources(), kzalloc()s a fresh vpd
> right before, and resets run release_vpd_data() first, so vpd->buff is
> always NULL here and kzalloc() above always wins. The leak can't trigger,

Cool! No leak = no problem = nothing to do here

