Return-Path: <SRS0=UY8D=K3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDFDC4708F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jun 2021 06:23:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CEA61375
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jun 2021 06:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CEA61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FvMYW1xD2z3096
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jun 2021 16:23:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=W4LHJGrO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=W4LHJGrO; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FvMY00rZ5z2yWt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jun 2021 16:23:15 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id e15so6331197plh.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 May 2021 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R9w3VBsyynBzvrOKhGUnor+2tF9n4dKvU0meQmd4evY=;
 b=W4LHJGrOxmR9j6iCI+qXHFE0u44HsMkEPSrrEziVpXFsxYWySDL75LZQzT+eozQx6/
 P8LxHQ5OcolPa8nnCg84G8q8lEuhN3sQtaXAEoIMKiECXWrX5Vuw3h4AHSktWZjfXT3k
 GOKZ0H0zkcANaZBcbker5dcVfOvLYKdCyfXLoDJp37S9pO8j43wTpw0HSoIiilA472e8
 lUiH99RrUo829uszk+oFNeq6ezF9ZkpTUWhsSaQGJb0GLvo4XJD5RW65i1NKgEZ5dLdC
 5TQBZGZWAP2c+ZS749kKFePyP69Nwzx2DPvyhAXBMdUg1OrSZQXOMSJ2NweUTxt6SIg+
 3ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R9w3VBsyynBzvrOKhGUnor+2tF9n4dKvU0meQmd4evY=;
 b=T+i36+G9iBZ52E11MmzLQCoJTOTcJQ6p0ndepVvbm9ZHbSV8HxFeOFB8vwydiuTQeW
 ItcJDNuFhT3wwYA4hDlR89t4M7oX0lSx5P3kHgPB5PkSSu+s93NyxDcUyXjZan3l5+Wo
 vSdB2Ll9m169cY1LVB5FFmBFAuHad7A49cPAbcyl4/mAwNx6wEO9EfTconaXfxU+XxJF
 B+AaotRfmEdjl99svpoV0cic5gAvYDDkfxkbjiNbN6DhEXORAman4lqnqp1v6gkZFhxE
 JNu7+B8tCp5jaGuxo2P03svR6S3cXOZsitpVjRdYaUUXGI9BCX8Yi6BBaBPaebFBOBtv
 1rYg==
X-Gm-Message-State: AOAM5331C1EzrhDXd6vdRU8VDSLMkVITr4mIhZDBcZtZvKq1LMt6qeYA
 uElTPAlBsxd+lw9g9LN+WC+APLsh7KY=
X-Google-Smtp-Source: ABdhPJxdBCBt6kjcsuYhTACpiaI01k2nCclazEEWA4VvIVS22YbO1VZ/TPZyZ/KCQQgJxi56faaOqw==
X-Received: by 2002:a17:902:f68c:b029:102:e6b5:f8c8 with SMTP id
 l12-20020a170902f68cb0290102e6b5f8c8mr12494108plg.70.1622528591450; 
 Mon, 31 May 2021 23:23:11 -0700 (PDT)
Received: from bobo.ibm.com (60-241-69-122.static.tpgi.com.au. [60.241.69.122])
 by smtp.gmail.com with ESMTPSA id h1sm12519100pfh.72.2021.05.31.23.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 May 2021 23:23:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/4] shoot lazy tlbs
Date: Tue,  1 Jun 2021 16:22:59 +1000
Message-Id: <20210601062303.3932513-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There haven't been objections to the series since last posting, this
is just a rebase and tidies up a few comments minor patch rearranging.

Thanks,
Nick

Nicholas Piggin (4):
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm switching to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

 arch/Kconfig                         | 38 ++++++++++++
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 +-
 fs/exec.c                            |  4 +-
 include/linux/sched/mm.h             | 20 +++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/fork.c                        | 52 ++++++++++++++++
 kernel/kthread.c                     | 11 ++--
 kernel/sched/core.c                  | 88 ++++++++++++++++++++--------
 kernel/sched/sched.h                 |  4 +-
 13 files changed, 192 insertions(+), 38 deletions(-)

-- 
2.23.0

