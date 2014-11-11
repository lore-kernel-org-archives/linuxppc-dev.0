Return-Path: <boqun.feng@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C8E51A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 15:50:34 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <boqun.feng@linux.vnet.ibm.com>;
 Tue, 11 Nov 2014 10:20:31 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 282EF3940049
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 10:20:28 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAB4owVS46661836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 10:20:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAB4oOSa023950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 10:20:25 +0530
From: Boqun Feng <boqun.feng@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix comment typos in
 arch/powerpc/include/asm/bitops.h
Date: Tue, 11 Nov 2014 12:50:22 +0800
Message-Id: <1415681422-3683-1-git-send-email-boqun.feng@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In arch/powerpc/include/asm/bitops.h, the comments about bit numbers in
large (> 1 word) bitmaps have two typos:
- On ppc64 system, the LSB of the 4th word should be bit 192 rather than
  196, because if it's bit 196, bit 192-195 will be missing in the
  bitmap.
- On ppc32 system, the LSB of the second word should be bit 32 rather
  than 31, because bit 31 is already in the first word.

This patch fixes these typos.

Signed-off-by: Boqun Feng <boqun.feng@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index bd3bd57..a39ab08 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -14,9 +14,9 @@
  *
  * The bitop functions are defined to work on unsigned longs, so for a
  * ppc64 system the bits end up numbered:
- *   |63..............0|127............64|191...........128|255...........196|
+ *   |63..............0|127............64|191...........128|255...........192|
  * and on ppc32:
- *   |31.....0|63....31|95....64|127...96|159..128|191..160|223..192|255..224|
+ *   |31.....0|63....32|95....64|127...96|159..128|191..160|223..192|255..224|
  *
  * There are a few little-endian macros used mostly for filesystem
  * bitmaps, these work on similar bit arrays layouts, but
-- 
2.1.3
