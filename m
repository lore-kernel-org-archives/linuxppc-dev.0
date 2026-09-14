Return-Path: <linuxppc-dev+bounces-27212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047E8C88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:48:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjy283wmlz30V1;
	Mon, 14 Sep 2026 17:48:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789372112;
	cv=none; b=gS/NkZ/ZJJCHMBL1DFTnZGFUsz/iAuklCJuDJk/Oa5xaca0UYpHwyxao4mO57D6oLRIph4WYqIdlYlxyO9yl31FsKUTUQ19SFeFlVNjv/XL1MxzQir4HOQXRgFo0AqgFtOdtG0bU/wVrSS5nomJ0lNcD+JBHmOePCqAoFU1bMjvQAUeSKyk7OyfGqGKwQ0+JSpvePVBzOLHMnE4qUZ1+55UEiXTUisQGltalEsjM+d9+mUe8mHc/8lWR9lSmsjkQ7HXkO5ghO+hawlCcTDLvV3PUdI3FH1X8UpOKZA4WzR4Bd0njm1YZb4NkuJwMm7AWMsjeZDRl/MSeo1leY1s+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789372112; c=relaxed/relaxed;
	bh=RESuNQUKZgqmJNMbknpLT8POXLSUN+8DRhun9jrOVhk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=euMUX1BAXvwUAbLzZu5deLoXvT7qkAwgxwR9LwDaaQ4k0X5LRMWhZU9grZnLyB+HMBDmK1A9RHVO875/YaI9r5fltRYTC+tvLPgM7Tso6aboCLOiRfLOVe+IeN7jzVht2zrC7qTF/6E/oFhLU7aSo458rD6ekUCcITNix/V5840w+F7fbtJm9dKujMmH//l92+WR1i120moHzw6p4ExbJO0yo1oMNAOOckFptNGhtV3g6C02NY2pUZmCkmj2W8Vljjzj5zN70E8BMZ+j+sWTBD31WKBhrrlmHpMiWF721t6OW4N3QWQy4meOekMzz+hxMKWRnCQL9U+IEH7SIDd/WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPB4CoCS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPB4CoCS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjy2813Lsz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:48:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A3BE4403E6;
	Mon, 14 Sep 2026 07:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDDD1F00893;
	Mon, 14 Sep 2026 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372110;
	bh=RESuNQUKZgqmJNMbknpLT8POXLSUN+8DRhun9jrOVhk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OPB4CoCSQXQMwjc4/kQbLp9oJw/ADZnF4xQX7WylqQDRXdOGfX6dzStIDgj3Sozsx
	 rwh3/JTdFukyIkZ/GTiHky3kVpGnxI3RsscJy9NPdEh5DqHzBn6BdodBmDWeVmfgv8
	 rnU8kAg1ifc7mk/ljWmNOoBt3mEn2qCV97Ww4fCOOqWWytl2DM4x02daXvgHof7TPZ
	 ZNU5WpkiVc8BliAonk+xAyWj9otZ3Hd8aP/wxVOEEqc9SOWf/1xC7Oy7TxyOb2do8Q
	 6XPx+f55fVSXQoS8wDI6jEbXM2ia1SwN41WnZ5oc2eA6/469ulUmlsPAsIgzmxOqFb
	 0oV+hP5RxrSQw==
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
Subject: Re: [PATCH v3 03/11] mm/sparse-vmemmap: open-code
 init_compound_tail()
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260911050228.58884-4-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
 <20260911050228.58884-4-songmuchun@bytedance.com>
Date: Mon, 14 Sep 2026 10:48:14 +0300
Message-Id: <178937209456.4188640.17384001721839433827.b4-review@b4>
X-Mailer: b4 0.17-dev

On Fri, 11 Sep 2026 13:02:20 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> init_compound_tail() is only used by vmemmap_shared_tail_page(), where
> the shared tail page setup intentionally passes NULL as the compound head.
> 
> Keeping this helper in mm/internal.h exposes that special case to the rest
> of the MM code and can make the NULL head argument look generally valid.
> Open-code the initialization at the only call site so the special-case use
> stays local to sparse vmemmap optimization.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


