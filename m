Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C93C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:43:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA73120834
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvN4V4HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA73120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hDwW43p6zF3FX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 17:43:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvN4V4HJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="OvN4V4HJ"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hDlD6NcrzF3F5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 17:35:34 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 17341B64;
 Fri, 26 Oct 2018 02:35:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 26 Oct 2018 02:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DIOsCJXEM5D6chAr7
 SkrJf+6wReDAZrARSRwUJphPhY=; b=OvN4V4HJuPmHWJiPMs9NbO3SYywBFlNDX
 m0lZK4wZwEvABqvgAN+sRpWjCOwTwnsJ2zvS5S9x/gD8Sxp4Ejmu/vxNVUuRMpqR
 8B2K0I/aNVtEvLVT+ZzWYU/6hdR6QwpQf9m72Hp+Ju25xA25wSN5aSiKN4DCIdNI
 s5HZNInZiwrcut+cxAq8W5B6jTpekDIEu+CSs9LKzHmJwjXu4qFi5Tgx+vX9M9/G
 nyXctZB9ne2shWd8PcLDGjaFz0rAIUROH8fiQHso6pYhzGjpzAQvQWPHhHizcP85
 QzvTH+I3TMc+K48wY23WwoL5or0V6taLapAAKXPRHCXG2jjhLHnIA==
X-ME-Sender: <xms:r7XSWxUPb8CrMEEJb3jEkVNPTQpFuseTQCkaaVkzcCsT7TbszuSW0g>
X-ME-Proxy: <xmx:r7XSW5NyEoANsYZQshXjyjMFRFz85s8IQhI30M1P5HaakdcYZxw0cA>
 <xmx:r7XSW2Xvg7sdsdwCNQcJJbKdX0F4yTWWB0WMzbBinKppoESXjqEnEw>
 <xmx:r7XSW-ZLJFQow5Dg1etqriHrkGM3RqWGbh0RPfp5CZ1m-MYwjQzT7w>
 <xmx:r7XSWw0ZFPfPptMp7pjSw-kDMM50s07aIx2R-gtzPcIGwNNj98FM_Q>
 <xmx:r7XSW6BdNzR_yMv1d7sgOrehd1QXssttyT7g1XWdcF9VHO7gLHg9lg>
 <xmx:sLXSW1ivqx4WaIU1VJ7TVH8L5pulfw7y3bphEuUwRBOhb7NBWlwmRg>
Received: from crackle.ozlabs.ibm.com (pa49-195-157-6.pa.nsw.optusnet.com.au
 [49.195.157.6])
 by mail.messagingengine.com (Postfix) with ESMTPA id 26733102EE;
 Fri, 26 Oct 2018 02:35:23 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] Guarded Userspace Access Prevention on Radix
Date: Fri, 26 Oct 2018 17:35:08 +1100
Message-Id: <20181026063513.30806-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
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
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Guarded Userspace Access Prevention is a security mechanism that prevents
the kernel from being able to read and write userspace addresses outside of
the allowed paths, most commonly copy_{to/from}_user().

At present, the only CPU that supports this is POWER9, and only while using
the Radix MMU.  Privileged reads and writes cannot access user data when
key 0 of the AMR is set.  This is described in the "Radix Tree Translation
Storage Protection" section of the POWER ISA as of version 3.0.

GUAP code sets key 0 of the AMR (thus disabling accesses of user data)
early during boot, and only ever "unlocks" access prior to certain
operations, like copy_{to/from}_user(), futex ops, etc.  Setting this does
not prevent unprivileged access, so userspace can operate fine while access
is locked.

There is a performance impact, although I don't consider it heavy.  Running
a worst-case benchmark of a 1GB copy 1 byte at a time (and thus constant
read(1) write(1) syscalls), I found enabling GUAP to be 3.5% slower than
when disabled.  In most cases, the difference is negligible.  The main
performance impact is the mtspr instruction, which is quite slow.

There are a few caveats with this series that could be improved upon in
future.  Right now there is no saving and restoring of the AMR value -
there is no userspace exploitation of the AMR on Radix in POWER9, but if
this were to change in future, saving and restoring the value would be
necessary.

No attempt to optimise cases of repeated calls - for example, if some
code was repeatedly calling copy_to_user() for small sizes very frequently,
it would be slower than the equivalent of wrapping that code in an unlock
and lock and only having to modify the AMR once.

There are some interesting cases that I've attempted to handle, such as if
the AMR is unlocked (i.e. because a copy_{to_from}_user is in progress)...

    - and an exception is taken, the kernel would then be running with the
    AMR unlocked and freely able to access userspace again.  I am working
    around this by storing a flag in the PACA to indicate if the AMR is
    unlocked (to save a costly SPR read), and if so, locking the AMR in
    the exception entry path and unlocking it on the way out.

    - and gets context switched out, goes into a path that locks the AMR,
    then context switches back, access will be disabled and will fault.
    As a result, I context switch the AMR between tasks as if it was used
    by userspace like hash (which already implements this).

Another consideration is use of the isync instruction.  Without an isync
following the mtspr instruction, there is no guarantee that the change
takes effect.  The issue is that isync is very slow, and so I tried to
avoid them wherever necessary.  In this series, the only place an isync
gets used is after *unlocking* the AMR, because if an access takes place
and access is still prevented, the kernel will fault.

On the flipside, a slight delay in unlocking caused by skipping an isync
potentially allows a small window of vulnerability.  It is my opinion
that this window is practically impossible to exploit, but if someone
thinks otherwise, please do share.

This series is my first attempt at POWER assembly so all feedback is very
welcome.

The official theme song of this series can be found here:
    https://www.youtube.com/watch?v=QjTrnKAcYjE

Russell Currey (5):
  powerpc/64s: Guarded Userspace Access Prevention
  powerpc/futex: GUAP support for futex ops
  powerpc/lib: checksum GUAP support
  powerpc/64s: Disable GUAP with nosmap option
  powerpc/64s: Document that PPC supports nosmap

 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/powerpc/include/asm/exception-64e.h      |  3 +
 arch/powerpc/include/asm/exception-64s.h      | 19 ++++++-
 arch/powerpc/include/asm/futex.h              |  6 ++
 arch/powerpc/include/asm/mmu.h                |  7 +++
 arch/powerpc/include/asm/paca.h               |  3 +
 arch/powerpc/include/asm/reg.h                |  1 +
 arch/powerpc/include/asm/uaccess.h            | 57 ++++++++++++++++---
 arch/powerpc/kernel/asm-offsets.c             |  1 +
 arch/powerpc/kernel/dt_cpu_ftrs.c             |  4 ++
 arch/powerpc/kernel/entry_64.S                | 17 +++++-
 arch/powerpc/lib/checksum_wrappers.c          |  6 +-
 arch/powerpc/mm/fault.c                       |  9 +++
 arch/powerpc/mm/init_64.c                     | 15 +++++
 arch/powerpc/mm/pgtable-radix.c               |  2 +
 arch/powerpc/mm/pkeys.c                       |  7 ++-
 arch/powerpc/platforms/Kconfig.cputype        | 15 +++++
 17 files changed, 158 insertions(+), 16 deletions(-)

-- 
2.19.1

