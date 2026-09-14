Return-Path: <linuxppc-dev+bounces-27213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E4C88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:48:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjy2F5H8dz2y7p;
	Mon, 14 Sep 2026 17:48:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789372117;
	cv=none; b=oN2lafkX6dGEIr+WAO0M/1QJgdzOdZ7BDRnUq8x4+Ve9U7CzU+52+7SqxWLZo7GnvwU4TzHAd+YTpiGM6jP/dYV2KiwMjYtoRkN3jofa/OlIL0jyo9JOnuBHBSt6zD4eUGCwtOKn0ghIzvLf+8fbBngznTrqpZb1wazR/v0D0TlRY8ChcAwOQWzPMnJDzuQm4NsvWva540LaChN9QkAqhwZfPg7kwsMBKdWSdbEchFoj2iXYgXZ8SZPgAq0dSzEj8ZKffJ3Qcta3DOPOpEVftJTvm3SzqIxKo56bTi9UgAdJk0D9gIWNJBFuC4HTR1jxWedjjlA16C7NtNtuhwMTig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789372117; c=relaxed/relaxed;
	bh=mxlnDynYYTzpX8hgcfRULDUhaAGoaZuLLRZriqsKtRU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YrSTjq6Yb100BvgeNJYJPyVIynZWNz4x2Eqgp7fgHGG6jXkjFRa2bP+DH2A0cl7bh9wbbGMk86SeOIP9M2VDvEQkCSs/6pIpF6KgxtIGyXIMBExWFBmaM6iLfM9Ua+TxmvlcX76waPDbpMI5ZWOAYKKalaIj3Hx+0w5TDYVRyHqUBhXVoJfu7t6e6kMPPVkS0gsaG2iY8pisB4tfTo7Hr+usUel2OCSxOQNWZCL2iBslc/6NaKPezfykXP32dRBPC+pxvSSIjjS2dO2YrpNdT24iPrI7Eh6tA+ffm3sUGsCRUuK0s6kutYoPPQquHjItn06qEeNdqM5qZOLnEIR6Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfXpuBAZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfXpuBAZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjy2F0f1Qz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:48:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D554601F9;
	Mon, 14 Sep 2026 07:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0B1F00898;
	Mon, 14 Sep 2026 07:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372114;
	bh=mxlnDynYYTzpX8hgcfRULDUhaAGoaZuLLRZriqsKtRU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QfXpuBAZsOXfWUwnFNXpOGxWqTSDLO01wvC3N/7vd1dC5Gkv5rxpsOtkrm1v1qk5s
	 YHqpigsAv1/f1RUg9nkHwCoPA998l9XsxL/MKCNTb39E0XXM/uqpp94Ow0df3DIB1W
	 z289LU+/hLhnvCvJF6VcF4PnQCkhx47CxeNF8r5v+dddAXlSgk7p51PmTm5esbd/iM
	 /v8B066Wo4MFfdbYYdhyVAkVqcWRm0TP0bmoLME1E/FGklu/ZO3znAv1zeUOInFU7c
	 B+oPdfCDuqtuviwkhFX2E3MyhcvWqYa8MgoD1gGHOeSkW2iBnqeYU6E81/KVuv7Vor
	 3iWrdauituXWQ==
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
Subject: Re: [PATCH v3 07/11] mm/sparse-vmemmap: move vmemmap optimization
 helpers to a public header
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
In-Reply-To: <20260911050228.58884-8-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
 <20260911050228.58884-8-songmuchun@bytedance.com>
Date: Mon, 14 Sep 2026 10:48:14 +0300
Message-Id: <178937209457.4188640.17073524319809876525.b4-review@b4>
X-Mailer: b4 0.17-dev

On Fri, 11 Sep 2026 13:02:24 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> The vmemmap optimization helpers currently live in mm/sparse.h,
> which is an internal MM header. That works for MM code, but
> prevents powerpc from using the same interfaces without including a
> private header.
> 
> Move the declarations and inline helpers to
> include/linux/vmemmap-optimization.h. This is a preparatory change for
> powerpc, which has its own vmemmap optimization implementation and needs
> to use the common vmemmap optimization interfaces from architecture code.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


