Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0525C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:27:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518CD2064C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU06CDGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518CD2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fNhk23JPzDrcQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:27:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nU06CDGd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nU06CDGd"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fNTk1WgtzF1Hp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 17:17:30 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id f78-v6so166136pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zh5a0oXfAbjeEOgFxGihzvB+6U1+ro2b74+S+sXuMNA=;
 b=nU06CDGd2YGQj8WTj6v61F6jiqwWWp9IwJGQGBmI+okH/f00JTe3IN0P4W8cf8d3cI
 H6nLPevdDTCX9XPusSQekvDJuPOJvQFSMdpJNRi4Jj755FwqBuEH0RYZrqIDqHQBRvy5
 /A8GrYsiB8SdEfyEzbCc7/h7bSgyf5mM3NITXW2rZT8RAv38W+4jsN8qdmq6rCBO3HJh
 fd369hzm/qD0y0/YZk/GrAFF233fFGfF+ZLEwEIt20XUa2r6SJQzcDShdL56y7GKcGmF
 zdtMNTrtXp5x1KMYdz9VpCsP6b9lvgUdED6bVEkBf4Ji2bWrIVJn9R2q0BwStUSQVEN1
 pOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zh5a0oXfAbjeEOgFxGihzvB+6U1+ro2b74+S+sXuMNA=;
 b=pfU3eXt4WQmEwdTwQcjLOtrnHnSQ5xJAzLwp+uldKlZ9KTUMjcsX/1BsOrgpzVax2Q
 /lfwnqc0EG9EaTl70/ckNGhxe0WCWcFDsxNo5ZIgiqaMG9Qi9qne9xF4Zy1wNPTUNtJb
 nQjbUlNjLPGTBVdDkIGVFx7UXbME5oLwURM0HyXOpW3v9Tls3zH4cp8w1Aq+N8lFz02l
 80q2Oxb6u8xTzWnTqbTvTwDvVx91hbq1IO81zA3/bqKl5aCXvFlnYHQemDIqjEjxRuS6
 YUHVaJv66XlIrMVUMz5UwuhWkqQ4kvBnzmr7X25b6SeMkUnoYnt+R87X3OroLCFxI3x1
 AMcw==
X-Gm-Message-State: ABuFfogu7oxPEJYvdWEnRUoz5MORIUU0TI7MD9lV8d/I9sZgHGSFLWHo
 4avSaZL8tsJA+3ufYvNI/iK7LMEk
X-Google-Smtp-Source: ACcGV62TgPSlJB5jt/fewdp9Eo5NI1MfnAG9NIKMiKYAeyFKODwky7oS6klNT3Enhp9pQtikNoV5sA==
X-Received: by 2002:a63:aa48:: with SMTP id
 x8-v6mr44674758pgo.87.1540275448069; 
 Mon, 22 Oct 2018 23:17:28 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id a16-v6sm1491074pgb.6.2018.10.22.23.17.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 23:17:27 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 23 Oct 2018 16:47:22 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] selftests: powerpc/ptrace: Fix linking against pthread
Date: Tue, 23 Oct 2018 16:46:54 +1030
Message-Id: <20181023061657.18007-4-joel@jms.id.au>
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

Some of the ptrace tests require -ptrace when linking:

 /usr/bin/ld: /tmp/ccH32S9w.o: in function `init_child_sync':
 core-pkey.c:(.text+0x1d64): undefined reference to `sem_init'

The targets for these tests are modfied in lib.mk to add the $(OUTPUT)
prefix. The makefile needs to specify that modifying those rules, or
else they do not match and we miss out on the extra flags.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tools/testing/selftests/powerpc/ptrace/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 58de6d4a0cf4..8d3f006c98cc 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -9,7 +9,7 @@ include ../../lib.mk
 
 CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pie
 
-ptrace-pkey core-pkey: child.h
-ptrace-pkey core-pkey: LDLIBS += -pthread
+$(OUTPUT)/ptrace-pkey $(OUTPUT)/core-pkey: child.h
+$(OUTPUT)/ptrace-pkey $(OUTPUT)/core-pkey: LDLIBS += -pthread
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
-- 
2.19.1

