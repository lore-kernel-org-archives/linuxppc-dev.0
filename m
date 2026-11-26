Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790A606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 04:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNmY1TG9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZk5S3Kqjz2yDs;
	Thu, 26 Nov 2026 15:26:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795667196;
	cv=none; b=OjI5OT+nxkz45F7YVNbOEdHxM+kihYGtZGb5j2oU7zTLsOVu1x/zQqPG0Msi5gXye4I/U1ap6h7NHc3L9G0bwN+D2lwDa97sstExUgVjtbTmCmqufbbn7ZrxqBZkztmhx4kVT8P/V2VKsWYzOD+/AyrFrLymy9hCWHYKKpsVDsUHbXudkyodwsXioH9txge7facsCSernEsODP1ZhL2W8M1eEi34yhiyzn8FWnO6ZIGTfMU36Cic0Di/ZDIjCM32htFodHNFFntfCHcmmN5x6t7Vx+XLKIcSe2/qx7r6oZasms4Y2b8ynThZGN8R/576CdUMUQ6ph/N5hincnYRz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795667196; c=relaxed/relaxed;
	bh=578266K/EmAtCgk1nwJlNHTzXTCrOAsEpFjzCSiKLP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9lBUbwX/40ZPHvEG3DVt7uwm+Fyf4fubDFNgdT1+AfrrKntuVfu8t6yIO1q2CQG6wklfaL1c7LWztGLC1k+uDs96r0yPlyHOpYRDFlmR1LOXuhUuXit6NPixh874JoaioSuZphjOTuxleuKSEs1MEqAIiy77AR9d7BKYB34BnV3Zq0kmaOoWhbHMIUZeeYwR4QFLtvg7UsKIhcTvglYS4NyFP4a7Nn6qQnY7HSG1LsBZHWB3rraCm0CzX4+lwEwyDgrAd52WVvAdbrU8uvF53MG9Ewy749BcXupOHmRBbrSVsh5BGAP8y1NhY+M8SIJWI7dRxd9nmX0gTgfKsjV2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNmY1TG9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNmY1TG9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com [IPv6:2607:f8b0:4864:20::122d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZk5R69yvz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 15:26:35 +1100 (AEDT)
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-1a3c08d6928so9771873c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667194; x=1796271994; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=578266K/EmAtCgk1nwJlNHTzXTCrOAsEpFjzCSiKLP0=;
        b=BNmY1TG94l80qEAXWd+4G1zgZBwd2uqBFVIB6IlcNW6Zzw1Lq9Gv/dcaqPsrLeNtBr
         H7zKIYxi1GmOwZRlc7Od+B70kDm1s/2L7sfU01JJaFJdrYWwQBrsI7v8PA7B0tnRNmZb
         WkFBcABxb6rk4tInKU54k+mF6U7pa/g+wM58F9FNXn7v7PMbth0Zm799jvEmLByeB992
         aga/pPO4jTlK3SADfMktbBHftUfxPWCNtNi4xL3f5rs3DmxOaK3AwrjMk9scpSQfui42
         wU8vXttCBKT/z/sX+aGjE3WBeEY7BSAGW/zW0UbfRtZ8Bx5tqYya++3hRUOIrBOgxK87
         zjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667194; x=1796271994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=578266K/EmAtCgk1nwJlNHTzXTCrOAsEpFjzCSiKLP0=;
        b=KEcWc2Jd1meZU86WcrM3lyTxvHTCEJkNAXpCBAanHEhYsb+W+yZFCY5iVzIbEAYl1z
         TiOpgNjlKcBdY3Lh9vHR2xQAEiYJR5pxU8wOEbj03vicHb2uIM62Kf3iPXQS5izxGMZB
         FT5Pqw6tl3t8zDat07uaBVvi7N3BwxgmAdERX8+Zmn9+zahUXpcHz7WbcNHGMNgw8tVO
         6YHt37NcuM3tbODfeIM7ZmMfDinb+Yp+wit5WvUaahHgMjGOa0VRZcIeqIqqvXUwVqFF
         MJfoitTHISD03K2bDF2N1L9I6zXGAGmZ3kYDg+GcoLgHcPQs8Zbbb87AwPjheNxSSUuJ
         ze9A==
X-Gm-Message-State: APuU4Z9VqsCAKqgDp0TOTZm6Ee4wCzDmULbOZzToaNOg8bPxsH954Jee
	4KbEqMgdAAYsDd9JFMCk1KRichzB4DNEpF8hgCEqO737xZOHGFr5OHhcusFVtA==
X-Gm-Gg: AZFdTZfWdJhA39lp82Tk7/LLt/Fuc2wJKwclIM5SDjYy5FbGgTozrJscTfA5aMUcRPw
	iH1yNUqOEQZjHSBmTl4pR6yAb1EXDTMohAIvvu0PSCNJE7drmx0q3zh7Qfhk+UFXgCOmJW3OrcZ
	fEROGUjMQZs/I9OCV23d9i7JH1deODgFfpISWiekAb3n2d/4bAss+kt4v/mXKD0mqIXN6Q6yYIk
	0ksTjhaWZPAIszsi7Dl5gkdzOoCiwUl10KItQ2hfaUbf3jEgibWRTfGuaBJY65H5qyX5SkIELFU
	pa0G38OjIMwxgYQwQYvBE0bZ+7ixpG+FxTx+4Oos3srI0N3mHz6u5lJhBgU1vHiZkk1mm5ZNNH4
	r9k8ndolnCAPiJGnykHwhur/Gh2eb4esf4yQMnzegW3L9XQSv/b6QlIBjOnnpcwboHdHNfGtj3Z
	skqPB8Zoyv5WCospZqkO1R73Ry9Sg6mF7uszPec+5aivT3OjdU6OnQ4YGbtNuUPKrEohsbDPfKA
	5CqdEV/u9orNyojakP37Wk19PZC33zhk1kayd7wcAKusKQ0jQ+dGtEU3UGXdfQ9riBI31w5h0zk
	g4ev/RjZzF5K5EjZzBR1tIrtJHGDT+8Ijw==
X-Received: by 2002:a05:693c:8803:20b0:386:9b9c:ef1b with SMTP id 5a478bee46e88-3869b9cf99amr15008373eec.3.1795667193709;
        Wed, 25 Nov 2026 20:26:33 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54542185eec.7.2026.11.25.20.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:26:33 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 4/4] powerpc/mm: Drop PAGE_KERNEL_EXEC
Date: Thu, 26 Nov 2026 09:56:02 +0530
Message-Id: <24f9efcebdfed51d3048bdd4642b8ba40dc01c2b.1795666663.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795666663.git.ritesh.list@gmail.com>
References: <cover.1795666663.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On powerpc PAGE_KERNEL_EXEC is just an alias to PAGE_KERNEL_X.

The comment above it's definition saying
	("Make modules code happy. We don't set RO yet"), is stale.
Since commit 4fcc636615b1 ("powerpc/modules: Make module_alloc() Strict Module
RWX aware") module text is allocated with PAGE_KERNEL when STRICT_MODULE_RWX is
enabled and only made executable later, so there is no longer a reason for
a separate name.

Convert the remaining users to PAGE_KERNEL_X and remove the definition.

No functional change intended.

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/pgtable.h | 3 ---
 arch/powerpc/mm/mem.c              | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index d20ff2ae02f5..ea06a85f0fa8 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -20,9 +20,6 @@ struct mm_struct;
 #include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
-/* Make modules code happy. We don't set RO yet */
-#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
-
 /* Advertise special mapping type for AGP */
 #define PAGE_AGP		(PAGE_KERNEL_NC)
 #define HAVE_PAGE_AGP
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8a0fdfd028dd..bc83e45b7ae9 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -388,8 +388,8 @@ static void prealloc_execmem_pgtable(void) { }
 
 struct execmem_info __init *execmem_arch_setup(void)
 {
-	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
-	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
+	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_X;
+	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_X;
 	unsigned long fallback_start = 0, fallback_end = 0;
 	unsigned long kprobes_start, kprobes_end;
 	unsigned long start, end;
-- 
2.39.5


