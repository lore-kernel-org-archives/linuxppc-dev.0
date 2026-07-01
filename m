Return-Path: <linuxppc-dev+bounces-23271-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5A7C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 06:23:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqqh76SMpz2yQG;
	Wed, 01 Jul 2026 16:23:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782886983;
	cv=none; b=UtA67n3XOF6kvsWtR25wlJM4ipejmnL+x17uh+GPqM3gRQf1PLiWsz5PUviJbyuePHytGcalXaQ3lNjdKzdUfJznYqlZzB/hDhhyEKj0Q9zN/0VPP4oyx7f0LwxgjholiARHp1CpBmqpfjaGIECSzEOX50nzbSbrDj7zlcv2xvjZODw/Z8uJQY/KrzsPbsDkITTIWZebjQR73wnuGLu/+C1N7+C9fPNabVgQrVmWqJxt7gP14WndjWIQ+NFMKctXq/cevRmYrFszMn7F3OwZ4/owy3WsXXYrfx8AY0QpK/O3Vri7xc6Gnp/069t/fwYAYEryuwEuCw711WNMC7TP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782886983; c=relaxed/relaxed;
	bh=+CV7vM2cx+5CJ4FbmSzaWHO/QerFhIw/VFpB9UKLnag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PKhEPd7Teg/feVqvsOw9hrbb/nmvSV+0+K3VqFjH86q1jw/RhCTVcK7hgU7O6SC9WBNKqsP2IUes+kZRb5ET6X/g/GeZ1paRiaHu7RgyeasU+kH425cTxvIo0b7Vw4IH944upgfjaoY039Fa+1GxW0f8YQUmRExSxG+iKP1l8MbMgsp2iJ7OtXw49NB6aMWBRGuzd0ghXqg36RKyJmd4OhQ04dZTgRNr6pMS6Gq8YZQ6tKz9vc94JpVwUXKlfTFleLH7l5u4P4S9DcAe/Iw88FETiRlmHa2f1DoaJdPBhL/KGoV3NIlAyBShJsG3S18c6yqfZUduZWbrwL+VRTnvyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mebOUl/b; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mebOUl/b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqqh66fKzz2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 16:23:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC4CB6001D;
	Wed,  1 Jul 2026 06:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCAF1F000E9;
	Wed,  1 Jul 2026 06:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782886979;
	bh=+CV7vM2cx+5CJ4FbmSzaWHO/QerFhIw/VFpB9UKLnag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mebOUl/bwwqf4S7w7kuJFeK55aOXArL3TFyTg+YwHZM0Aqo11A2cwS2qc5uyoKBt3
	 dO1KZT7hVdrx3UQSma8+4XOmo21d0bOAN1LIlAgM9Y8eOKJY0Am34vRTyrvlFkADQo
	 x2jOHdyCdZ4ScD80uScfDrZqs4dIm7ltOQlidHQ4sEnEeMHf6nhJANmcdrRyxybp9x
	 JiBCaAsNQyVRCHvCxSm8C+u/RhJQ7nrDRUq8ub8VwDsYeOka1bmYijdNL1YvAxDwRy
	 dbxGH1+8CZ5cX5Q+oodtuhxPWpU3U8Kh2r3L9QxGBPoQqcrIq4NLslPud4kI2Fins+
	 hgjq0enJu8OWw==
From: Mike Rapoport <rppt@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Will Deacon <will@kernel.org>, Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Andrey Konovalov <andreyknvl@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
 kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20260630150413.1718632-1-ekffu200098@gmail.com>
References: <20260630150413.1718632-1-ekffu200098@gmail.com>
Subject: Re: [PATCH v3 0/8] treewide: remove unnecessary invalid range
 checks in memblock iteration loops
Message-Id: <178288696837.1179975.5183177963398478769.b4-ty@b4>
Date: Wed, 01 Jul 2026 09:22:48 +0300
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 01 Jul 2026 00:04:05 +0900, Sang-Heon Jeon wrote:
> treewide: remove unnecessary invalid range checks in memblock iteration loops
> 
> The memblock API guarantees that for_each_mem_range() and
> for_each_mem_pfn_range() never return an invalid range, meaning start is
> always less than end.
> 
> Several memblock callers still have unnecessary invalid range checks in
> their loop bodies, so remove them.
> 
> [...]

Applied to range-checks branch of memblock.git tree, thanks!

[1/8] arm64: mm: remove unreachable invalid range check in kasan_init_shadow()
      commit: f6e6c57f2e100813be6d5882060fef81cb6f32de
[2/8] LoongArch: remove unreachable invalid range check in kasan_init()
      commit: 68d3b7d58237b8794d9343210d4c90b8381cfa96
[3/8] riscv: remove unreachable invalid range check in create_linear_mapping_page_table()
      commit: 99e60ebe108817fd48791f2cb81f1e672ad8285b
[4/8] riscv: remove unreachable invalid range check in kasan_init()
      commit: 8008f6995d0c0cf22e7b4d60e95fe14085c10f35
[5/8] ARM: remove unreachable invalid range check in kasan_init()
      commit: 3db1a9ccf9290ea3fe01aadf3bd743ef7032b24a
[6/8] powerpc64/kasan: Remove unreachable invalid range check in kasan_init_phys_region()
      commit: 21e95a4b6f34770571eeeaa6adb535efba1b7281
[7/8] mm: remove unnecessary empty range check in early_calculate_totalpages()
      commit: c6af91e48594191f62ad3c1fcc8269b1eb539ef8
[8/8] mm/hugetlb: remove unnecessary empty range check in hugetlb_bootmem_set_nodes()
      commit: 2db44dc8bdd3cfc933a3193724f4d38b03e35b80

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: range-checks

--
Sincerely yours,
Mike.



