Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 892811A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 10:42:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/kvm: Fix SMP=n build error in book3s_xics.c
Date: Tue, 28 Apr 2015 10:42:47 +1000
Message-Id: <1430181767-2193-1-git-send-email-mpe@ellerman.id.au>
Cc: warrier@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 34cb7954c0aa "Convert ICS mutex lock to spin lock" added an
include of asm/spinlock.h, which does not work in the SMP=n case.

It should instead include linux/spinlock.h

Fixes: 34cb7954c0aa ("KVM: PPC: Book3S HV: Convert ICS mutex lock to spin lock")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

I'll drop this in my fixes branch for tomorrow unless someone objects.

 arch/powerpc/kvm/book3s_xics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 8f3e6cc54d95..c6ca7db64673 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/anon_inodes.h>
+#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/kvm_book3s.h>
@@ -20,7 +21,6 @@
 #include <asm/xics.h>
 #include <asm/debug.h>
 #include <asm/time.h>
-#include <asm/spinlock.h>
 
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-- 
2.1.0
