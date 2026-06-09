Return-Path: <linuxppc-dev+bounces-22361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E194CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyT4Wqjz3bwd;
	Wed, 10 Jun 2026 08:20:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043601;
	cv=none; b=ELwdj3SQkp/blhyMjbIFbCknLyp4UhV3x0EHvQzE7ejiHemlGHAc0My9c6sHu/4VqiOrHy+s1i6Uq77A8zL6fDGL6p9ye4hAfDdLyOw5IyqBg6n9zyPU7X5hv0XQL+IANJXiXvc4D4Kv3Z3ncD+GY7TEPFjLG5M1o4Gh3WkSh65MrR6xaWJ9rchrVDUqNNeEoAboyc6fcMCKOvtwUPe0x0kYqR3wmNpleLdeEmLgcLWDn3FCOf1o6QZ2PC0faZuq8ZkkJdlHYz8vbUVF/fwEoUElJO4xLR1YPzNuHtYjfp55wfGuYJHUBAFDyPYOldyzKQVE/XPv4ij9t/JH5nAmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043601; c=relaxed/relaxed;
	bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0RIdoc0UhMgxSjUrQS2s22dMEowO4J2jxNufzMkzAT/hAvv5xNpTS9sX56+C6fRry6qzwT8DupBUyz8obPQ90r8kc8MtNN9D1CX8qVe04w/Hao/faWWRuxIRW+8uUNBny08vVkEzP1P6OVpHUy/rzIy2GG8EokgohhQ3ntZT7UyKGW44SW5zDFRSCQfTkOvU7p/JiDAkb8yATY7uDwg7WeOHtR8MPfQlXlGhMIVc6niUPpiPsesV7FarL2+jXGmmy/z6zNbOEXtNmDuHWTfrHuyTXako0vnyVZH6GkAUMrl9td45hSQdDJRYIw7qREWl8RnJG5/M512qW5hpwy2QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F+D5cIka; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F+D5cIka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyT0FDjz3byl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:00 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c85c9e8b7e4so2532221a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043599; x=1781648399; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
        b=F+D5cIkaM6t5kE9SQMyr9stUXVUSoLgUz6MjBPbodK1qaT240L3Du7o4JuV8WxMolz
         EEE6kjws+euEhjiesGZjtxu6p4ShvAUu+5IbJ9+eyzLRWHEdKvLPISqStd8gxpzbOYGy
         yMiZP6G3/4rtEgBWJKqe9Vsnu7dayMAsDrxMciscnDl/2gyLkk6kIk+3G00Ua3j89gDW
         f8FHHnuHpPjNodlw+MFoYYebGz0vDlJ2I7WJG65XXHcJo8hzifoQ1RRVdzihvUm1c2f8
         Rbwylqav2AFxfP5nhldrSDhIXZ6veYV9N/s66NswaOzslZI0LKTnCcOdNlVXmBcxl3SK
         S30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043599; x=1781648399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
        b=puJOIHsnunUGjzzWglbNh9AzmJj4qeQ9VMovI0GcTOrQrWXPSxVDmYfRQLbvQd69w6
         HccKxbM8bnPw2ztloCgh2YVm42mdh8eYKLGO/Sz8Lh+kpkXhEHbu1gCwKtGCSTBB+Pji
         TCQdrN5Svjtln9dEw/BFqEl0+qrdcXWOwBCDOd+Z9ZxFWso40CyTzD4OQdpu+MJO5fDk
         MH3zFy8lDv8ceo1zQ+i1OkrRpfhUKXLetX70aTuLiPAGbh/dJlIxjz8YJOWFo0RA9fcc
         QbCPsKbX4ZbE1Dmz3p8xEBrVd+L9EHHoBesfSzzat3bx78s2gzM1ClHhDDvngT8mF2wc
         Ceuw==
X-Forwarded-Encrypted: i=1; AFNElJ/6sWHm57PIwezsqJDDBnI0Ia4gfgS8wvqUqhT5XIpM2SMFlRMPnqFac3sfMsKQ4j/4dX05nIYvk+KE1Wc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YweTyVRx9JQMIe5zQN6ffUXlc8QP06jSQuqQZ4y7heGkWHeRnzI
	A9Mozjotj2JQxmANybKCvyT/4UBBuprmxCWlNGW56TiupNdpXUuP6JdhUjmQ1AYt
X-Gm-Gg: Acq92OFcH40Qcr+9bURG8af1kHedc492RGOzD6eri1R+wlgnXfH993lQASbO/4R1pvl
	yC+aZ/Z7+5JtnMwzug0aN17QUpbGBYRQ0FNPKk7CKOKmaW/3Riy7cZ4DqQXNfgiIFMcEU+1B7YR
	vD507grsY1fnI0e7HwQbrYaCHim3wtST0L9iajPrdpLGWSgD3URDb/oPrJu4Z38Ooyjg56NDAdm
	ONhEoEUN8hyJNrUC1mcd0NXyZcQsVwJ2n8ebpXLjEEnzsIKL1YJyGeSfwCBWhVMBIEiX4/sxuh1
	BospGRbtYdnMDrfIoSnrDIYfyC2WvOaFn3rq482UXSfN0kMx5aOLNkNF+ZeqiuNU2v5DuYVDuBz
	CJ1KGT0b6Jw1iiIIG+n7XQsnY0qF192hJeewe9xLVXrvBy02CZFjRmOZ/sAaq44BzM+fADUbobd
	qW0X5752n5OD6Gf8Vj6InK6E6i3HVBY1gaSEyMdExdxKLrnfKmitkZZLF1rcF+Pqm7y1peOPfUE
	UH+QYxbE8hHRLIsCGNS07nqjPgJobRu3Iacw4JXftZVqQ==
X-Received: by 2002:a05:6a21:104:b0:3b4:7eb0:479f with SMTP id adf61e73a8af0-3b4ccd3a851mr24318303637.5.1781043599239;
        Tue, 09 Jun 2026 15:19:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv3 07/15] dmaengine: fsldma: fix request_irqs unwind freeing unregistered IRQ
Date: Tue,  9 Jun 2026 15:19:18 -0700
Message-ID: <20260609221926.35538-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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

When fsldma_request_irqs() fails on a per-channel IRQ, the unwind
loop starts at the current index i, which calls free_irq() on the
IRQ that request_irq() just failed to register.  Decrement i before
the loop to skip the failed channel.

Bug introduced by commit 586f54672b33 ("dmaengine: fsldma: convert
to platform_get_irq_optional()").

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4475d50a94f5..c04a7fbd2ed0 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1088,7 +1088,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 	return 0;
 
 out_unwind:
-	for (/* none */; i >= 0; i--) {
+	for (i--; i >= 0; i--) {
 		chan = fdev->chan[i];
 		if (!chan)
 			continue;
-- 
2.54.0


