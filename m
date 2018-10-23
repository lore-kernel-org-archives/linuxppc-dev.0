Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B8C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:34:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C072064C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo731jqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C072064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fNsB70TxzF322
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:34:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oo731jqE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oo731jqE"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fNV46PfKzDsFQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 17:17:48 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id e67-v6so141407plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+EMKdn4JqGd67sac0ZOTG546D/v2ITC51DMCJXlcAlM=;
 b=oo731jqEz7o5lKRsTndjUp3ydNeqNaCrsppnM1dF6rglY3W0yHd/NKbXUTVizX2CiA
 GJP6muQXZf5af/z4D+oTdJGbW2/kgW4jI9KU24+UGNZclNLt80S2GVAAPWjoaJfTzJKT
 qD+vNrTFE784q6eZObIkVLP9wsjGONeywL21nNqUzn7ZlSA3aET+dXCwFvAxEAFAMH/I
 BCad2+orinqL8mXKo/rgUjyT74PsW4s30BqkCwakygsJ++4AwY1s1VilR6Fj/e0P+4iv
 tg6MTrLHw+pyHv6HBHSsmkNQDs4ElJh9IWa3FYVGAa+LxPo3NDYyXUM/e+1H9l9lL/WS
 YfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+EMKdn4JqGd67sac0ZOTG546D/v2ITC51DMCJXlcAlM=;
 b=c2wgotN1XelzF/eHoxIXSrZJcbzbaJaVahkSESwm5Ify3JhW9q9kfseuO1MGVYTzPE
 Oo7QYZj0bMvQabpN6pLRYJbUNXNTMwB4BBzvqy634XbX/RBYQS15lihuzpUyc8zxE09t
 Yf1O+MnljTkOAbZQbCB4YO1ar3g7/f+KKTzalg46R2aAqYrLt5OMhouoBWSdF0OB+fGq
 E6Bw8oImDKg1S9r5YKMpmbngojOdZtrj5I3rV0N+bZ1sNVmeEapemyJvbXB9w/X4lLKn
 AkyyJ2fJ8AVKMUMwO4tfAun1GltLZ2DVVHWnNrVyt7iwCUOq6CXhxesgzYkcEPQXSlyW
 PaVw==
X-Gm-Message-State: ABuFfojvkq5YuF8Ddash9ZlBdic8dLMwWK43NpO4FO4YOGZ7yz0EQmmD
 la4t6uZGipRAanEzy+S5m+PCLTQs
X-Google-Smtp-Source: ACcGV617w6UJe24rmgwBbaBLyCyOmoW9UiItqlDzB+V4YoVplvTOhtmMSqfr2AmwK9zZzxnBivnlNQ==
X-Received: by 2002:a17:902:bf09:: with SMTP id
 bi9-v6mr47015327plb.118.1540275466944; 
 Mon, 22 Oct 2018 23:17:46 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id u190-v6sm1608448pgu.3.2018.10.22.23.17.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 23:17:46 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 23 Oct 2018 16:47:41 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] selftests: powerpc/pmu: Link ebb tests with -no-pie
Date: Tue, 23 Oct 2018 16:46:57 +1030
Message-Id: <20181023061657.18007-7-joel@jms.id.au>
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

When running the ebb tests after building on a ppc64le Ubuntu machine:

 $ pmu/ebb/reg_access_test: error while loading shared libraries:
 R_PPC64_ADDR16_HI reloc at 0x000000013a965130 for symbol `' out of
 range

This is because the Ubuntu toolchain builds has PIE enabled by default.
Change it to be always off instead.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tools/testing/selftests/powerpc/pmu/ebb/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index bd5dfa509272..23f4caf48ffc 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -5,6 +5,9 @@ noarg:
 # The EBB handler is 64-bit code and everything links against it
 CFLAGS += -m64
 
+# Toolchains may build PIE by default which breaks the assembly
+LDFLAGS += -no-pie
+
 TEST_GEN_PROGS := reg_access_test event_attributes_test cycles_test	\
 	 cycles_with_freeze_test pmc56_overflow_test		\
 	 ebb_vs_cpu_event_test cpu_event_vs_ebb_test		\
-- 
2.19.1

