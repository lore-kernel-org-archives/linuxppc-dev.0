Return-Path: <SRS0=xZg/=UV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9321C43613
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 13:32:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD63205ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 13:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKvDTqWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD63205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45WGhJ0TWnzDq5n
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 23:32:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gKvDTqWf"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45WGKG51hYzDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2019 23:16:18 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id z75so2077795pgz.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2019 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9v0Jo/4C6u+j9lTVKp8lADVfsWbF6A2T8ZoeMXsA74k=;
 b=gKvDTqWfEBrRb4DIsZjrUG1gOnaQHl72G630VJinxh9Xxg7nRVlsT7/tKVRp87Qtgy
 CPBDqTG80zC1JQzhIfeaOSa3vKA9VP/knt+l9iLp9GfzWyOEKeurtYrSdDHGXMTOyd6s
 8T5DNKdAiT6Pv9ly1MDD+wl22nybWubKWmJ5C4JtSHIpDIPXWmI6eatIRRRZoKDQQ4Cb
 njnosLFHWJ5eaU/OFwLZDar7lL8kQuHbAX8jpd9tQ6CH8kB0hvdwcmziyfyq3Z3+8p1H
 tdkQeANN2L+TSBkPPGiUl0GHsCO4Vg/f1fp2c1uzLzV5S5sFie9qwHLIc0bOoA+wQKRA
 ufEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9v0Jo/4C6u+j9lTVKp8lADVfsWbF6A2T8ZoeMXsA74k=;
 b=OhFNSalzY+BlK4Q/zWOMIHwwkislTvdg6OuRjLWuWeTTlPAfdQKSDf9q4SxIUwP3ok
 BZd7H+hSZzvVoM+8IPyd9MjZCSh0msomC36yxWzepyahxbIsQdrzPwTk6Z5kQrZv2mWK
 68O6h+ppJMrXV7IokoAbGNTNnZXZDTbe/juP4qVklPnEF1LCWKNWEACxkVWGLOHAk69d
 ildfklCgkeLVhTXpRKGppyr+Tdv8WC3ZCYJXYWSua7qGHkRG1USWvVnSZLydM0wBpiKA
 YwVVzzYBy81GeaWWhAfuqTs58ePasRmAG8a7AvbdyoHz7NQNdoORAjcHdPH3ALVRJT1P
 TgKg==
X-Gm-Message-State: APjAAAUXA8ghTPzFTp/MG1BgHdJA3JF6SzlJ8U0yYqg/FcDvS/jnTwNM
 XNazo50jdee/VafTCpQa09VNjZ0Fhx8=
X-Google-Smtp-Source: APXvYqxPDcp5F+Tuh7f5j6s5grR1VcBpOgpQ2qf9vy2t+XEYv4o+nJvNdWkKXjd4fXAHvA2WADCMsg==
X-Received: by 2002:a17:90a:80c4:: with SMTP id
 k4mr13253938pjw.74.1561209376227; 
 Sat, 22 Jun 2019 06:16:16 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([1.144.136.2])
 by smtp.gmail.com with ESMTPSA id n1sm5192471pgv.15.2019.06.22.06.16.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 22 Jun 2019 06:16:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 04/25] powerpc/64s/exception: fix sreset KVM test code
Date: Sat, 22 Jun 2019 23:15:14 +1000
Message-Id: <20190622131535.20996-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622131535.20996-1-npiggin@gmail.com>
References: <20190622131535.20996-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sreset handler KVM test theoretically should not depend on P7.
In practice KVM now only supports P7 and up so no real bug fix, but
this change is made now so the quirk is not propagated through
cleanup patches.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4ebe39c74aa0..1a2ad5a022e8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -126,10 +126,10 @@ EXC_VIRT_NONE(0x4000, 0x100)
 	bltlr	cr1 ;	/* no state loss, return to idle caller */	\
 	BRANCH_TO_C000(r10, system_reset_idle_common) ;			\
 1:									\
-	KVMTEST_PR(n) ;							\
-	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206) ;	\
+	KVMTEST_PR(n)
 #else
-#define IDLETEST NOTEST
+#define IDLETEST KVMTEST_PR
 #endif
 
 EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
-- 
2.20.1

