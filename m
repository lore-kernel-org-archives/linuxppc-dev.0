Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FDA606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QqSaK/eK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8fHx62zrz2xM9;
	Wed, 21 Oct 2026 17:19:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::f8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792563549;
	cv=none; b=bPzJ5w+k2D+cwIR75fKnD1ddH+lp2VAwqewc5uI0DBLtLHtZBFwEQbQKuHHWMMlGaPHxDodIQ45qcvdGM5Az7615rF6IWZNfmEFUC/PPoht+NPiGmwzBWmpGF64kQoqpe+E77dAxrJB2bWMiW+oHW3KVR1pS/3cxnCJJr2d2DyAG1xRhzdb40ALi3QOgaAk6I4wUCtlFPm/vgddIKFBHCt+WfUKqpdLW1jHzq0MNhMv4d0yxPwoH/JvfvKD+P6mY+o6/1GiRHff56q4BBibSDsy7/N74P5Nr0h7VE5JsKFUfCweR6CPmMMgOE+GEvF+iviv2AkIeHLF9J2mbEqdN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792563549; c=relaxed/relaxed;
	bh=pj0w5I+TLXbeTsxEvtV/dSAOrVQeyg/NjtI1DIx1aAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UziBTYO6oTLL/kjLwAfrfUMHei49+iM6Ofs6a3Nz7nIuD7nke8VJ3GyHeSeeCVLzNT2UD6+QFBGgrbJmLAfBdtRAKgYTdQjm2lQDtlBHkpkQezf26IIfzTjMfLkSPODc2bHnmS8Ty91AxIdTq7Uuk/Z+Akb9Dl6Z7UClOLIbkzHz+g3Z89AFghdUKZtNjT7RC1ENroFwIRN1+kj3O1Px79MDkeYXp9t3cmzPllCvGGYdFinYoYT3s6FXy27Xnb9k4wWLIHzB6atKOgO1c0f+znku5oNuUub1t5KS4S9SjCLw6okUmB6+PQHR+54VN0fa8xsVU6rVqwfy/aixU7pt6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QqSaK/eK; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::f8; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QqSaK/eK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::f8; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-248.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8fHq570sz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 17:19:01 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=pj0w5I+TLXbeTsxEvtV/dSAOrVQeyg/NjtI1DIx1aAo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792563522; v=1; x=1793168322;
 b=QqSaK/eKxDPUM3bH4vyLayiguqJ6warLZ28ldQpe0q72pf7Uvj9vGsJW5Ve2sY281s6w6HS9
 Ep6qXpkemssHk94iGyYGv2fnotQlsFTSycw+VaMxHHDljpESjSUuMBPzLGiPbT1UnsPIjqbHS7E
 B1JrO5VnYezitc/LRuLdq5Sc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 2bd75f41de4092a6;
	Wed, 21 Oct 2026 06:18:42 +0000
X-Mizu-Trace-ID: 2bd75f41de4092a6
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de,
	maddy@linux.ibm.com,
	corbet@lwn.net,
	muchun.song@linux.dev,
	lance.yang@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	qi.zheng@linux.dev,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/hugetlb_vmemmap: remove hugetlb_vmemmap_optimize_bootmem_folios()
Date: Wed, 21 Oct 2026 14:18:34 +0800
Message-ID: <20261021061834.6834-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261019090830.1917657-5-songmuchun@bytedance.com>
References: <20261019090830.1917657-5-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, Oct 19, 2026 at 05:08:30PM +0800, Muchun Song wrote:
>With vmemmap_wrprotect_hvo() removed, the bootmem wrapper no longer
>performs any bootmem-specific work.
>
>Call hugetlb_vmemmap_optimize_folios() directly for bootmem folios and
>remove the redundant wrapper.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

No boot-specific work left, LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

