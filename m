Return-Path: <linuxppc-dev+bounces-28541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C3FC9830E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 04:24:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvhlh6k1rz2yTP;
	Wed, 30 Sep 2026 14:24:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790742288;
	cv=none; b=DeLD7Gv0i+pW9Uf4i0vCQos5cnp7ttuRo1KEbYECDMprlXPIB6lwg+ZYWJEN1dP8ctkgu8t4TIfU5MGwZ9POPqHKKtZLthvQbBZkHRfKXoNy7fYoKJGCh0WrZrl65+JPX6Bux1El2fw1SQO2qCXTuCSxWHE2tQDpBWTToCHA5dlr0Qm8nNxtDfrIj2FYHBty1gqGLXaHjBv7I/5HZbl+W5dOObRz5yhxPmcbKe1brcbp+3mjC9d8xQGzbPUZJUxTTEr1fm7DLC998SAWcGXHqM8OljgUo4/LYCR2ScWZem8Nvh/kweJR1+Hrlh7QT2+2a6tglCp6JMMpHr18cOAH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790742288; c=relaxed/relaxed;
	bh=G1OKfOOyF6BwRdf3CIc0O5VCRioxKKHcn1/LjJVvnXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcwKiD8wxWu1tEy4Bpl3uVk0AviKqLo8cMkISi88hWqmPRq8T+6oGmRRIqZCBABFvr+UZ4tw1G8N1i9VEvf72aV4ObWHnC+0aFiyirCNXuO3qnkCAXrByDNmJjru5RngjY4b6Fm7ACf/qWyMVOy3InNTosndRSGXVy/QNvqZgRqU4hDi72VehUBTcCyHXcbHL45TIeyzUfJqBtQN4ygtyobXpyaHptTsIOLDjjR+MxvVSUGB+K/n63n4ahesqq79k98yTbVb0kFAdgNdnHFvL7P8LK00RfL+UzGaDbANmg9XziXGSETvOoNao8N4PAZ+HiM3wqvjNSYq2LRB9C5k0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TgUVzpOq; dkim-atps=neutral; spf=pass (client-ip=95.215.58.177; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TgUVzpOq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.177; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvhld5Vx8z2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 14:24:43 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=G1OKfOOyF6BwRdf3CIc0O5VCRioxKKHcn1/LjJVvnXI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790742264; v=1; x=1791347064;
 b=TgUVzpOqjnPJe9H5dexIn0XHK87NboL/nfI1SdxOEH45hzuGWQlNx+zLhs5bNmYtGvz2tdR6
 syfl+MjRqXj0Wrq0Wj2eGjU2o754/Stbh5K2acwjZd2iOuFO8P9OWvu5C1VWF6G+TcGU0QEAxKt
 sMflHXCkxccGYa2R3123wk0Q=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id e9b7e58d84d31462;
	Wed, 30 Sep 2026 04:24:24 +0000
X-Mizu-Trace-ID: e9b7e58d84d31462
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
Subject: Re: [PATCH v3 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
Date: Wed, 30 Sep 2026 12:24:14 +0800
Message-ID: <20260930042414.97599-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260929053231.66085-2-songmuchun@bytedance.com>
References: <20260929053231.66085-2-songmuchun@bytedance.com>
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


On Tue, Sep 29, 2026 at 01:32:26PM +0800, Muchun Song wrote:
>VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population in
>two places: it keeps allocations on the normal path and takes a reference
>when a backing page is supplied for reuse.
>
>After Device DAX switched to the common per-zone shared tail page, both
>conditions can be determined locally. DAX supplies ptpfn for every shared
>tail mapping and requests an allocation only for compound head mappings,
>whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() alone
>selects the correct allocation path.
>
>When ptpfn is supplied, the caller is reusing an existing backing page.
>Once the slab allocator is available, take a reference for each reused
>mapping to balance the release performed by vmemmap_free(). Although the
>buddy allocator is available before slab, no vmemmap population occurs in
>that interval. Earlier mappings are backed by memblock/reserved memory and
>do not need page reference accounting.
>
>Remove VMEMMAP_POPULATE_DAX and the flags argument from the vmemmap
>population helpers.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

LGTM! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

