Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DDDC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 20:56:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD632081B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 20:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srg0HPF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD632081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Z0f5nJrzDqGv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 07:56:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Srg0HPF9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Srg0HPF9"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438Yxl64RnzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 07:54:03 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id a18so10793763wmj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TIdz95ThPzutAt/0Gs1laVAbtjq4MULqHeE84zRq5M4=;
 b=Srg0HPF9yl1uMhsYa3XeqGIcyp4t8/Ltzhk2DGkBzpl0snuECUbhBQ6JAfiiz5BUFv
 kqGWRIk3WPlKkw5Ce547rtijE5yJFxbXZRqupm+43w4I8oOxIlbSgYW7opCfExjIYVWS
 Abt5Mlduh8EDmc9I7p2w6LGTH5Y1lrBqUNtdQgfyXi/sjPY39XI0hrybb5XnEO3zlzfE
 rUizDTQ10bC0CC+35MV2ZiMpyrxs0AXwe7S2Fc8NfsjdIRL5Y9NhNHV7GgHuZGxim5ds
 SEPEsYXstsXNWnhbz/l9CaAYspzHWqj7uGYWC7/7MGBsSN69KI6aXUO2ZANNeJWQVNs2
 cGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=TIdz95ThPzutAt/0Gs1laVAbtjq4MULqHeE84zRq5M4=;
 b=iZpjExHSUM2EDLIJU59VijtDafJ2KObNuA/32mtLannUQe3UYV4ge3dlZgKyoaICFo
 1UAQZNuag45i+EJZhyVs4JdnxPhpFq7CKvy9ujQp5XIKlYUthW0GlE4QbauJ91ANgCAE
 XQ19OhJ84/ajLNaj2o3lipA11/HAar3vEuBXAghb0pvV/5GW9zBcls3KQjcC2gHnOCTf
 JvMpaFvLi8memzvTa6Pss0osnUswWapOmMtJattIozPDI0LznfMn7A0TAC1JWq0dps45
 hL0JfFdDambA40zn8FkUeEQ7XOdpQ9eq4OhkFJtwAEuCJzsHCWcsRRwIXmqjAeSwzx93
 mWFQ==
X-Gm-Message-State: AA+aEWZxSra0if3GvSUyTfSKLb6xYgQbDQTLFG7CDXYL7Uh4hb74DD8b
 M0q9QAy2owy+zuCeHlqzi18=
X-Google-Smtp-Source: AFSGD/UJkTIVQrq1HBP75IjCNFDKZmFdowtVuPrMDZmjrLIUNiXoZZDLOe9zF8k3wV8mEaamECMN+A==
X-Received: by 2002:a1c:35ca:: with SMTP id
 c193mr13421476wma.146.1543956840524; 
 Tue, 04 Dec 2018 12:54:00 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id n127sm4074949wmd.20.2018.12.04.12.53.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 12:53:58 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id A71D21141016; Tue,  4 Dec 2018 21:53:51 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/32: Move the old 6xx -mcpu logic before the
 TARGET_CPU logic
Date: Tue,  4 Dec 2018 21:53:45 +0100
Message-Id: <20181204205345.9514-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
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
 arch/powerpc/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a2ce14d68d0..544b30667ea5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -30,6 +30,10 @@ endif
 endif
 endif
 
+ifdef CONFIG_6xx
+KBUILD_CFLAGS		+= -mcpu=powerpc
+endif
+
 ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 else
@@ -241,10 +245,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-ifdef CONFIG_6xx
-KBUILD_CFLAGS		+= -mcpu=powerpc
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
-- 
2.19.2

