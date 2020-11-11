Return-Path: <SRS0=kIvJ=ER=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B396C5517A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 11:15:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF47620659
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 11:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZZajbZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF47620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWMbr1C7ZzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 22:15:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oZZajbZk; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWMQH3d1nzDqb0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 22:07:34 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id f21so800134plr.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 03:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N9WOVOySLT6I3GdZDGmxLF1+D/YdBUYGAyOrinwGECY=;
 b=oZZajbZk62T0v6JILfrOwxWZwMHOQG80TMDS1INiNWCLQw6jEKqaFxs9ChXDprHVP4
 gxa6et9kKWcofGqXNIV6Pj3mAqT6OvDNYMjUgevZ7YIp12por+sUFx+bupfb6yGREP9u
 keh+ZRu+wRD2T40CMF/4fcH3KakueNJM+Aj+kJnpjGZKJy3c7RtAdkqBCSxsVzT5LZVo
 rpjZpE0bQYC50BU/ubd+FEmKXZYys3/6V2k1aATD8cQ2O+0D6tN0VdnarHEQ6oWC5uop
 djN8jpAPp10HtB862qnCYRnvOkKZbjmjVkEWzH2PRegzPiuJQre6kZgWVvMzazzu/K9t
 k/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N9WOVOySLT6I3GdZDGmxLF1+D/YdBUYGAyOrinwGECY=;
 b=IywMWKUnDayoxTh5QocA599dFHiWlyXZCrI2ONYDNi7G+634wyWn7rccHVJIpwdUzM
 HADsq6P+eDv7avHFZ6h3MVJayAUEP9hzy9vCUJKmHzBRZmidrWj5QJhMfnLkRSlbZdpo
 rfDEUQyJJCwKWpTZetJl68MlJdUhjWIqoHyvKBcNUwpQfQx7spLx8yWPke/Bx59uFoVb
 WMEeuRShuzy5ptNk480pmBo+SM151TFO1NI115HmY7tP3QdzoWWT7VsZiba6rI+wOZzY
 yogBnTZE5YX4d5R4oOUYKVK01Pu9U2Wx8P0iOoYW2+xQTtjOxfi8gN7GoXIkCQuzUULm
 +Mnw==
X-Gm-Message-State: AOAM5309wYZrPmlTyq6oNy4i+ihTm52lCY8GAwvfoPpvneyKiTakISMb
 TgteZulfKfa//92IX4m6BovHXm9dECk=
X-Google-Smtp-Source: ABdhPJyDttk9RAk/tJT2toeUMROv7QB4mIAfIhexx29xo3detoty5pzLTTKNL9F+EqpZxj3mDDzBjg==
X-Received: by 2002:a17:90a:f691:: with SMTP id
 cl17mr3337938pjb.231.1605092852045; 
 Wed, 11 Nov 2020 03:07:32 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id 9sm2154943pfp.102.2020.11.11.03.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 03:07:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] powerpc: convert to use ARCH_ATOMIC
Date: Wed, 11 Nov 2020 21:07:20 +1000
Message-Id: <20201111110723.3148665-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This conversion seems to require generic atomic64 changes, looks
like nothing else uses ARCH_ATOMIC and GENERIC_ATOMIC64 yet.

Thanks,
Nick

Nicholas Piggin (3):
  asm-generic/atomic64: Add support for ARCH_ATOMIC
  powerpc/64s/iommu: don't use atomic_ function on atomic64_t type
  powerpc: rewrite atomics to use ARCH_ATOMIC

 arch/powerpc/include/asm/atomic.h    | 681 ++++++++++-----------------
 arch/powerpc/include/asm/cmpxchg.h   |  62 +--
 arch/powerpc/mm/book3s64/iommu_api.c |   2 +-
 include/asm-generic/atomic64.h       |  70 ++-
 lib/atomic64.c                       |  36 +-
 5 files changed, 324 insertions(+), 527 deletions(-)

-- 
2.23.0

