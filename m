Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61877606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hm16ekas
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYqdv6qvBz2yCP;
	Wed, 25 Nov 2026 04:33:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795541587;
	cv=none; b=Mdgo+1fnGh6GBTSH54dPTuSQQJg+vsjiPeonxS8u5CyfoQgZxpPaPBS9N6747PmB7FXe8UelP8ay1BgNVA44ZKhbB9KChLuRoDQS0Bqaph7HDvcjFT8rifte3wlpRzFaEEYB4I+7kW5YFX+6lg0Dz/BzTv1TU6Ek5mYHF41ZjDUoZeOQnwgys5RgmGdTydSlI4ClpXH53FWhfS0RFEQQci4Phy09CAzKjPfFru7/CNhdBn6HPf/0BQqgg4IG4tDbMXg1XJ253dcFU1r6VKq7P24mTKDNAVER5DC5OtJvh72/zSPVgzl+YPQeTbirCRKc7aa5ZelCzCl7QfnEz0FHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795541587; c=relaxed/relaxed;
	bh=98A+7uN4OE7FH54APkf+DmmnH7gzrRDq3ZVMmdDn64o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4MgnIAQaMKVgT29dB5yNLKslcRxQD8HymUds7sLuta5TbWMyJEIPScK6S2qj9m91jJroC4cdFw60GwnwarvKG/etwtTOW9ujCBIL4L/dVtsAL+yU+d+G9b+QsVPjneB1KuQJF1oRp/yGZQuEWZWBZGd258vuD3icPejBoB9cc70mwe7n24r3JBw3NKnPBkcUmkhdUT8WQfUjzJFkLd/9nOayDyp6z/ZLcKId6yX2dadnUQecSs7JYq1NVWgU7WlIugqyEmt01AY6HjBkjoVRZnjVk6Ubj6GSHjPerLx22S8CmG2yl0z0ZuyN74+dpcYs2jZ3yp+oB7aK/agKFy0xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hm16ekas; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hm16ekas;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYqdp6FmMz2y97
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 04:33:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=98A+7uN4OE7FH54APkf+DmmnH7gzrRDq3ZVMmdDn64o=; b=Hm16ekasdYLPomvBkJw5X66rV8
	qBap+Z4Nz/KXi8CvYxm347QOP2tNba+zrR6iofdgWaHhuNXJ3HIJG+Lj5G2NHVIvKqu+CDFAOQcoT
	lv44a004RmudgeDVba6WEEtBydQkBB2kVwJS968tRnfctXQqAPR1XhVGjb0jqcUFP927uIdU13Ikg
	PYwAd1wYWLeJ6spprzCnzr35ywY0j9iUdaiZR2xABsencCBn3z7QwXRMB0T+ynRjE0HQxDOIyRBbP
	dqZM023Udr0gZqungI+fYTvKBjaGcTL/ORuTH80tIDSZrg/ZGGLN3hcwA8CTZI9XU5cdhmLW/vJzU
	EeZsV0lA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVuO2-00000007N71-3KWQ;
	Tue, 24 Nov 2026 17:32:58 +0000
Message-ID: <0f88a818-55eb-407d-847c-7d2c9d2bcbd1@infradead.org>
Date: Tue, 24 Nov 2026 09:32:58 -0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] macintosh: ans-lcd: add missing MODULE_DESCRIPTION()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20261121192319.930162-1-rdunlap@infradead.org>
 <31d57c47-d8a2-4ac1-bf40-292fd3eab1a1@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <31d57c47-d8a2-4ac1-bf40-292fd3eab1a1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/26 3:10 AM, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 21/11/2026 à 20:23, Randy Dunlap a écrit :
>> Add missing MODULE_DESCRIPTION() that is now required.
>>
>> WARNING: modpost: drivers/macintosh/ans-lcd.ko: missing MODULE_DESCRIPTION()
> 
> Can you add in the commit message that it has been required since commit 6c6c1fc09de3 ("modpost: require a MODULE_DESCRIPTION()")

Will do.

> Also, that's probably not the only one in drivers/macintosh missing a MODULE_DESCRIPTION():
> 
>   drivers/macintosh$ git grep -l MODULE_ | wc -l
>   28
> 
>   drivers/macintosh$ git grep -l MODULE_DESCRIPTION | wc -l
>   23

It's the only one that I found after doing a lot of allmodconfig
test builds on various $ARCH.

But I'll take a look at the others. Thanks.

>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
>>
>>   drivers/macintosh/ans-lcd.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> --- linux-next-20261118.orig/drivers/macintosh/ans-lcd.c
>> +++ linux-next-20261118/drivers/macintosh/ans-lcd.c
>> @@ -202,4 +202,5 @@ anslcd_exit(void)
>>     module_init(anslcd_init);
>>   module_exit(anslcd_exit);
>> +MODULE_DESCRIPTION("/dev/lcd driver for Apple Network Servers");
>>   MODULE_LICENSE("GPL v2");
> 

-- 
~Randy


