Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F4C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E1E20835
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7ek2heF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E1E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PnqX0lDgzDqNp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 11:34:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="T7ek2heF"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Pnnf3SYczDqMy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 11:33:10 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id q206so3005294pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 17:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=syTbUBdwWbHi/pq6Q37lY3Zt177JkyDGlnneZJfCvOM=;
 b=T7ek2heFE9eoLdMiNDKgTfuJeVMDCkSlYxXhhNzUnuXeS9QEi/HOI68RKnthglr8Ky
 XfItJC/Sm7FVgCTGLKv9ajJGp6m3frWyqvAGnGXGa8QioY1CuQHockN3cwjP7wEy6ou1
 5RtLsD5ORQQrwI/YVc81ri1vgQSH0FYbRaTlKSsbpjvU1CA9MQJBdkKDS40b/t1y46KP
 47AaGdmsH6FjTrL7JSXS5drMzl+q/jPehVTpCaAfoDv+hX1OSCKtTvBM5e4Gy+egf58W
 YTG396jqTswgbO0mNhyBSsMREGjkq1N9GTe6/cXhmsA51MW8OPdGjJsvOo+/HgsvXaR6
 8NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=syTbUBdwWbHi/pq6Q37lY3Zt177JkyDGlnneZJfCvOM=;
 b=cLJMDD2LTbtF4pbXEyE8rYIJlFxu3NoVSMK5VjP4q7Np+8Ry84W79kiiN2cK/5MI/W
 C4iyw1a8TzSCTzigvB0MW3KDdQh+JWkl43a7fenIHM2TyKu2HgWH+T5ANPlJMm1L+bSL
 X+dVF8WW2FRwJCBTXX/PoC0MwexvY0D4/2EbkpNLarrFJ0nHyFeK7pDbF0EGycrtXM0D
 ERTv7sw5/Ek0dqyk7i9f+xpJR5OPvzKrbkLNBTKBG2613Y4j3HidsmLdIndBg0k9I66a
 VsPM/mtIZUstuiDtApb5sxarTjDJoSonJ2WnsHoX2g9ZL7ZeRQN+8gnM8d6gjQMJmcix
 6ZlA==
X-Gm-Message-State: APjAAAXaDBSKtPrsA0R2iAZQG2B7bJDlutY17GvHSWQLnLsSCtE2UTSD
 nWS0LNcjwB+QApXsUIWyYw4dlgB3
X-Google-Smtp-Source: APXvYqwZrs2uFUK/n9MW6vq2fGkOPsoJ9VEvOt9mU1qX6loq+IPpSt9dCxBG0fsyzIwVdqVOoeriAA==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr644212pfo.90.1553128386215;
 Wed, 20 Mar 2019 17:33:06 -0700 (PDT)
Received: from voyager.jms.id.au ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id p14sm5497276pgn.34.2019.03.20.17.33.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 20 Mar 2019 17:33:05 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
 Thu, 21 Mar 2019 11:03:00 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
Date: Thu, 21 Mar 2019 11:02:53 +1030
Message-Id: <20190321003253.22100-1-joel@jms.id.au>
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

Segher added some workarounds for GCC 4.2 and bintuils 2.18. We now set
4.6 and 2.20 as the minimum, so they can be dropped.

This is mostly a revert of c69cccc95fe4 ("powerpc: Fix build bug with
binutils < 2.18 and GCC < 4.2").

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 35 ++++---------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..0551e9846676 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -17,25 +17,6 @@
 
 ENTRY(_stext)
 
-PHDRS {
-	kernel PT_LOAD FLAGS(7); /* RWX */
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
-}
-
 #ifdef CONFIG_PPC64
 OUTPUT_ARCH(powerpc:common64)
 jiffies = jiffies_64;
@@ -77,7 +58,7 @@ SECTIONS
 #else /* !CONFIG_PPC64 */
 		HEAD_TEXT
 #endif
-	} :kernel
+	}
 
 	__head_end = .;
 
@@ -126,7 +107,7 @@ SECTIONS
 		__got2_end = .;
 #endif /* CONFIG_PPC32 */
 
-	} :kernel
+	}
 
 	. = ALIGN(ETEXT_ALIGN_SIZE);
 	_etext = .;
@@ -177,15 +158,7 @@ SECTIONS
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
@@ -200,7 +173,7 @@ SECTIONS
 #ifdef CONFIG_PPC64
 		*(.tramp.ftrace.init);
 #endif
-	} :kernel
+	}
 
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
-- 
2.20.1

