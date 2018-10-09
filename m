Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B4C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:35:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC0120645
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSfrKYqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC0120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VD9n6nc7zF2X3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 10:35:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fSfrKYqC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fSfrKYqC"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VD1n1KlxzF326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 10:28:29 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id f18-v6so1576479pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=of/5JUSwXK9l7WNRVPej6jR9w8RQ26WmmHda3ChEltQ=;
 b=fSfrKYqCIhk2Ajfc0aFErxm/anl0EUYPZ4XJ8IOQvED91m7NLA80oT2Vk+jNuufIKh
 HWlPQweCrKcxyRaahGn7IMukuxCdpVAUt803qFvW8be43nweJxb54MNEb+WXB3yIBlhN
 njb4eZHtxOBls4dO4ZQj1BW6OsWmHrdpBkg/jKGE50sChio8GF7uM9zyhl8yKbGwtXMV
 Zmn9s6dyJS7ryBFoBm7TQxXzGPF44UCPguUReNMV+ovC+8AQX3DodZ3KGAN9vJim/vje
 WgJWAgsUqhKC+nBpET75JLrwoXOheUaaMs6JncR0veR1Q15VqOsIGuAys07VeaelXT0q
 XJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=of/5JUSwXK9l7WNRVPej6jR9w8RQ26WmmHda3ChEltQ=;
 b=dSyFBHJqsZeevTO/YOS1aqpe1oLixpJWqIv49ryav0vGTLy7BcORc3c1jars52171G
 7Csp/ayalMAR8fbIa1z+Qb+/tRfiz3Ko7a0odQCkBqvrqGJS66BsI24fdZaETXZIxGsg
 mdpKQCmUqx7a5N0sT/kriA/D75EtuvhtOfVUvkBQr5eg/F81mOtUccRX4HtxdgrAkLRo
 dmBzxM7w25/0ERAZAoI52BaASTjEym16zdWIpS8+Wz+dMjhljmerFU/XbhytJorYQQa2
 vwQaDFJnI1PiN0JzZPgF1RKwcC/icFB2NW9sfZZ8BT+ST3Q3txjEfbFil8FXsQtcPKq3
 w86Q==
X-Gm-Message-State: ABuFfoh4yOEaXNXv7WS/04xiI/DTxK5qSS2w+jzh3hc9fQE7I4xuuIWZ
 3rCMXba7EtDhDJr8k9eY1cPXZKam
X-Google-Smtp-Source: ACcGV63hd+jAHGyya/EeRSKjJfRZ5lL4FASfLMZNhZPmkIbXdKktvMbkdIUYUBB0bUwWxOLvNkhQxA==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr32012301pfe.236.1539127707195; 
 Tue, 09 Oct 2018 16:28:27 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id r76-v6sm17394880pgr.11.2018.10.09.16.28.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 16:28:26 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 10 Oct 2018 09:58:20 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/boot: Fix opal console in boot wrapper
Date: Wed, 10 Oct 2018 09:58:03 +1030
Message-Id: <20181009232803.15072-3-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009232803.15072-1-joel@jms.id.au>
References: <20181009232803.15072-1-joel@jms.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As of commit 10c77dba40ff ("powerpc/boot: Fix build failure in 32-bit
boot wrapper") the opal code is hidden behind CONFIG_PPC64_BOOT_WRAPPER,
but the boot wrapper avoids include/linux, so it does not get the normal
Kconfig flags.

We can drop the guard entirely as in commit f8e8e69cea49 ("powerpc/boot:
Only build OPAL code when necessary") the makefile only includes opal.c
in the build if CONFIG_PPC64_BOOT_WRAPPER is set.

Fixes: 10c77dba40ff ("powerpc/boot: Fix build failure in 32-bit boot wrapper")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
I wrote this patch before the kconfig one. We could use autoconf.h, or
fold this in, but I think the clean up of the redundant ifdef is cleaner.

 arch/powerpc/boot/opal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index 0272570d02de..dfb199ef5b94 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -13,8 +13,6 @@
 #include <libfdt.h>
 #include "../include/asm/opal-api.h"
 
-#ifdef CONFIG_PPC64_BOOT_WRAPPER
-
 /* Global OPAL struct used by opal-call.S */
 struct opal {
 	u64 base;
@@ -101,9 +99,3 @@ int opal_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
-#else
-int opal_console_init(void *devp, struct serial_console_data *scdp)
-{
-	return -1;
-}
-#endif /* __powerpc64__ */
-- 
2.17.1

