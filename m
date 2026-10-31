Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2069606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Oct 2026 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmd4w7mM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGxfH5rkzz2xJF;
	Sat, 31 Oct 2026 23:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793448711;
	cv=none; b=d3r++yMnwPsFkQ7aGWO84JxW4UpyW5zD2WeTlE2HUwN96mo6qaRZ3NQB0itDtWDWmhZoSG2m9NX/BE1m2uL8HrZCfWsTESWw1pDw+BAvhHpRg0HEtXI/8CJ1XgaqOh3Nl+F8Sjw+9jv4xeix4LMroYT3F60wy27AWdxFiL8D4tAI5yZdrmpbkxrPBfEH/K3FD8VlgS+Kh3UQB0mzJRRnJ98Wl2KriHKIAaCwGZnObM/z/UHFSvfzE7zWQxAkV9Jd8tiUHLfV3r4OMoJlPNLHmDxImQHmHe8kCTE7eWRyX7S4lRpHmgCy6odwkfdiArn3Y3yPMzwX649CzKFRKZGnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793448711; c=relaxed/relaxed;
	bh=BT6J6/b48vPr/t0dhtJHyqHkA9y0z58dhZE+8yeOg4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aUcNgwiohXjFm7RgnWU01afxo+rRrfGtqqG6dUSqLnFgGTcyp4L+8JMZv4TREud2TDAmx7ldVAFB9woho9NBbGepjvmf/UH47qlv0jIVhiLKYGebKzc5qzCBK+ANZGtpei1YmynaaZ+fAYr0UBqA/MEqkvrBgNQ9am774bhBjspBHI9W7mmxvs6BhhqX+dKkh4Xack9Hi4pbnCmqmU9X0CQt8PGUd1qix5St/ieJu5KVeyz0ztasWZnjwJjIfTigwAm+Joln/0qMLAfptNGa3b/96OGpili2SPJbBMgZ6uACic2X2SfNl2b4TsIaFvP2of/+sbQK40n47edZTebQpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmd4w7mM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmd4w7mM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGxfG03bDz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 23:11:49 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-15ea896ddc8so2717536c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793448707; x=1794053507; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BT6J6/b48vPr/t0dhtJHyqHkA9y0z58dhZE+8yeOg4k=;
        b=zmd4w7mMDGrliSnt/jdWyBrYDma3JQEM6PLo4rrKriNuN8EHd+qn7d31tPTai+dPrq
         Q7ANK7TfaXMgPKSib3bFzaQxyL6tpp89CEqMyeLWjy+GFly0fPJkZmEgeoWWdE3qoejr
         QtfmKoHbmT++pofw+1TMAAzBKG0HP7lDZRC8Aecxow6R4wMk+sRMiZS0HTw4tVXZrUgo
         ba79+PUk+fBEF+1KORaDnV4xQ0tVSeY/XngzGwTOyfEYU5vn201YdV+Rnyqiwu7WTu0p
         tGzjWpdF0AS2jE3eE20i2trZW6X/1lLM3+9x6b9r+6hjSBv9k4+uj8E/MV6fsLoQl1vQ
         EmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793448707; x=1794053507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BT6J6/b48vPr/t0dhtJHyqHkA9y0z58dhZE+8yeOg4k=;
        b=fsWqL8JVxTFUZeRDu3DeqLjCGo31ZSwz0W+ecTGFmdD8mHDpavhsR85ND4n2gTOuho
         G7xYuayEs5ySpZpcqm6k2lPTLR/l+d2C4Z299kczAiVt6O6RuV9UOPs67HF/QFJHUZlh
         u+qMMTKhMc3GiN5dAemchlTXimcOyaPMac4RWQYtST73x+dLMpWQ91tWEqIYYmRLl4St
         ex+DWRf6fDbPAIyVOI/Vr3ETh735SRaTMViTVFu7xC3dG/faFCFUUSLf/q7HOOq/WSmc
         yLQtkCX/fpyT01BKHcrcTyASnCY0MmryfyIEOIU93InFvmfOVd7bNvMkeaCuYT4Eb2PQ
         gSgw==
X-Gm-Message-State: AFq9FYLoOnljqxnH99AD6KcNVa1VK1l4k8uGkqO/lVJd+wP1doLztP98
	11EgK0rHLwklNK4/tEd7ITQZypbzOalVxmi5CzIETybGR/y2Q6OgwF1Vc9WnBA==
X-Gm-Gg: AYBFou0F7DpJ8xjKdhV0p9sxRjo+1UkTBR1Eqk/aTV+eOon9uRoDPcERD+iFxIemXxE
	YVZ69xnJq7ko/+GCQI2GGVE+ucKDBqlVbdAM1J4ghkChk7vYaOzbNkjQ0MWwM51A6FtNZLbSBuX
	c8cpexSDrsrUJvJU69BtZTVf1VjxfHa5ZgnjaAtCvsG7lDPhj7nFMBTG+cXrAtFQv6ZcalrGMiC
	fJ7ZpvyZGSmL20VycT8npCCAeyACEwA6A//XLOUMMEsmrRpHXsLYSNwP1ldQKSeN5zpAPI0/s5u
	g6Nh7gAqbHOzYQO7slR8XBmF9Dw7w77MzIVwTvYWncNMCbCohETcQtFt1jM6CRcLnXzGhMCRo8Q
	0KJ+ZF9MG6gHk29eXqKW8wqUvBEkCaPHkbzfs5u26mIgDBBuM3C9pQXhUsnFS4TOz5XFvKqzabF
	qS46G0DnoneOStDyPAid58cCmPRB+8m+QT4ixWPPNL6f4m0F4SYW+HenmozQbt4dNGmOaoSKg+3
	JGY0OZT9OYHV3Kep7Qj4nzD6LFHnsv9mQRdvQ0vhsyi936PKoEbkJ3hi8YCxwxRa2czeHMxzain
	rkrbCVFWKJAAeNIHNmociHgtC7Sx629Zwqs=
X-Received: by 2002:a05:7022:3a02:b0:169:bef5:f445 with SMTP id a92af1059eb24-1ac55774bf9mr7170978c88.4.1793448706406;
        Sat, 31 Oct 2026 05:11:46 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm26762301c88.10.2026.10.31.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:11:45 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	chleroy@kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] powerpc/entry: Trace the IRQ disable before irqentry_exit() on 32-bit
Date: Sat, 31 Oct 2026 17:41:37 +0530
Message-Id: <a14571be1897955f43d9994f0e093de3ada6ecde.1793447880.git.ritesh.list@gmail.com>
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

Commit 63a7531ca31f ("powerpc/entry: Fix irq_soft_mask corruption on
replayed interrupt exit") changed arch_interrupt_exit_prepare() to
disable interrupts with hard_irq_disable() instead of
local_irq_disable().
This is correct for 64-bit (since it takes care of everything there)
however, it breaks lockdep on 32-bit.

exceptions such has page fault handling (do_page_fault()), re-enables
interrupts since handling a page fault can sleep. Then generic irq exit
expects the arch to disable the interrupts back before returning to the
user/kernel in their arch_interrupt_exit_prepare() function, before
irqentry_exit() is called. irqentry_exit() then checks for lockdep's irq
tracing state and expects the interrupts to be off.

Note that on 32-bit we don't have any soft mask and hard_irq_disable()
just clears the MSR[EE] state and does not update the irq tracing state
unlikes local_irq_disable(). This causes the lockdep to warn like:

    WARNING: include/linux/irq-entry-common.h:540 at irqentry_exit+0x398/0xd1c, CPU#1: init/1
    NIP  irqentry_exit+0x398/0xd1c
    LR   do_page_fault+0x390/0x7b4
    Call Trace:
     do_page_fault+0x218/0x7b4
     DataStorage+0x15c/0x180
    --- interrupt: 300 at __arch_clear_user+0x10/0xcc

    WARNING: include/linux/irq-entry-common.h:312 at irqentry_exit+0x224/0xd1c, CPU#1: init/1
    NIP  irqentry_exit+0x224/0xd1c
    LR   do_page_fault+0x390/0x7b4
    Call Trace:
     __per_cpu_offset+0x0/0x60 (unreliable)
     do_page_fault+0x390/0x7b4
     InstructionStorage+0x150/0x160
    ---- interrupt: 400 at 0xb77b059c

So, use local_irq_disable() on 32-bit which clears MSR[EE] and also
records the transition for lockdep. For 64-bit we keep hard_irq_disable().

Fixes: 63a7531ca31f ("powerpc/entry: Fix irq_soft_mask corruption on replayed interrupt exit")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
This was caught during debugging some other issue on 32-bit platform.
When lockdep is enabled there, this warning can be easily seen during bootup
itself.

 arch/powerpc/include/asm/entry-common.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index 8e91489fdf2b..c944a267532d 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -268,7 +268,10 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
 	}

 	/* irqentry_exit expects to be called with interrupts disabled */
-	hard_irq_disable();
+	if (IS_ENABLED(CONFIG_PPC64))
+		hard_irq_disable();
+	else
+		local_irq_disable();
 }

 static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
--
2.39.5


