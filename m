Return-Path: <linuxppc-dev+bounces-21374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67034CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 08:57:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMK0L3mb8z3bpJ;
	Fri, 22 May 2026 18:57:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779440226;
	cv=none; b=eyFIemYGFVjxQ9WSOfN6vL47RsWYEmqS7pMcktVIN8yG/lkZ5TTeHfrs/JEh/QehcQ1O9tzMRcx8SYR3NzVG6GnG1kIZfOypPm0ykS4T3PTEz0OWVcWNbGVcXZxClcrr8Ui1BvEIR6lqukvKW9+Kib8XphICihUya9dm8qgj9pHIo8jMrJ95qR4X2yvGZATvF7jyhHXnVYdT6/x3rMIiJxouIEvCsEVq1jc8IIiCQPYKw2woQQ8DerSDiUHlVMZy9jwk9UsLG7jt2Nz7qs2uJu/orrXzY4gQzCEuvTgaouAQnyGmLgiwgYBQ1SC3ZA368nUDwRe/XiBkVYmtiIR2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779440226; c=relaxed/relaxed;
	bh=I3GcOzyKQx/opwSym7kmkIz1q/A2cCWc6XlxcY4I5Gk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=b5LkWly3SUAXLOV9Mrpo+qtV83dmlxmwxswR2ll01coQB8uD/pR56PWHGy8ATrnXHYuX5QtI+u/JFx5uqSm8zaH7sehY2VXB0n1AE59BVxHFBhcW1gM6F185+F12Zzq7hUgAoECmGgEM/0VQuDJO62bD4fUzCD8mxYGrTJiRM+X8VFfwsGOh3yeUtlHyaGERwit58/Saad1yZCMzX7YApYoYv2hJq0xTqo+OPzpz/zgQlHfW3cTxlfP2omWglkTgHoKquJrD0gyKj+YFFjCz/bC7ub1FVyY6oZocyZf5qLZ9XAeId7j4BHoFVU5ZN3DRDVQBLGYIMl2Gv9kxH62ccA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNlsbfD8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNlsbfD8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMK0K6Zkpz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 18:57:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 55CF240BEE;
	Fri, 22 May 2026 08:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4B01F00A3F;
	Fri, 22 May 2026 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779440223;
	bh=I3GcOzyKQx/opwSym7kmkIz1q/A2cCWc6XlxcY4I5Gk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fNlsbfD8FjyTESz6OuzkCrX4RT/DuLxPcyu/Fd2CWNvrQlVVadwmxTQvZTM+jQuH3
	 +3wcE9b8vq+xdlri3GT5APNk2OWo4j+dt61XJJLr7tbQVnBfgLsIZyB4Wz0FtY7iLU
	 fNwLX5kgMMD7YYwA+dh2k5Hct+Jgx2QbBD9hVbYr0/QyYTNXnut68KpjAXtnOohpfP
	 OzIUmnohrA3no54L4NePJvPrDaDGt2OphyVpVR6J9D8meA1IB/+cUaJfZQutctmUh7
	 d1i6kx8Cg0CH3HJ7ZXqDSh3ijmYjAjIzOYKLauI1+NC4npOv5AQ2YLni+i08nMyEno
	 znrxSt+xX2sXA==
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
Subject: Re: [PATCH v2 19/69] mm/mm_init: Make __init_page_from_nid()
 static
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
 Ackerley Tng <ackerleytng@google.com>, 
 Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com, 
 joao.m.martins@oracle.com, linux-mm@kvack.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260513130542.35604-20-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-20-songmuchun@bytedance.com>
Date: Fri, 22 May 2026 11:56:36 +0300
Message-Id: <177944019670.3663073.4082076266566320906.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 13 May 2026 21:04:47 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> __init_page_from_nid() no longer has external users and is only used
> locally in mm/mm_init.c under CONFIG_DEFERRED_STRUCT_PAGE_INIT.
> 
> Make it static and keep it inside that block.

Can we just fold it into its sole caller init_deferred_page() please?

-- 
Sincerely yours,
Mike.


