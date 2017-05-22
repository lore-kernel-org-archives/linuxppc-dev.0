Return-Path: <dja@axtens.net>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWLkz0W4CzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 11:32:58 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id j13so16485449qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 18:32:57 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: kernel-hardening@lists.openwall.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 0/2] powerpc: fortify support
Date: Mon, 22 May 2017 11:32:31 +1000
Message-Id: <20170522013233.21780-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series provides arch-specific support for Daniel Micay's
fortified string functions on powerpc.

Fortified string functions provied some compile and run time bounds
checking on commonly used string functions.

It's cool - currently it picks up a lot of random things so it will
require some more work across the tree, but hopefully it will
eventually hit mainline. These patches make powerpc ready for when it
does.

They've been tested on pseries.

I think patch 1 should probably go through Kees to line up with the
fortify patch itself, but patch 2 can apply to powerpc as is. But up
to you, mpe.

Regards,
Daniel

Daniel Axtens (2):
  powerpc: Don't fortify prom_init
  powerpc: Make feature-fixup tests fortify-safe

 arch/powerpc/kernel/prom_init.c   |   3 +
 arch/powerpc/lib/feature-fixups.c | 180 +++++++++++++++++++-------------------
 2 files changed, 93 insertions(+), 90 deletions(-)

-- 
2.11.0
