Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E2606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgm6ni1b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZv9W1R3Vz2yS4;
	Thu, 26 Nov 2026 22:15:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691743;
	cv=none; b=mROIeB/6QyHlp3VoIwWEgxwiGGjMqu0IBfZu3cpHzA+xsnRa0JllnPW0dA/8ftqUQXHRe6N2uNRSz3V8SCCJE5jtLQykpqw2hcm8nZNLyf6U9fBf5oAnYPuCNKosYBgGl15IXxihZ8Os4nmnpwoYMjiHbLX9AOVJXwJSefeMi8Tp+aVPKf7zo8SCe3tOQ9RLyaDJ1u4GrKKUKRKGhd3TYbg8M4WLNvADsA59wzU6acIEPY39lb0BjG4HzM//xtakdH7LjiMHYWV1U0aueAYH8L1vac5Ie3HuxZHfrWaDrTxkCpqXXHn59Bc/loCTdBJu+No04ilyZc3s19XXFx+gWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691743; c=relaxed/relaxed;
	bh=nf8Dg1I8n4rgs3e9w7cnbg/z5iiBQqzebLGhMMMtmX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d2F88ft4fqXi7LAc3GA6jKOQdG0z4w4qSZjl1us68ZgqYbYgZwQq4KU1rnCJ+h5ic9B7w/ahyUFX0JkhgvzZ/2fEyApAEwNP4WOqjX4g/ZCbs0tJ/85g9DZkuiMHnY7C2D8C4d5BijRXz7Oc5rZI8xlGo1nGC+DRpVIioDV07DjXpLb6K5tRoakClt6h+4b980K5b19rfB6NSUTGahpOY8xnBhXQMDI9JYpLrHYG+pzB7taNm2NPTkiYBY16ke6vz+8B0ERbjEENTIbraJQxRhNkFVDsEkbA9TX/mc+QQX38Yg7wBSuUsrcF2PFyx/rpauB0bJED/EC5J3kqFLbmwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgm6ni1b; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgm6ni1b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZv9V4hR4z2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:15:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2761740DD0;
	Thu, 26 Nov 2026 11:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AD91F000CA;
	Thu, 26 Nov 2026 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691740;
	bh=nf8Dg1I8n4rgs3e9w7cnbg/z5iiBQqzebLGhMMMtmX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dgm6ni1b4ATvsu8fOCDBBMC4Gh77ed8M4GQRbcomJQs08awcbabF4eaq9qmXy0gqg
	 JJvtmZ6YrX89lCG0g6pPuy/2dFSN9kOM6Gz56GcV7TnzjNyrWyS3PFur8FPZpE2ffJ
	 2PgnJyOJTT0Z8ORoOShyglFN4IjkQlALevS2VfUB8S9Zi/qhrGyEus3D7slbTIChIB
	 T2YrCvr7+p4qI96CGgok8isNnhQgrbn9k9y9zWEv2CeyRtTpAMgS4KW/4gxjfHZ5iO
	 2mcAZCh8kqAsGsfpbwo1eszlrG4UjdQZeusc0Ba1auKtD460X+FDVjWIcghsrzOaJg
	 GkQEntGvSaGjg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:20 +0200
Subject: [PATCH RFC v2 07/54] x86/mm/pat: drop KERN_WARNING from the WARN()
 in __cpa_process_fault()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-7-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

WARN() prints its message at the warning level, so the KERN_WARNING in the
format string is redundant.

Drop it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 42f27d60adf3..db41f94f2355 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1835,7 +1835,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 		/* Faults in the highmap are OK, so do not warn: */
 		return -EFAULT;
 	} else {
-		WARN(1, KERN_WARNING "CPA: called for zero pte. "
+		WARN(1, "CPA: called for zero pte. "
 			"vaddr = %lx cpa->addr = %lx\n", vaddr,
 			cpa->addr);
 

-- 
2.53.0


