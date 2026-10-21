Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC879606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p02NDSmT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8f3f20G6z2xM9;
	Wed, 21 Oct 2026 17:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::f8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792562910;
	cv=none; b=NltqLZrf0GpuaYOni2bfBLsHqwRsw3sT+YiwKmziYNECHOuo6Rr6/EtvdBlFhiEmFhu30lj3fVKBc8sx+npFzxcIMvb4lbPoBIYrdMn8+Yuwj9bAYl07xUb42Fs2/XwLXreHOAke4lKy3xkgVy8xa1FBu7qU6wPquOdIHs1mZMwQfKrjRpqPwTN3LXeLGVBkoFtmJK1Q1i/xwtYx7COuyF493pQE9b/PXuHCu7qe83/i6jUBUzwqz5Kjmgl4vsn6ratUl9ozyFGLDIx7jN/aBM+iT1+8cNsbKyGlpMK94KIgvw98q2HQbYRtPqXD3VaR6keC7T80N8f9AUCLw+9HNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792562910; c=relaxed/relaxed;
	bh=ZYe3wOkYMWAT9nEkJmHND9GUlXX8tkyrEnTbfn+hGAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQkel2IkEwVfY7Vr1u1fZvEHzMPuMvn3q+pPzpGrEg1mwYwO3MLmNxA+ank+FPvHudiqdJxaSBpRmG2yOQYMpkTE88AStMul+2L67ZANIT7t/qairqxAasaUHSPQz+jfrbejPiPq8ofdDdinEDaOK/+t5ZwzOC+s9VRDUc6tyjXYRzqLh9qCJWr7MXOMa0stY6aDq0u0k35px8UKI+o+4rtdwlmW/+rbcrJDTJRexjt27ojP90lZKIa6ZBwuxhzKDbT8uvuUbFCw6yWs+sLPbdWI9pyLSFqr4T4oeIZk+nys2drsH5pc4VxaBPVTD+Zo/a70d3LK4/K8Yn280vuxWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p02NDSmT; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::f8; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p02NDSmT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::f8; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-248.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8f3b22Bdz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 17:08:24 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=4KIURn7WEb1ayotO22ZrkJ9wcqdsX7N260OoXXlEYTw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792562884; v=1; x=1793167684;
 b=p02NDSmTaSCB8KSHun2b3TBjbf1NxzTB/b6rDos/XyDiLhiG+2lxVTaZ4aTR24rWJ9/gY/mw
 cOxsxKQ8l4CCJ668HxHAkwzAjhfXpzA02MknKMDcP6EqNdBo6cYSi0IeK3sur8sTHobIbATp94K
 8nj/4oIDDrwoxMYcccNwBXQE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id da1eddc643cb8bda;
	Wed, 21 Oct 2026 06:08:03 +0000
X-Mizu-Trace-ID: da1eddc643cb8bda
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
Subject: Re: [PATCH 3/4] mm/hugetlb_vmemmap: remove vmemmap_wrprotect_hvo()
Date: Wed, 21 Oct 2026 14:07:56 +0800
Message-ID: <20261021060756.4599-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261019090830.1917657-4-songmuchun@bytedance.com>
References: <20261019090830.1917657-4-songmuchun@bytedance.com>
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


On Mon, Oct 19, 2026 at 05:08:29PM +0800, Muchun Song wrote:
>Shared vmemmap tail pages are now mapped read-only during initial
>population, so already optimized HugeTLB bootmem folios no longer need a
>separate write-protection pass.
>
>Remove vmemmap_wrprotect_hvo() and skip these folios during boot-time
>optimization.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

Yep, already read-only, so there's no need to write-protect them again.

LGTM, so 

Reviewed-by: Lance Yang <lance.yang@linux.dev>

