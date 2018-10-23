Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D755C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:32:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3F52064C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC/wa9V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3F52064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fNpX5RQrzDrq6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:32:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UC/wa9V5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UC/wa9V5"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fNTy5p7wzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 17:17:42 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id g21-v6so150936pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rWi8S4jzSRPfejSB88ND0s0ZmPcoPT0LbfeWB9sCGJ8=;
 b=UC/wa9V5rWC3TPHs/w9mcyYFR9F/laIqKxHUx4ME/UjwjuUg1xubx6JXza8I5XUw9W
 kg8CvJ3KNOdNu4nF5z3zGrgyiFKzbb/K2xpzuHXqQvaQpHq0P3L0jBJHamXYCLtUM1tN
 0dQtPzhP2WI3lrohylzEGA24PMXdF/8HrtBNzUFdjF/2su3C8mBf+7OgXF3zpGQWdwti
 GOSkhj62JrjtF/ZT/XxKzTJJ0wlHmeqcPY1WvuBsPgBPG2qqcVSh2YMeJRenaHPDq9vk
 BsUd76vvgNDZYg/iKuatM2E2AKpiZqsdYfzASD7KYcLoSoo6jzwIsnNFPJksDiN9vomp
 LINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rWi8S4jzSRPfejSB88ND0s0ZmPcoPT0LbfeWB9sCGJ8=;
 b=CEmmM8fd87g1VR66EstwuzLYI4q6wTRZXVFrCRH78NiuA1iIjqPBwM/1ym1axi1jnn
 tr3uzl7dRUFiBsLDioARTI7oiPp833jMMyUbJJDGpNV01do0G39A3bVBpet4bXXch631
 5adBCW0/MI7PNUPQIekbdEBi0C6qiwuS0quL4lW6EuWr7KMQKcS9sEE2XRmCoXD0HwzQ
 4i7XoS21Wtx6zJOgjFxy7nEl9TLDO1wNhAyivNlmxP0hN9AYBQUYf9de2L/t0UgcW1R+
 UYWP4cB9hwdmdJz9QxA9mV5WgTn91LMQSfC1Bq055U5mTXvOM0IrsfApQc752ENwfdv8
 nlJA==
X-Gm-Message-State: ABuFfojgkDKiC+NcCP3gntpOBcm3aqz0ggzVmPqXh7Xx4iXLxT4CHGv6
 ldoxHLZVklfEumYt0W3GNTs3L0Ha
X-Google-Smtp-Source: ACcGV63hBJqkMsbFKqFneNQdoiOesPbB2KN9KIlQ2kQGacV4rEpDcnhLED+Noc0+YKhpKJ7dIlG8Pw==
X-Received: by 2002:a63:790e:: with SMTP id
 u14-v6mr46027423pgc.111.1540275460582; 
 Mon, 22 Oct 2018 23:17:40 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id z11-v6sm1109332pfd.99.2018.10.22.23.17.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 23:17:40 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 23 Oct 2018 16:47:34 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] selftests: powerpc/signal: Fix signal_tm CFLAGS
Date: Tue, 23 Oct 2018 16:46:56 +1030
Message-Id: <20181023061657.18007-6-joel@jms.id.au>
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

signal_tm tries to build with -mhtm but it currently does not.

The targets is modified in lib.mk to add the $(OUTPUT) prefix. The
makefile needs to specify that modifying the rules, or else it does
not match and we miss out on the extra flag.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tools/testing/selftests/powerpc/signal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index 25d0973df5b3..209a958dca12 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -2,7 +2,7 @@
 TEST_GEN_PROGS := signal signal_tm
 
 CFLAGS += -maltivec
-signal_tm: CFLAGS += -mhtm
+$(OUTPUT)/signal_tm: CFLAGS += -mhtm
 
 top_srcdir = ../../../../..
 include ../../lib.mk
-- 
2.19.1

