Return-Path: <linuxppc-dev+bounces-22314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E76BCD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:33:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZMcb6bwMz2yY0;
	Tue, 09 Jun 2026 18:33:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780993999;
	cv=none; b=NS+zUYXaTANa2zzFVbNjOhmCLgAgtUIFrMtn1Jxgu/B7dQARmKAx+5LaAQaJB4gQLA5bgVt1LJ8o0s0N65WHHbBL2R+M3rNawGU3zSiug53QTPrUfJym6+4pFQ9qorUk7KTkcP+lRjb6uYQLTRaVKw/qjvJea7tihlVmXwQG2G1tWJItdi+bPvZGwZ+L8PUi4Ah2v8GxSEkg1b3LmmS5wVhC4qi7bts9IdtwhCFteKDdy48GO3ta7axs0nYaBKBShNpxoDlpiyzvRR354PzJ+1C5Df33HUAB4LO2rib75/MSIqHRyHWvgTXuGqmpHwCWlQrBuNbWTcvSuwvfR4DSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780993999; c=relaxed/relaxed;
	bh=RNEiL25jLm9POHPH27wOyewK7kZxaI+xHPG08xT1M34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBK4raAqWBhUup4h0vxaJIM5LrhZCemKqQORFoJ6M1yUig1KKsad58/ETaVs/3UYQPkbmh5XAx/3uasKhQ50dkX+XhmUIpOgHME5jRodPVC1BtciMmltrF7dpp7YO8ug86ui5V1vwHCMzAM3sxLszRFrlE+IhT30WpauxmWTEgcu6f7seQTAtVFqFoH/2NPcYOHowTVqCzUVIp4VXNr1z1TD04BC+END0tLUEhRNeIpGYgX3+BgKqqnB4FBtMfNhj0V5WxsfDycAcUc9K8eolt0fMs2+o5MiBBdr7wGjZDqN717zrZ3uBANaS9Z7ARmZq5wih2gZrN7fOJ/A9n/43A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mJaSDUGc; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=vladimir.murzin@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mJaSDUGc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=vladimir.murzin@arm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 368 seconds by postgrey-1.37 at boromir; Tue, 09 Jun 2026 18:33:17 AEST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZMcY1gF1z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 18:33:16 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BB552437;
	Tue,  9 Jun 2026 01:26:30 -0700 (PDT)
Received: from [10.1.38.173] (e121487-lin.cambridge.arm.com [10.1.38.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF7863F93E;
	Tue,  9 Jun 2026 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780993594; bh=Yoo/97pymrQY5ONHYeyzpmC5cmDHw3EWNj3VX3KKs18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mJaSDUGckTEW2cEbViQ2Y9cbstKnsRfKnWiSBkOsT20+8kN+ghoWrdrovk4UE4G92
	 gj/2Tpf8iA1JtlD+yUL6Ew15movzmGVGJldLk+P4cITzDAI/Y+W3366q2yK018N9RJ
	 V7e5CVm3j2zR/TdePl7zFwH4kY7u9AHYNyBhTkkg=
Message-ID: <4f635592-b294-4303-a045-d529de29875c@arm.com>
Date: Tue, 9 Jun 2026 09:26:28 +0100
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
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Liz Prucka <lizprucka@google.com>,
 Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com>
 <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
 <CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>
 <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/9/26 07:28, Marek Szyprowski wrote:
> On 09.06.2026 08:22, Marek Szyprowski wrote:
>> On 29.05.2026 17:02, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The linear aliases of the kernel text and rodata are also mapped
>>> read-only in the linear map. Given that the contents of these regions
>>> are mostly identical to the version in the loadable image, mapping them
>>> read-only and leaving their contents visible is a reasonable hardening
>>> measure.
>>>
>>> Data and bss, however, are now also mapped read-only but the contents of
>>> these regions are more likely to contain data that we'd rather not leak.
>>> So let's unmap these entirely in the linear map when the kernel is
>>> running normally.
>>>
>>> When going into hibernation or waking up from it, these regions need to
>>> be mapped, so map the region initially, and toggle the valid bit so
>>> map/unmap the region as needed.
>>>
>>> Doing so is required because pages covering the kernel image are marked
>>> as PageReserved, and therefore disregarded for snapshotting by the
>>> hibernate logic unless they are mapped.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> This commit landed in yesterday's linux-next as commit 63e0b6a5b693
>> ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
>> In my tests I found that it breaks booting of RaspberryPi3 and
>> RaspberryPi4 boards with the following kernel panic:
> One more comment - reverting 63e0b6a5b693 and 53205d56212c (dependent
> change) on top of next-20260608 fixes this issue.
> 

Thanks for report! It seems it already has been reported and discussed in
another thread [1].

[1] https://lore.kernel.org/linux-arm-kernel/aicVyebkEMs6w6UV@sirena.co.uk/

Cheers
Vladimir


> Best regards
> -- Marek Szyprowski, PhD Samsung R&D Institute Poland
> 


