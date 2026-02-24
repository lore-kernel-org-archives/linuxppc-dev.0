Return-Path: <linuxppc-dev+bounces-17116-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F4AF3C9AC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 16:11:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL2lM6lSwz3cVK;
	Wed, 25 Feb 2026 03:11:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771949471;
	cv=none; b=LIvQ09tKPvdtRZ4ExCQZKOFN4/Pc1SLfsgprs3Z63Lz/nlxGlrDa7iY93X/u04rYXZsyKYLmXCafsaT/B7BBKlaAQZybCHaRrcHJcbs6h1MnaffUVhRFnSNMGQeQBPDAg+Gla2MOIwkVqyzwfoJ7r0mgoyDU0EgGh21PecXd+1Tmmnua0HzELmZSIi6dUp03IWmyaiPKGqj81LBlNEdPrsbR/CiWrpIwV7TLggjqXrMeSlhfB5C3y0oS7FiwWKoUw2rWDIV0ULG3O2tSDUp0UCd3uZJ5vlZsWZGQkzteMv1QYP7zpiw5QRo/mrKay4I+Ctj7dZoBFxfeagGzYKaCag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771949471; c=relaxed/relaxed;
	bh=MGxPgbd1Y1eKUe4oqApKFPkyBU1147l5ua5MacsPo4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLNPWs/+goTqvI9hjNCXJOeLKaK6O8o9w3lpmgVtS0/L+t9hVkKRqHvn3n4jhwrJcLJsixmhpEBXuMwOnPYpslVJCwR18f4N7OPCN7Vl8nWjc3e8RM9Y4QkvUHmsA1l7KojdeR/5Nu90oQWHIKBgPRKt/Gqoa3IRdFaduKqps7DDGeshnTgi4leSyWuZEJtxUq4BHwKFCheq3VdwwMgy5iOd/1J+oHnyEegAweLS5SW58kN8o67VTXU5xq/yuv+AKimU62gsYZMrHJwwvFLZY4GsX3v/1ev8rr/AY72ulzSr2p+k63ZghCxPgLAq1p8dHUnFleW2clypoqM09YR/EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M9/c75dG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M9/c75dG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL2lM1mWCz3cR1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 03:11:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 642FC61119;
	Tue, 24 Feb 2026 16:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A80DC116D0;
	Tue, 24 Feb 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771949468;
	bh=fdhBT8l/JcKIXS2ne2lkmrwsuR/CTkT5ozhsuLKERZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9/c75dG8dszOV0z1Be56sld1x/t2ZfPsTWRDI1P85Kk523WNOmba2nuMGKc+1Jku
	 M856aa+x0L/FpI2uLf1hx4XYG3e6JlSkl02y6jCbB8Ky35lWiOog5eECUG5FqzLJ1f
	 gZAy3eoMsogHzIThoAmlfOCcdUlWhFL77GKhTJDIoG07WLzl/chn5dHkFtnkkLOHeR
	 pQPXkmYgU6FbGH2Z4wiDmFKQR3fWW1gWw8ffZh+kdvgI0BF66s4lOFYzfcPf8WeZDF
	 1j+9jtzdwHADBkrH3xGU6vBW53yyCiwzPtZjBJTGd0SXDCVrhh5oOBlMxJDC6nRkmA
	 hdsf7LRfmjK6Q==
Message-ID: <c43286ec-90fb-4d3f-830a-e3644be3c310@kernel.org>
Date: Tue, 24 Feb 2026 17:11:03 +0100
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
Subject: Re: [PATCH v3] net/ibmveth: fix comment typos in ibmveth.c
To: Dave Marquardt <davemarq@linux.ibm.com>,
 Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260224153601.17534-1-abhindeka@gmail.com>
 <87v7fmyvjv.fsf@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <87v7fmyvjv.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/02/2026 à 17:07, Dave Marquardt a écrit :
> Abhilekh Deka <abhindeka@gmail.com> writes:
> 
>> Correct spelling mistakes in comments:
>> - Fix misspelling of gro_receive
>> - Fix misspelling of Partition
>>
>> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
>> ---
>>   drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 3108bf50576f..b2a578e6ff31 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -355,7 +355,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>   
>>   		/*
>>   		 * If multi rx buffers hcall is no longer supported by FW
>> -		 * e.g. in the case of Live Parttion Migration
>> +		 * e.g. in the case of Live Partition Migration
>>   		 */
>>   		if (batch > 1 && lpar_rc == H_FUNCTION) {
>>   			/*
>> @@ -480,7 +480,7 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>>   	 */
>>   	if (!reuse) {
>>   		/* remove the skb pointer to mark free. actual freeing is done
>> -		 * by upper level networking after gro_recieve
>> +		 * by upper level networking after gro_receive
>>   		 */
>>   		adapter->rx_buff_pool[pool].skbuff[index] = NULL;
> 
> I'm not quite sure why this was a v3 of this patch, but anyway.
> 
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
> 

I guess because there was a v2 5 minutes before with a misspelled 
subject "[PATCH v2] net/ibmveth: fix comment typos in imbveth.c"

