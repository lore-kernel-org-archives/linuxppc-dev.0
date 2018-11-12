Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0FC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 02:42:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E626120881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 02:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Y5+jxYWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E626120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tZlr62Z7zDrcN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 13:42:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="Y5+jxYWh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.75; helo=conuserg-08.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="Y5+jxYWh"; 
 dkim-atps=neutral
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tZg35kvWzF3Lt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 13:37:51 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id wAC2ZqVS015801;
 Mon, 12 Nov 2018 11:35:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAC2ZqVS015801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541990153;
 bh=QNuGxZanL/Y+BPrezzzgYjKa+CWGG7l6IBD17r6BlRs=;
 h=From:To:Cc:Subject:Date:From;
 b=Y5+jxYWhfiq1HNEpgyGIjnSw3pk5W0nWi/6VdfnIo76V8PXlnRKAi3gBUhfXopzox
 f7bNoaO97n7KLp6WFQNuzYoXJ0Qc123JxrQRKFXgVvLgmyoG9RsbVs+jqGRe/HZG/D
 6lkPYpa2EmpeGv9ScsMCfeUXZL3x54uNKGVXFpbDcuQYjCAfsL2tYanubLFGAvsyOL
 1ZK11KdgOHwzSKMXIALZs+KWiUqEornER0ZZ0VQAoDuUm3ZXmWBuvLGhpbYJtGDoP+
 EUsHrXSwLfjpSvvCLzjqAvVZ12H6hkQ/YpZOB+s4Qx3QctRx6D73saIEVqY8y4oP68
 +Rbj8wdhR1Z5A==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org
Subject: [PATCH 0/2] Remove -fno-unit-at-a-time and -funit-at-a-time compiler
 flags entirely
Date: Mon, 12 Nov 2018 11:35:18 +0900
Message-Id: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Mackerras <paulus@samba.org>, Richard Weinberger <richard@sigma-star.at>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


1/2: remove dead code, which is logically obvious
     because the minimum GCC version is now 4.6

2/2: we can say -funit-at-a-time is no longer useful
     according to GCC 4.6 manual

I hope, this series can be applied through x86 tree.



Masahiro Yamada (2):
  um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
  x86, powerpc: remove -funit-at-a-time compiler option entirely

 arch/powerpc/Makefile | 4 ----
 arch/x86/Makefile     | 4 ----
 arch/x86/Makefile.um  | 9 ---------
 3 files changed, 17 deletions(-)

-- 
2.7.4

