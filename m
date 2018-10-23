Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69349C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:24:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EA72064C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r50EyNIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EA72064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fNdz2nldzF36k
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:24:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r50EyNIy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="r50EyNIy"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fNTc2WL2zDsFP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 17:17:24 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id x6-v6so155966pln.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DchC4fzBfq664Zcwfp3UWlikdpNlcOrti+O6REmBdMI=;
 b=r50EyNIy/awkLfHZchBfsvGN4xZ5pdJPs5f0eJ+iWttXf1pUs/lM90BtuJ+g/2qbQ+
 cpu7RI0l+ZhBL1fFG5RYzuLOexPRxSwEAmur+lUVd6R5YTHxqlRQizhzpf/Ni9CWi4vn
 yGZcsUt2K2la2Ln9kYW6y7J5dkvyO+jpxoXKoENQKWQ0xjswlTvoSi4xcCpiQlml6Ogl
 zlG6WQ7NnY+5oW69u7lZPl0kQJC0byPZF3p7Ri5U/tKZlXMTiob4zme4AU/NuWzc14Jm
 zjZ2Dr4NjRQEPNv12gb18+oZ06IAe5QDYqwN3MdiusuOSABrvWEvjJrHYAT6x7HmkvOg
 2Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DchC4fzBfq664Zcwfp3UWlikdpNlcOrti+O6REmBdMI=;
 b=jOpRvPMfhwWQKARunJ4fpsyxWMmdHBznklrlVfUwdiD+fk0s7sS4aVJyDlkOZAgQEi
 wFvHD8JHEslg57FvA5bvAb1z/6cbj+mBZbz+aersXOg7mSAeVRv3V34SWR+9guXqdgS4
 aH6F7P7fEZPdDpgd8NSjXxBP1QezdgrrGLfBnEW1h4XQvoMQBTJBX3Qp0Wtt4abrMese
 2OYsc8DNnQXxs0CTSR5WudYDMLeffTgc/L5jWYZDxGzcLN+QoIIdOk04hTnzSQdqRmbN
 5XwI45B4H5bMQWJar7nCIPZXPZJZSAlxZJRa9gQ1CHqoH3CUzVZbf5Zdp2Iy17v0YuVb
 InrA==
X-Gm-Message-State: ABuFfohdc+qX6b29CQyKzHIbN0X3lCatRJ20HqIZrD3ogOf32xeYAnfK
 bjJ6HYPvXwEqRZL/MOteSHqQFIy6
X-Google-Smtp-Source: ACcGV60QHlE2W/zsCX0KOG7i1bTpxwmed8pKIQekbgnSaUzy3HUvlxUSrpCfoZeTbXOiDpIwaMOeTQ==
X-Received: by 2002:a17:902:167:: with SMTP id
 94-v6mr46149033plb.142.1540275441916; 
 Mon, 22 Oct 2018 23:17:21 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id m18-v6sm544611pfk.149.2018.10.22.23.17.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 23:17:21 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 23 Oct 2018 16:47:16 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] selftests: powerpc/ptrace: Remove clean rule
Date: Tue, 23 Oct 2018 16:46:53 +1030
Message-Id: <20181023061657.18007-3-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023061657.18007-1-joel@jms.id.au>
References: <20181023061657.18007-1-joel@jms.id.au>
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
Cc: linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When running 'make ptrace':

 make[1]: Entering directory 'tools/testing/selftests/powerpc/ptrace'
 Makefile:18: warning: overriding recipe for target 'clean'
 ../../lib.mk:137: warning: ignoring old recipe for target 'clean'

The rule is unnecessary as TEST_GEN_FILES are cleaned up by the rule in
lib.mk.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tools/testing/selftests/powerpc/ptrace/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index e9a3850aae86..58de6d4a0cf4 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -13,6 +13,3 @@ ptrace-pkey core-pkey: child.h
 ptrace-pkey core-pkey: LDLIBS += -pthread
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
-
-clean:
-	rm -f $(TEST_GEN_PROGS) *.o
-- 
2.19.1

