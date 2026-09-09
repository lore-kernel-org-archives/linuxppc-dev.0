Return-Path: <linuxppc-dev+bounces-26890-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB689C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:51:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvg56kVsz2yr0;
	Wed, 09 Sep 2026 18:51:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943889;
	cv=none; b=lgUdGDBOI8v4IjNrLk6snQfXechE/0sYISk11a+36bBoKJGkc6Ga+J5obUmnGAAosrRCcEVKysXhMLeou5sU7z82CLfbsNFsW1Q/hWKGjw6KxRVJvfIehc5fbDbP6CV9doOfcR9IxQKPkC/lOehaYI1piDRJN2h862l0E7tFBAhSmB4yNo0JXC79sgGtFJFAMdN+FfcnMTLGBQUtRc6l/awvh6QM8aAG9O0BIX3UwPUj12uCTmIkKy1n6XFthIckVu+k7ITI1yTMmUmoQS2UBkunKokwgVo2D51PKni0ivljTkaxDyzxJ3l2ugziUcSJ6Pw5bsgzEoNh5g6zMPmMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943889; c=relaxed/relaxed;
	bh=qBxNGRr7V0cZXnwM00gER/wx3P+kfpLfgDvX2l6pq3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j+eKzY5XuLiIUoPzGSKPO2mGuX1bYrshXCpvtPMmex59zR1KWOBG2sWlg+6fgKRr2OtamoeycFNOk/OdnJjbt3mcEIZFy1wfJhDKTqD5kCSryPK+ODNNUYKhiZ3qpC2hvYOWKTkDfvjamGj1iPYtA8LxQESL0Q9Aw/u8xTVLhjmWypzflas3ycRjSyOpJCkverBk1fhoKZLC3kzOPMx1fJkkXiaIrn9WbVp9y0tmwXM8qR21HlVv2k88/5Comq43siCMdOjF4sCofLehGeaZz7+xjyzLVD/eLQhJ+ljGRl6LGAiZugwljLkeOcv5WTh1+mOiXu74NQvrwSE0g7L8gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=k9vEQJ8w; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1FCn8GUQ; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=k9vEQJ8w;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1FCn8GUQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg36Bjpz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:27 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qBxNGRr7V0cZXnwM00gER/wx3P+kfpLfgDvX2l6pq3g=;
	b=k9vEQJ8wTctywsO8hI1YZ6um9M/lNjs1S0m1fgpc08NdgIYbZov0Zkofq1AxPdfblwLPa7
	4KmfcHeu6b2Yr+01ivvZ6xjUcjoYm3eAQ5TgjEPS7CKlSdWg/JDCIFLH8782o31SLgz6gd
	OtPuQq0Sjy9sgdW0sWOoMBh3I8RgTIUi6zxLRszOk905I462f6xWyvSyMqAO006ybGNQdu
	SGKHJOBw038XIG0FBCvj4tz2gBcwNTvJjmEFGFYE/BwAJM7xynzmQllAr8cj2jRLAhO1yH
	cjh8vmeAx20BKowGWdN/9sqWAOfZypcjYsZemxfmare/Lp1o32YdrpkitPZpLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qBxNGRr7V0cZXnwM00gER/wx3P+kfpLfgDvX2l6pq3g=;
	b=1FCn8GUQNiHI5qLn1sTrlANzuUZEkf5xuKf+VYLZdOJYxtaWZpt+V7r7Urvulh09pavhRF
	dsm/084ewNnqYqDw==
Subject: [PATCH 00/15] vdso: Clean up the vsyscall.h headers
Date: Wed, 09 Sep 2026 10:51:13 +0200
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswIamuEi1ExxooCwekkO6et
 HyL/wsIJSaBqSmQKLPwGSu6tgG32bgSsq8GrbRRQ6cxeznRyoErxZo6zPKIs/uOG6pgTKB+tL5
 3UA9XosD3f5+X9/0APF61mm0AAAA=
X-Change-ID: 20260812-vdso-asm-generic-vsyscall-h-0f66fe59ad5c
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=3678;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=7BLVTFBp0ZEd00ydpjlDQmwAhB/KSP4xZMVY9pc9HOs=;
 b=uTe2i40O4/xeVZQd1jNjZ2OlErGJqBh1xMapRWODGY5Dal9y4CKYI8NBfBpyMTHddnVSWXGD4
 N0TrnT9R60lBMxCVhZtCvdvXAnyBBfInKOtzLXA0tNQZs9VfRNj5zYY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vsyscall.h headers are a mess. Some of that was necessary back when
some architectures where not using the generic vDSO infrastructure.
Now that this is not necessary anymore, the headers can be cleaned up
and many of the can be deleted altogether.

The recipient list is trimmed to only the vDSO maintainers and the
architecture lists.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (15):
      vdso: Move the kernel-side time update helpers to a new header
      vdso/gettimeofday: Define fallback __arch_get_vdso_u_time_data() in gettimeofday.c
      vdso/getrandom: Define fallback __arch_get_vdso_u_rng_data() in getrandom.c
      vdso/vsyscall: Define fallback time synchronization functions in vsyscall.c
      vdso: Delete asm-generic/vdso/vsyscall.h
      x86/vdso: Move vDSO page definitions to asm/vdso.h
      sparc/vdso: Move __VDSO_PAGES to asm/vdso.h
      s390/vdso: Delete asm/vdso/vsyscall.h inclusions
      sparc/vdso: Delete asm/vdso/vsyscall.h inclusion
      x86/vdso: Delete asm/vdso/vsyscall.h inclusions
      arm64/vdso: Delete asm/vdso/vsyscall.h inclusions
      riscv/hwprobe: Include vdso/datapage.h
      vdso: Remove unnecessary vdso/vsyscall.h includes
      vdso: Add asm-generic/vdso/vsyscall.h
      vdso: Remove __ASSEMBLER__ guards from vsyscall.h

 MAINTAINERS                                  |  2 +-
 arch/arm/include/asm/vdso/vsyscall.h         |  7 ------
 arch/arm/kernel/vdso.c                       |  1 -
 arch/arm64/include/asm/vdso/getrandom.h      |  1 -
 arch/arm64/include/asm/vdso/vsyscall.h       |  7 ------
 arch/arm64/kernel/vdso.c                     |  1 -
 arch/arm64/kernel/vdso/vdso.lds.S            |  1 -
 arch/loongarch/include/asm/vdso/vsyscall.h   | 14 -----------
 arch/loongarch/kernel/vdso.c                 |  1 -
 arch/mips/include/asm/vdso/vsyscall.h        | 16 -------------
 arch/mips/kernel/vdso.c                      |  1 -
 arch/powerpc/include/asm/vdso/vsyscall.h     | 14 -----------
 arch/riscv/include/asm/vdso/vsyscall.h       | 14 -----------
 arch/riscv/kernel/sys_hwprobe.c              |  2 +-
 arch/riscv/kernel/vdso.c                     |  1 -
 arch/s390/include/asm/vdso/getrandom.h       |  1 -
 arch/s390/include/asm/vdso/vsyscall.h        | 16 -------------
 arch/s390/kernel/time.c                      |  6 ++---
 arch/s390/kernel/vdso.c                      |  1 -
 arch/s390/kernel/vdso/vdso.lds.S             |  1 -
 arch/sparc/include/asm/vdso.h                |  6 +++++
 arch/sparc/include/asm/vdso/vsyscall.h       | 10 --------
 arch/sparc/vdso/vdso-layout.lds.S            |  2 +-
 arch/sparc/vdso/vma.c                        |  1 -
 arch/x86/entry/vdso/common/vdso-layout.lds.S |  1 -
 arch/x86/entry/vdso/vma.c                    |  1 -
 arch/x86/include/asm/vdso.h                  |  7 ++++++
 arch/x86/include/asm/vdso/vsyscall.h         | 22 -----------------
 include/asm-generic/Kbuild                   |  1 +
 include/asm-generic/vdso/vsyscall.h          | 35 ----------------------------
 include/linux/vdso_time.h                    |  8 +++++++
 include/vdso/vsyscall.h                      |  7 ------
 kernel/time/vsyscall.c                       | 25 +++++++++++++++-----
 lib/vdso/getrandom.c                         |  8 +++++--
 lib/vdso/gettimeofday.c                      | 10 +++++---
 35 files changed, 60 insertions(+), 192 deletions(-)
---
base-commit: 1c2a9f9d89050cd9f2b2280060a9442338a1e6fe
change-id: 20260812-vdso-asm-generic-vsyscall-h-0f66fe59ad5c

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


