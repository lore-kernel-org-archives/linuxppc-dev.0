Return-Path: <linuxppc-dev+bounces-17218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F08DFD45F9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 01:45:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLvRG3YNLz2xQs;
	Thu, 26 Feb 2026 12:45:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772070314;
	cv=none; b=bz+yub+sSLxH7pP4XvjJkZYpO2NPPDTYBrOubqd4s/9omG6EOIvEGGgvO5uFV9iSGOP0LgyGBVnW5FYB1P1DH/zEMgtqAnYbRv2e3rQhx8Q6NQU90gJoLtjcM9JGZ6xv5Fc/iOISa5GpOP3XZLn7RvYZuMTAiKf+rEwWIfBT+KEMUgmOSitVTKbBngKFogJvUjzzUhEe7YcOAYZPsR4CL2+ON9FqMG7H++EoYuHVgWG043Kw7KG9gmryJeFrZz7IMn40diLmUJ5fFutlfN6MtAqhtzT0scvWMj7kJq09Ucd66TrUtuSBGO+xPDKTA1S0o/PUuwqzXCqCyDsI9eEFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772070314; c=relaxed/relaxed;
	bh=2KLFSpe/y6PBK2utudpiIr0PIzy9MAZDLPGOa1YtlsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTx8OipGo4pkgzc+5gOEovSI2Htkg/6Krv/YtiY2jOXpDez+mvHnZBnJA0qymYAGt/iuKbp92itj4INX8JHk/HR9wFs0bMj7GFkp1ha678wu6kGQFiR8XmxZfQFgn1PsLI726FV+BoLyI9ew1lhdoWdcGtGsudQ/3DdFjMuy/9Ks2iTps3anZeV2i7CdqW9dX4A3qtyJBOs2sP/TuxrjaHKs7H0x2yQi1UVhplY+BUp+W93RvgHQJpSXSBMiSe50ivbYdl+flkFOmTVMIf62VFzK84tl5noP8E9YkvT4GArHAvexeeNCqdZpxedqV1ICQg5qNb0dImaUs80FrlPrtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XesDZs3s; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XesDZs3s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLvRD3zQWz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 12:45:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2KLFSpe/y6PBK2utudpiIr0PIzy9MAZDLPGOa1YtlsY=; b=XesDZs3s/vFUSEaG45tkq6htUZ
	NJxH6F2qYowi6RtzeQQ3dtaB3ZeeDPR4ubDUMvmpH2ydYlmDsxRZ5Z4YvHDajuiqRpncZFJqAJhPm
	/gIhyt15cpKMDEeeiF5A/+VA5w4wHe+kNK6ZjDomj9gaasy0dnuG8ET1jbV6wwuUn3XmRDHkVxNes
	6cwyc4sLgFIrxr85apUI8ECSCO1HEK/UtQVUNrp73IO/Won5hrtxzMZtaO3RcKLC3LVCyq2B4vHeC
	zjAMpR6Os2COBQUc3OO9FiNNoqB6wzgNsg02JnEQPtoGXZ3Chi8yKoU69EX9CZfnQdX4lq21VOakp
	PNwin7Hg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvQR5-00000005Cbx-3sNs;
	Thu, 26 Feb 2026 01:45:05 +0000
Message-ID: <17c0c331-276b-4f43-890e-39fb3010103c@infradead.org>
Date: Wed, 25 Feb 2026 17:45:03 -0800
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4e84b9ea-9e7b-420a-bca9-6febd87a80cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/24/26 10:57 PM, Christophe Leroy (CS GROUP) wrote:
> Hi Randy,
> 
> Le 22/02/2026 à 07:01, Randy Dunlap a écrit :
>> Eliminate all kernel-doc warnings in ps3.h:
>> - add one missing struct member description
>> - add one missing function short description
>> - correct one enum name typo
>> - change several incomplete kernel-doc comments to plain "/*" comments
>>
>> Examples:
>>
>> Warning: arch/powerpc/include/asm/ps3.h:96 struct member 'dev' not
>>   described in 'ps3_dma_region'
>> Warning: arch/powerpc/include/asm/ps3.h:408 missing initial short
>>   description on line: * ps3_system_bus_set_drvdata -
>> Warning: arch/powerpc/include/asm/ps3.h:473 Enum value
>>   'PS3_LPM_TB_TYPE_INTERNAL' not described in enum 'ps3_lpm_tb_type'
>> Warning: arch/powerpc/include/asm/ps3.h:473 Excess enum value
>>   '@PS3_LPM_RIGHTS_USE_TB' description in 'ps3_lpm_tb_type'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> You sent a V2 with the same subject some time ago, see https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20251129183636.1893634-1-rdunlap@infradead.org/
> 
> Is this patch something else, does it superseeds V2, or is it a wrong resend of V1 ?

Yup, it's a wrong resend of v1. It means that my patch tracking system
failed me. Sorry about that.

-- 
~Randy


