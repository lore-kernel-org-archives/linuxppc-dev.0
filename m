Return-Path: <linuxppc-dev+bounces-22392-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A2CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 06:29:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZwqk1bKgz2y1Y;
	Wed, 10 Jun 2026 16:29:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781072994;
	cv=none; b=J1g+14AvogQhfO5OvhdECGy63YhxyUa6i44dJZXlqpA6qx9t3A6aTSCUPg4OkkGoIpW7LsY3xXh71fnV9lrcgAhF9IguWVa/p4HFEqkhL3FGsM6XHQZ3I4VkrldGLVztFrQ6J/edHNw+RStq7S2fQY4pQLv6YyWKpupXmvruqpNhEWMHpKj5964ga1HMAq8M/Lr6rIF6MU0uUvP6TONosnDM3J7iPOkz0GL3AwQFeNut8zQdT1rsv0k+u3R0PR7oeJapxevYtCGdHtgZD3UiKXEKKfh8360Tvqt+YOAv6iK1hcasRX/fgS3O071CeJ6wBNCrFwC67VA6INIFwQTscw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781072994; c=relaxed/relaxed;
	bh=nXhoKBKFsBSVgBh+Kydkjm+k3Aw/b2vmM+J6r2LJmuo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=XQh/92HJk9yu7SKb9r3Tl2GFlJvPHJbGgm3es17Bq8mmVguIb6lDHP5ufVaHTlu4/BCxTIUZCDhIhs+aJVj6/QmFe2V/OBSf6ahVL8VyGMLHYFUuf4bcmDGFt0oHDU18c2FjjHSDga5s2iwaaI3+2RpA1FR7boxuZ8bGAeSne18OewRt5Jj1Kvq7uSSaIrFBxn0eUfvTnD2ELEjEXlsvzABQ8kUtktWtMwEVMn5zTpQt+WrikRVUy1t15hjaB6+bUmSX/j2rr5uljOB7GI5sfV9PXQygZxzZLtJXqU268vbA/56K91WJJDUIf1u9g/gzmOciLUVCO/0vBtwGSd6BxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HvozhdCN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HvozhdCN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZwqg6R6wz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 16:29:50 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c859a374903so2238173a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781072989; x=1781677789; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXhoKBKFsBSVgBh+Kydkjm+k3Aw/b2vmM+J6r2LJmuo=;
        b=HvozhdCNNebcepdhrhWJf1K2BcCs86MhommLXOZV6tu2rgaGjk8QLLKgWzUVQbnSrj
         th0X981+KZOcQ2IeU2tYe5XcGhXIIVv/LAEW1NbI5ylmRidqtk7XmimhDFWx7XVu191J
         Obpzzvju9fvlAWy1MiOvQTZLwh+Lf1ll9vTRZuBeiEsMoQZdk0cZ4ehf2yiw/PPC0EL2
         3fmOdw/jouyOQvTvo0DEIQ4aFiJIidw61QG174fN8zQUZmKivbRpyEwYN0aF4hhV3Sx/
         uqlDB4bPxaj6CShJqhdtl7K8xqDYbi7wbevYTuxzeE5JSThQw5Z906mV2dSGBZL6Qp/h
         U25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072989; x=1781677789;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXhoKBKFsBSVgBh+Kydkjm+k3Aw/b2vmM+J6r2LJmuo=;
        b=bl3cAg/SkCP23LKgVtRNbGUBhBrknOexS9GGuht56X+9LBO/Nn0F+1httUnDwwq5wS
         C77VPhgZqa33l18qLcYvU1jX6EDmAjSYzsb0DA0snebOun1nvPd8fY977eb8lnMPD0rD
         E2dPSAO327Ml5wNdlb4Z5KX3qfbI90dwU69UuOLVveBBVyVbVZfc4SXbdinO7Ha1IHya
         n6t6MGiQtgNtQqZZ7O/jRLjltfK88jIdR2YZnImFhV+FgAB4rTp7RRrQtkPyZu03kvma
         ZZrjJ6fLMaiUGYd6yX478PDuQly0XE3M1lDpYC2j1hMP+SQ7OPJfMq1VoO6CVMoJ5Err
         z1Og==
X-Forwarded-Encrypted: i=1; AFNElJ9jLHv9fZORb3fPruOMFfCYtUA3ros+tLd61AYzm7ES/XO1rT4qvs8/LNQ8dj0cTsHPgLpN9EhVAXm0AIo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1NoB4P+YHV03Z3W4R95+ZpvPFZBEQlZ1puT3V76rJpTF+0QCz
	rrzeSAyXVsM1oq+JYIv1YqPoRqLAqQB9Ls/dEziZHbvT8Qw01LsCYZq1
X-Gm-Gg: Acq92OHb/AGO5p7NmhuG7ovCejTN9drbFx7aPbqs9O6bYl3iE2/oj7arSjcgpDbWoWi
	Lx+dubWxCfu5m3KBm20Oyu603oVvZ6zqFAb2AXljYu9gu0TgluWOwCR0MtPIfL+jm/+Rq4TM8EK
	hckOuKFSe7XXIw75ykBb+mNFRpQZCQfcwKBTTLX3++mUpa4PTbXrf4wADeobU5DX4UYXGmuTIpV
	D07EC/iRdeOZnBONSVGN7Ktyh7OoDJ0c8rzrV14BOX6a+ibuQmnhTu+7wwGDZaJFz4vYCX3epPX
	Garkr+1qiKYJQBOQbG1S9jdvvsiv1Fe1XfUH+cj7G47UY8SuwGZFtoT40rpEkqTMzapLmfPzXQO
	WNNxe3heVeb0XfTdTKdFbF51Xt/H7NCq/Wbtb4n5HuCLfRrMARKs3XUveQEGBAJglA+UUEfMblZ
	P1e5+PVi1tXbzJQctJvWyalPhx2EUHneu0
X-Received: by 2002:a05:6a20:1615:b0:3b3:1951:489b with SMTP id adf61e73a8af0-3b53bf75f2amr8504650637.45.1781072988909;
        Tue, 09 Jun 2026 23:29:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04a0e9sm17535932a12.13.2026.06.09.23.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:29:48 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [RFC 0/4] mm, swap: Enable THP SWAP for PowerPC Book3S64
In-Reply-To: <aig3PFm9jst8cHxn@yjaykim-PowerEdge-T330>
Date: Wed, 10 Jun 2026 11:00:43 +0530
Message-ID: <pl1zdksc.ritesh.list@gmail.com>
References: <cover.1781000840.git.ritesh.list@gmail.com> <aig3PFm9jst8cHxn@yjaykim-PowerEdge-T330>
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

YoungJun Park <youngjun.park@lge.com> writes:

> On Tue, Jun 09, 2026 at 06:49:30PM +0530, Ritesh Harjani (IBM) wrote:
>> On PowerPC Book3S64, MMU is selected at runtime, so macros like PMD_SHIFT are
>> effectively runtime variables in the Book3S64 code. THP swap code uses these
>> macros for e.g. to size some of its array data structures based on PMD_ORDER.
>> This patch series makes that usage dependent on the runtime variable.
>> 
>> Sayali did some performance runs of this on Book3S64 with Radix and it gives
>> 40-50% performance improvement. We also plan to run it with Hash, will soon
>> update the results.
>> 
>> Note that this patch series is based out of linux-next (next-20260608).
>> 
>> Ritesh Harjani (IBM) (4):
>>   include/linux/swap.h: Remove unused leftovers
>>   mm, swap: make SWAPFILE_CLUSTER runtime
>>   mm, swap: make SWAP_NR_ORDERS runtime
>>   powerpc: Kconfig: Enable THP_SWAP on Book3S64
>> 
>>  arch/powerpc/platforms/Kconfig.cputype |   1 +
>>  include/linux/swap.h                   |  17 +---
>>  mm/swap.h                              |   5 +-
>>  mm/swap_table.h                        |   6 +-
>>  mm/swapfile.c                          | 132 ++++++++++++++++++-------
>>  5 files changed, 106 insertions(+), 55 deletions(-)
>> 
>> --
>> 2.39.5
>>
> Hello!
>

Thanks for taking a look at this.

> Instead of making SWAP_NR_ORDERS fully runtime, could we set it to the max
> PMD_ORDER possible on PowerPC Book3S64 as a compile-time constant in the
> swap.h ifdef block? (My assumtion is PMD_ORDER max not too big.)
>
> I think the general runtime version adds cost. It impacts all other archs.
> percpu_swap_cluster needs a runtime alloc,
> the si/offset and nonfull/frag arrays become separate pointers, and some
> accesses get one more indirection. And for nr_orders=1, the allocation
> itself is just waste. 
>
> With a compile-time possible max constant, the only downside is some acceptable amount of
> wasted bytes per CPU / per device on Book3S64 (the unused entries in the swap
> offset cache and the nonfull/frag lists), with no perf impact. the perf
> improvement comes from THP swap itself, right? Other arches see no
> impact at all.
>

I looked into the memory waste comparison between static v/s runtime
alloc. And the wastage for per-cpu alloc data structures (with Radix
MMU) will be 0, because we use kcalloc_node() which will use kmalloc-64
slab. So slab padding would anyway add some memory waste. So it is as
good as using static arrays with some max PMD_ORDER for the
percpu_swap_cluster.

For the other lists you mentioned, it anyways adds a onetime negligible
cost which isn't worth for making SWAP_NR_ORDERS runtime. 

> patch 2 looks fine as is. SWAPFILE_CLUSTER backs much bigger per-cluster
> arrays, so runtime sizing makes sense there, and it looks like no impact to
> other arches or the current code.
>

yup. That make sense. 


So, unless someone else raises any objection - I will give this a try
instead of patch-3 in this series and will get back with v2.


diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e67e64ac6e8c..57abd8b2c9a1 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -204,6 +204,9 @@ extern unsigned long __pmd_frag_size_shift;
 #define MAX_PTRS_PER_PGD       (1 << (H_PGD_INDEX_SIZE > RADIX_PGD_INDEX_SIZE ? \
                                       H_PGD_INDEX_SIZE : RADIX_PGD_INDEX_SIZE))

+#define ARCH_MAX_PMD_ORDER ((H_PTE_INDEX_SIZE > RADIX_PTE_INDEX_SIZE) ? \
+                               H_PTE_INDEX_SIZE : RADIX_PTE_INDEX_SIZE)
+
 /* PMD_SHIFT determines what a second-level page table entry can map */
 #define PMD_SHIFT      (PAGE_SHIFT + PTE_INDEX_SIZE)
 #define PMD_SIZE       (1UL << PMD_SHIFT)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 46c25523d7b8..5f1451f8f266 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -224,10 +224,14 @@ enum {
 #define SWAP_ENTRY_INVALID     0

 #ifdef CONFIG_THP_SWAP
+#ifdef ARCH_MAX_PMD_ORDER
+#define SWAP_NR_ORDERS         (ARCH_MAX_PMD_ORDER + 1)
+#else
 #define SWAP_NR_ORDERS         (PMD_ORDER + 1)
+#endif /* ARCH_MAX_PMD_ORDER */
 #else
 #define SWAP_NR_ORDERS         1
-#endif
+#endif /* CONFIG_THP_SWAP */


-ritesh

