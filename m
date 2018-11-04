Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35CFC32789
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 23:16:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CE02082D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 23:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6v2TWnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pBX316B0zDr6B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 10:16:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6v2TWnz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6v2TWnz"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pBQv5mhmzDrPb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 10:12:07 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id y18-v6so1077528pfn.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FYux4C2W77ompUQVjAbeAh3v7QT2cdZi06vXygmle5U=;
 b=X6v2TWnzkxTvrtjhspedABX3+3IMc2u8jvE7A+YZLOcXW01H7Oh9o7TuZhFoHv0tyE
 yq/YwK+NniMGr9wnbckTEX0bRAg7Ffu8d29k6PGBgTgPsC0BakRjE9HNBCCNPm/6PF4A
 F0/2yNXJg2A8ZOHmg25yOb0gJVDz7lxRUwk9nG19M+biDg4mUqgLqit8gegZKCLBijAq
 hRQzefA7wYdGndb6gMg1AmTsOTUmmjypb+KbNFKo2Xpz100YNfKAXnniR+n1sgKu8xlc
 omr8KAPjbWlBJuMulPxaFIvLD+YLDjmsktcoRd5RzhQs7JG7Rxsx2DfojgCnOVRhjkmi
 9KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FYux4C2W77ompUQVjAbeAh3v7QT2cdZi06vXygmle5U=;
 b=UR+3ZRrg5XppqAclj3k7lSHTicykTIQp2THw2Sju7UKFwKik6f18Hyrzfx27isaxlC
 ZhOfspFvQjRhVv5mjioTmsrTiFVbdcZVschoHBQzwsPsT44OF9ZJ80F+rVLofa7dpOvA
 weNrFdGqA3lMu+F9oTIk6fMtlRk7InDsGt4b7csNNRAADaMpsASo0vpzYwmokksvUTZN
 7uXYtPMVrrALoXq3t0SgsnGSVORlD1hO2pLXFL01esOH/vaS/iQZTlvh7hudYB5ZUvjG
 x86upVpoLHm7Deh9kZVWQ062Z0Iu1fvXKgZTsSp8+UPIMvCl1Xf3x2hpoDj506+oVirk
 X3cA==
X-Gm-Message-State: AGRZ1gIUWryil96OvTmzwdk819gP6+Q2JvAJGzcyq4kX5agu/0RLDNie
 RFg7g1+g6375R47m+W8tkOs=
X-Google-Smtp-Source: AJdET5fMU/L9ONzwUnycp7JkHaHEI+ABkuD4LzA5aQJqNWEG3vzRGs5xlnX+lQeDIpZDAGa7kQAPvA==
X-Received: by 2002:a63:4e18:: with SMTP id
 c24-v6mr17877627pgb.6.1541373125365; 
 Sun, 04 Nov 2018 15:12:05 -0800 (PST)
Received: from aurora.jms.id.au (pa49-178-43-40.pa.nsw.optusnet.com.au.
 [49.178.43.40])
 by smtp.gmail.com with ESMTPSA id v185-v6sm45133255pfv.48.2018.11.04.15.11.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Nov 2018 15:12:04 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 05 Nov 2018 09:41:53 +1030
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/2] Makefile: Export clang toolchain variables
Date: Mon,  5 Nov 2018 09:41:32 +1030
Message-Id: <20181104231133.30848-2-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104231133.30848-1-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au>
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The powerpc makefile will use these in it's boot wrapper.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 9aa352b38815..a2db3c885b38 100644
--- a/Makefile
+++ b/Makefile
@@ -495,6 +495,9 @@ endif
 ifneq ($(GCC_TOOLCHAIN),)
 CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
+export CLANG_TARGET
+export CLANG_GCC_TC
+export CLANG_PREFIX
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-- 
2.19.1

