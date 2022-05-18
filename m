Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B24C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 May 2022 10:10:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L37yp5Hc0z3cg2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 May 2022 20:10:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=LOb3V4kO;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L37wt5tlcz3bxh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2022 20:08:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=LOb3V4kO; dkim-atps=neutral
Received: by gandalf.ozlabs.org (Postfix)
 id 4L37ws4GCKz4xcT; Wed, 18 May 2022 20:08:29 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
 id 4L37ws46Rcz4xcR; Wed, 18 May 2022 20:08:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1652868509;
 bh=TxmrULAGiAXYhtXIbJ6kRvZYSTyWm5CFItj3DKlVdfY=;
 h=Date:From:To:Cc:Subject:From;
 b=LOb3V4kOYcJFKRcUx8gc27XvpMZEY4x4WVI9fgEJM5yY4R8Ng9BV14jxMRm44xGYe
 pl6xv2TJ2nQqRhI9Fx0F50kV+ZbL91N0QFBN+GI4A61eq3npdP57YeiaJpyVDvJUd4
 8VbCewaHuUSaf+ZMy3SCSyr4FyHCO6UhrSjyJcYd9wXsPw1TFVElFjLdl00ooWncnA
 rhM6deDh7hY9jG2GDEJWVtGhTOl0jkT0KSKgIeFMpp/w21IZP68oCiaNMAwmSmxeLq
 OV66QDXXxnYRgLa2GQ3+GRc4HlodYwLLAI7h77nZHfvSM2y2ea+452acsaNIT6/Mo9
 zfTujUEZuP2IQ==
Date: Wed, 18 May 2022 20:03:27 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/6] KASAN support for 64-bit Book 3S powerpc
Message-ID: <YoTEb2BaH3MDkH+2@cleo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series implements KASAN on 64-bit POWER with radix MMU,
such as POWER9 or POWER10.  Daniel Axtens posted previous versions of
these patches, but is no longer working on KASAN, and I have been
asked to get them ready for inclusion.

Because of various technical difficulties, mostly around the need to
allow for code that runs in real mode, we only support "outline" mode
(as opposed to "inline" mode), where the compiler adds a call to
a checking procedure before every store to memory.

This series has known deficiencies, specifically that the kernel will
crash on boot on a HPT system, and that out-of-bounds accesses to
module global data are not caught (which leads to one of the KASAN
tests failing).

v2: Split the large patch 3/3 of the previous series into three
patches and addressed review comments; put the generic documentation
changes in a separate patch at the end of the series; removed the RFC
tag.

Comments welcome.

Paul.

 Documentation/dev-tools/kasan.rst                  |   7 +-
 Documentation/powerpc/kasan.txt                    |  58 ++++++++++++
 arch/powerpc/Kconfig                               |   5 +-
 arch/powerpc/Kconfig.debug                         |   3 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   3 +
 arch/powerpc/include/asm/book3s/64/radix.h         |  12 ++-
 arch/powerpc/include/asm/interrupt.h               |  52 ++++++++---
 arch/powerpc/include/asm/kasan.h                   |  22 +++++
 arch/powerpc/kernel/Makefile                       |  11 +++
 arch/powerpc/kernel/smp.c                          |  22 ++---
 arch/powerpc/kernel/traps.c                        |   6 +-
 arch/powerpc/kexec/Makefile                        |   2 +
 arch/powerpc/kvm/Makefile                          |   5 +
 arch/powerpc/lib/Makefile                          |   3 +
 arch/powerpc/mm/book3s64/Makefile                  |   9 ++
 arch/powerpc/mm/kasan/Makefile                     |   3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}        |   0
 arch/powerpc/mm/kasan/init_book3s_64.c             | 103 +++++++++++++++++++++
 arch/powerpc/mm/ptdump/ptdump.c                    |   3 +-
 arch/powerpc/platforms/Kconfig.cputype             |   1 +
 arch/powerpc/platforms/powernv/Makefile            |   8 ++
 arch/powerpc/platforms/powernv/smp.c               |   2 +-
 arch/powerpc/platforms/pseries/Makefile            |   6 ++
 arch/powerpc/sysdev/xics/xics-common.c             |   4 +-
 arch/powerpc/sysdev/xive/common.c                  |   4 +-
 26 files changed, 320 insertions(+), 38 deletions(-)
