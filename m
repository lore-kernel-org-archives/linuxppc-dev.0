Return-Path: <linuxppc-dev+bounces-19612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C773F459EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 15:14:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsgLl6HXKz2ybQ;
	Sat, 11 Apr 2026 01:14:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775834047;
	cv=none; b=csliaIOOSzIdUzTB3eUQs67pDaU7byWgcI4i2+xqDFAKaeCq1XoVOYB6KLZDWQTssB7yqflLiX1ejxCG+LBpf5BpO92jegVq1y/FJiOBzKDRCTsf/2hXibsu4MusoCI+BbMrpvP477L6JRctcp8G+TJPjRi090pi9YQaDwJoS8Gfs/607MvwNr0MNGR+v/V7A5HoDNVNEdwnZG8y8vdS618IOVyC/Fk9p1coTgFa0nMbgh6AbJ0de/K/6eg5fzO6JgQe5qTSbucBW9MpuVesrT/sc4WojE/NQChdnHpFI0geSSBg/XSYOJzmEO1FfbtnOSl9oP3yLEdNZFoWjsorWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775834047; c=relaxed/relaxed;
	bh=Z6eHisBYg7qyonBevv/veresEfTDm6GmxPzgogzf6FU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IA4QCXLRayDwdlJEy5yBBg3fJXDOpmLa4V7IuG2JSGtgovXvn2qJ3yh0OgEVn0jWR5PYIOPNtrkDgZ5CHnF4MYYyB2oVYRVQOF59HPY7FGuctrgBuqhcX+txIiOlqyJovPlKU7oonOfVDfeDURfKwcdXetyAk0QkryUv2CrtPiLDL1TR6ozzEFfaw0zgq/32eqsJjxPge6poMhcVtY7vJOR5HblrMwi312rfF43ZuES5r49IlG98ZkpWbpYB4f0x8nt54L/wTR6mImPDhe2YZOV2EVuVUbW2rj1or0n/1QxiJYV6k49tnHVw0f5lkLwKZSrxP3BN+hQZFwTx7vZVyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DQRfv3hP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DQRfv3hP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsgLk1QF5z2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 01:14:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B0CF43DD6;
	Fri, 10 Apr 2026 15:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7DC19421;
	Fri, 10 Apr 2026 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834044;
	bh=ZX44VkA/oGGdYrqGVtHG3BQ09eU0s5TAD8UsmKEvOJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DQRfv3hPFw/TKa/ZakF0C/CvhlLPEsVqQv+2r4uwxdObvOGMMWr2s346gixb/wzYP
	 kH3jI1VGrMbPCg8bbeliLsWsv0WorMVV9pr65pzZbqt3ANfLMAZ3WpCzHo7EbPC0aw
	 sFqvG5W5Zh5Zl9hqpd/S10vk3SPDt4AvvXdP7MWFAVnJ1yy95RtrFN5r3P/n0YzraC
	 K1ddeqgVvP6yW3cqrHOPD+5bbhJuKzxhUEtkBkREvZCz2D1PF358eBsZtX1OaLotF8
	 mIrAdKqmlNIgawRmNAF5mT5jG8tytmCXBJPCuscrYjON8tMw7soKn19X1CoLhvhPBR
	 sIA/Sxe0F1CKA==
From: Thomas Gleixner <tglx@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: baolu.lu@linux.intel.com, x86@kernel.org, iommu@lists.linux.dev, Arnd
 Bergmann <arnd@arndb.de>, Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, Vlastimil
 Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse
 <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, Andrey
 Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer
 <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Richard Henderson
 <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Catalin
 Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, Jonas
 Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul Walmsley
 <pjw@kernel.org>, linux-riscv@lists.infradead.org, Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 09/38] iommu/vt-d: Use sched_clock() instead of
 get_cycles()
In-Reply-To: <9db9515b-08e8-47bd-aced-206ac183195a@linux.intel.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.187521447@kernel.org>
 <9db9515b-08e8-47bd-aced-206ac183195a@linux.intel.com>
Date: Fri, 10 Apr 2026 17:14:00 +0200
Message-ID: <87y0iuzw3r.ffs@tglx>
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
Content-Type: text/plain

On Fri, Apr 10 2026 at 21:45, Baolu Lu wrote:
> On 4/10/2026 8:19 PM, Thomas Gleixner wrote:
>> Calculating the timeout from get_cycles() is a historical leftover without
>> any functional requirement.
>> 
>> Use ktime_get() instead.
>
> The subject line says "Use sched_clock() ...", but the implementation
> actually uses ktime_get(). Is it a typo or anything I misunderstood?

Indeed. Leftover from an earlier version.

Thanks,

        tglx

