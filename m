Return-Path: <linuxppc-dev+bounces-23839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3EDC44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 17:07:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwPf31BHVz306N;
	Thu, 09 Jul 2026 03:07:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783530427;
	cv=none; b=Fp6AanNEXmhLnXqEAm5jWcb+BLCc6mV2DZ+LUWP9uRjD6N1v0KDOEQzqaNYHGBbWc1sH1lFV1mtwj1b9AflgqfFMvi2YbF4ub0OPrjVqBL813iUUmNOQpNdPvUzJDFs7BWKfG9QiGpXPJq0+NudsC3frFNQygvFhjxOr8+tRaT2eyZ0/mKXqgZ2/OaDBoxFPymPyH64wACuX3JzgbbZYgqmqrOFdSUHwy+p7i8t2F9Njk5MTa8lpPP8Gi/hXRq9M6NpfEwRC7FQFIX6STi03EoOQDv7FLXMLNSmia/qjaA8Ygr4HFZQI/7dw+FiNrgiHK1lh9dI42DnGJ+RZCtbr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783530427; c=relaxed/relaxed;
	bh=amf9A3ny0stjzBNYa5xxQpkuKUHxHwl/QGUYuXrMddg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPYeFZEIQ+rI4vr/s0HdueTOFkQjmNjSdjzOq1n1oM+x0wAiA+5Tj+MV0ZrzMLEhIu5WmFsWtH+EPZd5c309GiMvTrA+4X0DUAR2O1YmbW9rBRbhwky1flqx0RBLfgXe4ATLM7w/8OhJ7o5MfPCzSD+elYjQo3kPCj4r2S9qCtzT1Jdv1Dzf4jlAk9tEKFkaiw+Ej/KwDjszCQQfMqUFAajb9LX2/XFZ4k9A6Mki2x09Y/ORu0jKAV1I7Ti1ME0b+z924WE3G8Yk7Fm2YDUg6B3eZd5WI2gLGE7q3bRed1bbRKE6/+umOz1IXzno3taHDmj812SxywyYFxoukdwiNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A28+2L7n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A28+2L7n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwPf16pnNz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 03:07:04 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8484a0b998fso864319b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783530423; x=1784135223; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=amf9A3ny0stjzBNYa5xxQpkuKUHxHwl/QGUYuXrMddg=;
        b=A28+2L7nEq+W+cRQNMcnlIruGu4EDTKa9fxKjh7Fg9CQcOWtY7/glPJ5PSDhA7yEYc
         Wni4/JVh839Mf0bXhcX6Jp0XstnAdFnVEMFgFBHVYy3XLH/jXx/4IECs6vmbZODBMfP7
         lBV8GwpdKjGyDiglgJxAmr0EfYCIUltKpvPbtVQfumusBld9ZbH7DkIj07IvJJkKZEIA
         5QEdCn6aWO8KMXpikwF84xkjYp7QbEVf/nxfN48qXUaKQQ9inwcFkinlsiUf1JsO+R//
         +JqbIyOc/+m1gFA36Fd8JkgfQwbP20gzPFJUOMNGZsgkS2W6pAeIK0sZleHlAxBgWU3v
         SFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530423; x=1784135223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amf9A3ny0stjzBNYa5xxQpkuKUHxHwl/QGUYuXrMddg=;
        b=LDWwaNDsjAjSAA2fEvPrUVdsRsmpP2VQP9nxkkQPE8+s6lNkklxoQdS/h9Ve+y1qMx
         RHlXXYJMnRQKFj5AA55kaSu6iKkBxZ7Bmd135keVXphQ6GJrhI7YQEgsFNdJBWyy5oxS
         lnnJw/7JH/LGfx+VN42rZINSGbEZ7Q5MtF8MewNzn0on986ZuM56eNUYTxpjkW37mjuw
         //48BhhUrxvsm9dmy175FBT8FsjGz1kZLv/hImOYvjTRgmvW1UwisskUfRZpsBSmp8DM
         tVq/LdT7ISrNQss5TzXVQ0vMqGvxeL8kirxwW76thFapAoZZzvwjL37+qvo+Wxm99r3v
         XRXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5wEB1Q54qkIfO1EtjM9t8oGPyOcIBfj9GYTQtdhSwquVZ88FoDDJAPtHIfQJP0+qDOIgpgQDjvCXRkDM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnJr75TNvfWDcPaY/mwg4TwnlugRNlveC+ItgURqnmkQaukrbu
	A0cMla8AAssHNfeb7D1g5MAIpVVF9acshM7nKjALxaPWoBXSkJb6PZfR
X-Gm-Gg: AfdE7cnlAzXuGTX05uOxmN1fYScNlsBKg9M+qo0AANyD9+hFc79p2A0ZaiFFDTw9/q5
	Lx54GdsWWBZ0Y00dGDhpz61SVp3ki701e8H7mopQpGtqCAe/pfPDD3sEl42NpvCBrpBKikWKeBr
	lnwxkAfGU0QWlZvhOZqBTWtIfL2R+GMh48HDuaPrL3u5vIM5X+NJNoBTUgQXR91w/7GAhYsyRTw
	48W3Rr4DsnL8n2l4hOQIR9AZqKZ+dfh8GbAAB19h5QRxZvDMwTZ+LJR3SkZ5aWg3yz46D5g3UO0
	726JW3QOj/A22ishRivTRyB9FS25fFF299DJkpU1iIZkGT857ukSSv5p9fHS2QUNYQ6fx7lGMXd
	AsnguaKylV518amqn5SuKcjeIW4sdUBgsAmYY1wYGDymB5Bx6ztIVfKJfZDH4u4MRUSl6S9Sz58
	Mv7JizpEBYya3APS0FQg==
X-Received: by 2002:a05:6a00:a15:b0:848:2f77:e2df with SMTP id d2e1a72fcca58-8484392f4a8mr3717327b3a.72.1783530422835;
        Wed, 08 Jul 2026 10:07:02 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84847275fa0sm1119528b3a.22.2026.07.08.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:07:02 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: akpm@linux-foundation.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH 0/3] mm/early_ioremap: clarify and clean up early_ioremap_reset()
Date: Thu,  9 Jul 2026 02:06:44 +0900
Message-ID: <20260708170647.362562-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit

__late_set_fixmap() and __late_clear_fixmap() are only used after
early_ioremap_reset() has been called, but the comment above them does
not say anything about that. So arm64, riscv and powerpc, whose
__set_fixmap() works before and after paging_init(), describe the same
situation in three different ways:

                 calls reset    defines the macros
        arm64    yes            yes
        riscv    no             yes
        powerpc  no             no

Patch 1 documents when early_ioremap_reset() needs to be called and
that only architectures calling it need to define the macros.

Patches 2 and 3 remove the unneeded riscv macros, which are
unreachable, and the arm64 reset call and macros, which change
nothing.

No functional change.

Sang-Heon Jeon (3):
  mm/early_ioremap: clarify early_ioremap_reset() semantics
  riscv: remove unused __late_set_fixmap() and __late_clear_fixmap()
  arm64: remove early_ioremap_reset() call and __late_* macros

 arch/arm64/include/asm/fixmap.h |  3 ---
 arch/arm64/kernel/setup.c       |  2 --
 arch/riscv/include/asm/fixmap.h |  3 ---
 mm/early_ioremap.c              | 10 +++++++---
 4 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.43.0


