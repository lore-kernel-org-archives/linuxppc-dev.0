Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E01C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 17:56:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F68213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 17:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSr3bP50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F68213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4395yZ3tB3zDqyj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 04:56:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSr3bP50";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSr3bP50"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4395vl5lHXzDqjn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 04:54:11 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id v13so20611878wrw.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 09:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xb9ECD3pNEGkoUfMI/2UPdjGrLKV78cyJ8sXz0lD43Q=;
 b=mSr3bP5077qrLQ4DbEjkq9wbJqLmnlE5pkdk75rs8iDgQG4QJtXAryNCoxSgWaXusy
 mS5d3s/KW8VhWIbNfYb2VeWgBA7/KNjTHrFJjjptBaxUwvYyFuiJfIv4DbegnUh+afej
 TRRGDI4zbsM649lBDrG0fbeLK8SbGL+QxpkQ+7ZkNWjKx7JiwjuGhMciDzn7zGkZ6dvR
 DpSqE4NPbFL3AKuBOhtCOD7WgAtnFR4I8WiH4Dl7JFrl0HieLnGimA8vYEoDOisdXhoG
 HWEcf0VNmZaHFpnlLlyBHCF66eCZfck4qgbFKH5XTs7GYK5rwxiKU90Bq6SpKuKmejbo
 EqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xb9ECD3pNEGkoUfMI/2UPdjGrLKV78cyJ8sXz0lD43Q=;
 b=XEmVBghPJsMvsktQ95A2dffJwn70hw5IALBZ0iZg5Yz+qxTvcakRzaBCv++weNZGIt
 wO12xByGfBf0kd8E0VHuy2eaclU4qdAkVdVq/hhLEvxUile6LfZlqYb1afUebagZq+fd
 tTeeOvrjaARXuENvIiQkmK8lhSZlruFbo8DgENTMq6nOfAytoLwfZ4RBFVkwbMM9Pb4J
 y+HR/q6gmsnfuH0EZ3uOdV3yXldJEA/irRn33RGyph6mRso1t9lM0jCjau2qTBIJbCNJ
 AzOvDJPQitHaXR827LkFeNQghZOiNkBfI8ukG0w1H1aKc9fHmj8U5bNixEtmm34bjFK+
 nGxQ==
X-Gm-Message-State: AA+aEWZazs6toeqzim3l29hlwEUH2Gzj3IWwKYfNum0KwwDdML/HNW4b
 IG2cogMq43QXVr4RmJyFcRo=
X-Google-Smtp-Source: AFSGD/Uwhk0ULfWzKfTBh6xXIRrT+cXc3gogBW4Rf5qwjr4IlwnYtsRpd8ThNhiyVgAA7bSyDH23Iw==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr21596357wrr.313.1544032446560; 
 Wed, 05 Dec 2018 09:54:06 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
 by smtp.gmail.com with ESMTPSA id
 k135sm21061725wmd.42.2018.12.05.09.54.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 09:54:05 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 3960611409E9; Wed,  5 Dec 2018 18:54:04 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/32: Move the old 6xx -mcpu logic before the
 TARGET_CPU logic
Date: Wed,  5 Dec 2018 18:53:55 +0100
Message-Id: <20181205175355.14787-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204205345.9514-1-malat@debian.org>
References: <20181204205345.9514-1-malat@debian.org>
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
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The code:

  ifdef CONFIG_6xx
  KBUILD_CFLAGS          += -mcpu=powerpc
  endif

was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
explicitly in kernel compiles"). This change was acceptable since the
TARGET_CPU logic was 64-bit only.

Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
also on PPC32") this logic is no longer acceptable after the TARGET_CPU
specific. It currently appends -mcpu=powerpc at the end of the command
line, after any TARGET_CPU specific:

  gcc -Wp,-MD,init/.do_mounts.o.d ...
    -mcpu=powerpc -mbig-endian -m32 ...
    -mcpu=e300c2 ...
    -mcpu=powerpc ...
    ../init/do_mounts.c

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142315.html
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: As suggested by Christophe rebase onto next-test

 arch/powerpc/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 40bbeeeb5b4a..4b16588c920f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -30,6 +30,10 @@ endif
 endif
 endif
 
+ifdef CONFIG_PPC_BOOK3S_32
+KBUILD_CFLAGS		+= -mcpu=powerpc
+endif
+
 ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 else
@@ -241,10 +245,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-ifdef CONFIG_PPC_BOOK3S_32
-KBUILD_CFLAGS		+= -mcpu=powerpc
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
-- 
2.19.2

