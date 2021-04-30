Return-Path: <SRS0=0xlf=J3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8681C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:10:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C496147E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C496147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWrlp2tQwz302D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 22:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=OxP8F5I1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::735;
 helo=mail-qk1-x735.google.com; envelope-from=danielhb413@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=OxP8F5I1; dkim-atps=neutral
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWrlN00bKz2yjc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 22:09:34 +1000 (AEST)
Received: by mail-qk1-x735.google.com with SMTP id 66so30768149qkf.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 05:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wuvEwLcH/dvtw0Uv4RHD3+0Kld2VHKIHHcVpswqfzHQ=;
 b=OxP8F5I1/oIWgma0EDbhlTk8gdm2XtB0FbqAe+1xrs33VxAsP4kXwkanmvZDluXYKv
 7HEaE8RE/q8+5CnpU3hJPvSpIWsbnh1i2uJ02NLLH+/NmBHVR/5PPnsOCavGs4KQXKZA
 SW6V5pGsNWvRo2Nd+q+APpwtfWojx2uUToAuP4/Gq9Z/MOqU44IZe1Ry9jpor2uJb0Co
 XfQ7XifetbOt6sGqD0pCzWe7MuALpRD5ndb2X+6YABCANTbb394JjBrhlFSOrVhDnRw7
 oV0dKnexmOGgnc0NKOnnRTnXIxi9yc2RuXXvjwjdbusprHC4LxMM1cP4PMeBZ5VmLe9C
 3fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wuvEwLcH/dvtw0Uv4RHD3+0Kld2VHKIHHcVpswqfzHQ=;
 b=jqH4j1xEisaCweBvgol9B1Q9aMYQInHNAAJ3Q+Nci0RGYaLR4P0o1fNw98NX8QBeah
 ZufOaM38QOLercn37fzCmCOfOofxtKRrI1e6mTCUD1yMeZvOGzzLmnPoDkTw2ayrkfhk
 GCSpWspNs8eqIxVxyEI06VuWwCvhLnTiqmiCO+pMa38XCyIA2BWCsJqngqJ9FUo7qFXF
 It1/nhv0jbo3yXB4aVehSEa20icu6OnAXRvoy15HwGqiEscaBHrNX63OyvguWM3cHGLr
 zDUHCZbAIwxGXb2DcDOIQkz7XjJazG3Q6Q3CzmTjQZ0WcBSsCgYmaCArJhiCj8Y7WNDw
 A9dQ==
X-Gm-Message-State: AOAM5328QLnxUWL+eEI7CdxkHZIHhJx4t20y3Q8iyjg5LvoYWrFTTBG0
 vVpSQaZX4eiiJRJPmglqODYcz9kmq2eAWA==
X-Google-Smtp-Source: ABdhPJwjFSq2tL5EK0ogD2JJzlpq+otaSLQVDyKpz6OslD0XBG8Pjf0yHEdZAHlCFixCICPBkWTrYw==
X-Received: by 2002:a05:620a:a98:: with SMTP id
 v24mr5079838qkg.374.1619784568977; 
 Fri, 30 Apr 2021 05:09:28 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6de0:3db1:1b8e:b097:6036])
 by smtp.gmail.com with ESMTPSA id p190sm928951qke.13.2021.04.30.05.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Apr 2021 05:09:28 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] Unisolate LMBs DRC on removal error + cleanups
Date: Fri, 30 Apr 2021 09:09:14 -0300
Message-Id: <20210430120917.217951-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.30.2
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

This is a follow-up of the work done in dlpar_cpu_remove() to
report CPU removal error by unisolating the DRC. This time I'm
doing it for LMBs. Patch 01 handles this.

Patches 2 and 3 are cleanups I consider worth posting.


Daniel Henrique Barboza (3):
  powerpc/pseries: Set UNISOLATE on dlpar_memory_remove_by_ic() error
  hotplug-memory.c: enhance dlpar_memory_remove* LMB checks
  pseries/hotplug-memory.c: adding dlpar_memory_remove_lmbs_common()

 .../platforms/pseries/hotplug-memory.c        | 162 ++++++++----------
 1 file changed, 69 insertions(+), 93 deletions(-)

-- 
2.30.2

