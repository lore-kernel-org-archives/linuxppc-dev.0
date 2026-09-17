Return-Path: <linuxppc-dev+bounces-27573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA32DC982D5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 13:56:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hly2t6F3Vz2y2W;
	Thu, 17 Sep 2026 23:56:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789653366;
	cv=none; b=IkIuq+UZwNToOgQvF0hs+MBeoW1Q2lO8YMl9ERENpp/lPcZt4tB6QtVwDfle18Mnag8+7prom4TJ7/f9XxD/TY5A4cHf7AOd+eqXKZVS8qL7DtjEARCh6JC+7gvk/W493DYE4bu2FfxcjtfjDcmuKoPqWurUOSVE/WYLa1zAPv1+xvj/M5Wj4OF8AeXlcYEv+qlR0i+kHyeSci7HU0xQqG3/nHoZzPSr/E0Kdut4JAFWeVLfM3Nmq/BVfAMp7ox1HWAkY1nTH9qHGFDaqSQqQBGFsKPnXBAC5RORuQq/F5oEKrtz5YnLqMzkBp4rwbq7AZNJXdTlCNFzVpvTYEZo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789653366; c=relaxed/relaxed;
	bh=AU8CGgy6Pa5vfZgK02vvr6pONCCFzHgT9ly82BtluUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b6tqRyPSsairA8OqWG3xellt+q15Lc0WTUgc+rLuZiq06Nd+pHAA8H4EDz5fDBUNeWyZJBVfX0VULOP0A1SbbZOEetwa0EkNqUKOCFC7IIlOOmN713FvVYpFpz8vhaxtjvttcBUJQebhOJtzIqir4OSfk1dlsML5F7Ff9665mBkFzdgzgGIpYgrmLZF2UuLVagNah1hYNjygGwm4vEkjGHbgOfa/3Ma2OpxbWT1JHaAKlN55s2Bj/NadXoJAHZbQNrUqXEXbkTgJW5m7+3FJw41AfZDY7Xpbs9o9QJfIJg+tgQQ59hqs18cuFjQ0T74fo/do5n/trDwqjYeetzoDUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0o1NCLo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0o1NCLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hly2s5zLVz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:56:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84CA760052;
	Thu, 17 Sep 2026 13:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB311F000FF;
	Thu, 17 Sep 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653362;
	bh=AU8CGgy6Pa5vfZgK02vvr6pONCCFzHgT9ly82BtluUM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=f0o1NCLoIaKYvHe6FBZBBPQIdVjNHSj17+boe4ixXC3+KOmFDflYlsRC5fnT5VKxe
	 HiRy4SVb68ngiM7azj5+u6m0xyNju5V08cQfHJi2NV7PnWKPKN0HohbudLio9W316d
	 /edQAOX6ErcG27FlD7aI7nIlFvgogzkRyJF2d47a43MYtpOIbd3z+9IDQOratubN4N
	 ZuFV4D+qsmLiDJtiANyhBpkxPnBMa9HwkwVS+ElI9GOaUk8mXNshPSlsKTwpKcv5iZ
	 W69f14zdA0DevKSl2Y8ooTN16Hqf4yJJ0lXRIWagnyzIQCBiYdtgcfS7LhiSuDGGLp
	 iwWBqDVpHt2jw==
Message-ID: <c92a1202-1fa6-4cd8-9d82-b46a1b5d8f56@kernel.org>
Date: Thu, 17 Sep 2026 15:55:55 +0200
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
Subject: Re: [PATCH v8 00/10] mm/vmalloc: Speed up ioremap, vmalloc and vmap
 with contiguous memory
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org,
 catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com,
 will@kernel.org
Cc: Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, anshuman.khandual@arm.com,
 baohua@kernel.org, david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com,
 leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
 ryan.roberts@arm.com
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <493ef264-eab3-4be3-a80e-357f01ae1b37@kernel.org>
Content-Language: fr-FR
In-Reply-To: <493ef264-eab3-4be3-a80e-357f01ae1b37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/09/2026 à 14:17, Christophe Leroy (CS GROUP) a écrit :
> Hi,
> 
> Le 17/09/2026 à 07:29, Wen Jiang a écrit :
>> From: Wen Jiang <jiangwen6@xiaomi.com>
>>
>> This patchset accelerates ioremap, vmalloc, and vmap when the memory is
>> physically fully or partially contiguous. Two techniques are used:
>>
>> 1. Avoid page table rewalk when setting PTEs/PMDs for multiple memory
>>     segments
>> 2. Use batched mappings wherever possible in both vmalloc and ARM64
>>     layers
>>
>> Besides accelerating the mapping path, this also enables large
>> mappings (PMD and cont-PTE) for vmap, which are currently not
>> supported.
> 
> This series doesn't apply. I tried to apply it on top of v7.2, v7.3-rc3 
> and next-20260916
> 
> Can you tell how to apply it ?


Finaly I was able to apply it on top of v7.1

Christophe

