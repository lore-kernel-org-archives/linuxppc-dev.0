Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tv08S6s5JzDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 05:44:08 +1100 (AEDT)
Date: Wed, 4 Jan 2017 18:10:28 +0000
From: Joseph Myers <joseph@codesourcery.com>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: fix 32-bit ppc_fadvise64_64 for 64-bit offset
Message-ID: <alpine.DEB.2.20.1701041806570.2535@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Consider the following test, built for 32-bit powerpc and run under a
32-bit kernel.

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int
main (void)
{
  int fd = open ("/dev/null", O_RDWR);
  int ret = posix_fadvise64 (fd, 0, -1, POSIX_FADV_NORMAL);
  if (ret == EINVAL)
    puts ("posix_fadvise64 returned EINVAL as expected");
  else
    printf ("posix_fadvise64 returned %d, expected EINVAL = %d\n",
            ret, EINVAL);
  close (fd);
  return 0;
}

For 32-bit powerpc, posix_fadvise64 uses the fadvise64_64 syscall.
The negative length means it should return EINVAL.

That syscall uses the ppc_fadvise64_64 function to rearrange the
arguments into the form used by the architecture-independent syscall
implementation.  That function calls sys_fadvise64.  sys_fadvise64
uses type size_t for the length argument, and passes its arguments
through to sys_fadvise64_64, which uses type loff_t.

This works OK under a 64-bit kernel, where size_t is 64-bit.  Under a
32-bit kernel, however, passing the length through sys_fadvise64
results in it being truncated to 32-bit size_t and then zero-extended
back to 64-bit, so resulting in 0 rather than EINVAL being returned
for the above test.

This patch fixes this bug by calling sys_fadvise64_64 directly from
ppc_fadvise64_64.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

Please note that I encountered this problem with older kernels, and
while the relevant area has not changed recently and the above
analysis and this patch are based on current sources, I ran into an
unrelated build failure when attempting to build current kernels to
test this fix.  Thus, the patch should only be applied given testing
that the problem is indeed reproducible with current 32-bit kernels
and is fixed by this patch.

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index de04c9f..7753f77 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -119,8 +119,8 @@ long ppc64_personality(unsigned long personality)
 long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
 		      u32 len_high, u32 len_low)
 {
-	return sys_fadvise64(fd, (u64)offset_high << 32 | offset_low,
-			     (u64)len_high << 32 | len_low, advice);
+	return sys_fadvise64_64(fd, (u64)offset_high << 32 | offset_low,
+				(u64)len_high << 32 | len_low, advice);
 }
 
 long sys_switch_endian(void)

-- 
Joseph S. Myers
joseph@codesourcery.com
