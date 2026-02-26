Return-Path: <linuxppc-dev+bounces-17314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FA6FD8FF4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMLr90nHBz2yLG;
	Fri, 27 Feb 2026 06:19:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772133593;
	cv=none; b=c7s0ey6T7MGeTQUANMNmNstzx+HsV9QSPa4OnsfvYgjsZuLkGOuBJEXDw6dwSOKoNvPCPgITeO38IsIsAFJMy7P3M0UmteoL8m8iJSri3Fx8rTXgCmnozrVDKjEDdFHQ7wXYKsPFYYycLD//KCG/dPnTKJpgPYVSOX5Bj6Qa/5Yu2jzr6KknHd6MxJM4Gmv2EXANlQKWp9S17wxWbDhxHnhoKHxn0kBIqS9s3lX94SOJsqR/APjL7T5K8kZVZshs26+siGQhnv6Tuk45Mtu7rQlgdoexHYurW2MjwYnIuQUFLaVqQStKnDazHSxzM9b+yb6XFEBrr9XIPzsiYfZCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772133593; c=relaxed/relaxed;
	bh=QswHhSqswsaY0/Szj1Ml4ocdX2s+k/6cyvO8Up56Duw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieJsuzr2GZqK6+0Df4E12hiwD65Na5SbDAAYIU/YB8MTeh+d7ijXQ7ZlQJYquP0lBHO8hu4YxJUifvSXL6mumgOMvTT2eIU3Z55L3cEBJHQWf4N0ag1alRHgthpRE8aIB6T5RoB2FGZ24uSuZrtONGo3A8BhR5VneK9KtgJedJZ46sHMGaqQwVc3WlGy8RdysHsx55UEZW2QjLA0ltZXMT9tHP4FP2BWciHDn4Aey2TML5h8+YYUShUnNKxxlpb0K4aTX+rktQWsw6AqBPMTyCryF3jaJeRCwq33S9IrP7d+u0yJVo0pAQkBED1jJFCB6Gv14ziZYAIJeWA0ePPPHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s00vwljG; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s00vwljG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMLr721wDz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 06:19:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QswHhSqswsaY0/Szj1Ml4ocdX2s+k/6cyvO8Up56Duw=; b=s00vwljGVTst0m8Eh5W/kFcdDZ
	nodIjbeYu5CrsVTY9NALdG3Ykxm9J14BoXZqG8ryrN5uT+GfJOMtG5etb4vrV6Eay5dSPJGXX+o//
	NWEMuMzocWnN6n3I7buwa9uKCP8rJ3nZMaDkR2rMcTA69YqoxCQzXNXJNSbCSG/zB+TL3ex1Ubq/C
	ch+zW7wcDY726Ob2C+mzfBZ5W5v1reB1Yahhcf5E5ZzBvLYnbQOP9o3VW7r0L3RWuOyYKEhxW+3lq
	z45kWVFluim4wqLaTpnR+oQkz6vXBPYCkXbWyb/rt8X8t390tU5pFBuNjZSthGnGBL/86ZwyrrM7P
	VKvX+a1A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgtl-000000072pT-0Du6;
	Thu, 26 Feb 2026 19:19:45 +0000
Message-ID: <8ef1def3-afa7-416a-af42-bf4324fc788a@infradead.org>
Date: Thu, 26 Feb 2026 11:19:44 -0800
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
Subject: Re: [PATCH] powerpc/ps3: fix ps3.h kernel-doc warnings
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20260222060101.2086504-1-rdunlap@infradead.org>
 <4e84b9ea-9e7b-420a-bca9-6febd87a80cb@kernel.org>
 <17c0c331-276b-4f43-890e-39fb3010103c@infradead.org>
 <c4a9ba45-24d5-474f-968f-a9dde81d3303@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c4a9ba45-24d5-474f-968f-a9dde81d3303@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/26/26 3:58 AM, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 26/02/2026 à 02:45, Randy Dunlap a écrit :
>>
>>
>> On 2/24/26 10:57 PM, Christophe Leroy (CS GROUP) wrote:
>>> Hi Randy,
>>>
>>> Le 22/02/2026 à 07:01, Randy Dunlap a écrit :
>>>> Eliminate all kernel-doc warnings in ps3.h:
>>>> - add one missing struct member description
>>>> - add one missing function short description
>>>> - correct one enum name typo
>>>> - change several incomplete kernel-doc comments to plain "/*" comments
>>>>
>>>> Examples:
>>>>
>>>> Warning: arch/powerpc/include/asm/ps3.h:96 struct member 'dev' not
>>>>    described in 'ps3_dma_region'
>>>> Warning: arch/powerpc/include/asm/ps3.h:408 missing initial short
>>>>    description on line: * ps3_system_bus_set_drvdata -
>>>> Warning: arch/powerpc/include/asm/ps3.h:473 Enum value
>>>>    'PS3_LPM_TB_TYPE_INTERNAL' not described in enum 'ps3_lpm_tb_type'
>>>> Warning: arch/powerpc/include/asm/ps3.h:473 Excess enum value
>>>>    '@PS3_LPM_RIGHTS_USE_TB' description in 'ps3_lpm_tb_type'
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> You sent a V2 with the same subject some time ago, see https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinuxppc-dev%2Fpatch%2F20251129183636.1893634-1-rdunlap%40infradead.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C5f40eabfbf95474b6c4608de74d8ad0e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639076671142017726%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Bk2srZQMhhrA6rpHEFx2CIxSee8%2FUM2TIrNQSFpP8%2B4%3D&reserved=0
>>>
>>> Is this patch something else, does it superseeds V2, or is it a wrong resend of V1 ?
>>
>> Yup, it's a wrong resend of v1. It means that my patch tracking system
>> failed me. Sorry about that.
>>
> 
> Ok so I reject that one.

ack.

> Here is the list of patches from you we have in the pipe:
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=18663

Looks good. Thanks.

-- 
~Randy


