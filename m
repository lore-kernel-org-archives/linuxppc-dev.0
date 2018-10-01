Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B8EC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 06:14:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55482084C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 06:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bB3d3XYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55482084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NsSK3WhSzF36m
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 16:14:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="bB3d3XYj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.75; helo=conuserg-08.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="bB3d3XYj"; 
 dkim-atps=neutral
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NsPt1Zs0zF35X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 16:12:17 +1000 (AEST)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id w916BMB8020398;
 Mon, 1 Oct 2018 15:11:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w916BMB8020398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1538374283;
 bh=vxJNdGOViqpKuCBNPTBCV/Q20ql4OXtHOHBA7JAiwk0=;
 h=From:To:Cc:Subject:Date:From;
 b=bB3d3XYjIWxM3JZPO7P09ThnPzTHs+MvOWF2LaRA8WeBeGP6laj/y/AMDWOBEVeyR
 y4eDn2c+NDEKCU0Ra0r1Zmhzk8QCMyssQxVjWjRCOQAper3rFX6IaU8u4CgCRH/59i
 4ZPCLrWI5JuvZmX8cIQmi9kgT5wa4hYCM0X8J8kRb5TcDSR9pRVwPbzVentBxaEIyn
 bHAt0n9kUe/SbW7VXgqrxSWmtR/dEYHSpbP69Z3Dar3HRoszzVVYCu8t4c+C5K1N3m
 soxzP4udedRVqMIeMl0jwu4HbZIoXH1ijL45pqwWIL0iqOQu0rQjXHEoV7nRsgYgoZ
 TzqKU3ZnaHXbA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: remove leftover code of old GCC version checks
Date: Mon,  1 Oct 2018 15:10:24 +0900
Message-Id: <1538374224-3742-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Clean up the leftover of commit f2910f0e6835 ("powerpc: remove old
GCC version checks").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

My patch had been sent earlier, with more clean-ups:
https://lore.kernel.org/patchwork/patch/977805/

Anyway, this cleans up the left-over of the Nicholas' one.


 arch/powerpc/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2ecd0976..b094375 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -400,10 +400,6 @@ archclean:
 
 archprepare: checkbin
 
-# Use the file '.tmp_gas_check' for binutils tests, as gas won't output
-# to stdout and these checks are run even on install targets.
-TOUT	:= .tmp_gas_check
-
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
 checkbin:
@@ -414,7 +410,3 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
-
-
-CLEAN_FILES += $(TOUT)
-
-- 
2.7.4

