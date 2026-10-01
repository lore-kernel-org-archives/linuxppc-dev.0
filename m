Return-Path: <linuxppc-dev+bounces-28654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FD2CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 14:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwZ550fyjz2yTQ;
	Fri, 02 Oct 2026 00:27:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::77"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790864873;
	cv=none; b=lEL/syVPX+HorhbV36ThPi/JYMfgkp7yv30OtuoqRQ9xHTQLA/pQHm469C/BwtYW8LEx9L+hgXbSQPWmrg+avongnGw7Bof5zLSfaPiRG74j+co1Q9MhdF2olnXXgp+T69z8j3luUdn2le47pLJ5Zp/0KHda9sAsbpLNMIoAXCdjPLUmSKTEHoxgaqX3pGrHQS9m3PpkuSKfbQYnq8X9FqtruKEJwHkm1ywfBF0tJOsYODlGWMFx0P3XPgAlvPQhw1HmhhARfISj6Xb87eirStlG7VLC4GzU5jeNqilLBU8tFDjtgCpwZyni5kKEndIiiezzS0TgZjuiD6T37zXECg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790864873; c=relaxed/relaxed;
	bh=LJMXlOX6G72KgzwR6NBXyCt54iCm9KoR+tZW/E7WXfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYxjmHeOYy/UTzG3Rlv2INL/LS1nq25ZUYp0lVvw/xShE3hkbG7UFQ4LQxx5l7ExWjmVyisQk7ZybU7PakVskJZRqXaDPCsOFyH/DzK60PFdD2NYgMPpu2j4Dya/cUs7LZdy6CAcenctWOm9j6HIxh/oVb3un9yO3FeRNaV4IapUocJ7Fg5r3BUmSLtc8MWqhUI7hUhL1X6Vcnd2BGS0juGuKqkkpJaeaM5AwfOR8pg78ghqm2tmdzEf0Y7HDwwMHty1ERnFJajKiUqfkl2nomYNu8g4Jwmckox+26cYAEB3vJBS/kouhrR2NN8U49Ru7xIijL6C76HjCv4eoS60dA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LVTy4xtf; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::77; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LVTy4xtf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::77; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-119.mta0.migadu.com [IPv6:2001:41d0:1004:224b::77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwZ4z3zYPz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 00:27:44 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=LJMXlOX6G72KgzwR6NBXyCt54iCm9KoR+tZW/E7WXfU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790864841; v=1; x=1791469641;
 b=LVTy4xtfopRyUlAYWDLVtKCMj+4EgWXO1nQ0fG46RqRJUjp7fIqMLXmqhthN8jMJf1/v7612
 u9rC6eAzFrlpDUf1pKXbolfDhx9//AQxU/kwLWzht8cVvDU7g1MdZm+gCxheL1w846vXQGwKpW2
 4KX1fUZwDb+3jUNdDVZ1rTH4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 37d698b651d6e08d;
	Thu, 01 Oct 2026 14:27:21 +0000
X-Mizu-Trace-ID: 37d698b651d6e08d
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	qi.zheng@linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 3/6] mm/sparse-vmemmap: drop Device DAX-specific population path
Date: Thu,  1 Oct 2026 22:27:14 +0800
Message-ID: <20261001142714.17172-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260929053231.66085-4-songmuchun@bytedance.com>
References: <20260929053231.66085-4-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 29, 2026 at 01:32:28PM +0800, Muchun Song wrote:
>The common vmemmap path selects the shared page for optimized mappings
>itself, so Device DAX no longer needs vmemmap_populate_compound_pages()
>to find a shared tail page and pass its backing PFN through the generic
>population helpers.
>
>Remove the Device DAX-specific population path and let section memmap
>population always use vmemmap_populate(). The powerpc retains an
>architecture-specific compound-page implementation, so select it directly
>from radix__vmemmap_populate() for optimizable sections.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

LGTM! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

