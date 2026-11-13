Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61F606A32D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdhFbRq6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQkp76zdfz30Wg;
	Fri, 13 Nov 2026 15:30:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794544239;
	cv=none; b=npoFWXfd1JurfWELIpGLtsZf/eVwhHB1v2/Rfh48Q0Vggixtf6zsizXGVpjf99odPu+HP5sJ7bpydujQG7jWS+mqun96x6K1tnnNAgcafYz9aEAD/fYKfEV4sYOwo8l1/TGUIqUhgRn53jPGaTq37ugNtWnHGorJ+TjgWPfiY/CQRaCnRQpKJVBfCPVarUUPd54E/jt17mHsKFHZbRBgpewJjoRWFoj8pq45dAjFs7M6rcRtgl0eyxNqMLW2122jzvP4LlEiKJBkIrQbolvRABtBi5HB6PofjPxAH8pLaxl3FJx9LgauWcoBdDY+cUSZsVGXF5B87cBG+X//ZpSQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794544239; c=relaxed/relaxed;
	bh=WVayaF79KuqXR5beczcnmlbf6rAuqOBk9ycmEbTKdrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRfvegr3sB+UaZtSXzkCuzNyTyBbJBfKqYMbvZ8SkWebnrJRLPX2xNEAwvAhgguPDPFji9jd5iICQZmoYHdQ/bEQd2Z5+QR0YOwDIRtxaJHwev258Fk3G0m2cQqYuzLnaQC8RfG/CQDxOFkFhaH4ZH8+z/JBCo38bwRpwp1DGIhVs0Y+1YMVS56lPqenSpHUCP++Xr5eswX7z4LNzjMm4xAp/cxTVCe3R3XdXWcF+J8iMsnvlEEyGmd9YcGvI3Ot8PzLhzUH/BUMwq5mTxRZfl8OM8TKKjDULt8VEE2nvI1JtJyR4FHUxrfw3MCuSkhaDEMn0mmt3VA0F6QfgM27eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdhFbRq6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdhFbRq6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com [IPv6:2607:f8b0:4864:20::1230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQkp64Nphz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 15:30:37 +1100 (AEDT)
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso528816c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 20:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794544235; x=1795149035; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVayaF79KuqXR5beczcnmlbf6rAuqOBk9ycmEbTKdrk=;
        b=VdhFbRq6/0JGD9ebYkUFmYtteQOh0mTVkTQ2W6K6IcpRxcT8epecQgn4AJjD4/tEjS
         PvzcptZr9hLLXUevAWmySXP/MDTY/X6MBY2ZpkGvLUw7kqjzX68KYWccQ102ig8ntDNU
         KZCIpbHsKtoNt/jsjTFR8c92F47pv4dPKTAIFwUCMD6kWaYhcvW1xJtJVNyGMYJZ7NI7
         y8+Hw7vBkDUrhZNySP0hI1hiyT+3hLxLClDp+lwE8+1cIWPKXgFE9WiEqHOTJGBHoe75
         B0YuRv46B6oKloevzjJawAHC4cXjpwydFKzvWu6Dm/0vIMtpcmK1dRANbv5GDbvG5k8L
         8T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544235; x=1795149035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVayaF79KuqXR5beczcnmlbf6rAuqOBk9ycmEbTKdrk=;
        b=wyQq3mQiZxVe5klu4RUpi15zAV+VRe7TVMqvNDZ4A0nZ7Jm3AXGmT6I/aC5KJtvJRE
         AyW0XyQakPzz3QVflCGGiLmlG/RJG8Ce3fl3mcXMN3XR5oyWa2mKBgxuYuh6tbCZ5lxh
         4hdFGsclqpyyG/a8l+Tg4MSsFXf2tz9VfpFF05HV1A7kpklf5EF5V6Nr3sfHCgk8D3l5
         UtSZi3pGUISYMP6CGShp5D+aBm6wrJYSzNT/8ER9ARxXe7nCQi3NaBQnErpNxQ3N9apS
         QxzpI23lyMqOtYeWetwPHzdoHaqKoVBYd6nJs8CWJG0XWjyD/LhqpEJRcyM+th+V0jTE
         4l5w==
X-Gm-Message-State: APuU4Z9dKBjCvR+rxQypm5D2cU52GxJ2gQkCyz9ZdQb4PWwTsuQiGZy4
	DDKq2j7izCgbdfgD1NVzoFYnCCxUWjK4k/NIBizlhKyxFfuhRjM0aYTHkZNzug==
X-Gm-Gg: AYBFou0q7WGXQsOdoLIuu1NBxWIY4UBspe2Zzn/jgCoFy7byNQA5Gm9d+OajwnJPUTQ
	VIWpUuWaRORZTbBJLRYLXnd3TUwVqJRCkV5hxW8cmUemWNoJKURhisNM6z2Ds6KDN5SC0v7/wnT
	SVnojLyFRxz7K4rfBmbQzRa0RXTc5rPGVTN1hQxermccYM3OJrhGQbrUCagn8UNuX8tUJq/qoVH
	cye49pMckhF5w1/McytD5MFFyf6WxvmcdyeMTAPV7bDBeOlUs8K6v8tJxInNWcxOZbR1gWips6N
	tByGsWw+ijRtGjoZCCL3m3zCg1ADgN/AinJ1BCMhZ9BUiQc4GAujz32n2kKxAABfFILH43FvRri
	00/99cSYzSnrTyQanGcaAVeyl2VH0J2qVLTg0kZgXghE/b1l60XUrZ13seNpNtdMNzDBcM+InLW
	9tH8wozWInIhPhxcXyD8T1tJNraEBpCPqgBdBKfNAeuVNWEzERgm93ot42mTVVXq2n9fo+csdOl
	PFUFUQpppQi66l5zGV27z6OVs2fgKR0ZWqhd0u3MMvgW0JelmrhbGUNEllk7LUBoP1j5Ns4kbRz
	7z2C0Ao9/MYc5C/XibwjY+/jNjgT8SVneQ==
X-Received: by 2002:a05:7022:ea24:b0:1a9:e382:cedc with SMTP id a92af1059eb24-1b5030fb905mr1774050c88.46.1794544234918;
        Thu, 12 Nov 2026 20:30:34 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm4473106c88.5.2026.11.12.20.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:30:34 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
Date: Fri, 13 Nov 2026 10:00:24 +0530
Message-Id: <ed03d290d440d579a81ae0b7de5243721291d903.1794543909.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
CHECK_WX default enabled if STRICT_KERNEL_RWX is enabled.

Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
we can see the following warning splat at boot:

    powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
    WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
    NIP [c0000000000ac204] note_page+0x4dc/0x4fc
    LR [c0000000000ac200] note_page+0x4d8/0x4fc
    Call Trace:
     note_page+0x4d8/0x4fc (unreliable)
     ptdump_pte_entry+0x70/0x94
     walk_pte_range_inner+0x15c/0x260
     walk_pgd_range+0x6d8/0xd5c
     walk_page_range_debug+0xa4/0xf0
     ptdump_walk_pgd+0xec/0x304
     ptdump_check_wx+0xd8/0x154
     kernel_init+0x94/0x26c
     ret_from_kernel_user_thread+0x14/0x1c
    Checked W+X mappings: FAILED, 1 W+X pages found

This happens because CHECK_WX noted a writeable + executable mapping.

This happens because execmem_arch_setup(), checks for
struct_modules_rwx_enabled() to decide between PAGE_KERNEL_ROX v/s
PAGE_KERNEL_EXEC prot, whereas kprobes depenency on modules was earlier removed
via commit:
    7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
Now, the insn slots are only written with patch_instruction(), which
does not need this mapping to be writable. This patch fixes it by
checking for strict_kernel_rwx_enabled() instead.

Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b617b69452cd..77b63b52d8f2 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }

 struct execmem_info __init *execmem_arch_setup(void)
 {
-	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
+	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
 	unsigned long fallback_start = 0, fallback_end = 0;
 	unsigned long start, end;
--
2.39.5


