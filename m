Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33E84B7C70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 23:43:17 +1100 (EST)
In-Reply-To: <20100112105805.50e39a77.sfr@canb.auug.org.au>
References: <20100112105805.50e39a77.sfr@canb.auug.org.au>
Subject: Re: linux-next: origin tree build failure
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <OFC91015BA.3FA77D43-ONC12576A9.00453F87-C12576A9.00457102@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 12 Jan 2010 13:38:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Linus <torvalds@linux-foundation.org>,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote on 12/01/2010 00:58:05:
>
> Hi all,
>
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
>
> cc1: error: include/linux/autoconf.h: No such file or directory
>
> (while building the boot wrappers - lots more of the same)
>
> Caused by commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 ("zlib:
> optimize inffast when copying direct from output").  autoconf.h moved
> from include/linux to include/generated in commit
> 264a26838056fc2d759f58bec2e720e01fcb1bdb ("kbuild: move autoconf.h to
> include/generated") which was in linux-next since 14 Dec 2009 and in
> Linus' tree since 18 Dec 2009.
>
[SNIP]
>
> This latter build problem is probably only noticed if you build with a
> separate object directory (i.e. with O=.. on the make command).  The
> previous PowerPC maintainer tells me that defining __KERNEL__ in the
> BOOTFLAGS is wrong and should have been noticed.

Is this any better w.r.t __KERNEL__?

>From 1a79993a42e17be665d3488663d81c0513b8bbfe Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 12 Jan 2010 13:31:58 +0100
Subject: [PATCH] powerpc: move __KERNEL__ define in bootwrapper.

Apparently using -D__KERNEL__ in BOOTCFLAGS is a bad thing.
Move __KERNEL__ into inffast.c where it is needed.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/boot/Makefile |    2 +-
 lib/zlib_inflate/inffast.c |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 79ebd6f..766fb88 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -20,7 +20,7 @@
 all: $(obj)/zImage

 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-		 -fno-strict-aliasing -Os -msoft-float -pipe -D__KERNEL__\
+		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index 05e1559..919c162 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -2,7 +2,9 @@
  * Copyright (C) 1995-2004 Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
  */
-
+#ifndef __KERNEL__
+#define __KERNEL__
+#endif
 #include <linux/zutil.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
--
1.6.4.4
