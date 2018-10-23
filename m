Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2037C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:22:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5C72064C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG6OKXlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5C72064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fNbB5XpBzDrVx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:22:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LG6OKXlJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LG6OKXlJ"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fNTV0dwqzDsFP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 17:17:17 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id a19-v6so148165pfo.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7cJ6FpAGdn+CQDG474XshJ1QBx0qkrYgVpFl3C9GuNY=;
 b=LG6OKXlJjMNgNe9bPK9INGduEqNgObI1qBQfisGhrRzS12aPTPaTITZqZlRKlz1R04
 ZR9zmFhB1pL4n17Z/4P13agS31M8QMOGIgZW2c9l7TvV6X2BdY7/Fc/7N8DYwvAVngUG
 H/hqGzShKkUNuylvT2AbBUkk/wdL71vhE9HC117y9UVk81GBO0acYQNBdsew7JtBWgiR
 2szX3AWhcvWMpgKJ6WJmnuuLqpGMgncDJ+kgrcLFE3i9DIZxSDGiIYVQFsUS2pRL9Y9G
 B0b3FnOSOpijn4LBFV4OQgD29tshVivYC7JQrUElqEG2vmppJCEIay9/zs/SK7b2pLfw
 LpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7cJ6FpAGdn+CQDG474XshJ1QBx0qkrYgVpFl3C9GuNY=;
 b=PDTi5R6INKKUlbr4AsR/YLAlrge3ia05YWu3aQwEl6NC2OYUYJLqJ8ugoXuMUzAbFO
 ZeAXLpHG95OrD9N306LXcpUm+pVEa4XDTVhbc5Qj92KuqjoGPF0HeEIXe94tfu047Msw
 6jswP8F0BDFyFpm637NNaXBx2tlapEQZaKHaSqGprzLYd6QXSfpxBBFbv6EWCB6Z5+zH
 OpiRP6JnprKW3lSoOUUOL/mRoO11drUoc9T7nea3b4loVUCZr0vzczXEfblB8j2T3Oam
 2b7lUxu7uQM3cfOZ5L5bxg01z6ba8sbVit/tTJVwPzaIPuCWD3WqVZ19s5ZyFLie9BPI
 Neqw==
X-Gm-Message-State: ABuFfohlp5AonytUHgqQczYBRtPVoZMMXs2LV+l+th8pXce98zpjkrOY
 xFlgPStQ0xrP2K3Eypj6QEHivlDA
X-Google-Smtp-Source: ACcGV62yDaP6QKxGQqi6MQKyfRpaLFVOdtkTsVcbm8OA59gM32qGfgVyPgleXsV71E+wq56VYJyFPg==
X-Received: by 2002:a62:475c:: with SMTP id
 u89-v6mr1272372pfa.225.1540275435664; 
 Mon, 22 Oct 2018 23:17:15 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id h14-v6sm486403pfn.80.2018.10.22.23.17.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 23:17:15 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 23 Oct 2018 16:47:09 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] selftests: powerpc/ptrace: Make tests build
Date: Tue, 23 Oct 2018 16:46:52 +1030
Message-Id: <20181023061657.18007-2-joel@jms.id.au>
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

According to lib.mk, TEST_PROGS is for shell scripts. It appears we need
to define the programs as TEST_GEN_PROGS to ensure they are built.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tools/testing/selftests/powerpc/ptrace/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 6ac71b629276..e9a3850aae86 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
+TEST_GEN_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
               ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
               ptrace-tm-spd-vsx ptrace-tm-spr ptrace-hwbreak ptrace-pkey core-pkey \
               perf-hwbreak ptrace-syscall
@@ -12,7 +12,7 @@ CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pie
 ptrace-pkey core-pkey: child.h
 ptrace-pkey core-pkey: LDLIBS += -pthread
 
-$(TEST_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
+$(TEST_GEN_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
 
 clean:
-	rm -f $(TEST_PROGS) *.o
+	rm -f $(TEST_GEN_PROGS) *.o
-- 
2.19.1

