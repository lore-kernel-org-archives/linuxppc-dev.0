Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B177EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E326B20873
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="iS1FIRS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E326B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434SYK5K9PzDqjb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 15:37:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="iS1FIRS6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="iS1FIRS6"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434SVR3tjKzDqf1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 15:34:38 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id w7so8883485pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 20:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=B+BBDOLbfBXXKdqWMTchgmE+jbwIkTgB415/KbhSgWY=;
 b=iS1FIRS6Y0nPP9tKa0Lxt84tl8AI6nbWFjQxyOLMtTeVsM72/7sZZDWGcDdwzJ9Efl
 tG9mZc4i//uQL2crSTXXiD/3L0j9qLa0FvRoUGGnXAFD1Hfn8ekbpkMqK9WETgsyX8bO
 uJYOGuHaAcywE75JSH9LgDVJLL6fllsk/E3z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=B+BBDOLbfBXXKdqWMTchgmE+jbwIkTgB415/KbhSgWY=;
 b=Hdz6pOuYF/cGPebM6FxOGysnbEIaq4NSnamu+uIIjXH4JCSXAyb+2XJF/GsnF0eGXL
 4elrhbOwD2vASRN5iJCcs02UvWMAojNjx5BEFiGGKnOazkp5kHhFbz4tqKJA9VaVxSvL
 VwC3Tvtrsx14Zxtsn9n5JoGdVqrdBWwosERK9GxHgdGVt3tHmCE+8ttbEw0ib2Tgfdfx
 HD9To1UJPpvPMJnQcrfjKchbZx4Ip4dWKge7Wktz1wN+ZJVUzx/lUXb5ppksY60Df7UP
 ShinenM5/2RXjq0SBvaiM4AQsq8NJUG6kKA0fNr6s/l+MYebU2P4rbKpbF2oKmFnX92w
 Cixw==
X-Gm-Message-State: AA+aEWakKmGJnXam4SEeJvzggZAKzjNBuT1/fubdPXabPZ0A6MFJY60R
 coP+9ckc+pnb0vayC/xQSNqeurT5f4g=
X-Google-Smtp-Source: AFSGD/Wubso5FkLeJcKlvc8SPh80upm6aZJKNocDLwVAwGAR1rjODmzLlRehzy0DjxLi7yW0GmQ7Wg==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr31436781pgv.31.1543379676271; 
 Tue, 27 Nov 2018 20:34:36 -0800 (PST)
Received: from linkitivity.iinet.net.au (114-198-118-47.dyn.iinet.net.au.
 [114.198.118.47])
 by smtp.gmail.com with ESMTPSA id r130sm9811554pfr.48.2018.11.27.20.34.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Nov 2018 20:34:35 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/boot: Copy serial.c in Makefile
Date: Wed, 28 Nov 2018 15:34:17 +1100
Message-Id: <20181128043417.24784-1-dja@axtens.net>
X-Mailer: git-send-email 2.17.1
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
Cc: Joel Stanley <joel@jms.id.au>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A couple of weeks ago, I found my powerpc64e builds were broken
when building out-of-tree with make O=../destination:

  BOOTCC  arch/powerpc/boot/serial.o
powerpc64-linux-gnu-gcc: error: arch/powerpc/boot/serial.c: No such file or directory
powerpc64-linux-gnu-gcc: fatal error: no input files

This is because 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols
to wrapper") adds a more specific rule for serial.c which doesn't
include a copy command. Add it.

Cc: Joel Stanley <joel@jms.id.au>
Fixes: 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 111f97b1ccec..3d5b24b02228 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -203,6 +203,7 @@ $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
 $(obj)/serial.c: $(obj)/autoconf.h
+	$(Q)cp $< $@
 
 $(obj)/autoconf.h: $(obj)/%: $(objtree)/include/generated/%
 	$(Q)cp $< $@
-- 
2.17.1

