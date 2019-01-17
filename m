Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE8C43444
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA1820652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJV/Erow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA1820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gTpr2K1XzDqwF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 03:21:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJV/Erow"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gTmH40t7zDqwD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 03:19:11 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id g189so4649610pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 08:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:from:to:cc:subject:mime-version:content-disposition
 :user-agent; bh=Yh3qbiGpjxaAJvITh5Ss6ioubvpHOgUYQyUYAdIiPdM=;
 b=eJV/Erowm0GeLQUDSuaKn+WZQlg8KAmrehnq+7XT3qou8SYUM//b6DKII+2vELxhkX
 lMWnN3vmHE7MQKWnzqc1TacQO+Vm5lvmw2p6YMTJT0gRhj+BFKL5qXq2o4RuvrHhWAcE
 9F4TLqQOcHyDJa6oGchO3orqWBbBttgQR+BjmRzWkdFKpUchRnFyJdYjGZ+5s3bYfOTB
 S16HKt58iQ9pDIfNyhGI+oDzQNK85nXnh9zWWxl68RhOsSjwOaSvcsikQtzi3goPGO46
 t6Q4+oo+YYt7lNoBX82eVvc2ivLtSPHV2OctaBcJtj9KXo9VjAB1iFryBrNtYq3G7quW
 sobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
 :content-disposition:user-agent;
 bh=Yh3qbiGpjxaAJvITh5Ss6ioubvpHOgUYQyUYAdIiPdM=;
 b=MQuYWcmiMBPnnEEsH/FKbYlVnoUbWuXVpNUbmuqRpviGGOq7dDIImY1r7Zi0whw2x1
 YMeBRruFi3/OPbPoFMNoRhqskY6P9WfDreVqRiqqzblmzg4eyp/lBQ/XJZRCg6tioOfZ
 6QFuAHawuidg/bzbjKVpJFA1pExioh67+h43n1U4Fwyp6bf6yuIIq+7N+PVfftZ3t2Kw
 4qxvRdMEw1a3U7QBx3sZmu66ix+RkaT4IYvOdfDgaIE/eA4q0sLeR3BFO16yp3WeYdxE
 XCAThy8byx1fPBBiZgRV3sMdMKyPViW3UAGIPDQucFdb0rU2bDrn8QLDi5O4rRID9MaT
 QbBg==
X-Gm-Message-State: AJcUukecss307QKkZ+/sDK2egBBE7rvz6Iv95cfBsezZYiLXm4qxb8KJ
 tC4WWMCgz8NhCh4Hg310quk=
X-Google-Smtp-Source: ALg8bN6VcP5mWImeZ6h4043pxQWpbLnjO4dFoF5U+cwY7XL6VflxbmUugfVG8vV96byvGm5u1Z8szA==
X-Received: by 2002:a63:790e:: with SMTP id u14mr14051254pgc.452.1547741949572; 
 Thu, 17 Jan 2019 08:19:09 -0800 (PST)
Received: from sabyasachi ([45.116.191.230])
 by smtp.gmail.com with ESMTPSA id z14sm2576929pgv.47.2019.01.17.08.19.08
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 08:19:08 -0800 (PST)
Message-ID: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
X-Google-Original-Message-ID: <20190117161905.GA23274@sabyasachi.linux@gmail.com>
Date: Thu, 17 Jan 2019 21:49:05 +0530
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To: arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH] powerpc/cell: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
 jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove linux/syscalls.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/powerpc/platforms/cell/spu_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 263413a..b95d6af 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -26,7 +26,6 @@
 #include <linux/syscalls.h>
 #include <linux/rcupdate.h>
 #include <linux/binfmts.h>
-#include <linux/syscalls.h>
 
 #include <asm/spu.h>
 
-- 
2.7.4

