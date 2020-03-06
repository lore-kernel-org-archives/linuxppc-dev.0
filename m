Return-Path: <SRS0=OxMP=4X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B995C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 13:49:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11A02084E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 13:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="hqyTcqIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11A02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Yprv1FM4zDqw1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Mar 2020 00:49:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=hqyTcqIG; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48YpVn6tx9zDr28
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2020 00:34:09 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id g6so883272plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2020 05:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
 b=hqyTcqIGcYRSfxPhsTnMYXAKvfyWxWa9yNdPDtkX8UTSp8Hd5c1GqP/I9nYxLw3Ewn
 KZnKO/QRU/7DKwObIXQu8nKYZpg+Uel8JNQ+AAx3ZD/QstxlgjHhWTsIpOev+rE6q8zl
 GdmTa5OE7dkxYmC3PY9TgsD8BgAT9geSvp5+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
 b=i6X49Jjze6L14XjA8sBhLVQWVu6VUweq991aEzXqk8ZPytqebPurRA8f8xLPE88Wka
 E/w7ECrSNyWmPb/2rjHAPRRXEc5/x+bd1y5s3m7Yl8/5SLU/QSMnpztswinb+A9ZKhUg
 YOMdEcHQmM4sPT0JjGQImov09GQlLzdpTAcwJ71jGwmUfLEDffp19cgYfzKRGz/Xd0Nm
 MBnjsvJrbhQKU5jly3bjrkVSMbmK/q+32qxk7ToXeV1lqI7kL4fMaK+FVYiHt/gNiCCn
 bB+BbuIx0GK2gJflnJRNaiiByWIHpoTh05/B61ViuDciJGivFsb68wiMGqCKAiw4VFvL
 djuQ==
X-Gm-Message-State: ANhLgQ3dTXggdPI3TgscXnQph73f+MMEpayDqeydltBzb7G720Cbgpu9
 hiJqYGdQmCX5FKavBT2o2xWMIg==
X-Google-Smtp-Source: ADFU+vv+KMS5gERf7CXGqDJLMTaerPdFTQAHXXtiRFVoMb3eP1LLQdOrxWN074muoj0uvCZ6KfuIIA==
X-Received: by 2002:a17:90b:4c4d:: with SMTP id
 np13mr3730802pjb.58.1583501647865; 
 Fri, 06 Mar 2020 05:34:07 -0800 (PST)
Received: from localhost
 (2001-44b8-111e-5c00-b120-f113-a8cb-35fd.static.ipv6.internode.on.net.
 [2001:44b8:111e:5c00:b120:f113:a8cb:35fd])
 by smtp.gmail.com with ESMTPSA id x11sm35601211pfn.53.2020.03.06.05.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:34:07 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
 christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: [PATCH v8 3/4] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date: Sat,  7 Mar 2020 00:33:39 +1100
Message-Id: <20200306133340.9181-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306133340.9181-1-dja@axtens.net>
References: <20200306133340.9181-1-dja@axtens.net>
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..36a4e1b10b2d 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,4 +2,4 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.20.1

