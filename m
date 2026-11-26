Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165D606A683
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dx43PY55
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvJf2G0gz3bQl;
	Thu, 26 Nov 2026 22:21:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692114;
	cv=none; b=Wtsr9p3o0PB65dPtAYZge99YmAbRQpfZ2sfnSqouz7/T7mYouw7HFocJrlmAyLMl5kma94EccHbC2MzatONzgAsZ7vK/PLug/UJEDs5eLcAEE8GkDBbXIx48oy5t2zZpgBbWoZiEMEPs5VKhEQZGRaRH/Q6UqQiwreRh81QgvwOICo6Nz/1gZ9BYlhLUl4sEFX2CN9Cs73EKieku1I6NouqQm7lOEzXmy1jUNK7gbD7botpElgJKMBWLBqWAvnytnlU+vhWLLV2q03jh/WDrY7MGq5YUQ8ykWh/elBEMS/9qeBmErdEJCB7hXeOHhapF2yzB2nfG4R7Om0GDbNS8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692114; c=relaxed/relaxed;
	bh=0iJQZ4JiZ/q2z43yM7sOmznlEhFue5dKtH3ZUaEt9EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6ky10LFl6yJRwoArQnyNWhbWszN4MqtcPvObufnzmg0ppIGnZtwcksFBy5iAxS0rkBQqgjjnuoXQyQboMjqIg4EPHnG+eBqX/yjCqk/3LQqBHkeVv6OuwthYsc5e6z65Lcd9hJB9AXN7HuxfIbPUt5ojlO9Z/bOf9jkRzBSM9RNLp0jOCEyapouZCs0bs6Jzink4TtEcsmccU5s5wUw6EqrJ41o749R5+N+1Tg8VjHXOPdbSfsTjJOzvQ9PwRr58/BgpKXZgH7zgVE7oHxk4FVFUglggY9h7/2P9dM/npvNC5YIpqK0wI9S+bgu205VAzsDOM9oDt+snHSRShx38Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dx43PY55; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dx43PY55;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvJd51xdz3bNw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:21:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CE7B76338E;
	Thu, 26 Nov 2026 11:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016FA1F00A01;
	Thu, 26 Nov 2026 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692111;
	bh=0iJQZ4JiZ/q2z43yM7sOmznlEhFue5dKtH3ZUaEt9EQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dx43PY55rPzSGwZLE10j3vMNvaChqjvukI+hPnb8O51peEgCTLD7xqLTbXfhZ4QnH
	 7pS+CZwsAXWfxbp/4JWBDp9do/VBawZXTV3ccWCbpuxUm3w6GIXCKgzhyOTodD89yQ
	 ebb1YIe3iMbTjMMO/txFQf9GfMmJqyzqek8CWJtoABUH/UGA97XeGs0zu1baThNVfB
	 qDDME3ZyjhYMlfHBuGiRumtfOFkh2Ov+xT0sD1dGDygGZA0oxdLDYurcRO0mTEOe5u
	 Z6FZ9HTm6ofPbgw7bA+4BeT2anx67vEy634jk1w4kSn7Xl1XzAFdMJa49y6aHSgZNL
	 iNMGCJcVGRqGA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:59 +0200
Subject: [PATCH RFC v2 46/54] s390: remove set_memory_rwnx()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-46-723f1e33c3d8@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

set_memory_rwnx() has no users since commit 33bd8d153c33 ("s390: Keep
inittext section writable").

Remove it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/include/asm/set_memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index e3562bf0c1aa..23987b721ed9 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -57,7 +57,6 @@ __SET_MEMORY_FUNC(set_memory_rw, SET_MEMORY_RW)
 __SET_MEMORY_FUNC(set_memory_nx, SET_MEMORY_NX)
 __SET_MEMORY_FUNC(set_memory_x, SET_MEMORY_X)
 __SET_MEMORY_FUNC(set_memory_rox, SET_MEMORY_RO | SET_MEMORY_X)
-__SET_MEMORY_FUNC(set_memory_rwnx, SET_MEMORY_RW | SET_MEMORY_NX)
 __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);

-- 
2.53.0


