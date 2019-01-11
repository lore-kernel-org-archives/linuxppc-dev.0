Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A868DC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 23:52:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DD920874
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 23:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O36enOsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DD920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43c06D54KyzDr7F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 10:52:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="O36enOsH"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43c04W3ytfzDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 10:51:06 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id b7so7659235pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 15:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=++9eEDdsUT8HBO5NqeOGNP4Jfp/w9i2O3P5HVjSpccQ=;
 b=O36enOsHXbdOHfU0fcOij9uLZ/7cCOo1Vajr/22thr94ZlwKktbWwU/RXGXmPoVfV/
 Q6gq2mod36ZR000V9/oM4ZDlqkZJD3xcUdVJX2aX3nV6XTYDMMnBA+Qu89LbAV6fN5dA
 SDz5dQpZmubRrP9K4xdAFyhWPGL+ampTVDBYEMej62ojyw0Km5ERMg2mREPuZkgQ0sJV
 XHFR27BWlzTCJ/axxeOSCTpoQ23x1IbbxfXwRwxCjtu4ZGCniskiHgmLK9PG0OGQwtPo
 OefCJEfcr0wv48iskXObsTiv91xIFvGVfm2etlwJgjpcj6rihTbkLwOyKo1iaRDljsAe
 9FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=++9eEDdsUT8HBO5NqeOGNP4Jfp/w9i2O3P5HVjSpccQ=;
 b=a0qVbOx9ySSFAUa0Kp9dnGhKDQ2iC7n/weMjaUW+Z/1KgTXOEjq3CzudllImUDCuWY
 5XdRONSAAXwbTeQU+H4AhTrPHeJ9rxV37n1OJYRtrKRv84dhUGcEXxb+R+UA37buR+ix
 AVZcRiSTGGCEhkHvCMEHmECUs26lWowvPc6ifXkb9nj2k1elmCCXP/HlIcJALUr22gqj
 TkxXPhZB2t6i30rxQaK7eu4LtYSxaP71AwVSBwp0qJR7xaBXstockT8z248iaWAD239y
 8i3i04/kyS3VoEYWXR829LW6Mklf2Wyr/z0A154RDMuSd/OtkiHevsyHb1q352g9qMc3
 IZbA==
X-Gm-Message-State: AJcUukcjeCLm13fR2wn/YIjx4jGNY6TK73yMVSitU86KXIsBae0A9Y1V
 5Pve3wJMlTQcjeMEnkDojOLX+9+e
X-Google-Smtp-Source: ALg8bN5R3n5LJ2+b0+n6r0ppGGK+Dl2ZuvewiNFy+8shfvW+s7nguucbu80NEkmuWUwnp8LpLJ2IFQ==
X-Received: by 2002:a63:6906:: with SMTP id e6mr14900118pgc.144.1547250664361; 
 Fri, 11 Jan 2019 15:51:04 -0800 (PST)
Received: from aurora.jms.id.au (natp-s01-129-78-56-201.gw.usyd.edu.au.
 [129.78.56.201])
 by smtp.gmail.com with ESMTPSA id 22sm101643100pgd.85.2019.01.11.15.51.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 15:51:03 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Sat, 12 Jan 2019 10:50:58 +1100
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Use ALIGN instead of BLOCK
Date: Sat, 12 Jan 2019 10:50:56 +1100
Message-Id: <20190111235056.27435-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In the ld documentation under Builtin Functions:

  BLOCK(exp)

    This is a synonym for ALIGN, for compatibility with older linker scripts.

Clang's linker (lld) doesn't know about BLOCK so remove this use of it.

Link: https://github.com/ClangBuiltLinux/linux/issues/253
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index ad1c77f71f54..3ae4c959f95b 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -86,11 +86,11 @@ SECTIONS
 
 #ifdef CONFIG_PPC64
 	/*
-	 * BLOCK(0) overrides the default output section alignment because
+	 * ALIGN(0) overrides the default output section alignment because
 	 * this needs to start right after .head.text in order for fixed
 	 * section placement to work.
 	 */
-	.text BLOCK(0) : AT(ADDR(.text) - LOAD_OFFSET) {
+	.text ALIGN(0) : AT(ADDR(.text) - LOAD_OFFSET) {
 #ifdef CONFIG_LD_HEAD_STUB_CATCH
 		KEEP(*(.linker_stub_catch));
 		. = . ;
-- 
2.19.1

