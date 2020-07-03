Return-Path: <SRS0=ZYlp=AO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFACC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 07:39:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B584206B6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 07:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx/HrLI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B584206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49yn064lhfzDr96
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 17:39:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Sx/HrLI1; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ymw41dLrzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2020 17:35:31 +1000 (AEST)
Received: by mail-pj1-x1043.google.com with SMTP id a9so3140816pjh.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2020 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vbRBeJ+XIbof8SsSnUrtwZgJ/aiu8Z+x8SsI7+GEKqo=;
 b=Sx/HrLI1gUrhnhruDmTnduBJm6i1u2AFd+QouTv/vb5YltoyihE6ABJowb0MWAz6Pf
 +uXGTwzRxR7b4k3wQmaA6naeh+y4u9Y2BAoN9vb0ulKlIyhXQw/raf4qDDowv+9P3vx6
 YEPSk+sNOeSOK0Umr8u1rPFcNnN5aW+kfalo8IP036e6NWdMYadk5NZDPS8fvt9SB2tQ
 sSHyx3urEWcOP26k/GNZ3LLNVlsem7fH+NdDgB53nCrQVtn+Jf6XtQEbLD4BdcW+QJ5v
 JucXQVQ44J3p+gLsA04oOXln9Ypjb4MyUkxCDnJOZein/EaL7mal3GVQ2TRMyoqf03c/
 2E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vbRBeJ+XIbof8SsSnUrtwZgJ/aiu8Z+x8SsI7+GEKqo=;
 b=h0Hk5+n9J3d7/eJKtf7IIFc0aKhDSzUaXg8qNrCwHCzgqrij+BAoDuwVQ8WzwoLqqM
 WLUyBA70a1aCzB8i1NeTo2XztMX49Ix2QgZfJxiKnW5e0+l7mI0iquCp+jEbdML6ZApX
 OuMsoI1DkYyXfrvJ5BbqDnRQ2Xj8xmhAWLh0dtf6Uni4urPYJNbdICFM7TTdMB0iHEFJ
 t1aZWi1fYfQTQbfvu2RxNboBe57GiKDv5lNDpgvY/BKb4s6doA9/gvow8dPVBl6mdJiC
 AoOqFoKowkJkztJGLrsLpjWRcDgTEWXCSwVNorCeovCF9/ga46VkW7aLpjfgAHzvC4bP
 YMHw==
X-Gm-Message-State: AOAM530PwxjQ1Wv3wLW7JEkr0fHVzXV2DiaOmnV+lvVzYNg4IWY4KvLQ
 ErV3l1+kuUNGZ1vNwV5zsww=
X-Google-Smtp-Source: ABdhPJxGGr/T+DMbaejYqpR0giBM8nZ8ynq17VDv7uveaGsjhL5t6fMWI9MQnFOkBe6Nr0BI89jHMg==
X-Received: by 2002:a17:90a:db48:: with SMTP id
 u8mr5957942pjx.169.1593761728886; 
 Fri, 03 Jul 2020 00:35:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id y7sm10218499pgk.93.2020.07.03.00.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 00:35:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: 
Subject: [PATCH v2 0/6] powerpc: queued spinlocks and rwlocks
Date: Fri,  3 Jul 2020 17:35:10 +1000
Message-Id: <20200703073516.1354108-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 kvm-ppc@vger.kernel.org, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v2 is updated to account for feedback from Will, Peter, and
Waiman (thank you), and trims off a couple of RFC and unrelated
patches.

Thanks,
Nick

Nicholas Piggin (6):
  powerpc/powernv: must include hvcall.h to get PAPR defines
  powerpc/pseries: move some PAPR paravirt functions to their own file
  powerpc: move spinlock implementation to simple_spinlock
  powerpc/64s: implement queued spinlocks and rwlocks
  powerpc/pseries: implement paravirt qspinlocks for SPLPAR
  powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
    lock hint

 arch/powerpc/Kconfig                          |  13 +
 arch/powerpc/include/asm/Kbuild               |   2 +
 arch/powerpc/include/asm/atomic.h             |  28 ++
 arch/powerpc/include/asm/paravirt.h           |  89 +++++
 arch/powerpc/include/asm/qspinlock.h          |  80 +++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   5 +
 arch/powerpc/include/asm/simple_spinlock.h    | 292 +++++++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
 arch/powerpc/include/asm/spinlock_types.h     |  17 +-
 arch/powerpc/lib/Makefile                     |   3 +
 arch/powerpc/lib/locks.c                      |  12 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |   1 +
 arch/powerpc/platforms/pseries/Kconfig        |   5 +
 arch/powerpc/platforms/pseries/setup.c        |   6 +-
 include/asm-generic/qspinlock.h               |   4 +
 16 files changed, 564 insertions(+), 322 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h

-- 
2.23.0

