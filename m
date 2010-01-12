Return-Path: <anton@ozlabs.org>
Date: Tue, 12 Jan 2010 13:21:51 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH]: powerpc: Fix build breakage due to incorrect location of
	autoconf.h
Message-ID: <20100112022150.GE12666@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roel Kluin <roel.kluin@gmail.com>, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 (zlib: optimize inffast when
copying direct from output) referenced include/linux/autoconf.h which
is now called include/generated/autoconf.h.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/boot/Makefile
===================================================================
--- linux-cpumask.orig/arch/powerpc/boot/Makefile	2010-01-12 13:15:26.266724762 +1100
+++ linux-cpumask/arch/powerpc/boot/Makefile	2010-01-12 13:15:33.532974469 +1100
@@ -34,7 +34,7 @@ BOOTCFLAGS	+= -fno-stack-protector
 endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
-BOOTCFLAGS	+= -include include/linux/autoconf.h -Iarch/powerpc/include
+BOOTCFLAGS	+= -include include/generated/autoconf.h -Iarch/powerpc/include
 BOOTCFLAGS	+= -Iinclude
 
 DTS_FLAGS	?= -p 1024
