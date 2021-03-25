Return-Path: <SRS0=KFk7=IX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A63C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Mar 2021 20:09:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44C4619D5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Mar 2021 20:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44C4619D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F5x570hgPz3c0C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 07:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ioLIImcc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=ioLIImcc; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F5x4h2VVyz3bc8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 07:08:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Shyze7IYwmhdHuk7ciduosr01KilslJO6pqTFNfikQU=; b=ioLIImccLGwVIYrkNdnjxiaVcf
 ShZvZlyqF0RC+1EwtkpAaKvmZ3F/reGuOBnAF+eGpmRq84NTpac7IOd1PiSzatcp981MN0NBoCSNe
 rzH8Sbaqy0lQaOHHCCDR30u5gtFY85brlJ/UevK3T5pZrbzWjSoa/RCZgvpOVsR2gemv6G6MSgxs6
 weea96UMKae3zacfKBPPr/5EKDdkH9bq+NTBMD7hZOEp5uuKdR2igTQKMoHy6WOyvfU/Ndh7E7Q1e
 yooSWs+En8usHn07bxSFa97Av8CBl3K6iENrax5BV3TdkIfEuSsscpl3nj951frli0zlbhlMSwdt+
 KDs4uihw==;
Received: from [2601:1c0:6280:3f0::3ba4] (helo=smtpauth.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lPWHH-0028a1-W4; Thu, 25 Mar 2021 20:08:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: powerpc: unmark non-kernel-doc comments
Date: Thu, 25 Mar 2021 13:08:20 -0700
Message-Id: <20210325200820.16594-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Drop the 'beginning of kernel-doc' notation markers (/**)
in places that are not in kernel-doc format.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 tools/testing/selftests/powerpc/tm/tm-trap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210323.orig/tools/testing/selftests/powerpc/tm/tm-trap.c
+++ linux-next-20210323/tools/testing/selftests/powerpc/tm/tm-trap.c
@@ -66,7 +66,7 @@ void trap_signal_handler(int signo, sigi
 	/* Get thread endianness: extract bit LE from MSR */
 	thread_endianness = MSR_LE & ucp->uc_mcontext.gp_regs[PT_MSR];
 
-	/***
+	/*
 	 * Little-Endian Machine
 	 */
 
@@ -126,7 +126,7 @@ void trap_signal_handler(int signo, sigi
 		}
 	}
 
-	/***
+	/*
 	 * Big-Endian Machine
 	 */
 
