Return-Path: <bastian@waldi.eu.org>
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id 1A6F3DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 07:29:33 +1100 (EST)
Date: Fri, 1 Feb 2008 21:02:40 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
Subject: [PATCH] Fix ext4 bitops
Message-ID: <20080201200240.GA28566@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix ext4 bitops.

Signed-off-by: Bastian Blank <waldi@debian.org>

diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
index 220d9a7..d0980df 100644
--- a/include/asm-powerpc/bitops.h
+++ b/include/asm-powerpc/bitops.h
@@ -363,6 +363,8 @@ unsigned long generic_find_next_le_bit(const unsigned long *addr,
 				    unsigned long size, unsigned long offset);
 /* Bitmap functions for the ext2 filesystem */
 
+#include <asm-generic/bitops/le.h>
+
 #define ext2_set_bit(nr,addr) \
 	__test_and_set_le_bit((nr), (unsigned long*)addr)
 #define ext2_clear_bit(nr, addr) \
