Return-Path: <linuxppc-dev+bounces-29097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C91CA6019
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 13:32:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1STQ6kGxz3048;
	Sat, 10 Oct 2026 00:32:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791527804;
	cv=none; b=R1Nxx56RotJGaZnfNm42ej4BeZ4/XgVEulWhhge5PyVSk0qoCLUb5/kFMOjPSlVIdsEupjXP5HC7vrF5ZONG0UxjHf+F02nMWSwKrTlpmYbKJxN+gM0EBNZPJq7tweyQc121IG7M5hfNT9ehnbl11djTYi1ShgYA4E54mVnCWGOVreFfRs47ZgFPTlNU276MVTxsyhSUSLutweQIblxiwD3o5yjloW4rETDeV5EGTlrA0HPXJAEtrPt2+0lugqeC4AVFZbwlL+WUWmA7MzX+ApjxCw0/mvN96SA8c4zj/U6wu7X5f1R1CRTeUsNW+j3OceRo233sPgKLim8p38+QEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791527804; c=relaxed/relaxed;
	bh=Uh2O0hPc7+AfgiciCPNYS5qtLSlalh9WpPtHIZy4QUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRRqLKxI/ze8zBWYEcggJQiOI0CWR462iPzqwAHr6Kd+UAQrCzZ/OUFzBf0VWvDJLYWxAfmkYLokjqSj8PuA67TJb9wKfq+WVuHMATy23Cb/zSzRhN97FEy0yjdLW5oB9I/XLILcpn/C0aUY1B9c2wJLqsmL2B4kgc8FEvoLgcBstBtu0da5cNqqyQPTopGnMsNOPpog0yQg7NRIHhxpSCbqgfvnkJed8pZqrIZMNWwKbXlwgKyXHRjJ1B5fUOlqzLk6axl51un9apLC6ZMi+2nf9PncA+J24HDl+weW2KQPs2a0293sk+RmKkZGCht2yJnb25QZznGPhvxlvbx/Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tq5jaOpF; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::2a; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tq5jaOpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::2a; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 61 seconds by postgrey-1.37 at boromir; Fri, 09 Oct 2026 17:36:41 AEDT
Received: from mta1.migadu.com (out-42.mta1.migadu.com [IPv6:2001:41d0:203:375::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1HFj1wjcz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 17:36:40 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=XX490udm4Ta6ALheN6Xuua3sT0ZXTpdEDmRJNuiAJBs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791527782; v=1; x=1792132582;
 b=Tq5jaOpF3DaN/KjM1sTJ9Kt+qtUR74OOFPzsUK5mu/rJy7iP8nwLZ/U5qbYT1NJrDtUpI0m4
 Pr3i264mbDoSlhbZEgkdKDC4I4tpufbBOvXapzekMxm/smgT4vG8u5GvDFPRUlx8gN8+xMFt9tz
 I0h43YIcNzUzCi+1GNSf+5t4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id a2f462b3a15301f0;
	Fri, 09 Oct 2026 06:36:22 +0000
X-Mizu-Trace-ID: a2f462b3a15301f0
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Hao Ge <hao.ge@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] mm/percpu: stop unmapping the CPU that failed to map
Date: Fri,  9 Oct 2026 14:36:19 +0800
Message-Id: <20261009063619.112313-5-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261009063619.112313-1-hao.ge@linux.dev>
References: <20261009063619.112313-1-hao.ge@linux.dev>
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

__pcpu_map_pages() clears the PTEs it installed when it fails, so
pcpu_map_pages() only has to tear down the CPUs it mapped before
the failing one.

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/percpu-vm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 509d8901835c..59d3a336a6bd 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -252,10 +252,11 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk, struct page **pages,
 	return 0;
 err:
 	for_each_possible_cpu(tcpu) {
-		__pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
-				   page_end - page_start);
+		/* The failing CPU's partial mapping undoes itself */
 		if (tcpu == cpu)
 			break;
+		__pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
+				   page_end - page_start);
 	}
 	pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
 	return err;
-- 
2.25.1


