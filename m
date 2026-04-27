Return-Path: <linuxppc-dev+bounces-20159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1129FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:28:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42sF3NFnz2y7r;
	Mon, 27 Apr 2026 22:28:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292881;
	cv=none; b=c9aosZDrtlyw4qo9gIjZn0t+uMjZeL7L8PviU6004D3qQB4/bUmgQKW9DwZISa9vtg7VkIJYijOQ41maHOhIlzGoyALH2jdnZ/a/BaIH3u515ycf6Iv79TDBqPygsFMgW76axBCpjVawxMty9v4tFeJsmCSyEDaq7HkunfVp0Vdk0rrLGAoWsIih6iGWQRGMoEeCH6+JDyrbUUIOEaDLFME88GwwxqS1F9dUcb2hBB0RxGZD1yAdGT18Qae2Y2Vgjw78uJW29m0Ji1uGP52AmGXV97zsSX4ehTrFj1Shtb42eKgB9LDdfwJG5RdzlgLrGebyfJh3O4URpfGSiOZIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292881; c=relaxed/relaxed;
	bh=A5+nWqwDcOBF7Fr/nIwR50jOx4j4ScLRDSFTu4WKkq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KhEZW3Cx9qF5MA1x2NY2Yq1Nl9z9QBeth1B700KnHzIKLSffGL5k2pbKc0uGLD6HHZ1iHxABwA7r9u0U3hPM0BtFFuV5FfNh3pySGxehfrLFlUHqLTNaDMjdzc2MUJEFYRvHNbLs9Pw4KObkdwIlg811oxX4BkTcyyk7SRGtMFBJIHH7yw+R7PWVLayEeq0SYqJjI3ADxPcREXiz2oHxR5UQkO2hW7Z802oruSfry8V+LSm1XYhCk07ZxAtoa/dJVklX+qpMFgV/nYWljq8MySbumCjCS11+lB+Bb0+hLegm6B3yIzVtyduOlRH584Wbr4VN7aBiFCEVoGyaMJ4r8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ITfKbH2U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ITfKbH2U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42sD4TN9z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:28:00 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so4868878b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292878; x=1777897678; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5+nWqwDcOBF7Fr/nIwR50jOx4j4ScLRDSFTu4WKkq8=;
        b=ITfKbH2UH6CBjP+7vr1sL8HQjOVO97n5lX47362+7mbXpeQ/2NobMIFlQRHQ66Nklz
         0qQVU14trrmq7mg6RzVKrYylEf4TRCQaxk4RHq8MGu5wVdlvfQTTNiNc8gduslTAn7ra
         f7/0SwcOYkjpKp9Cs6spLVB7OI/ufQvK4bZhX3Sal1ruSEzuU31pe/xzFBzTTSPODNTj
         GUH3TAzlYZJzZaMXDlCyOC3W6L82qJVh8qy3HTQP+ZGyoz/QJSs8cWhU30WSmUH0IkOD
         Vye4Opj4ysaDDi9hf8C4WUhIJYwcByUvYwY6u9IKm33S/8azXHOTPjVba5DVfy+38i71
         vQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292878; x=1777897678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5+nWqwDcOBF7Fr/nIwR50jOx4j4ScLRDSFTu4WKkq8=;
        b=hPJAPbLTTv4YRkkhg8gVBqN7l+wmFXZsVJ6TwGfzHvwyldpntEufi8u8PZQkcRiYly
         W2OgQkREJoD6GxFJGnaRNjrKma3o+i/3kvxGyj2url9dJux6ncaQALd+DR+L7dkF4cpb
         MNmRtTDgQO98aCQB+zZbEz69qSEQErZV/j8pRZQ1jf9TnuaRO1qutLrFyigkF54DYiH8
         H20lDxMetsnDISICBD6Nm3bvJjCGk8lKX+9MoNBbXOqfBoktwG69dyMTq+kP41qKP3jJ
         dqDl7ueXy9wbpKxQSpqd10npJvSMNVqL+B4Rv1/RR48UuW81/8/MiiWAEhqsykGh4ZBG
         5gnw==
X-Forwarded-Encrypted: i=1; AFNElJ+NE+LBIHxQYW+hV3kA/u2hx5BTWdhh/IeoKp63abRgNrnusOeMUnurXGAHMRxquvpWt12/kdv2qzv1Ubw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXk3EKxFyrjFMd/oZMSVWdq9/v4Xr8r3Tao/2tiRyvqjaeMNtp
	IiuJDlI71S0oeCU4eyEiCrV3Yhlzf9N4oKBNOY7I3sBTCA8xGk+a4x0x
X-Gm-Gg: AeBDiesowpqVQqt5s5xDSzM8UXhKMkmOt6IDSQfY0/ulrgK5CGbPIF+DKxHjQ+5GLZz
	yZWh0uWFlaAAK8WK0VpJujbvcNoFvsJ20oC8XcnmSL7QN2+NxYczCIe26fgp/j+JJR3zVBNZaIg
	rgeSdzpgarfogWEySpC6IrxAgXGXiPAhbZ1A7o2uPGpuBQwhwewAKv/7v79407PV8C3U7aU77sX
	Tzkeg1vZpSSn6Dndc5r/Dvjpd997b7jMBy1E9yXi/TgySvl4lEmv1zKI+xa5RjwyDkd283VYIdn
	BFUKdQJQCvu3ExU6FmWeCOJrsyCywRgLCx6rpwEPDPEWTGZgxESCDtghxL938zLg0bsONCmIY9E
	lKStsvK+I9SlA0kfLw9D6IKPS44BYcH0/IHNIkiNPTmF3p1Y4kLzpGHVLYm7vGEk2sLLITczTqn
	oyNyA7zobtL7FTJN9GUHhIGausFK8I5GLceF+ZJRWznwYdlgSDjiZdaK6pxQg5TvYfgM15SZsr4
	mdvAA==
X-Received: by 2002:a05:6a00:3e09:b0:82f:456c:29f1 with SMTP id d2e1a72fcca58-82f8b385c38mr37432010b3a.12.1777292878196;
        Mon, 27 Apr 2026 05:27:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm32733466b3a.21.2026.04.27.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:27:57 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	oleg@redhat.com,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	mchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	thuth@redhat.com,
	ruanjinjie@huawei.com,
	akpm@linux-foundation.org,
	macro@orcam.me.uk,
	ldv@strace.io,
	charlie@rivosinc.com,
	deller@gmx.de,
	kevin.brodsky@arm.com,
	ritesh.list@gmail.com,
	yeoreum.yun@arm.com,
	agordeev@linux.ibm.com,
	segher@kernel.crashing.org,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Date: Mon, 27 Apr 2026 17:57:34 +0530
Message-ID: <20260427122742.210074-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding support for the generic irq entry/exit handling for PowerPC. The
goal is to bring PowerPC in line with other architectures that already
use the common irq entry infrastructure, reducing duplicated code and
making it easier to share future changes in entry/exit paths.

This is slightly tested of ppc64le and ppc32.

The performance benchmarks are below:

perf bench syscall usec/op (-ve is improvement)

| Syscall | Base        | test        | change % |
| ------- | ----------- | ----------- | -------- |
| basic   | 0.093543    | 0.093023    | -0.56    |
| execve  | 446.557781  | 450.107172  | +0.79    |
| fork    | 1142.204391 | 1156.377214 | +1.24    |
| getpgid | 0.097666    | 0.092677    | -5.11    |

perf bench syscall ops/sec (+ve is improvement)

| Syscall | Base     | New      | change % |
| ------- | -------- | -------- | -------- |
| basic   | 10690548 | 10750140 | +0.56    |
| execve  | 2239     | 2221     | -0.80    |
| fork    | 875      | 864      | -1.26    |
| getpgid | 10239026 | 10790324 | +5.38    |


IPI latency benchmark (-ve is improvement)

| Metric         | Base (ns)     | New (ns)      | % Change |
| -------------- | ------------- | ------------- | -------- |
| Dry run        | 583136.56     | 584136.35     | 0.17%    |
| Self IPI       | 4167393.42    | 4149093.90    | -0.44%   |
| Normal IPI     | 61769347.82   | 61753728.39   | -0.03%   |
| Broadcast IPI  | 2235584825.02 | 2227521401.45 | -0.36%   |
| Broadcast lock | 2164964433.31 | 2125658641.76 | -1.82%   |


Thats very close to performance earlier with arch specific handling.

Tests done:
 - Build and boot on ppc64le pseries.
 - Build and boot on ppc64le powernv8 powernv9 powernv10.
 - Build and boot on ppc32.
 - Performance benchmark done with perf syscall basic on pseries.

Changelog:
V4 -> V5:
 - Rebased on latest mainline
V4: https://lore.kernel.org/all/20260123073916.956498-1-mkchauras@linux.ibm.com/

V3 -> V4:
 - Fixed the issue in older gcc version where linker couldn't find
   mem functions
 - Merged IRQ enable and syscall enable into a single patch
 - Cleanup for unused functions done in separate patch.
 - Some other cosmetic changes
V3: https://lore.kernel.org/all/20251229045416.3193779-1-mkchauras@linux.ibm.com/

V2 -> V3:
 - #ifdef CONFIG_GENERIC_IRQ_ENTRY removed from unnecessary places
 - Some functions made __always_inline
 - pt_regs padding changed to match 16byte interrupt stack alignment
 - And some cosmetic changes from reviews from earlier patch
V2: https://lore.kernel.org/all/20251214130245.43664-1-mkchauras@linux.ibm.com/

V1 -> V2:
 - Fix an issue where context tracking was showing warnings for
   incorrect context
V1: https://lore.kernel.org/all/20251102115358.1744304-1-mkchauras@linux.ibm.com/

RFC -> PATCH V1:
 - Fix for ppc32 spitting out kuap lock warnings.
 - ppc64le powernv8 crash fix.
 - Review comments incorporated from previous RFC.
RFC https://lore.kernel.org/all/20250908210235.137300-2-mchauras@linux.ibm.com/

Mukesh Kumar Chaurasiya (8):
  powerpc: rename arch_irq_disabled_regs
  powerpc: Prepare to build with generic entry/exit framework
  powerpc: introduce arch_enter_from_user_mode
  powerpc: Introduce syscall exit arch functions
  powerpc: add exit_flags field in pt_regs
  powerpc: Prepare for IRQ entry exit
  powerpc: Enable GENERIC_ENTRY feature
  powerpc: Remove unused functions

 arch/powerpc/Kconfig                    |   1 +
 arch/powerpc/include/asm/entry-common.h | 533 ++++++++++++++++++++++++
 arch/powerpc/include/asm/hw_irq.h       |   4 +-
 arch/powerpc/include/asm/interrupt.h    | 386 +++--------------
 arch/powerpc/include/asm/kasan.h        |  15 +-
 arch/powerpc/include/asm/ptrace.h       |   6 +-
 arch/powerpc/include/asm/signal.h       |   1 -
 arch/powerpc/include/asm/stacktrace.h   |   6 +
 arch/powerpc/include/asm/syscall.h      |   5 +
 arch/powerpc/include/asm/thread_info.h  |   1 +
 arch/powerpc/include/uapi/asm/ptrace.h  |  14 +-
 arch/powerpc/kernel/interrupt.c         | 254 ++---------
 arch/powerpc/kernel/ptrace/ptrace.c     | 142 +------
 arch/powerpc/kernel/signal.c            |  25 +-
 arch/powerpc/kernel/syscall.c           | 119 +-----
 arch/powerpc/kernel/traps.c             |   2 +-
 arch/powerpc/kernel/watchdog.c          |   2 +-
 arch/powerpc/perf/core-book3s.c         |   2 +-
 18 files changed, 690 insertions(+), 828 deletions(-)
 create mode 100644 arch/powerpc/include/asm/entry-common.h

-- 
2.53.0


