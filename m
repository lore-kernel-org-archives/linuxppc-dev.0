Return-Path: <linuxppc-dev+bounces-18600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66156EC01A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:49:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQKX14lcz2yhG;
	Mon, 23 Mar 2026 18:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252144;
	cv=none; b=EsWyruMMePCRyL6BcCi0cQki4AeDdrQ+EONOOCueUJje5GC3hqmXYzGZGgYwoxKS78eGIQFJphdlYVEiT+DqLrjxLvpcgg1bkj+6gcw+WiyKJrIBnxi2ZrEubhO37SgKDI+veNHTACqsU81zOTXnHzFMVwe83cTKVtDZ2ijEumuQ8wqykZD2NxKq4W1UcBdOwMD0/dusB4+JJOpxBHKINp7d+8/zjVZ51hgyjZv0nq2pLnZ1QaCci7Sjr7EOnuF/2nbbz2dDZYXRetfbmNSyFtX4qR/nRiA1TsT/odMQmyTr0dJ7pVzDIrG0ZinwCS4wU4XU4/eWz8RlbY6SCl9c3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252144; c=relaxed/relaxed;
	bh=PRKSTfQ2O+eVNBGid9yhgznzOkdGuXgn3KcDsHXlPeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8fL0SWCDZJUtw3MS+KEkEpyehO3Xpo7YarXob96cEJiNKbQe3uNwfvJyMiO0qhSaf5iRuD0J6twyQMZDAwJwoghjt11EGhIPZrhkENMxgLfetDqzVZioMUrUdXcxd+dAY9FidlrjF9JNBtfE91xivzXDuU6Ln8UkI+egMhcF+HOyLJTq7QiDZCj3VMDpxMJeU7cpLX5pupJAVokDmb/RjOtNtHEP85SVr6xpb0cZDCx/4IiLuKsvb4MbY4YLQQu0H8Ey1IZeodv473pxKz7ANRZae1LXsPCnPAI31JPg0SFzjVqf6JVyUXaGnrnfKBRmPxLLNQdXdINzWHPny29Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=soMwPHB4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=soMwPHB4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQKW3mSfz2yds
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:49:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AE2A04358A;
	Mon, 23 Mar 2026 07:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B1FC2BC9E;
	Mon, 23 Mar 2026 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252141;
	bh=ZPayAoUZgLwz6EhVKnVbCR0MqW3d3UF4hy1nzr/kEys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soMwPHB478isjyOEuq0IFRN9Cief5Jqwxg1OL7jUkDAL9y4hBeM9dbR/1MWaRqGWi
	 ib0jpyTzOuLzovqiLkfFzH/sitT7zv4W8SFvjQAfIZyXowACHhmqxuqnkiN4Ye2w/b
	 fqdb/4qzrOD886HOPMUSVszQTzLVwA06GpzpYZb9RUwXxMKzldKhDOEpdPGEiqzvEz
	 d8ZnoMumXfNyr/H7/zGCKqVZFhNYMDERdxkrZ9jFtVB2x96iGjkhmG/En+iUsCJUVO
	 API6o3jBTJGcQaw3dzn8rTLMq1L6nSmRBE/0It/iNumPWF5phnJ73bZcJMJHMFZdCH
	 C3sxaPr5Q/wkA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <jackmanb@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 1/9] memblock: reserve_mem: fix end caclulation in reserve_mem_release_by_name()
Date: Mon, 23 Mar 2026 09:48:28 +0200
Message-ID: <20260323074836.3653702-2-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323074836.3653702-1-rppt@kernel.org>
References: <20260323074836.3653702-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

free_reserved_area() expects end parameter to point to the first address
after the area, but reserve_mem_release_by_name() passes it the last
address inside the area.

Remove subtraction of one in calculation of the area end.

Fixes: 74e2498ccf7b ("mm/memblock: Add reserved memory release function")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index b3ddfdec7a80..d4a02f1750e9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2434,7 +2434,7 @@ int reserve_mem_release_by_name(const char *name)
 		return 0;
 
 	start = phys_to_virt(map->start);
-	end = start + map->size - 1;
+	end = start + map->size;
 	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
 	free_reserved_area(start, end, 0, buf);
 	map->size = 0;
-- 
2.53.0


