Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stZSj1kf0zDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 22:26:29 +1100 (AEDT)
Date: Tue, 11 Oct 2016 22:25:47 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Fix incorrect return value from __copy_tofrom_user
Message-ID: <20161011112547.GA24222@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Debugging a data corruption issue with virtio-net/vhost-net led to
the observation that __copy_tofrom_user was occasionally returning
a value 16 larger than it should.  Since the return value from
__copy_tofrom_user is the number of bytes not copied, this means
that __copy_tofrom_user can occasionally return a value larger
than the number of bytes it was asked to copy.  In turn this can
cause higher-level copy functions such as copy_page_to_iter_iovec
to corrupt memory by copying data into the wrong memory locations.

It turns out that the failing case involves a fault on the store
at label 79, and at that point the first unmodified byte of the
destination is at R3 + 16.  Consequently the exception handler
for that store needs to add 16 to R3 before using it to work out
how many bytes were not copied, but in this one case it was not
adding the offset to R3.  To fix it, this moves the label 179 to
the point where we add 16 to R3.  I have checked manually all the
exception handlers for the loads and stores in this code and the
rest of them are correct (it would be excellent to have an
automated test of all the exception cases).

This bug has been present since this code was initially
committed in May 2002 to Linux version 2.5.20.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/copyuser_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index f09899e..7b22624 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -359,6 +359,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	addi	r3,r3,8
 171:
 177:
+179:
 	addi	r3,r3,8
 370:
 372:
@@ -373,7 +374,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 173:
 174:
 175:
-179:
 181:
 184:
 186:
-- 
2.7.4
