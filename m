Return-Path: <SRS0=kIvJ=ER=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F5C55ABD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 05:57:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE442075A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 05:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/BovdlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE442075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWDXT3wyMzDqYV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 16:57:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=g/BovdlV; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWDVS3YLszDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 16:55:44 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id w11so411772pll.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2020 21:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wHdSxV4OAG5c+ULYxQ5MDxPGeUl/iSW7JydxriISKxI=;
 b=g/BovdlVQbiFYPMJ7aQ/oObcup6Wla6sXJDC7VRy4ZxH/mt5u5y1jqz0qsXJCZvibI
 7K5yVKDbFgwPBPoh//qrXemE1bxo6ulw85VDJ/OxH7Ts+lJua68SLlxjgw3z77Aam0QF
 lYU/Y51UBP98GyaVPU7c8YQOMA3gyZvCZ2nQYq2XEoAnttDKq3cvj5DiaoLqv2cFqHPg
 eaOvn1CV9eT1KWcBbcEcVHsOY5TmYPdLFB020HPNCJxtJVxyBMSQn9AUdEmM6KEPMafS
 Dn13d3xzEuD4xz3mfdp+cMfnCuws9gc1YEFLG9PaFJDq7yfHgOLz2UkntNei2DJUEhj7
 AhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wHdSxV4OAG5c+ULYxQ5MDxPGeUl/iSW7JydxriISKxI=;
 b=bLChJcEx2wOCZHTIX5u8TN9qQIKnPAAO6q7v4pMR7/ZnAKg18d9lt9oYW5Txnj9n6P
 95ItvtLcBjY02OZDx3x2RjWZt+boguu8u06EMShYDO4dbV1zpUJ8ak1agSqNR/BTryRO
 Y0/zYEEXA3ioUdFiZzncUz6e/vyXrM28OVYWX8gT3/cdM550vpWuACF4fVL87YshlSZv
 QAghd+4lVbE9T+kn1lqV+gzzbKPzUu+egiqQrRw+QgHE138J7nbA57Nyrfn8LNwhXeL/
 DOHgduMgsBsZprEwiiBni+ma9fN7SnKqEs3kF7eEoW0AOGNYlm0hwz78o40KByDFuvt+
 CLhA==
X-Gm-Message-State: AOAM532Z2sC5etrQs6fc3m+gcGhYwaZqOzyImhcImPK/pDadc1pXKmBS
 QfYPoKP9cQqYosY5VmuahnebBJTj96gWfg==
X-Google-Smtp-Source: ABdhPJw3+PPmU0jQRzjanJODcpqUpkMvNI0SkO4X0wnwiQ4hfVA7wd9vBenGzY9kJzP3LO5drNrLbg==
X-Received: by 2002:a17:90b:a4e:: with SMTP id
 gw14mr2286644pjb.48.1605074139972; 
 Tue, 10 Nov 2020 21:55:39 -0800 (PST)
Received: from tee480.ibm.com (180-150-65-4.b49641.syd.nbn.aussiebb.net.
 [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id i7sm943780pjj.20.2020.11.10.21.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 21:55:39 -0800 (PST)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv/memtrace: Fake non-memblock aligned sized
 traces
Date: Wed, 11 Nov 2020 16:55:24 +1100
Message-Id: <20201111055524.2458-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jordan Niethe <jniethe5@gmail.com>, mikey@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The hardware trace macros which use the memory provided by memtrace are
able to use trace sizes as small as 16MB. Only memblock aligned values
can be removed from each NUMA node by writing that value to
memtrace/enable in debugfs.  This means setting up, say, a 16MB trace is
not possible.  To allow such a trace size, instead align whatever value
is written to memtrace/enable to the memblock size for the purpose of
removing it from each NUMA node but report the written value from
memtrace/enable and memtrace/x/size in debugfs.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 6828108486f8..1188bc8fd090 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -191,7 +191,7 @@ static int memtrace_init_debugfs(void)
 		ent->dir = dir;
 		debugfs_create_file("trace", 0400, dir, ent, &memtrace_fops);
 		debugfs_create_x64("start", 0400, dir, &ent->start);
-		debugfs_create_x64("size", 0400, dir, &ent->size);
+		debugfs_create_x64("size", 0400, dir, &memtrace_size);
 	}
 
 	return ret;
@@ -259,33 +259,25 @@ static int memtrace_enable_set(void *data, u64 val)
 {
 	u64 bytes;
 
-	/*
-	 * Don't attempt to do anything if size isn't aligned to a memory
-	 * block or equal to zero.
-	 */
-	bytes = memory_block_size_bytes();
-	if (val & (bytes - 1)) {
-		pr_err("Value must be aligned with 0x%llx\n", bytes);
-		return -EINVAL;
-	}
-
 	/* Re-add/online previously removed/offlined memory */
 	if (memtrace_size) {
 		if (memtrace_online())
 			return -EAGAIN;
 	}
 
+	memtrace_size = val;
+
 	if (!val)
 		return 0;
 
-	/* Offline and remove memory */
-	if (memtrace_init_regions_runtime(val))
+	/* Offline and remove memory aligned to memory blocks */
+	bytes = memory_block_size_bytes();
+	if (memtrace_init_regions_runtime(ALIGN(val, bytes)))
 		return -EINVAL;
 
 	if (memtrace_init_debugfs())
 		return -EINVAL;
 
-	memtrace_size = val;
 
 	return 0;
 }
-- 
2.17.1

