Return-Path: <linuxppc-dev+bounces-26222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9499C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 06:49:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYKP15C24z2y2f;
	Mon, 31 Aug 2026 16:49:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788158997;
	cv=none; b=TKuvwfcvGRfIn0T6/yCcTImqCwzVm/5xkO0KA3SywafK30WEqse386hYD+06QWYIu94H4sg9VwYZa6H2Ean2m/1tbqotnQGTDYuGoqPfqp5wFFCmsJQS4zXRZOb/0RKXeBJEZ0PVC3hX9uGGwEaqNYR774516KhU3qgIoWNIYQU61r47uhxe+NFX0ThOlSGU1TKCmTa4h8hjCatsA84ddksYZ8W9YXup5R+q1PXmTS3bsuwLp/XNx7zLyjxLZCIiw5N2CpNiaZ2KsZF2J+yOTrYpiyCeSHH9hUJdmRR8DYzVm8OjMLdO05D3SWsq4NgwuYQwGHFWlE0RVV/jhD2b1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788158997; c=relaxed/relaxed;
	bh=/H8XwUq6/bROzHqqhxbKEvOIJlS9kKt/F3AGQnb3rVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJJ74K9Jc9xxqgKa0w7yfreoVyYNvwvoXhtIFpLx9f6t4wwVp8kpQjHxjAvHGQPoIsjJEPMWFc6lUwA1IEBO4qe3BlVTuF0tgP/1rzAPV+7cDABnhQNB0iRA3ES1kbSN09mlNbhgayJqwNnoeGUlGMF25XwKArKq9VGAbsdswX45s9fAGNsxy0FDQHpmd8g0WHCPj/oI83e5kY+HEJqgtu4roS4jX44+MvmVrma/XRWVCYUPe68zxDB87VWapZIaLpa2R6mjmwM7i5pIM+wLb8yAHPXHxBLuBqyzDfUYiTSPxdyZtT0iNO8USCFPugyVGXW5np2TRU4AqkZMvgHRow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U7FcIb97; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U7FcIb97;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYKNy3ZxRz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 16:49:52 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B591414BF;
	Sun, 30 Aug 2026 23:49:14 -0700 (PDT)
Received: from [10.164.18.31] (J09HK2D2RT.blr.arm.com [10.164.18.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75643F8C6;
	Sun, 30 Aug 2026 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788158958; bh=UzZgy0NWc63K+ko4Xr6TdOnwA9EjAL5aleqBNdt6jY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U7FcIb97JDEewur9Kf4radnvfeDHm6NiB7P5FNYX6eqEzgaSbcLTTz2427bXHEGdQ
	 uo4OFurjcGsPFnWvC+QS8s3MrHKwugc62Aj4Qy9UerHzl+ldPYjUgyGMq+omakELHp
	 zDbAViiLJS8zWjabH0UPjbR/p9ivvj9kKzLGGkiE=
Message-ID: <8ad05b11-5cc3-4682-b921-a0c7820b1f97@arm.com>
Date: Mon, 31 Aug 2026 12:19:08 +0530
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
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-mm@kvack.org
Cc: samuel.holland@sifive.com, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <d766413f91cd778912f6af372d3d5429bac7765f.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d766413f91cd778912f6af372d3d5429bac7765f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/08/26 11:38 AM, John Paul Adrian Glaubitz wrote:
> Hi Anshuman,
> 
> On Mon, 2026-08-31 at 11:13 +0530, Anshuman Khandual wrote:
>> pxd_ERROR() macros have been provided by all platforms, which are very much
>> identical and can be dropped off completely if these pgtable printing could
>> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> If pxd_ERROR() macros are really all identical, why not provide a common definiton
> of that macro? I'm always a bit concerned about such changes as there is always
> a risk to oversee arch-specific peculiarities.

We don't those platform macros any more after converting generic MM into using ptval_bytes_to_hex_str()
which now handles different pgtable entry types.
> 
> Adrian
> 


