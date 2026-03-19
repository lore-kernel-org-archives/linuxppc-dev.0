Return-Path: <linuxppc-dev+bounces-18435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9BA1075274
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 08:20:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbzCK6f3fz2ykV;
	Thu, 19 Mar 2026 19:20:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773908413;
	cv=none; b=fPipcIjMK9ebRRrv6rFCwb77N+zuzs7083QwZRK6YyVjaXUeMPn5Ba0UIG279DDAtzkB7cVxIzvceQ0ohtipgle2y8O5eHflyuqehEsyaY5M/k8+Xl7p7sRLbpIjyHziwayAuwV7ZMQeaD5d++IJwey1ebHSdeMx315hKtqDIPrMrgIQ/L5xzYSjDGiWIgbrv2jaK7RGN0Q2A+IX2AZcEVQUrbO5ftbKe75+FyDscL9a972BT9c4cI2OlUT83jr9KlQWKa4m4FYcQDVe5faE1oCvl5eJd3X+7ISPMx61JS+kgDdRf2tsI7hVK6sLEAEHlcPveJEA9z/FbvEWUqslfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773908413; c=relaxed/relaxed;
	bh=9vONOIrqW/UJkG8W01y5FtYV4fnBAGfruHFEOeSnnYw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hb+hAFKeTHzMKKGz+T+gGTqUUK6CKNwdX+WF7F1DDIvQVCdQA+b0dKJOQ7Nv6fvtFrRgh0sFxL1ZGHSNU0/FHq8GCvgjHR0xVmUvzVgn/awm3G5+XoBIqnCgYfaEiBc4bx9Amcg1+P04MbvXL25qKcn1/wTXZvzbr1o3ZFjX+t59EaWzYDiCgtWxUTYIvp7MR1G/j659GGh5yKcTjJ5AhJyUg4flqeCj0eW8gzOPYTcTI366CshW/rXW/6zi1RGtyxhzIiKekWdn0iyRVegIBrjDyzrPuJy2UQJ5YzaBc29FYmUVlmXwCwfThZi+ijeRPoygAXfowxTKJYxj7b7Itg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nW9ab7On; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nW9ab7On;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbzCJ1x8Zz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 19:20:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E02D43D39;
	Thu, 19 Mar 2026 08:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B1C19424;
	Thu, 19 Mar 2026 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773908409;
	bh=GAQ9b9edKTgGxU+mpQzf5vrvp0GbZiNpB68nUzbzDyY=;
	h=From:Subject:Date:To:Cc:From;
	b=nW9ab7OnkN7S00RxQQ6fV539CUU/HXaHfFwpCsfjk1vZa9nrCehAKXmvHkrdByEwi
	 UTuF8w219c0gp/9PlGkyTjPCXYgHMu+wuB+VcuJDOAEMR4YYArxHQyQe1bdwRE69iq
	 6KnzMuHTxJ83BywVs82C5DCGxHXYPZw/XiMZC3jCTCs7Ed7M20epXUlpSA58uZXblU
	 VhVWCftNRHTP6Wysxkep+z8UHXRrW+AIwQJO/Iq01wPPGebHyKnPiUVOyGVPTWywxV
	 gA0MkkSVRuNWrkUsu2BUt2gfc0ropCqtacyuIkXHK1ZCQaGyBOonZgNXG1/Y1ey4xt
	 IYgm8NZf2LthQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE and
 cleanup CONFIG_MIGRATION
Date: Thu, 19 Mar 2026 09:19:39 +0100
Message-Id: <20260319-config_migration-v1-0-42270124966f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAJuxu2kC/x2MQQqAIBAAvxJ7TlhNjPpKRISttocsNCIQ/550H
 JiZDIkiU4KxyRDp4cRnqCDbBuy+Bk+Ct8qgUBnsZC/sGRz75WAf17vKQpuOFGpEPQxQsyuS4/d
 fTnMpH8Y9x3JiAAAA
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-mm@kvack.org, 
 linux-rt-devel@lists.linux.dev, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

While working on memory hotplug code cleanups, I realized that
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE is not really required anymore.

Changing that revealed some rather nasty looking CONFIG_MIGRATION
handling.

Let's clean that up by introducing a dedicated CONFIG_NUMA_MIGRATION
option and reducing the dependencies that CONFIG_MIGRATION has.

Heavily cross compiled. I assume these changes are fine, but messing
with kconfig sometimes feels like playing with fire :)

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (2):
      mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
      mm: introduce CONFIG_NUMA_MIGRATION and simplify CONFIG_MIGRATION

 arch/arm64/Kconfig           |  1 -
 arch/loongarch/Kconfig       |  1 -
 arch/powerpc/Kconfig         |  1 -
 arch/riscv/Kconfig           |  1 -
 arch/s390/Kconfig            |  1 -
 arch/x86/Kconfig             |  1 -
 include/linux/memory-tiers.h |  2 +-
 init/Kconfig                 |  2 +-
 mm/Kconfig                   | 33 +++++++++++++++------------------
 mm/memory-tiers.c            | 12 ++++++------
 mm/mempolicy.c               |  2 +-
 mm/migrate.c                 |  5 ++---
 12 files changed, 26 insertions(+), 36 deletions(-)
---
base-commit: fbf55982f31ae6aa11f890c36bccc130ce70a312
change-id: 20260317-config_migration-463e20400499

Best regards,
-- 
David Hildenbrand (Arm) <david@kernel.org>


