Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452BC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 14:50:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD1F2081D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="PRKDMHBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD1F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qCCW3GQKzF3DX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:50:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="PRKDMHBQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="PRKDMHBQ"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qC8t1xv1zF3CM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 01:48:28 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id r64-v6so6193895pfb.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 06:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=QRUz2Nr1kqfJktC7qw/kDjCnnn1GyDOb2GGTwPoK5UI=;
 b=PRKDMHBQxo21gvVPVGcMn62TPHKc/mxRvISwkM5wmOqWcQtswpxq/hAJ7CFs76VgBV
 Q5fJ20/kWU/m8kiVf4n5IhLo0XdVGQ5t240ndA7B453XPX4HHJfh1DEhRBWqeAEL7qVn
 Kf1vjQKwLdhmNCD6rtV5aunzdg29ptpJDJVp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=QRUz2Nr1kqfJktC7qw/kDjCnnn1GyDOb2GGTwPoK5UI=;
 b=IivQUS/Pmc/bajn3m7WFA9WZRKnuINxqF5ys+HbuFx7BCtXSnhxWUgA5jHFBKxQUiv
 T7g5lGu0WFczOjZB1S2e07ozicDl1tnKVkIyaOT661QIyv+tY5a9YgyImZz2ly3sxskV
 FWoPsku6h0PPZZlhZ8tFZoVW6GfSrIAXulGmbVPzrA6DEy7Pi55MVNq2d+xcw761dOLl
 cL9TWsroTJfcIDZFMy/kUKjYdveBjRhnkF9OTLtj/QMypz6bQPuoEPQ7aLiZMZ48WmX4
 c7ujxIjdR8EJy1iKqB08ep98HEuMkVG7bSo+Kl2qcu0PasTrRhGdPXSV/1q/SKmWPKee
 oPmQ==
X-Gm-Message-State: AGRZ1gKsUhZgEchtsdHiuTUnONHfQmkPLpokuWvtrW8SdBk7NYeh26na
 gwwk0/WbkNvmv15MH9BhRESSsyRhInQ=
X-Google-Smtp-Source: AJdET5fk1e/3lPPcP+5+OIPgmrpdYe1l0PATSTmN1iAvh2niqZA9v2j8XYLRpvHgl7/6/hlThL9HhA==
X-Received: by 2002:a62:8c93:: with SMTP id
 m141-v6mr26091688pfd.239.1541515706184; 
 Tue, 06 Nov 2018 06:48:26 -0800 (PST)
Received: from linkitivity.iinet.net.au (124-171-110-15.dyn.iinet.net.au.
 [124.171.110.15])
 by smtp.gmail.com with ESMTPSA id i88-v6sm46896794pfi.66.2018.11.06.06.48.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Nov 2018 06:48:25 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: mark 64-bit PD_HUGE constant as unsigned long
Date: Wed,  7 Nov 2018 01:48:03 +1100
Message-Id: <20181106144803.23687-1-dja@axtens.net>
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When compiled for 64-bit, the PD_HUGE constant is a 64-bit integer.
Mark it as an unsigned long.

This squashes over a thousand sparse warnings on my minimal T4240RDB
(e6500, ppc64be) config, of the following 2 forms:

arch/powerpc/include/asm/hugetlb.h:52:49: warning: constant 0x8000000000000000 is so big it is unsigned long
arch/powerpc/include/asm/nohash/pgtable.h:269:49: warning: constant 0x8000000000000000 is so big it is unsigned long

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Boot tested on a T4240RDB.
---
 arch/powerpc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f6a1265face2..9ea903221a9f 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -289,7 +289,7 @@ static inline bool pfn_valid(unsigned long pfn)
  * page tables at arbitrary addresses, this breaks and will have to change.
  */
 #ifdef CONFIG_PPC64
-#define PD_HUGE 0x8000000000000000
+#define PD_HUGE 0x8000000000000000UL
 #else
 #define PD_HUGE 0x80000000
 #endif
-- 
2.17.1

