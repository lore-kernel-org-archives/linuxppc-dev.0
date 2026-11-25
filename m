Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B684606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EX5+p9HK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQjB00ckz30dj;
	Thu, 26 Nov 2026 03:53:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795625581;
	cv=none; b=SmhM/EAlC1isdBN/F/wZsIhEuNl7UvNvHsHGjLlJ5F0QgogmnsTuxgCzlmCiu7wsRHMupxgWpFpw2eE81blHGZHdC5TP+L9pjKGsmIvaSs13UaRAPT/ZsGnLsDJn4uCAF4es4envLm9M0ffL4gjNX+BGh3dfpPilbsziMbMmTV05GCkrEWlzBRr79XD9yu7OaENgZ6ago377Hj1LJPINrr95WNxNb+w7xuDojyG9Kxy0GP7bkPR7H/uH7JmKe17f0PitP58bJphK+ushKjYR7aWW1b6NCM7n6LyJU0hkw9akvrMhbm5xEJcqir8A4q78DhbqYx3HVZ/zeqeUx2uIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795625581; c=relaxed/relaxed;
	bh=Oz7Jwrl1fyQvd1SM32ZV4uHhbma6E080yta+7JCPzik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLq7ZPQBwQ3Ana3Keb3UWITyfyYb7OUL2waBUDcqHfcj6Dg4pY46zSLWtr+HuS90xSdeMSXZDc8xbty/gsqlA6u/wcNN1P4CU9wB4ySEOVFtt+qxImtoaRt1hucvPE4a8ZLD18OWmuuE6O1OdcLpNjc2zz2N3aIWR4S5b9SwbSXmoUDNE9sb47lR1HNo+dyiJ55Lo9HC+xhxn1IH7IjevOto4GHtNoc0YL16zDr63KxKKOLdthabm9kwPFG1StpBBzWjNItaeWF4cRLNu1RMFRo3Zw0ciobIjRE4WW5prthm7vS4+0OTB/fb7Zy21ellGQrDsJxrTC9FxFTsdKH1gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EX5+p9HK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EX5+p9HK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQj92MKjz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:53:01 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-386b8f2f671so3036217eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625579; x=1796230379; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oz7Jwrl1fyQvd1SM32ZV4uHhbma6E080yta+7JCPzik=;
        b=EX5+p9HK46R49XvDJvqAUDwzF0CfXTCFIhTYupJJQDrCvvaizhafaM4PrwQ4I2KQ/T
         T0sPcJ84J0ZlcwgwGzlG0l/KMP6P95PYvwFvCfkfJ+hhmN9YF8GeMjaBCiYUSZHOH74w
         5E37sbBILTZdYPly1s/rB7e8ZrZPv1hVfsL1UXyuIDQ7uWNeCZN/hKphoZ9JCvQTglUx
         oP6k7Q6fAB3tXUUESMSKV/qcQHMxs2olw73BKXX4P8Zo+aEwvbCyG+PSF2aXd3JBt86m
         PtpsJltHOdj10f2p7nMPuGFPMU4Pyz3i/MUf++yB+/4P4WJLkZ/kFepJvD946SazCshk
         2F5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625579; x=1796230379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oz7Jwrl1fyQvd1SM32ZV4uHhbma6E080yta+7JCPzik=;
        b=GAFJsQ6oyvUzBLCqC/Dpnxsqw4EsHu3ZI4Ey5i01258doKwmy3f+X3MN3Qd7JVzPJ4
         eF29iI/nkS7sn32NxB1kvrSzDf8g5hpCu3esOcbvtNer7KVWMD52VNm7V6P1QU/gYYjj
         f47OOigMck2NzUfFP5rlIGM/itCDnArkD2Vmhgs+tjVmAfWffmQAuKbPJtZccaYIMO02
         6TP8IgPqKlmsTTZIlmG541vM5vA4Tbe7wwG20EFQ5TrMp0f8FkgQSrZQNjviOg9fmeBo
         CIE/NmdoQO5VAr2kACj3fwsrgqwrSXUQrhfkdBrfKB8qmd7ilPoWEKbrPCCg/473TyhA
         N51Q==
X-Gm-Message-State: APuU4Z85sNSmEFem7UwZuOzDLeFfPtLqgKzG5FRLHY27s7JA0f3SOqi/
	kjelkthM9QHYTusGhojoRF+PaI2zxCZPi+U6n7mQJJLqLKy5W9WsOaBZLi2qgQ==
X-Gm-Gg: AZFdTZcCGjTsSSjCqqYfxsInaytxcRSksTuOvQekxy5nelhO1DUzQHBcf8qpDDUnne1
	73KPEsPhQLMhVWN8VceYKJqqYkzusyqcQjJo8Y+I+RUIqV24Dp+Vb0aXNJE5Co6xWfjLN3PQuMd
	cfly6pzvFWc2YhJBeaZYPzFEy5qpOr42UHnnkdL9Tx0xiwi8nHi7Lg8MQ67r/x+oLzsfxv+JeOB
	SdTpIwsRyy8eJRUUKFczPHTSMYiSKBXHQzQLsbphGZzDvszu0tCRtZxA+xmQ5JcwQQRGb52IYnQ
	sC/bdjp7hDwlgp4GKYeboPheYcZxb57akewlIge3R8WvBpRm9Lc0+IFNUyG8M8+uk/tSL92ScoD
	PEF+uIwHIaZKmCXBEC9MJnX0S9uo/YeEASvbumWgyYa6sqlyx76PeJ8fQ27apmX5BancR9ZLyw7
	svLeutkWdq5xwFa/cHURJ0uwoJ+CfjicGXcTE3w8f32jIxb5mxbv30cTTQaXTud0SPKOu+wGyvZ
	vDmGsPQLgSMJv7LdpHDtt9IKtoG1Xzc52n9EmSr+skwcBBjyfbtaDgKUazJ+DLgmDgRkFC69UfY
	2vssr5ETxNlN7CTjRLJRzYpZJXVc5dVocg==
X-Received: by 2002:a05:693c:41c3:10b0:386:acf5:b4b5 with SMTP id 5a478bee46e88-386acf5b7c7mr10136296eec.23.1795625579483;
        Wed, 25 Nov 2026 08:52:59 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98545358eec.3.2026.11.25.08.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:52:58 -0800 (PST)
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
Subject: [PATCHv3 4/4] powerpc/mm: Drop PAGE_KERNEL_EXEC
Date: Wed, 25 Nov 2026 22:22:33 +0530
Message-Id: <96692b22febc2c4ee366de072cebb57abd8ffb18.1795625038.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795625038.git.ritesh.list@gmail.com>
References: <cover.1795625038.git.ritesh.list@gmail.com>
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


