Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24FFC32789
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:06:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F9720827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W7j4p7n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F9720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qSt718vmzF3Fd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 12:06:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W7j4p7n6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="W7j4p7n6";
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qSqL0ttrzF2Dy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 12:04:13 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id p6-v6so7045705pll.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 17:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AdAdeS4sZQ8YU1vAJNV5eR8xeGN1ehQuodDt1kCsI6A=;
 b=W7j4p7n6cVnICxU3fNbrsRLIna/24le2c2DHgzKLMFf5CQnUYOE2mZUtt2Rw7cFgi6
 K1v0NjXfenWwuPfGX4TL/6/Henxpcn35IpbF7yXLn6/NLFzfnwdGwXNL7gL4KSJTVfu4
 3gwDRe5HZSKr3bULeqf4DdS9aSwrikmCeHVEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AdAdeS4sZQ8YU1vAJNV5eR8xeGN1ehQuodDt1kCsI6A=;
 b=nPRSgP3LhFifETCQ5PDMAvQ4C70dxeORKjZ+O6QjG0KGJ2Z04lQPnzxqHZkO9WDjrx
 zFZKa22DSzan0sl170KWy1rtyZr81HTdoJ9+9F733sXQLhTHFwk+dHLWEgpPeIVCuaUJ
 Hn5sEoxrkS4eFFy1zBcPc9javqVAPx4lWbGsJfUJPw7NFzxBKJbKt8igHB712KlwaSux
 EpUgTVqQIh1LGJP3QL6/Kxpxeac0+l2Y9b8NUdDiVGAOrtRPpFG5VltliEk/5Ehf2OE9
 1qxduVX9emSzfzT2kDm4WEDn5iYgzldekxff3Y7artUJe0vdPbDbkwYtO2DEamgMV9+z
 xcVw==
X-Gm-Message-State: AGRZ1gLWRs2+lIhRBntJDHrtEaCiUVlolYdvgXLhmZ113OIHNz3APm3C
 kOCihLZWybkN1UB4uO8bjRUsFA==
X-Google-Smtp-Source: AJdET5fgJULXvtUFPnFq52slokQNN7z81I0D9HZsdKxVHZdxgHrZEi4Cy7djJVVncN5rD1H9qJsdhA==
X-Received: by 2002:a17:902:2:: with SMTP id
 2-v6mr29324872pla.178.1541552652131; 
 Tue, 06 Nov 2018 17:04:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:c8e0:70d7:4be7:a36])
 by smtp.gmail.com with ESMTPSA id v37sm30134695pgn.5.2018.11.06.17.04.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Nov 2018 17:04:11 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v3 0/4] kgdb: Fix kgdb_roundup_cpus()
Date: Tue,  6 Nov 2018 17:00:24 -0800
Message-Id: <20181107010028.184543-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
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
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, kgdb-bugreport@lists.sourceforge.net,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>,
 linux-snps-arc@lists.infradead.org, Huang Ying <ying.huang@intel.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Vineet Gupta <vgupta@synopsys.com>, Douglas Anderson <dianders@chromium.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Patch #3 and #4 are new.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c     | 10 ++-----
 arch/arm/kernel/kgdb.c     | 12 ---------
 arch/arm64/kernel/kgdb.c   | 12 ---------
 arch/hexagon/kernel/kgdb.c | 32 ----------------------
 arch/mips/kernel/kgdb.c    |  9 +------
 arch/powerpc/kernel/kgdb.c |  6 ++---
 arch/sh/kernel/kgdb.c      | 12 ---------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-----
 include/linux/kgdb.h       | 22 +++++++++------
 kernel/debug/debug_core.c  | 55 +++++++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h  |  1 +
 kernel/debug/kdb/kdb_bt.c  | 11 +++++++-
 13 files changed, 88 insertions(+), 105 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

