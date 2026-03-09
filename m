Return-Path: <linuxppc-dev+bounces-17914-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB05F417F3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 15:19:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV0zq5Ny7z3c9l;
	Tue, 10 Mar 2026 02:19:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773069575;
	cv=none; b=KqkUacd1yNXiALOh1YutszJzhGWyp044Dp1PABrfHgbiDVwnKVjF3MmrQBL61gaMUpOla8HJT837jmq1MbM4EDOvt1ELT9Tl3iF0ZN/AxE/EIjI29Sph2fTRBJtdQEIDXlmw/hTdZvGnY1hoS8BGD4nmWj7zNC3iu5fPb++55WNANuCafH+u/tgCT72epDiapi63sZIdN8JoEQcPctPOwo99qdL+3EvTCVMX0kOFgi2SJHPVdcGl2i0xKY1LpFLrT9eyV/0TI+gXeKG2A+6GaMJY1IEoTaV5Kp5hMWuEgAMwYa9iwEb5I6IJsJHm2ZKHfcQF9C+L7oyXzMBy/KgFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773069575; c=relaxed/relaxed;
	bh=ZfcQPKW0OITtqsF6mlfleo6MJjHr9NFl0AaTRWZ2Fvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDNBK1YASiww+81kY9fGt2ym8O3Rqa43u1YvB4g7bjEIaSoS+aq7sPg+ASm3vAwqjCQKG6oqkdbm2X8ASby3NxmmZK9T/CBlDL6ZPdRiX+gwkvMPEYy8v8W1Ob1HclFu8v5RYW487t+W9UHFT0MPcH13DxUnMqcr3NnJzpv4m4Tx7rrbRKPWVyI6kUegl+ZV9w2kDEzTriE4uaIDBdwtMIWpcvKpMkbmlgtBAeJ4MnDwP8Kc3jrM8D6k1jbVhQfFiOKfzvx+5W1Y8UMbgH3kdsScT2qd1lVAAQlc7CJRJkXYztKgHgpsCdLIFc802yuJQHjviY3KYWb7iXbgN0C0Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U8TGSaQ0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U8TGSaQ0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV0zq0yvfz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 02:19:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9191343997;
	Mon,  9 Mar 2026 15:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70011C4CEF7;
	Mon,  9 Mar 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069573;
	bh=1Tpg8dpXogI43ldKvRVlXnwzZdDW6L9YkP34QCbqGtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8TGSaQ09iR0FrKwfQh/wBeA8JtXPa5xh1Ijd5GD24HH22yWtc+WRIYBBREe/zHoX
	 mim+0F4xyogg6j27YYr6oJKdiXjqBE929wUafl3JTo8XBlu9GK0F3BawY08nMnNnN5
	 +dZqqJk/DQlH12qhxFlRweFgExjYT5kIvUesROaZ4jsW99zDPzXaNBzmbx0Z9pzSya
	 FVcCIb3miryqet2ggbFgd0dGu1BmqGwHdYr/EJT5KzwbLnzwxP6bklbZHFaXUh5xdO
	 wano4BfHvih62oU0ZcLBupR6QdJQT1Qvl6hD0050OGIcjN1HThoOUCGOUqmWope7ZF
	 BXIeXML+1yMnA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 3/4] KVM: remove hugetlb.h inclusion
Date: Mon,  9 Mar 2026 16:19:00 +0100
Message-ID: <20260309151901.123947-4-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309151901.123947-1-david@kernel.org>
References: <20260309151901.123947-1-david@kernel.org>
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

hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
to mm.h.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 virt/kvm/kvm_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 22f8a672e1fd..58059648b881 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -41,7 +41,6 @@
 #include <linux/spinlock.h>
 #include <linux/compat.h>
 #include <linux/srcu.h>
-#include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/bsearch.h>
-- 
2.43.0


