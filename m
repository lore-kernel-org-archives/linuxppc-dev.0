Return-Path: <SRS0=2YcT=CG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A686C433E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2020 10:03:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D91208CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2020 10:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8laPJoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D91208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BdFXp65pmzDqsC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2020 20:03:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=I8laPJoF; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BdFTc1BGfzDqnx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2020 20:00:35 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id u20so417952pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2020 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hTusVnD1ClA8mtLb09fp9NQDzSnVoJXOXrpjrekC98M=;
 b=I8laPJoF5gq/Tx/yo6hHGNcnujKhq4w+OTtKVT+dhkE1mpMjlhx7SkoFUIwm36XWc0
 CMKdSgQvRMqB5mbglvUzmti6RR/1pIeLzak+egHk0fGTFbObciEP/5YzzZ95YjwG96b1
 r87VD6xFdBSiplVmoEnpiVUwATIxQ79dhCAlK/HqEciXnasv4yReH5uWTTBcya1bxHHI
 q+5PZzBYEas2ktSEm9L47JY//7SoSkYVarDDWTS2Z5hEj47aU6Jhm1zYQ/DONWwDZDCT
 o2EFr5ebo2ozIQnkYIm1NsQDYrnBAmIGVN4tnl6bli7pV+O6MSA1Y/ONeK0Snn55EbA/
 HsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hTusVnD1ClA8mtLb09fp9NQDzSnVoJXOXrpjrekC98M=;
 b=hgKnVV7d7H+si85JG5AtsdAuTDo0aVTOBjys+9OefkgDBUTQwrmF7aoCbf/ydVANkl
 xMlxE09YWWy2Y9f6fe6gwYfW7al2dr9G3ZRYiLUhWF+1rpu1ou3Dq/WFznIlOiW53jVG
 IDi6GzUmTQRABXdMECxEYv8dw5T49kSg7cXFddGjslIKobRGsHqgz04GDfJvkqsXKbUt
 yiWBW8trWrqVrorV4id26nUUubTViERnMFrE1xY3iJdoY+q52nosXgz3zuYdkDOvVr7s
 tIRKr/2FfGNx85viqcEaboswU5EJY6op4F9BdjrB/NjiketF9PNdb742shclHmjLJ74q
 BSIg==
X-Gm-Message-State: AOAM531ZUGGky+lyKSH772C0uc8+o52W7ebE5NF4fCfZlLQGaZUYPfgF
 q37xKJJ8a95IR7cA4vqpp4s=
X-Google-Smtp-Source: ABdhPJySkqUl0R+DKjCAETRrCLwUUvZBNU7lZcOeYY/aEtoZsU6VUskB25O9sStm08Vp5gP3u/2QEw==
X-Received: by 2002:a63:d20e:: with SMTP id a14mr653429pgg.231.1598608832848; 
 Fri, 28 Aug 2020 03:00:32 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
 by smtp.gmail.com with ESMTPSA id 78sm1068608pfv.200.2020.08.28.03.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:00:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org
Subject: [PATCH 0/4] more mm switching vs TLB shootdown and lazy tlb
Date: Fri, 28 Aug 2020 20:00:18 +1000
Message-Id: <20200828100022.1099682-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is an attempt to fix a few different related issues around
switching mm, TLB flushing, and lazy tlb mm handling.

This will require all architectures to eventually move to disabling
irqs over activate_mm, but it's possible we could add another arch
call after irqs are re-enabled for those few which can't do their
entire activation with irqs disabled.

I'd like some feedback on the sparc/powerpc vs kthread_use_mm
problem too.

Thanks,
Nick

Nicholas Piggin (4):
  mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
  powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
  sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
  powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm

 arch/Kconfig                           |  7 +++
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/mmu_context.h |  2 +-
 arch/powerpc/include/asm/tlb.h         | 13 ------
 arch/powerpc/mm/book3s64/radix_tlb.c   | 23 ++++++---
 arch/sparc/kernel/smp_64.c             | 65 ++++++--------------------
 fs/exec.c                              | 17 ++++++-
 7 files changed, 54 insertions(+), 74 deletions(-)

-- 
2.23.0

