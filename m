Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3802BC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 03:54:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6002C2086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 03:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SstBiiGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6002C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433qfR5YgPzDqby
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 14:54:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SstBiiGW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="SstBiiGW";
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433qbR6CC4zDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 14:51:47 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id w73so7658806pfk.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 19:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ckFwfWrXDG7mbBgtIA9ywF+G24oiGIeq/mDuQRgaBZM=;
 b=SstBiiGWzw5dBJG/3tQu6dyCWZzwOYkKa8t0/fa0w5gcDTZaE47UUcy03dPrz4/uvH
 mFYss26Ji3dfFsBbZtXM9Fkiw7fyvNZFThjXOqmer3sdiz1pAVn1Ulbd0owmzDDRP5vg
 d+8ef2cthPwUtXBypN4pDgp8cmiqJR5m56fcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ckFwfWrXDG7mbBgtIA9ywF+G24oiGIeq/mDuQRgaBZM=;
 b=rFY8sRgwauw9GubBX+hN8t6KnGMUXolQXCDDGSx+4QeozJZVc5YTgIJ0sV+NMR/Wjd
 CYxHyB+FqhPNPBj/vjdkeTlS4z8m4lavuYi1TsQPNTdfK+VHgdseMAxZbtWR8K1a09sh
 WZpHJaQCe2nOkAGFjC3v6LDBD9SN0QVbOE0a+P+bk8fMGMzuRCmiacuwT1SzMSl5XaPc
 sO9LEJIkQwi9BiNNAi1a8u3LX2pWyJhIDSudthasGaUdT8crrBoEHgHvmxgq6lvXTn5I
 IM0fEf1isrFPYvlibI5KqN1MCZjg1X281cg4LDvAq4vjr8kCGqjDkI2vxM2ZK1jtoWqe
 kAdg==
X-Gm-Message-State: AA+aEWaw27P6pbZ2O5ec618JhZH3WSmwBvdba/THCOpx5OG7niZs3vg0
 zxJVnQjP0Sq4lR6//1IGp/uRCQ==
X-Google-Smtp-Source: AFSGD/V3wZAxhlYGm/KNcJbxWJViWYHfJeGL3B2UeBIJOeAl5ZlvisN4Y0oJyigojv6bCfo+1dgibw==
X-Received: by 2002:a63:2946:: with SMTP id p67mr28146422pgp.317.1543290705498; 
 Mon, 26 Nov 2018 19:51:45 -0800 (PST)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:c8e0:70d7:4be7:a36])
 by smtp.gmail.com with ESMTPSA id i4sm2690112pfj.82.2018.11.26.19.51.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Nov 2018 19:51:44 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v5 0/4] kgdb: Fix kgdb_roundup_cpus()
Date: Mon, 26 Nov 2018 19:51:29 -0800
Message-Id: <20181127035133.225592-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
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

Changes in v5:
- Add a comment about get_irq_regs().
- get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
- for_each_cpu() => for_each_online_cpu()
- Error check smp_call_function_single_async()

Changes in v4:
- Removed smp_mb() calls.
- Also clear out .debuggerinfo.
- Also clear out .debuggerinfo and .task for the master.
- Remove clearing out in kdb_stub for offline CPUs; it's now redundant.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Don't round up a CPU that failed rounding up before new for v3.
- Don't back trace on a cpu that didn't round up new for v3.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c          | 10 +----
 arch/arm/kernel/kgdb.c          | 12 ------
 arch/arm64/kernel/kgdb.c        | 12 ------
 arch/hexagon/kernel/kgdb.c      | 32 ----------------
 arch/mips/kernel/kgdb.c         |  9 +----
 arch/powerpc/kernel/kgdb.c      |  6 +--
 arch/sh/kernel/kgdb.c           | 12 ------
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          |  9 +----
 include/linux/kgdb.h            | 22 +++++++----
 kernel/debug/debug_core.c       | 65 ++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 +++++-
 kernel/debug/kdb/kdb_debugger.c |  7 ----
 14 files changed, 98 insertions(+), 112 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

