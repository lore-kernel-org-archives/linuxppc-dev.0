Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8098C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:00:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A92A20851
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ2s7qGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A92A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4383SC0S1KzDqgb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 12:00:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQ2s7qGI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQ2s7qGI"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4383L13QKVzDqg1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 11:54:49 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id h3so7292273pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 16:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v4k2f2rgLU/NjQjCdL2USbJnvWMvh+n3HPFPZT4YsGo=;
 b=gQ2s7qGIGI2T6cDaEjDhP7qWQOjjF01pQuKCuhjwbupHJLh1TI/3pvSf+EaF91trpJ
 7NqxpwNR3BKemIzlBcfEB6WcvmkvGu+3J0wTjZfOibLr4KY2nEWN4/KHzgpNj9y9nq8o
 wnrlIdBFY9NplvXa+7L8l3xzUA9ZyPa1nWHiroXKl5sXu3guRM+yHB9guqllOZDslcC4
 +UiWFR4fFoT4K4Nyvvf/X9PMk+E6oN0LUqnFW0vCVbhq5dqoq+YzJ6YqRNbPiK3xgNyV
 OsBKMY4yxg2YuisuKirTtjU2BHUODfkWMVdZZvDBCTLRviZ7pn/fH5+aS6yew5UUztIE
 QLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v4k2f2rgLU/NjQjCdL2USbJnvWMvh+n3HPFPZT4YsGo=;
 b=M6O19w3sL5IV/otCKpzzKrH4Ur+9Db4pGk6vbKFUvo/HYUIWXAnPNf+O1t+b/D5VAF
 ZZMHq5TCtSep5QozK8bQ8pAC/bxV104AGuRQ1Et09xq5Q1lna95PteMx6IUghHzLpB6B
 McgcnTM/ZKoscTgDp6gdXM5WLl5/MtMPznog+xIcHIBxAcmB8IB455BXr9qa07NOUQbF
 0Hzif8K+DC/wvnu69tzc8Y/h2RnJh6TfhlZAfTyP3m82OO++1CVmJw9EW+AIHQxPfPuG
 S6eTzEhUnLeGEpVxTNWNI7YyUg2n1HLCt655js60hRkTq/p7P7qC5OiwCi16oXqxx+7X
 0YKQ==
X-Gm-Message-State: AA+aEWZSs1GvBRzfS3IZIhrelnjatS5xbVNR4Wzdnbazv2/zCggj7BTq
 HccxtypP/WTwAkMdiQ9yT1Ec2RUl
X-Google-Smtp-Source: AFSGD/XlIiUAr8A8io5RFiMFSDj8Ug1oGOZeKdVbdyP/g2eouSoJdzihg1VnqYKu8zf6ZYokMYX/yQ==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr18767396pfg.183.1543884887378; 
 Mon, 03 Dec 2018 16:54:47 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id z62sm21504925pfl.33.2018.12.03.16.54.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 16:54:46 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 11:24:41 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] powerpc: Discard more sections in linker script
Date: Tue,  4 Dec 2018 11:24:27 +1030
Message-Id: <20181204005429.32681-2-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204005429.32681-1-joel@jms.id.au>
References: <20181204005429.32681-1-joel@jms.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Building the ppc64 kernel with a modern binutils results in this
warning:

 powerpc64le-linux-gnu-ld: warning: orphan section `.gnu.hash' from
 `linker stubs' being placed in section `.gnu.hash'

Alan Modra <amodra@gmail.com> explains:

 > .gnu.hash, like .hash, is used by glibc ld.so for dynamic symbol
 > lookup.  I imagine you don't need either section in a kernel, so
 > discarding both sounds reasonable.  Likely you could discard .interp
 > and .dynstr too, and .dynsym when !CONFIG_PPC32.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
See https://lore.kernel.org/lkml/CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com/T/#m58532c86cf0c7b4fb01cc1fe724e48d4c7d8e4a7
---
 arch/powerpc/kernel/vmlinux.lds.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 434581bcd5b4..6570209b0671 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -279,8 +279,6 @@ SECTIONS
 		__dynamic_start = .;
 		*(.dynamic)
 	}
-	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
-	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
 	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
 	{
 		__rela_dyn_start = .;
@@ -388,5 +386,8 @@ SECTIONS
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+		*(.hash .gnu.hash)
+		*(.interp)
+		*(.dynstr)
 	}
 }
-- 
2.19.1

