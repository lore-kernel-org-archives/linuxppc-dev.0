Return-Path: <SRS0=Z2Z0=4A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B26C2BA83
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 05:54:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDB62073C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 05:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="DumKrTfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDB62073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48HTNQ42QwzDqQ1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 16:53:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=DumKrTfg; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48HTF92kdyzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 16:47:41 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id b9so470371pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2020 21:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CaOpE+RnykMge29WfCqnRai8zpZuPSzzYfJQc7CCb6s=;
 b=DumKrTfg6Pqfw9FrH+l5y8HVJp2QumCRHOGDX7JDwWlRy3JJ1NsWvcygtvbhXQXQXX
 77Qc41YkGfOUkwaBIJHLaCstScOHwiBM55UPUwjKsDUo67xZsvFLMv2Ykxrnr6UzEpSX
 T80Z/ivcAMzC80gn7Oq03L2DEu6lw7qTZQ76s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CaOpE+RnykMge29WfCqnRai8zpZuPSzzYfJQc7CCb6s=;
 b=SqMKLxc/4oBPacVCslem11ke5iNxTHdWAUFmzE8N5cxWOJLiaxm8sjEJX1C4OBUx7y
 Kv+axKI/VRgFQT+aztoy7Z/F56IAJIAvsAFgdtFZSzIb4P4npe27kdwRuejS6yfObRnT
 C7BjivIYfmfeAVfaaf7PGsM3VEasq/GxFHckaplrtkznIC24bWP7mv/1lXPc0mRLLOds
 jOhh2OcFWc0hdxSQKb8FJOuTESFxpBjBM5f7yxPZ91IBnpPEaaeAov7/0U7nMEryaIAg
 0VfByrjrEp6t0QchDtnHljaz+UZK7hY2Sjmyz3Dd8m9GJNUM1geMZeR4+xkoGzEdi3Hx
 5WuA==
X-Gm-Message-State: APjAAAVfmp/uvjMk+3zkYP2FHgonR2DdxtTzLufSCv5KlgCZtvr9M25+
 za1oBr3qcAUdfDrwSNpj9NJNvA==
X-Google-Smtp-Source: APXvYqz7EkVSmJF3ZGM8CrPp3b6VnGwsCFVCqzLEvUQDWK6xIBDQVJZHgKocIRP2ZJE/jpgLHWCYKA==
X-Received: by 2002:a63:c601:: with SMTP id w1mr10154971pgg.449.1581486458953; 
 Tue, 11 Feb 2020 21:47:38 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-65dc-9b98-63a7-c7a4.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:65dc:9b98:63a7:c7a4])
 by smtp.gmail.com with ESMTPSA id h13sm5424371pjc.9.2020.02.11.21.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 21:47:38 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
 christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: [PATCH v6 2/4] kasan: Document support on 32-bit powerpc
Date: Wed, 12 Feb 2020 16:47:22 +1100
Message-Id: <20200212054724.7708-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212054724.7708-1-dja@axtens.net>
References: <20200212054724.7708-1-dja@axtens.net>
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

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Document s390 support while we're at it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Changes since v5:
 - rebase - riscv has now got support.
 - document s390 support while we're at it
 - clarify when kasan_vmalloc support is required
---
 Documentation/dev-tools/kasan.rst |  7 +++++--
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..012ef3d91d1f 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,7 +22,8 @@ global variables yet.
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
-riscv architectures, and tag-based KASAN is supported only for arm64.
+riscv architectures. It is also supported on 32-bit powerpc kernels. Tag-based 
+KASAN is supported only on arm64.
 
 Usage
 -----
@@ -255,7 +256,9 @@ CONFIG_KASAN_VMALLOC
 ~~~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
-cost of greater memory usage. Currently this is only supported on x86.
+cost of greater memory usage. Currently this supported on x86, s390
+and 32-bit powerpc. It is optional, except on 32-bit powerpc kernels
+with module support, where it is required.
 
 This works by hooking into vmalloc and vmap, and dynamically
 allocating real shadow memory to back the mappings.
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..26bb0e8bb18c
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is optional, unless built with modules,
+in which case it is required.
-- 
2.20.1

