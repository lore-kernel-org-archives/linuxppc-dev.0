Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9265CC6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 22:21:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04F12081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 22:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5MtIjUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04F12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42l5Xz4y61zDr7s
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 09:21:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F5MtIjUS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="F5MtIjUS";
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42l5V1322qzDrbn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 09:19:04 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id j13-v6so3059394pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SPVTCN7yB3EvcS3VgTBTPuwRPE6icIQDbNo/cFgw8x4=;
 b=F5MtIjUSmfPSLlRLUcvlxb8bgwO944Vzlwsrb+STW1m9SKp+FbIUnhKepFgX1d/6zY
 WFEsTME5GAO3fNxqCMjL5qf9DfZtUWW/0eu+pQx31M+moNIAPuITstIM3gP6+QCFd8p4
 spMZEp8n6pfvs7QIBWD5+GLOMia4bijBqXNww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SPVTCN7yB3EvcS3VgTBTPuwRPE6icIQDbNo/cFgw8x4=;
 b=mTE+Ba2UPfDh2gP8q4gH17xyz9sCGruBKTnUO44+5BPN8yk5RJ3EG2vK/QWDWtULF2
 qU2+CLOlmIdtg/pT9YJ4v2f5GFBY8T/xH77Z2qceUa5ov7U/iLWy5LwVX51j99rlHDUB
 UnCXUyTATa7TZZDrKr9dfxcb3NVFGWktVU8ds0HPgewgmzum/X3TRItgNnVG92Q71mZi
 g3dLM/XvzCNHNKMxe9ji2Ukfzr4m5+zHFutQBAZd/x7xYr75CmGCNk2ANd5McVoHsFen
 guCbdXUa55RgqHdbZzSmpMwKQk9KVgA+OOHrm6Ap2LXV0rby89rgC7EnyskuDXVbLJcK
 LCDg==
X-Gm-Message-State: AGRZ1gIXL3Fl8gQYgagw56f9wLMMr3aaKfqg3im37qsnH0e5gp+v91lH
 t20XhjPU2AsVQjmHYusPYnDE1A==
X-Google-Smtp-Source: AJdET5c8VEq72Qy0GxQVPtDW46vA6aevXpwki6KHW4SNnqLPDwpMxBbEkvTAqWJGZKK3oeUkFc+Anw==
X-Received: by 2002:a62:571b:: with SMTP id
 l27-v6mr521667pfb.209.1540937943074; 
 Tue, 30 Oct 2018 15:19:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:c8e0:70d7:4be7:a36])
 by smtp.gmail.com with ESMTPSA id c70-v6sm2889774pfe.93.2018.10.30.15.19.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Oct 2018 15:19:02 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v2 0/2] kgdb: Fix kgdb_roundup_cpus()
Date: Tue, 30 Oct 2018 15:18:41 -0700
Message-Id: <20181030221843.121254-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 kgdb-bugreport@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>,
 linux-snps-arc@lists.infradead.org, Huang Ying <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Douglas Anderson <dianders@chromium.org>, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (2):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()

 arch/arc/kernel/kgdb.c     | 10 ++--------
 arch/arm/kernel/kgdb.c     | 12 ------------
 arch/arm64/kernel/kgdb.c   | 12 ------------
 arch/hexagon/kernel/kgdb.c | 32 --------------------------------
 arch/mips/kernel/kgdb.c    |  9 +--------
 arch/powerpc/kernel/kgdb.c |  6 +++---
 arch/sh/kernel/kgdb.c      | 12 ------------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-------
 include/linux/kgdb.h       | 22 ++++++++++++++--------
 kernel/debug/debug_core.c  | 38 +++++++++++++++++++++++++++++++++++++-
 11 files changed, 60 insertions(+), 104 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

