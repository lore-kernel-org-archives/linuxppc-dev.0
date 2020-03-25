Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAD2C43331
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 10:37:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E476320772
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAyoRTqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E476320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nPgm6rtpzDqhF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 21:37:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630;
 helo=mail-pl1-x630.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=FAyoRTqG; dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nPd82hLnzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 21:34:52 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id g18so667857plq.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NyrPfQMtuxVfZmf42P+L63vgrz96KmwOJScO9uCxpFk=;
 b=FAyoRTqGbz12ipzB0K6d3eGk1JPzUOBQj+g65zd9Jbexrjo7o7iuyzdQGIOitNNFP+
 CCdfVv2eg1gxqiFailHabvq9ci61qVZVGil1HSsCQssTREGIfW6yZP2KLz6PmEc08PaR
 gZg/7CC6dw1U/wCH5AwvYf2ZG1SXHYL+/D9fKMVRNjLS9vIc28gFdeQta4vEnbalziCY
 P/1lIDg5UP05OnJK91TzH1gta/jUdlfePGyD92PkCtnctnAm/HO3Gh3gU6zpO4WSmHDe
 3xhnNSUKZDuTnhHQir7HmLl3A0DoBkbth2wUHvFvXCvX+Dk0gS+KEGuHpoTaknFVTT0u
 EbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NyrPfQMtuxVfZmf42P+L63vgrz96KmwOJScO9uCxpFk=;
 b=YfCPGP1g8KZL7HYsWeUivC6xCGXhmd5avUg5jFL9eof7l/l/KtuYT1ykKQ5Ow8owkG
 FABFxKwJHlbopLsLgG7OMlD1G7xecRMpvX82rVadGlzTywJusXoX+goPLUfkhzeX/mi6
 nCJRMNQMQri/aP8Iob2jPflpcY4KuwK3fF/weGndosnh/2Cx+kYu6sEpaGndDb6YdB1Y
 9A0B7veLqbQvwGQpfWa4skOuvm3hfre3m+/ySrOLsbZwSOyQ8XiQKZZnNx4Om6u0/Mx0
 sfRDGa7sXlhDVxjrwlnhE6DYStKHp3WLZ1HIb3XdLHjKgmiOGsu+UYpURgUBjVUhG9Ia
 eseA==
X-Gm-Message-State: ANhLgQ3c9IXAVEsrqqn2J4QfYbqa/cJWfVsAHwd60APdh4mORQ2AX1wO
 YmC+Fu/Y0okLjm51zLg42xk6TCPb
X-Google-Smtp-Source: ADFU+vtgnOzoqaKwH1j/loy5pfn8v+DVsmte5X+M0nSA3NNU5WpUPRH81FlXyXKFh+QFWaghkrr8zw==
X-Received: by 2002:a17:90a:8909:: with SMTP id
 u9mr2951392pjn.149.1585132488204; 
 Wed, 25 Mar 2020 03:34:48 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id b9sm16549701pgi.75.2020.03.25.03.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 03:34:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/12] powerpc/64: machine check and system reset fixes
Date: Wed, 25 Mar 2020 20:33:58 +1000
Message-Id: <20200325103410.157573-1-npiggin@gmail.com>
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There's a bunch of problems we hit bringing up fwnmi sreset and testing
with mce injection on QEMU. Mostly pseries issues.

This series of fixes applies on top of next-test, the machine
check reconcile patch won't apply cleanly to previous kernels but
it might want to be backported. We can do that after upstreaming.

This doesn't solve all known problems yet, but fwnmi machine check
and system reset injection in QEMU is significantly better. There
will be more to come but these should be ready for review now.

Thanks,
Nick

Nicholas Piggin (12):
  powerpc/64s/exceptions: Fix in_mce accounting in unrecoverable path
  powerpc/64s/exceptions: Change irq reconcile for NMIs from reusing
    _DAR to RESULT
  powerpc/64s/exceptions: machine check reconcile irq state
  powerpc/pseries/ras: avoid calling rtas_token in NMI paths
  powerpc/pseries/ras: FWNMI_VALID off by one
  powerpc/pseries/ras: fwnmi avoid modifying r3 in error case
  powerpc/pseries/ras: fwnmi sreset should not interlock
  powerpc/pseries: limit machine check stack to 4GB
  powerpc/pseries: machine check use rtas_call_unlocked with args on
    stack
  powerpc/64s: machine check interrupt update NMI accounting
  powerpc/64s: machine check do not trace real-mode handler
  powerpc/64s: system reset do not trace

 arch/powerpc/include/asm/firmware.h    |  1 +
 arch/powerpc/kernel/exceptions-64s.S   | 33 +++++++++++---
 arch/powerpc/kernel/mce.c              | 13 +++++-
 arch/powerpc/kernel/process.c          |  2 +-
 arch/powerpc/kernel/setup_64.c         | 15 ++++++-
 arch/powerpc/kernel/traps.c            | 18 +++-----
 arch/powerpc/platforms/pseries/ras.c   | 62 +++++++++++++++++++-------
 arch/powerpc/platforms/pseries/setup.c | 13 ++++--
 8 files changed, 118 insertions(+), 39 deletions(-)

-- 
2.23.0

