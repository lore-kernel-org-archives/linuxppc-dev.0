Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9626EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:11:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16404217F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="bSeL2yPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16404217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440tw82GjdzDqYL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:11:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="bSeL2yPp"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440tmy04z2zDqXd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:05:05 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id k15so4003387pls.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p2egav4fAG375GOuS+egjg+nfkVekpMJLDtsBFpP9fc=;
 b=bSeL2yPpLtP2R+D9Ijw2mOdNvMzXbbrqce8VboBkFX+McvnSJuD9u5HZDZ2hztx5A2
 NdIMc5u0mnd25ywHI7G/bt6ndkqbBp+ZuJ5OxJIj3v+T91ypez743hFtTKj7kH2VJjET
 k/mrCn1/kbqqKFVzyNWK/C/M0s16vgT5TySeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p2egav4fAG375GOuS+egjg+nfkVekpMJLDtsBFpP9fc=;
 b=TgtGwvm7Pjj/eOpAZiM/haJ9NhAns4msYrQpDhlUdTQGZeQ4TdRciDbtoq34GS1wPW
 t0BJzIC2DFS8TqBsM5mxso0RgILL5p+qGFxJ11PvJ3ox6JRhnXiSNZ8bWehUzDqPInb5
 LBKvNv48FRk/jzyVjhGKiu+xT2MeKLCnKw7ar99qXgciac2/d7ZqtT/YWZl90s6CDAGg
 kmA/e7uu9AcbtgZM233F7KgJJtb2EOxEfzBmP6ZqhwUliZw/QT3oXVAkIyv5yoKvtcdR
 g6953r12BJmO/pe/qyImkvR/cQLz8N+LI8FGB4Yy24AktPVV8HvDuJRy8PRKByv9m/DC
 KODw==
X-Gm-Message-State: AHQUAuYRMgLtQYSdlOsosizWgw91qdfhjcmk9w7OrStOgonlTeci9fbo
 oehhkHiMlS3NIqgc4BgHNJ3A2w==
X-Google-Smtp-Source: AHgI3IYTQMiSTPyCPDtg6l0gBhkxTjusDGcckdrJt+0prsWEB0nOhZTeSuwE88O7sP8igwZTxrwC6w==
X-Received: by 2002:a17:902:8690:: with SMTP id
 g16mr7208049plo.81.1550189104139; 
 Thu, 14 Feb 2019 16:05:04 -0800 (PST)
Received: from localhost (124-171-165-212.dyn.iinet.net.au. [124.171.165.212])
 by smtp.gmail.com with ESMTPSA id
 b12sm6082023pfb.30.2019.02.14.16.05.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:05:03 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFC PATCH 3/5] kasan: allow architectures to provide an outline
 readiness check
Date: Fri, 15 Feb 2019 11:04:39 +1100
Message-Id: <20190215000441.14323-4-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215000441.14323-1-dja@axtens.net>
References: <20190215000441.14323-1-dja@axtens.net>
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In powerpc (as I understand it), we spend a lot of time in boot
running in real mode before MMU paging is initalised. During
this time we call a lot of generic code, including printk(). If
we try to access the shadow region during this time, things fail.

My attempts to move early init before the first printk have not
been successful. (Both previous RFCs for ppc64 - by 2 different
people - have needed this trick too!)

So, allow architectures to define a check_return_arch_not_ready()
hook that bails out of check_memory_region_inline() unless the
arch has done all of the init.

Link: https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
Link: https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
Originally-by: Balbir Singh <bsingharora@gmail.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 4 ++++
 mm/kasan/generic.c    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index f6261840f94c..83edc5e2b6a0 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,6 +14,10 @@ struct task_struct;
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
 
+#ifndef check_return_arch_not_ready
+#define check_return_arch_not_ready()	do { } while (0)
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
 extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index bafa2f986660..4c18bbd09a20 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -170,6 +170,8 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
+	check_return_arch_not_ready();
+
 	if (unlikely(size == 0))
 		return;
 
-- 
2.19.1

