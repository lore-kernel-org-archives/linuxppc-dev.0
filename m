Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605A606A338
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfZMckG9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQhy2jqlz2yLH;
	Thu, 26 Nov 2026 03:52:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795625570;
	cv=none; b=TX7D5i8BPFC3tShpTiqcbIn3iqqToTu7zzKyRl2bp2n4sZhdgKB6upruLtxItrtdmlfRTFhd7YNLjgzO/8NNEBo7Q8l7W/NO4IzpcR0z2xCx0NQqWGwuY0CNA9mrFhtZXIcfQthg6Jub7tIMPaSkMCeJaaLie6+2RlqYY04xBMuo6FYQWJtrr9fVVsdP7JRCJ/U8Kikzz4ysfun1iHH0MmCLCO2BFnu3k3VL3KOsInZNs6uNVhhqaLw/90ok6oQa1205aU2hgAm1crk7FmVOG10rVpWoKrtfW7MlzJyIiyT39HeD5Z0M+OO6B7tvzWOfErdZ6Z46fau9+9YEaWI6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795625570; c=relaxed/relaxed;
	bh=RtvJC4h8ugJIk49Jy7lU/lOFV/X8Ev1N/tXAk6wGQes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mx+mZzcAXvdfdNVGSOBW+/xvSprsexATEF8pZM7jKqevbe80FrRisJ4mKY+1qTzS093QDTZmFzeoRPCNDY5jxBcZS5Pt4QG+2osTlr7UPRUOzokiGW8rc9bFL4XNdzn4DhSQBa7VJW1t8WplxtkFaG/bPfXSQvxjo+IWwRL0APvRAnHDSEIe5pRbIct8uxEnHdGXAspPy6BQLs0vSctpFYNmTUdJhl39HW89xEOncwXP2TMcvt7IC7PofltNOOIWZ3ik2Jpm2txTTINj1nRihpxPxtwlWdYd0dQQBwOVqnAMNdvIfWdCtJJnTVOI2e4QQoIZjnFMhwxzSDovF48N6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfZMckG9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfZMckG9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQhx00h0z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:52:48 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-3282db206d3so486652eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625567; x=1796230367; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RtvJC4h8ugJIk49Jy7lU/lOFV/X8Ev1N/tXAk6wGQes=;
        b=zfZMckG9quKUptafx0yUddVGawfeeu2rBnEZmXL9yBoK1Pt43swFyV6rEjzJupJpyB
         XMIO4edS8JRXnrXa8Wd8b5XBfEtvrUS6yTLtb80o7Hwlo1YSJ712+lFLuwauK7evF/tB
         SBESqMK6Av7+LXyTty+owPpB7EIH//cwH+IPGexQwCeHuY7l7IltKeQUJ/U55hYV1sb+
         P7mtfN39YTNs7YnCzQUuZYx+nM3cgRePVKpehMFUqCKph7lhbpPM2g7FisrMkmVjp5Gn
         xCdJOYRpCs6uCdnXz1Plo4KP+cmuhh6AejKDAM3+phFafYG9PIKa2Ww/zndQDikCZyGl
         n+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625567; x=1796230367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RtvJC4h8ugJIk49Jy7lU/lOFV/X8Ev1N/tXAk6wGQes=;
        b=BiW+jLmWnSY+giQGf9ZxgK9C5ViwSUU+boE/ADG16ATaVh5ko2ZvFox5ty07ZWGa2O
         l6H6EBvTue/TUbRA61OrCMCzc3SASg+/zxS4ShlhB3k+CZpk4za6OkafBLqL3ar9IaIB
         DAc0+mTEcVmtGPfh7gSUIeLWGD/Xl3hZHe+kJvLWVaxc1WObFC7Cfz19QJlsV/k5E2FI
         C8G2Lvor9vuwA98T5yaCn1ZuZNPlKbbWPcMckDekCAH9RMVOjxBPaBKgME5M7nMz2LFP
         HhL4Y5WaX8ZbEWfjjtZWPzOHxD+hjBUOH3XGpNQ/mrRaokiNIUnaLCEUd/Yk1S1JxjJZ
         5aiw==
X-Gm-Message-State: APuU4Z9kej5mrzbAisWn7RHu6WZlb5G9T122pvh+0S4HbNCt/ngufHIm
	9rYo4okacsyaA5bSdLhcZjApjBcOLcG6ovqKSBDw86LeZ9aczctjdP4n9WuTGg==
X-Gm-Gg: AZFdTZdpVqTyCASZYh/8JwGD79GzQ7A2HrDmJYHo6+nw9FtUftkVJ7ZmjbTZLDdlo23
	p5K2ZRtCOt3KDWafurbSYG3xVXVH1ljFQRuJBoTR+9D/5SdCQMfyhdZBViB/YeUZDql4aDt70IU
	9fEJZixV3NSoxPSeyL92tEkMt+reVZp8h1WXlayn9wrWsbMs3gYUu342GZfUPcwYhqL9zuGwKSe
	KBIAyRoWIuw5gkYA95rlOVTzCD7xdHrFVXUDX3UyY4A4COyzPruuBBpKtGuYodB7cxtascRpVhX
	iikpKzh0N8/7HcX2d0GtdWbpZ1e47BF2CccSrhON8cAYO1vK2aj2QOHif/X/TEuT8EDROyAigS4
	7UZkejwUAznJnqc12VQWXIa+hmpcLQpUUhiIKSUJTR5BLgjwvn198DnQ+M36lmfx6ir1IGt8ocQ
	80Hm4A9PVO0Lu2jZz2gdN9DFPBBjXgieqCQ0TZmb1Wh515HhXPIHLQzQN7zx7iLJ5CZtX8ohytg
	psIbvjYSKbkZAkOZIS2y0nRCph5hSUJBs54KQryNNm8HiLE18KdUpcg1kUd1TaA7sLQPbpuwVwC
	P4I55+cI5MIkc4my4kE0aRA5+nXc0NirChw=
X-Received: by 2002:a05:7301:a23:b0:386:9ad5:6641 with SMTP id 5a478bee46e88-3869ad56b0emr15566931eec.32.1795625566576;
        Wed, 25 Nov 2026 08:52:46 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98545358eec.3.2026.11.25.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:52:46 -0800 (PST)
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
Subject: [PATCHv3 1/4] powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
Date: Wed, 25 Nov 2026 22:22:30 +0530
Message-Id: <5f5185b80df2a3a4e85ca711b5071096f36a7892.1795625038.git.ritesh.list@gmail.com>
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

commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
CHECK_WX default STRICT_KERNEL_RWX.

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
struct_modules_rwx_enabled(), while kprobes depenency on modules was earlier
removed via commit 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
Since the insn slots are only written with patch_instruction(), which does not
need this mapping to be writable. This patch fixes it by checking for
strict_kernel_rwx_enabled() instead.

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


