Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD026C67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 12:13:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0225D2064E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 12:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6zr1zAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0225D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dwQc2s6qzDrYb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 23:13:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D6zr1zAX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="D6zr1zAX"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dwLS3XXRzDrWV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:09:36 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id j23-v6so19817326pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZAhcNQvUfIL2jtB5Hlk9h6pg/yZ1ONa/CSn4hNbnGm0=;
 b=D6zr1zAXxibrm9TOWX5WNlX+EEgtTygT6PcrGIqQSVL7LfRXxPwIZ/DP92dgFPIfDW
 JBXNSLpf1ZI+0Vi0bdjW/YGKcoxLhvvckSDplRT1+R1sUi0Rtk6l/YnPSXFB0FNbipUZ
 HLn/hNM8xaeDrzdb5dx+VtmO/vEnsWYd2mr12IcLi40oE7SBdJlyMkKE7ZJUTyRoeTiv
 nubTXt/fypUuHfwjC8JFppLCBTWB3GndjC9fwbqHRGeiSup0DYpad1Ich3DtmSxTC8X/
 T20d91r4+kXEQuUYgGOI7hhGJ85E9fWCYSJKC4gucIzbaPzc1iOVkEbgmIzNxOIXrKya
 2CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ZAhcNQvUfIL2jtB5Hlk9h6pg/yZ1ONa/CSn4hNbnGm0=;
 b=tlApoeqV+ht2UsX3zkfbH1YQ4xdNvfsPN26AlLdSyXWiT3Mebl95b4cNsIry8ODj4e
 MthLKgVmdUV2qKxJoPKCWqiyWzz7aTbBfkbCuG6TmXSfoUDlS+PKMaAYr6mOiqVMpDIe
 auxgVr+ABwsoX9Hl5tPcG8S80e2s4b2nwPC3KXKUnDVSTdsmEAgQ6vCo71eY0B/Cgj3w
 9sz1XvG/O2aB/F+rSTh6M6NGHRtSoNBFrDsg4y6Sg4wCOdID9nwg/qkKFLBIc1xTJOTq
 x4r0n3xqewpDMXF0RSv4O63fQH86qelKevTmOzCuVw8CMlgbcRryNeNyHIEeLTAb1m+/
 Irlg==
X-Gm-Message-State: AGRZ1gL6uGxArIcTS/BHCuX4bdpVSUCThOi/iwnpDDPGF8H2joAkZ0cw
 aWPS9hbLP0a/pvVK7jtbuRfKW89X
X-Google-Smtp-Source: AJdET5duNFDOUU1z+y2WyvETQ5loi78cmp1O4tfatK75ZvOA8VB3yIsMEDp8Re0g8fo3p1//EJ5vfg==
X-Received: by 2002:a63:5a1f:: with SMTP id
 o31-v6mr5411184pgb.438.1540210173905; 
 Mon, 22 Oct 2018 05:09:33 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id l2-v6sm33051277pgp.20.2018.10.22.05.09.31
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 05:09:33 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 22 Oct 2018 22:39:27 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests: powerpc: Fix warning for security subdir
Date: Mon, 22 Oct 2018 22:39:26 +1030
Message-Id: <20181022120926.12797-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

typing 'make' inside tools/testing/selftests/powerpc gave a build
warning:

BUILD_TARGET=tools/testing/selftests/powerpc/security; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C security all
make[1]: Entering directory 'tools/testing/selftests/powerpc/security'
../../lib.mk:20: ../../../../scripts/subarch.include: No such file or directory
make[1]: *** No rule to make target '../../../../scripts/subarch.include'.
make[1]: Failed to remake makefile '../../../../scripts/subarch.include'.

The build is one level deeper than lib.mk thinks it is. Set top_srcdir
to set things straight.

Note that the test program is still built.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tools/testing/selftests/powerpc/security/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/security/Makefile b/tools/testing/selftests/powerpc/security/Makefile
index 44690f1bb26a..85861c46b445 100644
--- a/tools/testing/selftests/powerpc/security/Makefile
+++ b/tools/testing/selftests/powerpc/security/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 TEST_GEN_PROGS := rfi_flush
+top_srcdir = ../../../../..
 
 CFLAGS += -I../../../../../usr/include
 
-- 
2.19.1

