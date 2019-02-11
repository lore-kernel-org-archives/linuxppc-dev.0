Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D089DC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 19:33:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1A12186A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 19:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1A12186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ywvT0BclzDqWq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 06:33:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yws14wgMzDqW6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 06:31:49 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4BB6BA342F;
 Mon, 11 Feb 2019 19:31:47 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AED255C21D;
 Mon, 11 Feb 2019 19:31:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/2] locking/rwsem: Remove arch specific rwsem files
Date: Mon, 11 Feb 2019 14:31:24 -0500
Message-Id: <1549913486-16799-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 11 Feb 2019 19:31:47 +0000 (UTC)
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v2:
 - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
 - Update performance test data in patch 1.

This is part 0 of my rwsem patchset. It just removes the architecture
specific files to make it easer to add enhancements in the upcoming
rwsem patches.

Since the two ll/sc platforms that I can tested on (arm64 & ppc) are
both using the generic C codes, the rwsem performance shouldn't be
affected by this patch except the down_read_trylock() code which was
included in patch 2 for arm64.

Waiman Long (2):
  locking/rwsem: Remove arch specific rwsem files
  locking/rwsem: Optimize down_read_trylock()

 MAINTAINERS                     |   1 -
 arch/alpha/include/asm/rwsem.h  | 211 -----------------------------------
 arch/arm/include/asm/Kbuild     |   1 -
 arch/arm64/include/asm/Kbuild   |   1 -
 arch/hexagon/include/asm/Kbuild |   1 -
 arch/ia64/include/asm/rwsem.h   | 172 -----------------------------
 arch/powerpc/include/asm/Kbuild |   1 -
 arch/s390/include/asm/Kbuild    |   1 -
 arch/sh/include/asm/Kbuild      |   1 -
 arch/sparc/include/asm/Kbuild   |   1 -
 arch/x86/include/asm/rwsem.h    | 237 ----------------------------------------
 arch/x86/lib/Makefile           |   1 -
 arch/x86/lib/rwsem.S            | 156 --------------------------
 arch/xtensa/include/asm/Kbuild  |   1 -
 include/asm-generic/rwsem.h     | 140 ------------------------
 include/linux/rwsem.h           |   4 +-
 kernel/locking/percpu-rwsem.c   |   2 +
 kernel/locking/rwsem.h          | 130 ++++++++++++++++++++++
 18 files changed, 133 insertions(+), 929 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rwsem.h
 delete mode 100644 arch/ia64/include/asm/rwsem.h
 delete mode 100644 arch/x86/include/asm/rwsem.h
 delete mode 100644 arch/x86/lib/rwsem.S
 delete mode 100644 include/asm-generic/rwsem.h

-- 
1.8.3.1

