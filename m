Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0618C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 03:13:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE0C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 03:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE0C64EB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmHtR5yZRz3f2c
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 14:13:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=o9rJZIVi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::629;
 helo=mail-pl1-x629.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=o9rJZIVi; dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmHq43XB1z3d40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 14:10:40 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id a24so2399655plm.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2021 19:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CF7C7GM1ZvhPdAUSLeRB4JOFHZdWUAMIVoyP5oDNTUw=;
 b=o9rJZIViszVzdKJw+LuCD7/rDQ7gwO3j5yvLde9tUbsY8OsNMvuWKIB+eeK2FveesT
 xtPCUT+vFZZPSOxvb/37y5LKhoaE4g+ermfXFTUr3MS3CKWtnS2MHXkp+jTRMTbnP9cH
 AaaNvzUoK/f0tC+n+agdwcpEIbUoNeS67P7UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CF7C7GM1ZvhPdAUSLeRB4JOFHZdWUAMIVoyP5oDNTUw=;
 b=aDV1/pTTvSkl33rWjekTfARCmLThpcC6f7ni2IABEEBA7Zzz+0WpKuxYBJs+GO7HTC
 kc6x8P1nc8xGdQZN+2Rp4TiaQ5y6tKH3WL1gqZ6pe0NIW6YPb0s341rjgQoMbZfiMDa9
 AdO/QPjU3GEAPjJcuPEgfy4Sd9EjqEf82oTruyjwP9aB5T/ManmhDXA8wAbl9uqCzBFa
 PrkmUanDnfGAJ1mCkXbBIwaodZ/RiUIiBtjwRPYMEUu52/2iiVp/u8CL6EyoPsPv6QCc
 cYSOEY00aZFn7bJkLqoRWX6170vIruXcp3T6e6lnM2iBPk+sib1G6kOX3L2BI1INmug7
 YxDg==
X-Gm-Message-State: AOAM532Hr5/g+m6emjIsTi9Agi4TrfH7x8YPK+pA+w5mjG11ilb3feML
 MXd9c1MJep7gyRQU4ZhZMySrgg==
X-Google-Smtp-Source: ABdhPJzGEmJKglC4gyPY9k1HtGXmDZeu7aZwGCKh6EH+rjmzp7jAviLIKo5bEG6G1X4QHIcCXWDE+Q==
X-Received: by 2002:a17:90a:ab17:: with SMTP id
 m23mr1097793pjq.0.1614222638163; 
 Wed, 24 Feb 2021 19:10:38 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-6e65-7e50-8dac-f7ef.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:6e65:7e50:8dac:f7ef])
 by smtp.gmail.com with ESMTPSA id me5sm3832362pjb.19.2021.02.24.19.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 19:10:37 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: llvmlinux@lists.linuxfoundation.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 7/8] powerpc/purgatory: drop .machine specifier
Date: Thu, 25 Feb 2021 14:10:05 +1100
Message-Id: <20210225031006.1204774-8-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210225031006.1204774-1-dja@axtens.net>
References: <20210225031006.1204774-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It's ignored by future versions of llvm's integrated assembler (by not -11).
I'm not sure what it does for us in gas.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/purgatory/trampoline_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/purgatory/trampoline_64.S b/arch/powerpc/purgatory/trampoline_64.S
index d956b8a35fd1..e6a2740a5da0 100644
--- a/arch/powerpc/purgatory/trampoline_64.S
+++ b/arch/powerpc/purgatory/trampoline_64.S
@@ -12,7 +12,7 @@
 #include <asm/asm-compat.h>
 #include <asm/crashdump-ppc64.h>
 
-	.machine ppc64
+//upgrade clang, gets ignored	.machine ppc64
 	.balign 256
 	.globl purgatory_start
 purgatory_start:
-- 
2.27.0

