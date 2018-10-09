Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5387C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:33:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC15204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBd6Rf5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC15204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VD750vz3zF2X3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 10:33:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBd6Rf5h";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBd6Rf5h"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VD1f42WmzF31m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 10:28:22 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id a5-v6so1552707pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 16:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=niS8W6NfWD0oGDDhUOqNl6R0IMTxMZLdovqZRaKwNyI=;
 b=RBd6Rf5huvmd7yoAoPloICpMaPvwOFJn70VqY78RfDBMTwvRuiOHfkxXamkcUO9m+H
 uMVeCR0tUGsHV8L2N40B6F5aKNd5ANoXMvqC8Rzdw+yFm2musa4XthdBp3If2a/uYB+/
 e2PhC3NAXArpLmokGWFWSV6RZiEPoUc2qepOw2ZNooJe53dOQLaQDDt8HRUl3xqY64WQ
 dqtOrC6QX+2E68OzO/usk8r4Gu2eLS4FDJ3OZr+WuJNgqDuR7rOs74m7v7oci/ZavDTX
 bxNIcP9EGGfokKoZkcS4w21BgFhC3+ahYSCXRuYoc7FiabXbicUwmtVnxHw1CXZiEOrb
 7vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=niS8W6NfWD0oGDDhUOqNl6R0IMTxMZLdovqZRaKwNyI=;
 b=hq9bC1JtO4Uyo9b9J0ZtS2aS84MGOxwDeIt+OJMzHlPN0DayWiEVDn/Bxrf046Dvk9
 V9YDGPgRmYx5blmeLdySy/aTnt5NHqtWvB8EhMTTItEvb1PtRkRTiAt5PwZqVMDu9wxt
 pNKjXrWz+O4rT3LTZEw8Mhbr/AJOogoMGQV5JLvU6qbqcot10Dz3wbAliieAt4zrygpz
 c9IKsKYeYUdynmUqpsoS433uJuYHiXGuy/Bl8jTeQO9L1Y1FSlMIklennI1njN37Dvoy
 Q1l7HGs4ezIJ3Hc0RYlgxuN98qZLtfRZM8jfc2Jk/0dPb/TRFF01pf3FcdTS8JhUJWOw
 1TTw==
X-Gm-Message-State: ABuFfog4JM5HykuWqE43znhPAHGFsrfsBMBSvor6j+qjpRxazrVbDAoR
 hpOSAsXXDM42lTQr5+vnpYatLGj/
X-Google-Smtp-Source: ACcGV62xR7jJkN/fIjEXIep2ecd0dKRUpvfH5wX7biI8QFQfRHrSwOydP7pXQVtx9/IEZENSyHSqQA==
X-Received: by 2002:a62:5d89:: with SMTP id
 n9-v6mr32857127pfj.54.1539127700137; 
 Tue, 09 Oct 2018 16:28:20 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id t64-v6sm30831293pfb.44.2018.10.09.16.28.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 16:28:19 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 10 Oct 2018 09:58:13 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/boot: Expose Kconfig symbols to wrapper
Date: Wed, 10 Oct 2018 09:58:02 +1030
Message-Id: <20181009232803.15072-2-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009232803.15072-1-joel@jms.id.au>
References: <20181009232803.15072-1-joel@jms.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the wrapper is built without including anything in
$(src)/include/, which means there are no CONFIG_ symbols defined. This
means the platform specific serial drivers were never enabled.

We now copy the definitions into the boot directory, so any C file can
now include autoconf.h to depend on configuration options.

Fixes: 866bfc75f40e ("powerpc: conditionally compile platform-specific serial drivers")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/.gitignore | 1 +
 arch/powerpc/boot/Makefile   | 7 ++++++-
 arch/powerpc/boot/serial.c   | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index f92d0530ceb1..32034a0cc554 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -44,4 +44,5 @@ fdt_sw.c
 fdt_wip.c
 libfdt.h
 libfdt_internal.h
+autoconf.h
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0fb96c26136f..eeed74e0dfca 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -197,9 +197,14 @@ $(obj)/empty.c:
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
+$(obj)/serial.c: $(obj)/autoconf.h
+
+$(obj)/autoconf.h: $(obj)/%: $(srctree)/include/generated/%
+	$(Q)cp $< $@
+
 clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
 		$(zlib-decomp-) $(libfdt) $(libfdtheader) \
-		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
+		autoconf.h empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 48e3743faedf..f045f8494bf9 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -18,6 +18,7 @@
 #include "stdio.h"
 #include "io.h"
 #include "ops.h"
+#include "autoconf.h"
 
 static int serial_open(void)
 {
-- 
2.17.1

