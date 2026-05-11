Return-Path: <linuxppc-dev+bounces-20710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF06CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:06:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhMs2wT9z2yC9;
	Tue, 12 May 2026 00:06:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508361;
	cv=none; b=DDS2lnKmIBMGKIx/GUwBikJL8RzmcOs+5HKrSsSHm/Q2engrzqrYyGLfkakqScTSV0CZk1STmctbevlYyJ3tVDFJ9atoblL3SX+cwYyMDVLd+k6MtAqW60PpKfqTCOgthOwyQGJDTP+kWmjFHp0+Oag9tn1k9Z2ZV85uB5KIE/HvpHsbRUTy2OeP2bqtKusEWixJeI7/tO3icOItVOC7cWRzyX6G/SG3SUizG7p+vIVq1VQQu8xwoPmRX8eIsttvQSJEm2JcA+BaYgaPp8RSnNFl2b53zB9q6MTJLAuzMZWctQwVDiqYYIgSfFKxUZEHb+F+DzIPVhcoqWbdYZQnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508361; c=relaxed/relaxed;
	bh=UoXpkzT0EfRbW4uqwNffzpPOEjrNcXkx1+2e54N79mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3Gb936wmnDcNr5XrqQ+IEPg8veVAI8tNClT+hQHTW9gLiWXfN3+COKP7or+pMRy84eUQ2Vfz3OWZ2Ir1HqNLchMn8JqScP2qzZ4hL151Nmh3I+2PaoxuXceQuEqXCXhs3n7KYBTInbdaCdZYHqzRRXPj22Lvp2ETW2WHLiAw3Et467vXmHY48JKEbl5WlSwSGnbos2i/aOhAeJcpxJoaaDiSh9KVSE5/QmME/pv7WMmZSueWMogFB/TQK4FjC0n3R7CI7sg7QZ0hG+d3vthWBuM2xTAvYoAf7ZCyfgU1FeNJzV5K6fmildeSn2eAd/WAzXi6DV9RHrseF4FRiqqSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kohAm45R; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kohAm45R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhMr5gFnz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:06:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C4F3260121;
	Mon, 11 May 2026 14:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A68AC2BCB0;
	Mon, 11 May 2026 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508358;
	bh=0Ocue3eCm7kftjDOEvgMIfcEU6dPF7QGnIf4HYzbk1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kohAm45Rpj0GtsJc339+4HuV+qMJDQGo+OaGrUlsvRENMLfGC7yd+8Am9w+nMsbot
	 lj6c+L4Z1u6qvm6mkjovGEmaHCIyIMXnG7LyJQpkgojs5UXrNFgpWefy6AwbnY5C1z
	 ty2kfu8/5ma/3T+/lZKlKFaDOGpcpGI/QWxfqZjZNw2uJlzHEDnZjf6L6VSMEqPIiI
	 AW+6ECoossl3ODeBCgdyyUGa1ibx5REXX3G95YbmSUcDkQIkm4h6rzaV3iCdE20VEm
	 omnCjbI3KzvVWJnQ8H1EH6BJI5eh2E/YkK6veo2XPHKLx0TNxDaFyDiqrm2Xf0StNx
	 ljcaeng7fr+ig==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:32 +0200
Subject: [PATCH 4/8] mm/bootmem_info: remove call to
 kmemleak_free_part_phys()
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
Message-Id: <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

The call to kmemleak_free_part_phys() was added in 2022 in
commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
put_page_bootmem").

In 2025, commit b2aad24b5333 ("mm/memmap: prevent double scanning of memmap
by kmemleak") started to use MEMBLOCK_ALLOC_NOLEAKTRACE when allocating
the memmap to skip the kmemleak_alloc_phys() in the buddy.

So remove the call to kmemleak_free_part_phys(). If this would still
be required for other purposes, either free_reserved_page() should take
care of it, or selected users.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/bootmem_info.h | 1 -
 mm/bootmem_info.c            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 492ceeb1cdf8..f724340755e5 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -82,7 +82,6 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
 
 static inline void free_bootmem_page(struct page *page)
 {
-	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 	free_reserved_page(page);
 }
 #endif
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 6e2aaab3dca9..74c1116626c8 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
 
 	if (page_ref_dec_return(page) == 1) {
 		set_page_private(page, 0);
-		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 		free_reserved_page(page);
 	}
 }

-- 
2.43.0


