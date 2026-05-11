Return-Path: <linuxppc-dev+bounces-20706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA6CCD37BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:05:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhMW1KN6z2xlh;
	Tue, 12 May 2026 00:05:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508343;
	cv=none; b=W9lEzz9oMwjjGgfIMcubAtW8iO/FUhFtcFIytipMjL/B7fmFQIP+KgB10RBcOIpFmEVYrFUvQBein/3uf6/QFZxrTQWC+fpNY4xaoGN/0HVhnIxQwrBY9Z1+Ohjp9Ac+CMzhpPAezQ/D8UvuIT8kmZ3LjIMVo/5dn7WwasuSJaMEEKq2U3+W3buarwIHr9UnDCbMhJe7oOWDCAZwgqdNSt6lJSa+F7LWkYypx4uOXTEx/bOdbMqiPqImaiAohyVZ2/DX2O6sV4n5zs4mn+kgZdCTv0jUQnuo9E74l2yOAM0Gf97k9YFmH5WcaSLZB9CWlpIH9q9kXQVkMlCgfefsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508343; c=relaxed/relaxed;
	bh=lQXqTgBue7HDYNHZQ87/hoDlL53avAm6YNApkaUe7pc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XC/irea8/akudxcviLW/TAYqJ7eUf8Cp2j51pR0g1minC/l4f0k1B0OJHzxyG1o3tj1x13B8AxmO/GvlATwq2DAPROxwkZL1RrHP6xmyRx7aOoY+jLjPqvj1rZnahSVIvZUINJNt3SZjgo4RN2sOCIQQ7J1bPvScBc59PmgceCVtF2FWl1BTREwz9aw0t69FJaQJzannZ1u8XEtDfLsZcbvQ+ZZeHl4t1htH9/LtYQ6fJS8Qv/+bbKG1CFwjkl+hGr1/zQ8QhRqiX0Up1j1kvbDdLxZhQOXvylMk9jikwnwPpliiH095md9xYL8cPnwtgAvBX2E++wTXTbN6+NuVpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pk8OvGhJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pk8OvGhJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhMV1CHQz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:05:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 037A4444E8;
	Mon, 11 May 2026 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6323FC2BCB0;
	Mon, 11 May 2026 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508338;
	bh=Pm3OKX4tz/hPsvUcluc/wv11pQMYSvwTXUM7a7WxgtA=;
	h=From:Subject:Date:To:Cc:From;
	b=pk8OvGhJq7glmUYSBkvjdGMP8W1PwVrj/Ni3Vl6ybhzKWT6REW5dAxr3KJL8Qww30
	 E588cfZ6DoBozhyhGn/5G6YQ/IWBF4Ds5JmK12mdtVf7FtP+6eg2pqtKxcgjkhacEt
	 7XoKR6PdHITxP1Lz63lzWXchEtWTiDthd8atbcP2GojB3NkRaoidqNmLH0XqLjqQt5
	 /xaOsOTS2ojBPwKvIW2lNWBCpaI3QT00m1Z5Rh5VuZKvNEnIcaO8wH3zOE3YvebS4z
	 Wjw3Jmmdw/vmHqR3GEnYlW3qe3zPpguwb7OJlJ2b4ie1RJEWM0QSsUDcjsm1zHmNUd
	 K+7av9Ttx/5rw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/8] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 1)
Date: Mon, 11 May 2026 16:05:28 +0200
Message-Id: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIACniAWoC/x2MQQqAIBAAvyJ7TlChjL4SIWpr7SEVjQiivycdZ
 2DmgYqFsMLEHih4UaUUG8iOgd9t3JDT2hiUUIPopeQupfPAw1AMyeSCmbvgBWrbu1EjtK7JQPf
 /nJf3/QA9mHRTYwAAAA==
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

We want to remove CONFIG_HAVE_BOOTMEM_INFO_NODE. As a first step,
let's limit the remaining harm to x86 and core code, removing
sparc, ppc and s390 leftovers, starting the stepwise removal by removing
and simplifying some code.

Once a related x86 vmemmap fix [1] is in, we can merge part 2 that will
remove CONFIG_HAVE_BOOTMEM_INFO_NODE entirely.

Tested on x86-64 with hugetlb vmemmap optimization in combination with
KMEMLEAK, making sure that the problem reported in dd0ff4d12dd2 ("bootmem:
remove the vmemmap pages from kmemleak in put_page_bootmem") does not
reappear -- hoping I managed to trigger the original problem.

Heavily cross-compiled, but let's let build bots run on it for a bit.

[1] https://lore.kernel.org/r/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org 

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (8):
      sparc/mm: remove register_page_bootmem_info()
      mm/bootmem_info: drop initialization of page->lru
      mm/bootmem_info: stop using PG_private
      mm/bootmem_info: remove call to kmemleak_free_part_phys()
      mm/bootmem_info: stop marking the pgdat as NODE_INFO
      mm/bootmem_info: stop marking mem_section_usage as MIX_SECTION_INFO
      s390/mm: use free_reserved_page() in vmem_free_pages()
      powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE

 arch/powerpc/mm/init_64.c    |  8 --------
 arch/s390/mm/vmem.c          |  3 +--
 arch/sparc/mm/init_64.c      | 20 --------------------
 include/linux/bootmem_info.h |  1 -
 mm/Kconfig                   |  2 +-
 mm/bootmem_info.c            | 25 ++-----------------------
 6 files changed, 4 insertions(+), 55 deletions(-)

---

base-commit: e9dd96806dbc2d50a66770b6a86962bd5d601153

change-id: 20260511-bootmem_info_prep-bfc0e7a5b87e

--

Cheers,

David


