Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CE606A31E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VGlc6efj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGDyK1HTJz2xHG;
	Fri, 30 Oct 2026 19:38:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793349497;
	cv=none; b=ZDbdxAsShfUojMnYbKE6387Sw+VaRIGXnTBI27H9m8MapRhmiGZ6i5MCMECXJg7sWrgzErOX1y8KYhH+z1nli3mEmd8vcHIlouuQev/tHpp7+4/dqyJ+6VE/aTOi7S6437ydkSqDDfO0XDl/KtJV6p/KPgAUcnlgKl5mCpRJiI5ZuVUz6wFg1bEFeRs8PlBCYPY26vY+nK3sm7wQISU4MmXMLhU16eIhxJZ6YiZeqRcwTroCCw+gnbRc5xxW5lt6ftTBd0rCIxJMR/W5DAwfatPVsbPVbW7nQJCA5sNUFmRHvQ+zsIsW7fCo0e9ASyhZYYxEeHEMRLyjq6qLa5WrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793349497; c=relaxed/relaxed;
	bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8x7r0+taK70sENqLPm5fgJDDn7X6k9DrVkrv9NHNsgC3q1H3okH2s6fPkFYac3EgdaPZGeGJW8eAkjydkCTKOyxgx6WMp49VbA7JYCpqMjwTyZ2YejuRgNamxlNqfD+vEkUhpiPMgIR9hS3kbnqepAWPcJB5xUsloa1EmnquwiRuS5gwMgrL63yir2oELcsBfZkWuQnz1DWZL3ygWW28DBfJoIx5mFIG3IeZ2Nik2owB1GSfUmmtQPO3Y5xrUNf0CtLhS0lVkX7OuXtyDIyGM5sFhir2tjKgmKRXypFTBb1NFy7AD+5alosy59uP3/JtZcKYEEd+CBcjiqFWlVsBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VGlc6efj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VGlc6efj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGDyG2sGQz30V6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 19:38:14 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso273545a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349492; x=1793954292; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=VGlc6efjK4nNM7D93lDWD9WRZizHkPQUyGpNl5rRg67AUAvE2KxIqWHT3/THOq/3P+
         1PSXYEGh/zCmen6jgXf2YhdvabJg0f6pZF1cruyzGmGbg4uhmi38gUfgazXCCN/QqiXn
         jX66aQ8V9GTfG8sbPX1UsFpXxnTocgpAnCgMZ1DW1a7AmY6xS6HoL7fnmMxn2xgz9D/F
         xbOzTGrNhL+Y2mtHywZWqpPKJFNyjzPo/SI66+rnOSaeIupJmb2ttT6xGn2BJYax4ypo
         4QEtqFxTU3qBYCGq3w8qOrFxdbFO31/R3ouE6i8rDprLxiS93bWAc1AjIPyOkTRw93fG
         yc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349492; x=1793954292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=unEmQHOzJsEsyol/Z9F1p/s96o6H5ztjj3xX9tj2PlL0z91nC9njTqVcL4Qtduvz3S
         20U1x1cHurIMbKZCX41MVgWLzBEa+YT+Uk43TWJgiaxYXDgwfpxDigjhHZ1Q+4sEOQOI
         QhOxsFJR9xFcrt3EIuvGiN4UnNuYLtkRof4elFQDOfry8y22GUoJGos5879D/vpvWg+9
         obzjW1UNURld9olmPCxovg20aOM0qvJQGPl8FBaXWBcp+eT8OTu3s/eJe756ArGpo3AL
         4OpsywAHSLRMvl5Dd9InLQgfqXNqyp8MDmmkgPhmH7tjbK6sjldRc7uO4/nTvP+wr4rl
         pDMg==
X-Forwarded-Encrypted: i=1; AKwUvByT+4imgQ124CTKP5LFfdnEJzUw0ISYhNTMl7YPc8yv4Id1Fx5Zn2chyUlL6pZ/aVcnyfTHEc+xte5F7i0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJYoV5/WKJXF5HoTxsu8yPvhP9XDnFFySVXqkYu1N8K5ky5W+kk
	3wJPq1ZIq6Xlv08SeMv74dEGLQXo5jwPyFb+c5mAstWb5oODNl0fxHw968dbed9P3JA=
X-Gm-Gg: AYBFou0ohpOxvHJp8VvsNYD2hsuzWueBaTVVqtsStZlbfs4ucPZoZeCIYBq7D6c5kQB
	T4D74TXD3MvOgpz9yC3Tiu8tvaQBTQ4ccxRO6YljfEI0Yf5VpVXErj+Cjs7XTzUJB95Y9F9n66g
	UjaBaGz5gdo3eK0WJ1vNVW6oAfDsLDZjQC3pSEWOdcS6jWCHLl6TZfydqXO3FTy4tZ5hK4RXcpn
	0NcbKLvWoXj8ayw+0vEx7S68k4dskUGLqa1UNpowyj90Ayx9L8+yONMvyJKHIyno+MHwlUflX/q
	cS2IxavHtmOBNhjWM9GVQuRjG3M2mbk4vH6QEimZ1JimOUTKxY9dKLCZmA3D+JZ32wJEin3OM/l
	mte875Iml9QtmtcUC7Md1Go+65LoLM7bgSnLR1nk4diWIGgKriBQGjXWhfdx0uWwuUP3T+w795K
	IKkedLseKLqWP+2enhIBC0T6QTW0xI8XK4aAlBIBkHpiceNQN/O973jQg/kHUJpcl4iByVAVmQa
	Iakk7vEAMd33Ro+dPhTWI+qumyYevQgWTmuLFMJnvxyXi/yGk4LWXfX9ykjqbWGO0pkodkbqeF6
	e2Y9UMmvz96z+/2Wi2Dq3Bpzn+3v89wr9/4lBZ/H5l1Xy4Yndc0=
X-Received: by 2002:a17:90b:5147:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ae897c7c28mr1424866a91.14.1793349491405;
        Fri, 30 Oct 2026 01:38:11 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:10 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Date: Fri, 30 Oct 2026 16:37:58 +0800
Message-ID: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a follow-up cleanup to the page-table teardown fixes [1].

pagetable_free() now invokes pagetable_dtor() for constructed page tables.
This makes pagetable_dtor_free() redundant and leaves explicit destructor
calls immediately before pagetable_free() duplicating lifecycle handling.

Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
then remove the remaining redundant pagetable_dtor() calls. This keeps the
destructor decision in the common free path. No functional change is
intended.

[1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com

Muchun Song (2):
  mm: remove pagetable_dtor_free()
  mm: remove redundant pagetable_dtor() calls

 arch/m68k/include/asm/mcf_pgalloc.h    |  5 ++---
 arch/m68k/mm/motorola.c                |  2 +-
 arch/powerpc/mm/book3s64/mmu_context.c |  1 -
 arch/powerpc/mm/book3s64/pgtable.c     |  1 -
 arch/powerpc/mm/pgtable-frag.c         |  2 --
 arch/s390/include/asm/pgalloc.h        |  4 ----
 arch/s390/mm/pgalloc.c                 |  4 ++--
 arch/sh/mm/pgtable.c                   |  2 +-
 arch/sparc/mm/init_64.c                |  1 -
 arch/x86/mm/pat/set_memory.c           | 10 +---------
 arch/x86/mm/pgtable.c                  |  5 ++---
 include/asm-generic/pgalloc.h          | 12 ++++++------
 include/asm-generic/tlb.h              |  2 +-
 include/linux/mm.h                     |  6 ------
 14 files changed, 16 insertions(+), 41 deletions(-)


base-commit: 9c449f885765cf8d80b2c60b1971e774bba51a3f
-- 
2.54.0


