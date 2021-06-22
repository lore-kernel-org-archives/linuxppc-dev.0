Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B04CC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 13:43:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDB961289
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 13:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDB961289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8SJg60Qmz3c48
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 23:42:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=u+fSfOnG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82d;
 helo=mail-qt1-x82d.google.com; envelope-from=danielhb413@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=u+fSfOnG; dkim-atps=neutral
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8SHk1yLGz303J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 23:42:07 +1000 (AEST)
Received: by mail-qt1-x82d.google.com with SMTP id t9so16014354qtw.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xVxbtILqCw88ceHLVU0EZsBfBWPgbOpF3qWk9H0/dJA=;
 b=u+fSfOnG6lo3IJNhSxbjPNIW075wBxz9MzzzK+wZh4/mw2ZsEaqNBm5FAuzNBYjp7K
 UA3h3MhSZHMzolJAWPBh0rhdN40cHokJvVcwoDIBtSM3WCKnOK6PcThY+jbCKfNe72HG
 BRtPUeLy0zmUiwyEFps+DyyADlkrwcECxwGWLIt/9eJeBNOta432AOWU7WV8cNALMMFd
 N+AH9UEnKz6W1H4XaXH+L66j0steenylNqr0qXvDrOaURTwI8vkdJHgVTWRPyNHlcwTl
 BvgxcKskbKPxPwShApYC8DEYnCqPZ0t1p4Vw7zFaitgxjT8h7ocWilixX4xZ5KENjvyj
 WxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xVxbtILqCw88ceHLVU0EZsBfBWPgbOpF3qWk9H0/dJA=;
 b=jj3GKkkWlrqcFREz0lj3pitUz+uOQY7vbmOZXednbjPxDmHY4wNbJJDsnl6zEO1tMI
 Vuw6exkTcuXu94QQFsr08+k+gV+EwKvd/P2GXGEOVoQn4n8MzOWj7CXtr/5sEVqeQVXq
 qcK/79uBGr/RqCYfJ63TtRiNpHfsH9dyuhHZk/K+rLuKYDd7ujn04qC1TKEVHVIY74iz
 INjfm0hDmtLC7ig3jht2LGqLWUxRZYha8ec5xywT/tyi7/ssGW0l4j9nuKyteEHaTIDq
 iflkVIy2fjOQk2ZcNvABGEWzkZywGYjeL8QeRYfOoE9KplG0D2TKi7eCSdbyUw4/FPXS
 Wi0g==
X-Gm-Message-State: AOAM532F4YRri/Ub/2CrmIZ3zRNqd8sn0Wy50ueSbHgWRW01Eu+pzAWu
 JUwk1l653/AZNPUNgn/eNUEbi32G73o=
X-Google-Smtp-Source: ABdhPJxg+ZZrcAmhDlfgzcZLOONukHqb5PvNQihvPqEDD0OIuTmGBhfkdlPeilmQ4gEYDRZdi+8WNg==
X-Received: by 2002:ac8:4e2e:: with SMTP id d14mr3454648qtw.205.1624369323570; 
 Tue, 22 Jun 2021 06:42:03 -0700 (PDT)
Received: from localhost.localdomain ([191.19.29.157])
 by smtp.gmail.com with ESMTPSA id r19sm1644491qtw.59.2021.06.22.06.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 06:42:02 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] powerpc/pseries: cleanups for dlpar_memory_add* functions
Date: Tue, 22 Jun 2021 10:39:20 -0300
Message-Id: <20210622133923.295373-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.31.1
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

These are a couple of cleanups for the dlpar_memory_add* functions
that are similar to those I did a month or so ago in
dlpar_memory_remove_by_count and dlpar_memory_remove_by_ic. 



Daniel Henrique Barboza (3):
  powerpc/pseries: skip reserved LMBs in dlpar_memory_add_by_count()
  powerpc/pseries: break early in dlpar_memory_add_by_count() loops
  powerpc/pseries: fail quicker in dlpar_memory_add_by_ic()

 .../platforms/pseries/hotplug-memory.c        | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

-- 
2.31.1

