Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A8C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:28:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03C620883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ApftFrBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03C620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f0l06FwtzDqJR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:28:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="ApftFrBp"; dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f0hT1xwqzDqJH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 07:25:56 +1000 (AEST)
Received: by mail-ed1-x541.google.com with SMTP id k45so126105edb.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DEibYvnJOT/AXrEykbQH+ZEm0O+Co96okaAqfEd0oe0=;
 b=ApftFrBp2GKWzpizNkRot6/E2kafAeHEayvgCvWkzyqFMUHkPv0Puo84qIaJIvHuOG
 7E9HbLIukZFDuX/ZSXdx8fRQYnraVsKdfurUV90y8HiVkho++04I5EJjBUUhLwH5lUUX
 GrcQFZwHiCD34KHgRUcacicW+Gf80EXMJVX90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DEibYvnJOT/AXrEykbQH+ZEm0O+Co96okaAqfEd0oe0=;
 b=AqU00GbkP51QWD+b8saqTUgHiQwgz/dtFRIVM7z+bER72DpOlYuA7+Bihs7KCXRIK6
 AMqxk9puqqtUhsGXZQdW9gZ3zQ+JwE9YT5O2EZ7Aw+cE5D2lqVcNor0Gj7STfjp7X0PD
 kwkntcmDH/e/IbVyhRfUtJvCf2aBLlLNqqXcDsRqmoR/lmJAZm3Agk4W1BtJdNXVveYt
 nt63SnWyChLVn+HhRJVF7z0nTjs30LrFO84CzMPT2PhKHg//H6L3GRmi1Q7ZmTwmMEvl
 MGMjcxYNbX8TwYDpBv0pIgxRvWZi5V00f5WL+7QVjx//M+DdHs6FX5txqoYG1I9fpU+I
 4IeA==
X-Gm-Message-State: APjAAAU8aaWaA0D1DnG9deL4p6spWSylru8F8DnVidYR5bd3w7dL3S+a
 k8kcLWDuAWguC/Zd0FEeiGvBwg==
X-Google-Smtp-Source: APXvYqwRRQpYse2JKy7O0+MQPpjToIC2KiJl10KZ5FIj1p46BJAckzLHtv1USMyNV6zx14fgC0GcCQ==
X-Received: by 2002:a17:906:5149:: with SMTP id
 s9mr21353914ejl.25.1554845151506; 
 Tue, 09 Apr 2019 14:25:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk.
 [5.186.118.63])
 by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 14:25:50 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 00/10] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
Date: Tue,  9 Apr 2019 23:25:07 +0200
Message-Id: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
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
Cc: x86@kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Jason Baron <jbaron@akamai.com>, Ingo Molnar <mingo@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Similar to CONFIG_GENERIC_BUG_RELATIVE_POINTERS that replaces (8 byte)
const char* members by (4 byte) signed offsets from the bug_entry,
this implements the similar thing for struct _ddebug, the descriptors
underlying pr_debug() and friends in a CONFIG_DYNAMIC_DEBUG kernel.

Since struct _ddebug has four string members, we save 16 byte per
instance. The total savings seem to be comparable to what is saved by
an architecture selecting GENERIC_BUG_RELATIVE_POINTERS (see patch 8
for some numbers for a common distro config).

While refreshing these patches, which were orignally just targeted at
x86-64, it occured to me that despite the implementation relying on
inline asm, there's nothing x86 specific about it, and indeed it seems
to work out-of-the-box for ppc64 and arm64 as well, but those have
only been compile-tested.

The first 6 patches are rather pedestrian preparations. The fun stuff
is in patch 7, and the remaining three patches are just the minimal
boilerplate to hook up the config option and asm-generic header on the
three architectures.

Rasmus Villemoes (10):
  linux/device.h: use unique identifier for each struct _ddebug
  linux/net.h: use unique identifier for each struct _ddebug
  linux/printk.h: use unique identifier for each struct _ddebug
  dynamic_debug: introduce accessors for string members of struct
    _ddebug
  dynamic_debug: drop use of bitfields in struct _ddebug
  dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
  dynamic_debug: add asm-generic implementation for
    DYNAMIC_DEBUG_RELATIVE_POINTERS
  x86-64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
  arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
  powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64

 arch/arm64/Kconfig                          |   1 +
 arch/arm64/include/asm/Kbuild               |   1 +
 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/asm/Kbuild             |   1 +
 arch/x86/Kconfig                            |   1 +
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/Kbuild                 |   1 +
 include/asm-generic/dynamic_debug.h         | 116 ++++++++++++++++++++
 include/linux/device.h                      |   4 +-
 include/linux/dynamic_debug.h               |  26 +++--
 include/linux/jump_label.h                  |   2 +
 include/linux/net.h                         |   4 +-
 include/linux/printk.h                      |   4 +-
 lib/Kconfig.debug                           |   3 +
 lib/dynamic_debug.c                         | 111 ++++++++++++++-----
 15 files changed, 237 insertions(+), 40 deletions(-)
 create mode 100644 include/asm-generic/dynamic_debug.h

-- 
2.20.1

