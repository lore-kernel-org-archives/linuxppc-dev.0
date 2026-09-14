Return-Path: <linuxppc-dev+bounces-27211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EEDC88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:48:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjy246Qv3z30Pp;
	Mon, 14 Sep 2026 17:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789372108;
	cv=none; b=EQslfMj7RsEJ9/z0Ukav0Hom+ShEoE/Y2EEThP+42MhSZ0C2NsvM3xKjgUUA1D5RiGfaN6otDD6EodvYPvflCAsH//R+8ZkL3R0PKfg1lrQbMbl7Y8/QZ4m533HKdjs45bQHKiNuG9Uk/80HcalMMF3t6ZWmfXC5qHP9AUxRBMR7eSQrEFAsryb+SfQPk9d3O+LBa0b0y+Za5sZezvC84cri4xlG+khb8wMieZOXvrDoqfTvxGewj0v0pW8eBPTdzKG2Re1Rb6ryBmEUr/M1hjnUztX8NHB66Kp+AE6+jZjkWM3jCrxZeVp1dMqI5AQmgIiNgGd0spl4Ej0T4223zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789372108; c=relaxed/relaxed;
	bh=KClFb1VkJGLkCtI9WH4c0jXlSTsGRG9fGPGrsgOGFto=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=IjFI+M6Ih5djJ0kauyI00sFimrGEzdb6BUOWozV3rJyLqpbxJzfqzZSJ+UbCrRdRiRg/Ue0InngFBVUCmLYEiE75i2qctyGFNa7ubUmL6PYzbl14SiFZEZkW+ZZQvWt3tiI6+5XDbZyKH+7YM5+WpCIdz2EYm5sdu8sTt1j/Ojazjq+SHoRhXOFKbxfoZks+sJjTzMpdaooirhhvOaJEI+xUHHA+CYxP5pRwxS43Y3fjQpa59wiWn/peY9JnqJQktU8ChX/ROIIWt8+9C6CVXde4vE5lZ4tKcVop2O+q3hF68Le3t3DKx4jTeXF3VcKiC8gGKBiWV0vUruAq4+ughA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLdtUM3z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLdtUM3z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjy241qD1z2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:48:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 51B1B435E3;
	Mon, 14 Sep 2026 07:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9971F000FF;
	Mon, 14 Sep 2026 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372106;
	bh=KClFb1VkJGLkCtI9WH4c0jXlSTsGRG9fGPGrsgOGFto=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=nLdtUM3zSn5yjHCXAQDEJt8zxWnibA6ikmvc29vVbrh8Ln3dybfNcrz11rsuUPiEH
	 5KCUQOuV4EQE90HKBkr0a/v+1VvUJVsxbcvjzjVApP+WrhsacfI9YY0VRuBkLu+Kkd
	 YgXkpu7rtKeyGbBpMQNP3XsuLaw0F4vuiQDXNJ3EwNQGpZveLv6/xNAJ/IOU19I/sb
	 2qFdKNiExZ6B71Cb1V/gYrS7EqO5zgaBEJVicA5k/tU5oGlQwEcpu0XBDijLiv9kai
	 mSqrIdhSOo41skGmUtaFAPfB32scbc46USqILXRyS8XI2lgF+Rpg/5cvUro+uG/+rf
	 0ps/oyP1ttzlw==
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
Subject: Re: [PATCH v3 02/11] mm/sparse-vmemmap: factor out shared vmemmap
 tail page allocation
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
In-Reply-To: <20260911050228.58884-3-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
 <20260911050228.58884-3-songmuchun@bytedance.com>
Date: Mon, 14 Sep 2026 10:48:14 +0300
Message-Id: <178937209456.4188640.108482640666201896.b4-review@b4>
X-Mailer: b4 0.17-dev

On Fri, 11 Sep 2026 13:02:19 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> HugeTLB and sparse-vmemmap each have their own helper to allocate the
> shared vmemmap tail page used by vmemmap optimization.
> 
> Factor that logic into a common vmemmap_shared_tail_page() helper. It
> allocates the page through vmemmap_alloc_block(), and uses cmpxchg()
> to install the per-zone shared page.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


