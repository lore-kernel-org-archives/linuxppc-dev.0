Return-Path: <linuxppc-dev+bounces-28667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F81CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 16:09:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwcLN4sk6z2yMn;
	Fri, 02 Oct 2026 02:09:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::dd"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790870972;
	cv=none; b=QJf5qRRIOGyElQjqRXdeYUMZtvbBdkozR44M43Ph7emsfR2SuhMeki8l0mCM1XP01wYAW+gm07QHGeFd8bY2frs/x6wPXrOm7xnkZjkslTkO/RsrzoqIdvpiFCTAG5O/FndhZOhOu3EJK23DSUlt7yRsAHv98iUi+fiNhVxCt6EEOVKvNDKk0iJ4c+Ki+816OOVYSsdXYLAt2m2k9RyHwp8jJFclHeZNq+0naybnTAqWYQTjIqi+BaYgFuWIWx89gP4zhJwafGq3PKpFO9S5wEPT8jD7N+i9Y3HLEglh8ihSEix/4lSGaSphvtx97/j1P6DHISG4jVqr7nBkiL+7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790870972; c=relaxed/relaxed;
	bh=m2WhXekatGyTe7NNA2QDA9cNUaDy0yKLA81NRXFUVU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni0GCiENdVXf7mPhyjCruruE/JcZG784l35kc8XAJEgFVXs3FmISWNEFQRHqmWD/WJXyCaAN9yPZPW4pGDjJYO+tmjVlsyjcDkBEtUUrGPLiao6m7N5HMSc0wSYxXLuwqeouWrxEZWmxEHl8jK+QvxT4zL5m4/YD1BPpnipvYOurZBgL35nwmfBohrw+zwxlZf2YF5UPCG7ZR9WXpK3qa9diVWGhHcCUWOAOTtbdC9Tl2TvYWuvj2LWKAVz87WXoZQKGgdgYuTcoj5iVbsptmzejSDUm7GR3fCdxFIUanTmRMuIpnPP82Gr7NLkQo6wNGfE8q+iQYLyxpHG46pWTdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QVBbfxux; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::dd; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QVBbfxux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::dd; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-221.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwcLM3tf9z2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:09:31 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=m2WhXekatGyTe7NNA2QDA9cNUaDy0yKLA81NRXFUVU4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790870953; v=1; x=1791475753;
 b=QVBbfxuxgsYOrmjIcMSb0o43Duk2Mj2lXbjKD2+nC0HWiqdCb2VIC5EzrkeCyoxIMnRwV086
 8TxEEnCIaDp80rwWDHlKGgjqVJ/04q3CTGGEx1Jy31O2Af2/myWegCaeMiqGyadEcOdGFWLKCIe
 1qqH5X0KwsFlAMkNZPZaQIzc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 991aeb1c7099deb0;
	Thu, 01 Oct 2026 16:09:13 +0000
X-Mizu-Trace-ID: 991aeb1c7099deb0
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
Subject: Re: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page init
Date: Fri,  2 Oct 2026 00:09:07 +0800
Message-ID: <20261001160907.25429-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260929053231.66085-7-songmuchun@bytedance.com>
References: <20260929053231.66085-7-songmuchun@bytedance.com>
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


On Tue, Sep 29, 2026 at 01:32:31PM +0800, Muchun Song wrote:
>For vmemmap-optimized sections, tail struct pages may be backed by
>shared vmemmap pages. Those shared pages must carry the same page zone
>ID as the struct pages initialized for the section.
>
>Warn in __init_single_page() if the shared tail page has a different
>page_zone_id(), which would indicate inconsistent initialization.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

Useful sanity check :) Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

