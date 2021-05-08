Return-Path: <SRS0=PWqZ=KD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C0C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 10:16:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EE26112F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 10:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EE26112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fcjrh1fPGz302W
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 20:16:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=L6Ppsvbx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033;
 helo=mail-pj1-x1033.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=L6Ppsvbx; dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fcjqf4R17z2yYB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 May 2021 20:15:09 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id
 b14-20020a17090a6e0eb0290155c7f6a356so5912118pjk.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 May 2021 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sHBlht2JARMV8qJuHm3+o7R+vdo6TuZriaAYK1gHiOc=;
 b=L6Ppsvbx4wgar5gpoUSXxg7j84f5ktv7g1i7VwVMboxa1wqI7jswncNeOhumChg2Vx
 5kuhtafussfJrI67uKlluWCPtQx89Dylzbzs6Hf4jbt8r+5I1RaY7locV6yGcxuZ4Zrp
 Vj0SfyDtbVGKkIJbdf1kLTJyTEPGKKfWFhKo4KvWxZ7TT3DwGGft0X3jlZxlx7oz2Myr
 4Uy2THHJPWG4A3CnURH8X/BZiaW84EguGR3ZGZsVZ+QPauPOW2U2x42aXYrVTqlx9qkK
 6wfNbBoDPF/5U7BfltCpoP8X+0YBa6V0sftLSgeJaQSGt1ez7reM8u+3dHYKeoXTgO/R
 HH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sHBlht2JARMV8qJuHm3+o7R+vdo6TuZriaAYK1gHiOc=;
 b=pmlBGR9BD6Evae5XRbP0Wr7wDjZttjDcYmviMCykvA0z1AbXURs6YMz2qmXhwaaaS6
 GR8b7ahPddS99hiKcuHlbqANTrnYNGhUUmqmOqZBFP8S2POtstf3t4EqADQuVw19W/zN
 cm8VBS84bjpi38vX7PP8J+hZVyU/ludc2ZXGyBso9o6khbSJSyqG97WygntML6JH7b64
 YKmVdFT7lKS5lNz4358GNanXlqGLXknQskTmwcihZSIlSJIB8rDOl3yc5MghNC6qPYDD
 qfHtcwGB6Fm34IfCxZEE5g62KdW14fOiGPihrRkjWdtqwu6lY3A3WFX195fV7x6NPKkF
 68EQ==
X-Gm-Message-State: AOAM530+KQ6b3so2VjpgKMtpAj0hgg/+2XFsJuu4nnjpTcB7E8MC07S9
 EuASI8LFLdXRbxcAXFl3ZQu6IHkRt2GzOA==
X-Google-Smtp-Source: ABdhPJxAZYXondmDz/vMu69dVDukxL75wLKmhHk0Q8KfpU7qcAQF7NFJIWUtEYAWpcVKQRyAIexzPg==
X-Received: by 2002:a17:902:b683:b029:ee:f0e3:7a50 with SMTP id
 c3-20020a170902b683b02900eef0e37a50mr14934841pls.7.1620468905578; 
 Sat, 08 May 2021 03:15:05 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-241-47-46.tpgi.com.au. [60.241.47.46])
 by smtp.gmail.com with ESMTPSA id
 c13sm6608465pfl.212.2021.05.08.03.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 May 2021 03:15:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/4] Fix queued spinlocks and a bit more
Date: Sat,  8 May 2021 20:14:51 +1000
Message-Id: <20210508101455.1578318-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This didn't seem to send properly, apologies if you get a duplicate.

Patch 1 is the important fix. 2 might fix something, although I haven't
provoked a crash yet.

Patch 3 is a small cleanup, and patch 4 I think is the right thing to do
but these could wait for later.

Since v1:
- Improved comments, changelogs, code style / wrapping.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc/pseries: Fix hcall tracing recursion in pv queued spinlocks
  powerpc/pseries: Don't trace hcall tracing wrapper
  powerpc/pseries: use notrace hcall variant for H_CEDE idle
  powerpc/pseries: warn if recursing into the hcall tracing code

 arch/powerpc/include/asm/hvcall.h         |  3 +++
 arch/powerpc/include/asm/paravirt.h       | 22 ++++++++++++++---
 arch/powerpc/include/asm/plpar_wrappers.h |  6 ++++-
 arch/powerpc/platforms/pseries/hvCall.S   | 10 ++++++++
 arch/powerpc/platforms/pseries/lpar.c     | 29 ++++++++++-------------
 5 files changed, 49 insertions(+), 21 deletions(-)

-- 
2.23.0

