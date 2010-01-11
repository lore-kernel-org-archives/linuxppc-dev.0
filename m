Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F0466B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 10:58:09 +1100 (EST)
Date: Tue, 12 Jan 2010 10:58:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: linux-next: origin tree build failure
Message-Id: <20100112105805.50e39a77.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

cc1: error: include/linux/autoconf.h: No such file or directory

(while building the boot wrappers - lots more of the same)

Caused by commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 ("zlib:
optimize inffast when copying direct from output").  autoconf.h moved
from include/linux to include/generated in commit
264a26838056fc2d759f58bec2e720e01fcb1bdb ("kbuild: move autoconf.h to
include/generated") which was in linux-next since 14 Dec 2009 and in
Linus' tree since 18 Dec 2009.

I added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 12 Jan 2010 10:23:43 +1100
Subject: [PATCH] powerpc: fix boot Makefile for autoconf.h moving

autoconf.h moved from include/linux to include/generated

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 826a30a..fb32a8e 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -34,7 +34,7 @@ BOOTCFLAGS	+= -fno-stack-protector
 endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
-BOOTCFLAGS	+= -include include/linux/autoconf.h -Iarch/powerpc/include
+BOOTCFLAGS	+= -include include/generated/autoconf.h -Iarch/powerpc/include
 BOOTCFLAGS	+= -Iinclude
 
 DTS_FLAGS	?= -p 1024
-- 
1.6.6

However, this then produced these errors:

arch/powerpc/boot/inffast.c:7:27: error: asm/unaligned.h: No such file or directory
arch/powerpc/boot/inffast.c:8:27: error: asm/byteorder.h: No such file or directory
arch/powerpc/boot/inffast.c: In function 'inflate_fast':
arch/powerpc/boot/inffast.c:263: warning: implicit declaration of function 'get_unaligned'
arch/powerpc/boot/inffast.c:277:2: error: #error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined

So I just reverted the original commit (after removing my fix above).

This latter build problem is probably only noticed if you build with a
separate object directory (i.e. with O=.. on the make command).  The
previous PowerPC maintainer tells me that defining __KERNEL__ in the
BOOTFLAGS is wrong and should have been noticed.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
