Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29173C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:04:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E6A22360
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2eNJ6P6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E6A22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vq915fjVzF3C5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 14:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i2eNJ6P6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="i2eNJ6P6"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vq6W4sPWzDrP5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 14:02:27 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id s9-v6so7101991pfm.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Pa4TVaRRxbmSdZsz2U2oZJOdLZGDGPBVSGD3xdgmZE=;
 b=i2eNJ6P6/wrP2nETwVo+cYcvyFA2P4NJMc+S9Xa2uEu4qu4Mk0qynVMO+vUI6mbwDR
 omltdImmksrc0W1+HpVJxZ1b8pJBfsCaGaYklETJpDoMECy7ab4IsnelElY0c76pvSkX
 b7uO69VN5g6pLuvlw5V2rkwh8j+dMFh9fWk+sZ8DVuQF/KWH5e6NL1ToraXCUl9bgcT1
 FLKresYfiDV4hO8pPxpuIM1srxk1Ciqe3V2t5ix7SQFsRxI9qXeDwYH67yIxI9AYVfEF
 EUrJsdrMNdvwDEUwoPp90wIkVPUWJqH1+GYMZdWVR8EHpogwkXA7+Bog0/j+0TPVquJH
 n7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4Pa4TVaRRxbmSdZsz2U2oZJOdLZGDGPBVSGD3xdgmZE=;
 b=Kft2Cz7ewoWhTdnTRozKfk1Z/KkgrhdU00HYbtsaoGHKEuIeNa+dRTfI9WCfv0mO0a
 ELQpBaoPxstYSvc5tNzM8eIyOXRJfjTQhvi4i9S7RSe+V2rP+cElJiCA69SgWoruX85w
 3per1a0tAkBFHsQuOpiflLApJPB7qTKA8wPTn0iNV+MefAl5ZoQNlN+Yk5FTGNpacY7w
 7kUCIEofCWhntIXbFfN5OJjYf1v88ps+bo1E0tOTOajTc3nkoVnXK/WEwvN58LJuArUG
 0xR7zCLyIjzrdA4Pa/fc3b5Q9H/5cxKJVvoKIQySBzykae1o5CHR5sL4DYtpFOHAkMTV
 y2mA==
X-Gm-Message-State: AGRZ1gL13GNgQmxEPzpJ7QFBgUau8yjgnYKwpZRZVa2g4oo54m6via3l
 EEJPwqJqV2i/yl/SO4PodD7vEqlP
X-Google-Smtp-Source: AJdET5df8zSWGcOZI83ylY6QY3hoy+nhTlz/E6kgqp5Nk9HZu5jJdeXiAE8LTSsIZc/piugegw6/TA==
X-Received: by 2002:a63:235f:: with SMTP id u31mr181454pgm.122.1542164545073; 
 Tue, 13 Nov 2018 19:02:25 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id x194-v6sm36226832pfd.32.2018.11.13.19.02.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 13 Nov 2018 19:02:24 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 14 Nov 2018 13:32:18 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32: Include .branch_lt in data section
Date: Wed, 14 Nov 2018 13:32:18 +1030
Message-Id: <20181114030218.25508-1-joel@jms.id.au>
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
Cc: Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When building a 32 bit powerpc kernel with Binutils 2.31.1 this warning
is emitted:

 powerpc-linux-gnu-ld: warning: orphan section `.branch_lt' from
 `arch/powerpc/kernel/head_44x.o' being placed in section `.branch_lt'

As of binutils commit 2d7ad24e8726 ("Support PLT16 relocs against local
symbols")[1], 32 bit targets can produce .branch_lt sections in their
output.

Include these symbols in the .data section as the ppc64 kernel does.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=2d7ad24e8726ba4c45c9e67be08223a146a837ce
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
I wasn't sure where this should go or if the ordering matters.
---
 arch/powerpc/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 434581bcd5b4..6d5fd1b95311 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -313,6 +313,7 @@ SECTIONS
 		*(.sdata2)
 		*(.got.plt) *(.got)
 		*(.plt)
+		*(.branch_lt)
 	}
 #else
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
-- 
2.19.1

