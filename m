Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC7CC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 08:26:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C39561B06
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 08:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C39561B06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gp6hd5Nrsz3cmd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 18:26:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=jT7PHESt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jT7PHESt; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gp6dx5LX2z3bbx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 18:24:37 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 j12-20020a17090aeb0c00b00179530520b3so10681134pjz.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ez5nRjqbyCLB7lm8hB7epSqLa5vR5YmVpdnQUI3QfY=;
 b=jT7PHEStIC9OiP7hVe1Il+bqxY3kIyjQuCmTCPEYroUVGIKH7+DT1PLZ1u8ByboTWD
 J6sMx/hR7DgHZU+MYW1YOIy/Mp4P3yjsdQij7U5CAfkDtZS2LRFQx6ecSsXGdPRxIWjs
 SY2VqTauFZbfJVYmjPSn0OjzwVmDsyj1paLTiBYXZweq1Fxjd4kacLqqZ3rTvpKc32OU
 5TftEWvUrRlqDq+Db0NbRmpTbnByPv6DWMtgrYjlXrvuSuezu680VDfcSDhDcDYKk9bW
 r/mQ/c03oEuPuzLHNk+5l70AYkAzMlkPeLARa77sqzNjNBV7Sa91dfUtUYthcz0ztK6U
 DNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2ez5nRjqbyCLB7lm8hB7epSqLa5vR5YmVpdnQUI3QfY=;
 b=gW16QDJbLcrjhA2LaGe8fdbm5HG8wbE7ty+7oYyZKokvbMSeM5TcVND+SQH+u+OO8u
 9g3e+koGOApsMLxPPmtgrzKRdDG0PLPAGkCzIBNykQxnmPlF4ecZ2dilleHQoUAOU8eS
 vQY89ZSxYGiVUE58nnThGnG3+2hSilKLT/edRE1PfguLIXR2ZCBttxgLpB4gz7SLVzzD
 lFfSwA9rz8DFhg3zd/9ulotbb0wnUtbwwkr9srey0AtVGqMEKJ86Jq99+8kABEBCL/99
 xCXy6Bb7tV0EMNA2H/wRS8FLkPJwDXJlTAoXTSx6CsT1EtBeMtjii4/ZFavvxuROFqct
 DODA==
X-Gm-Message-State: AOAM531uMbOg7T/1HpyjEbOySmeBlugTuFb0++n0J5XB9/xt4eAb5At3
 jx3Jp2PA1kCC7J7yg6DOQPs=
X-Google-Smtp-Source: ABdhPJw3TZc2M6QWwTA0ZOwBxq6+qgWGYC/OU5iZbIDZB6+o8ehBEFev/3yWRQiO2hzuDj9RtNeXPg==
X-Received: by 2002:a63:6983:: with SMTP id
 e125mr14966187pgc.389.1629102275204; 
 Mon, 16 Aug 2021 01:24:35 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id u24sm10542358pfm.85.2021.08.16.01.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 01:24:34 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/microwatt: CPU doesn't (yet) have speculation bugs
Date: Mon, 16 Aug 2021 17:54:03 +0930
Message-Id: <20210816082403.2293846-4-joel@jms.id.au>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816082403.2293846-1-joel@jms.id.au>
References: <20210816082403.2293846-1-joel@jms.id.au>
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 663766fbf505..d5af6667c206 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -279,6 +279,7 @@ config PPC_BARRIER_NOSPEC
 	bool
 	default y
 	depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
+	depends on !PPC_MICROWATT
 
 config EARLY_PRINTK
 	bool
-- 
2.32.0

