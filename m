Return-Path: <linuxppc-dev+bounces-23119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96341C43602
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 16:37:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpsQX0grcz2yH4;
	Tue, 30 Jun 2026 02:37:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782751076;
	cv=none; b=Bk4W2NqR6FEOa8VsyxAJwQs/jh7WHBeNvj5kDborKapv/NoFP4gzFTFHDm8WzDLKF8GePutd9D/O15kQVvxgxO7XCgSJih3yhB7AuCxk8L0emSPvN2kf2g5JlUbsScD2k0Rto7Hlb7OiK9WMBX3/VcEoMrP1LzIacbLGntjIOZEI70fPOesCp3JbWfeLTswh/+b457XFLFAKxvJTYjBfWGVXip/8Rnir0yjAzURA57dVtHU4o2loeKm8JnQDhYQKpp8Tsx+uO5uRb5nEzVkoyGQgjd5MoAwa1JtAv8uo6p5zYbdFnVgWVQxMfC6abEoF5NAo/nptpaykI5ZqDhcDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782751076; c=relaxed/relaxed;
	bh=rGoS9kJnOsBC1GLvPLCMMJFTI12ls42atzGQpoe5Bdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+qG6Ifc9SvP7KXwbbtb8a3c9zlhGsoXCX5yNCjjrJkM+B2fhfp68tofUlZ0zn1rAJcTiFckhQWf85RQwG59Usck1D0iBILeR3yWVgBO5KJJATD8yHKNgFCzhFH50STKz1TqYOUtXoHabCpNARDXCta49BUMD5xJVeqa+l8xd5B6L53bMHQJ6WqMIjonqAafOjP4uVpJlW8IPFCYa2BEl4M+XfLQlnEA8fXn177elx3zDUrgiJaIBzRq7Po+nq3B6HrYaGi9HTYZDtef3FWgjLPStQVaD1fLw3MyzO6dINWIXV7ndOYGGRNp4XqafJgf1xGoylToaKVYXYy16TOVmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nUGq0YSo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nUGq0YSo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpsQV36pcz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 02:37:53 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-84794e800f4so393219b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782751071; x=1783355871; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGoS9kJnOsBC1GLvPLCMMJFTI12ls42atzGQpoe5Bdw=;
        b=nUGq0YSoyweJNmExO8TdiDAFboeMDpBbKNtUH9KKWt9p6QAFLXDIN0kNmzIUloWIh9
         IFq7zXTX+AxbSpQgDHjsT1DdUjra4cJ8j5gSN8y93Ns0nzPjs6b/VGEeGz5YG5GRErLM
         7+YFmn4JO6CpoiOZjeHVLaM9+ItIZhdHh7+5DALXSc09ITaxfqV3Bhw4asHnpLpAagCN
         henrdhFy0Abp/6Eu/detGY4itfxEvwzgfxf3BSHiFI/MwTyIuFRjhGtqWCem81PE9+V7
         yqlfHv84VzcMxkiVRZ3QMHD8mo12lbSyWbO9OeJwIwhnWGcct7wX473bE19vJdtrSG+L
         dbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751071; x=1783355871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGoS9kJnOsBC1GLvPLCMMJFTI12ls42atzGQpoe5Bdw=;
        b=CT8fHsOPQ2B0c9lXEGVMjVsYBj4QzYQgIGpLeKfwZFKX5xSvVBlHSatVVp40Xsovtr
         R+BcEcW/C6CRSCc3aI5oq2Kg/ykSYOupSjc+5GhgTkMEYsEeiLhIbiJj3zaZUSxkiZQc
         2wMZdNMh6yLkcdAeAQUcx7/+lYm0ERii9JaC6TLSR/2/PB5y2QOSbnqSFQc9PsZjhK9Q
         j/n4wL7qFykDOTmkvdqOV0KY3uK3pPfzY/jkjAFOm/SWtIz7T7Y2pRJF7nkuqXw8TLGR
         /PGwC7QK4k4G3FSdrwW6UGiPusL3aJbSzMPgXEPRC8dz3DqfSgvJzYKfZ5kqBMteKNtv
         HHVA==
X-Forwarded-Encrypted: i=1; AFNElJ/HdSk3dVi0uMHL5XAiwj+4o6Gbjobn+Fa22LMTJ1v42dp9WCUDlIJv48JBxYs6+MgpX4iMETW/YLNCkUc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqGIZuUSB1f33os0y71M3vrpAnECVvcHEZqRpU+1qhUAqAsR16
	Myn0ColZcOhJSKJv6m2EtsSefUqZ42BOuQrCt21XaOPbsGEIhZWTceO8
X-Gm-Gg: AfdE7cmNkkSlPbT3st7IfPE6KUhSYCRVzweg9nxUWfT8fGFLlPWBT5L5Heo+DGqqVjU
	bZV/8lsfxMxh7rpyPEpaupo+IfscFYukRlsITYUA01/UGOOf4CcwIX6YJoo9d1yXWgWBqXhfJ0T
	HxgMInTUkDlqGVjnmHpD91ldORanSpDj8U9SYuw1dEwHfb5VugIy48DvQ4tKJ6x+Ll69OzkNhfm
	PLLcpGQVzw/ghNjuRLciroXr9rupiJq/ZWrnhhP5TQ3H/NkeTcAevd/ftCEn0JPOeal/bn1gnvS
	hMHN4QhCQEjLjO3bKvL8JB8utjY8N7ERSp4JeIKrHmZVeo9L6eduCzttIQx3b2LSA5qefF+IBKC
	yLdq7WjUGRXsQjbd5BzbtsiMJC4VpXdZFNwfEelO4/bqB31KVwKWaj/uHHPUolWdeToZnU14cyw
	bXx5nvk00=
X-Received: by 2002:a05:6a00:92a5:b0:847:8337:64e4 with SMTP id d2e1a72fcca58-8479f1f553amr205069b3a.30.1782751071179;
        Mon, 29 Jun 2026 09:37:51 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02d41c0sm18474b3a.33.2026.06.29.09.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:37:50 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	Nicholas Piggin <npiggin@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v2 0/8] treewide: remove unnecessary invalid range checks in memblock iteration loops
Date: Tue, 30 Jun 2026 01:37:28 +0900
Message-ID: <20260629163736.1606688-1-ekffu200098@gmail.com>
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

The memblock API guarantees that for_each_mem_range() and
for_each_mem_pfn_range() never return an invalid range, meaning start is
always less than end.

Several memblock callers still have unnecessary invalid range checks in
their loop bodies, so remove them.

Patches 1-6 cover for_each_mem_range() callers. memblock never stores a
zero-size region, so the range it returns always has start < end. Some
callers apply __va() or __phys_to_virt() before comparing, but these keep
start < end too, so the check is unreachable.

Patches 7-8 cover for_each_mem_pfn_range() callers. __next_mem_pfn_range()
skips any region that contains no whole page, so it only ever returns
start_pfn < end_pfn and the check is unnecessary.

For reference, commit 36ca7f4be809 ("arm64: mm: Remove bogus stop
condition from map_mem() loop") did a similar cleanup in arm64 map_mem().

All these checks are in different trees, so I split the change into one
patch per arch/subsystem. The patches are independent and can be applied
separately.

---
Changes from v1 [1]
- Add review-by, tested-by tags from v1
- Add missing simliar patches(5,6) to patch series
- Change base to rppt/for-next

[1] https://lore.kernel.org/all/20260621145919.1453-1-ekffu200098@gmail.com/
---

Sang-Heon Jeon (8):
  arm64: mm: remove unreachable invalid range check in
    kasan_init_shadow()
  LoongArch: remove unreachable invalid range check in kasan_init()
  riscv: remove unreachable invalid range check in
    create_linear_mapping_page_table()
  riscv: remove unreachable invalid range check in kasan_init()
  ARM: remove unreachable invalid range check in kasan_init()
  powerpc64/kasan: Remove unreachable invalid range check in
    kasan_init_phys_region()
  mm: remove unnecessary empty range check in
    early_calculate_totalpages()
  mm/hugetlb: remove unnecessary empty range check in
    hugetlb_bootmem_set_nodes()

 arch/arm/mm/kasan_init.c               | 6 ------
 arch/arm64/mm/kasan_init.c             | 3 ---
 arch/loongarch/mm/kasan_init.c         | 3 ---
 arch/powerpc/mm/kasan/init_book3e_64.c | 3 ---
 arch/powerpc/mm/kasan/init_book3s_64.c | 3 ---
 arch/riscv/mm/init.c                   | 2 --
 arch/riscv/mm/kasan_init.c             | 3 ---
 mm/hugetlb.c                           | 3 +--
 mm/mm_init.c                           | 3 +--
 9 files changed, 2 insertions(+), 27 deletions(-)

-- 
2.43.0


