Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84CC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 06:46:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774232183F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 06:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD9A4CJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774232183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vsj66Lf5zDqRh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rD9A4CJo"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vsg810jzzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 17:45:07 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id e24so565280pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 23:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3QMBndSJUG66bEm5laqHvvWsM0uekV0VrM5u+ankrxo=;
 b=rD9A4CJo4TPl7vqqSLWrYwF9znfsrGO8RvUAlglZzTwpzz3oBIT6oTFs+tko8UPuAz
 vgJSLSKQPvZSbQBVSjBQioxt7bgBUMwcUO5zjYFssJiqDZD7XEdG3NQU09caFJUotD3m
 h8TI+pyOKe55knWUJ8GqbJTnlwjNmraT7AZEZQJOfhtiEeTJp3ckZrc0jCCW/r91J273
 l36wlMbPd4FIlLJS+5SkfMzYFWWeNBxskhJtm/H3DEVOIeYmH83kwfi+5E4oQyz7XJl5
 zC/JhNWNFQhwrwjeBNb4dlNuImNcsOQe/0FND65wdPfjQZFAxV68+z/xu2DqvJ7THOC0
 medg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=3QMBndSJUG66bEm5laqHvvWsM0uekV0VrM5u+ankrxo=;
 b=AlvVbyeKBMPp417jwBHSZRD+gEMvLv2G1SuiTxCxJf2qVR+s834l6TnsglU7yY5gQH
 U+c/4kQ94ajMrLavUMNh8c08MHJ/4VA9DMytQtrlSdNStvKUDtYWoJhTUOOe+qw4pXVK
 s+yfSbmRUFPMjLwUsmYYN6cLvo4Wt0gHxGxbujFBcm0o36hxNqvWBynDfi0wiQB3k8lI
 w5WKCv3sBroy8aXJwL8U7Q+6R0qZDVpQ/bQEbV1aYPpQqiiRX3CtKjThY2uWLsDvpw4m
 +05GdP2MXpTgQcOR3Gqny+iRT9LhuO9YEczwOoMOb0pnueV7Xw4flUMDVFRfZMPPYWbs
 9JIQ==
X-Gm-Message-State: APjAAAWcTST1UFmZPwJ+5n/B+r0iakXYGH/YEC5k6PmPoKY7NLnel4fY
 DVks5xpN7YeQN+8MxFcWuOOSZQTG
X-Google-Smtp-Source: APXvYqyunk+17C05TmZeWJAVQRUqXagae1i/arm1NjzdQ9tHmhOGMB9kfmJJSIejysLHRlquEqJdkw==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr47000723pfo.181.1553841903952; 
 Thu, 28 Mar 2019 23:45:03 -0700 (PDT)
Received: from voyager.jms.id.au (bh02i525f01.au.ibm.com. [202.81.18.30])
 by smtp.gmail.com with ESMTPSA id n65sm2848183pfb.160.2019.03.28.23.45.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 28 Mar 2019 23:45:03 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
 Fri, 29 Mar 2019 17:14:56 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/vmlinux.lds: Drop binutils < 2.18 workarounds
Date: Fri, 29 Mar 2019 17:14:53 +1030
Message-Id: <20190329064453.12761-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
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

Segher added some workarounds for binutils < 2.18 and GCC < 4.2. We
now set GCC 4.6 and binutils 2.20 as the minimum, so the workarounds
can be dropped.

This is mostly a revert of c69cccc95fe4 ("powerpc: Fix build bug with
binutils < 2.18 and GCC < 4.2"), except we keep the kernel PHDRS
statement as ppc64_defconfig would fail to link without it:

 powerpc64-linux-ld: .tmp_vmlinux1: Not enough room for program headers, try linking with -N
 powerpc64-linux-ld: final link failed: Bad value

See https://lore.kernel.org/linuxppc-dev/20190321003253.22100-1-joel@jms.id.au/
for the discussion.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Fix ppc64_defconfig by keeping kernel PHDRS

Segher, Christophe, I did my best but to summarise your conversation.
Please suggest corrections or additions to the commit message if you
have any.

---
 arch/powerpc/kernel/vmlinux.lds.S | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..9ddc7c0dc672 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -19,21 +19,6 @@ ENTRY(_stext)
 
 PHDRS {
 	kernel PT_LOAD FLAGS(7); /* RWX */
-	notes PT_NOTE FLAGS(0);
-	dummy PT_NOTE FLAGS(0);
-
-	/* binutils < 2.18 has a bug that makes it misbehave when taking an
-	   ELF file with all segments at load address 0 as input.  This
-	   happens when running "strip" on vmlinux, because of the AT() magic
-	   in this linker script.  People using GCC >= 4.2 won't run into
-	   this problem, because the "build-id" support will put some data
-	   into the "notes" segment (at a non-zero load address).
-
-	   To work around this, we force some data into both the "dummy"
-	   segment and the kernel segment, so the dummy segment will get a
-	   non-zero load address.  It's not enough to always create the
-	   "notes" segment, since if nothing gets assigned to it, its load
-	   address will be zero.  */
 }
 
 #ifdef CONFIG_PPC64
@@ -177,15 +162,7 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES :kernel :notes
-
-	/* The dummy segment contents for the bug workaround mentioned above
-	   near PHDRS.  */
-	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
-		LONG(0)
-		LONG(0)
-		LONG(0)
-	} :kernel :dummy
+	NOTES
 
 /*
  * Init sections discarded at runtime
-- 
2.20.1

