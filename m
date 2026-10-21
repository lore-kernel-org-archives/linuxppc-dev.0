Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B83606A319
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C+vG9SFB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8dRt43Wcz2xLv;
	Wed, 21 Oct 2026 16:40:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::26"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792561258;
	cv=none; b=FCaXNhdsPe0/kuFmHMloY4E1aE4jGDorkgmT5ihu088KzA6/Vd1j2I2og4qIyPwDYHWPhNrc77aM4P/1EAbzK2t7efNhsmeRJHHacHKjFubrF5KQubd89sj/gKrMseFhAjzD+MH+feBgjRqx4t++PK/X06Qd8q2YFIvAE44ViZxoCR4ZQS+9q6egtW1GEQMNJx9bgkhu1oQGeRRhGR4r4FBYtZ2tYwbeu0ksqPTSi85N1UMUKlRzShGY1eb6IWDUJPLjYjrEMOEej/J8akY2Mn2zv9xZKjrs7U+J4s1ojFweuQe9CAqKSNCmkZnpAoAY51fJtmi64Dh/2wWKlBSNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792561258; c=relaxed/relaxed;
	bh=MXiUGp1caAHyyuVtstCR/2L4nYD+n3m1gvu2wPtLXMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ+TkxQnnLssDBsulLKzQaVAGOWnDjnEZ6Kuf8t+mCePM7qT5BQACSQkZs0YGGlceDLvL8WVtfk4wIeSbSnaQxI72zPprBMJzvDX637cTWeUh125PWBjj3mjn+Dk+XsGQg5dukJmQFqbcjG8e7XMDCRnqbzn3zDC44iKr9l4cKEmv6HAJe+Hf74+UIChKDA9GPBu8fOo6lKe8cNrwf1vhtLi0DiBQ6+zAx272Rtejw1azQ6TkoAdXQDWudVeJj/ulp8VKz1QruDHpb4B8iw8as2h/ps8uSq7C75JFgiJzl8ClhivLPtDue62mgE0fk32LXXCMowNObEX4nyEvQWx2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C+vG9SFB; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::26; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C+vG9SFB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::26; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8dRs2Y8Yz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 16:40:56 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=MXiUGp1caAHyyuVtstCR/2L4nYD+n3m1gvu2wPtLXMI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792561237; v=1; x=1793166037;
 b=C+vG9SFBdBQyzmPAziKyxgOkVqVFMKpFAz91RKnVqhXiTWdcCNqsz48DU9VR4qp/m0yzSUQV
 Ukar89XaW1+7SLsXgAbtzL1jRmim1TE67erPvFkI9qwWgjmSW5einQc4C9m+YgKG5Gw8xPPaM06
 EGYG7YWYbrPWjGGM4uejPjW4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d2fc8a9e32f8bec1;
	Wed, 21 Oct 2026 05:40:35 +0000
X-Mizu-Trace-ID: d2fc8a9e32f8bec1
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
Subject: Re: [PATCH 2/4] powerpc/mm: map shared vmemmap tail pages as read-only
Date: Wed, 21 Oct 2026 13:40:29 +0800
Message-ID: <20261021054029.98875-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261019090830.1917657-3-songmuchun@bytedance.com>
References: <20261019090830.1917657-3-songmuchun@bytedance.com>
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


On Mon, Oct 19, 2026 at 05:08:28PM +0800, Muchun Song wrote:
>PowerPC radix uses an architecture-specific vmemmap population path for
>shared tail mappings, so it does not inherit the read-only protection added
>to the common path.
>
>Protect these mappings as well so illegal writes fault instead of
>corrupting metadata shared by multiple tail pages.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

Nothing jumped out at me, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

