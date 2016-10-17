Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syXzr5ZgFzDvRh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 09:33:44 +1100 (AEDT)
Date: Tue, 18 Oct 2016 09:33:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: ignore the pkey system calls for now
Message-ID: <20161018093344.1f52d1f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Eliminates warning messages:

<stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
<stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
<stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]

Hopefully we will remember to revert this commit if we ever implement
them.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/unistd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index cf12c580f6b2..e8cdfec8d512 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -16,6 +16,10 @@
 
 #define __NR__exit __NR_exit
 
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
-- 
2.9.3

-- 
Cheers,
Stephen Rothwell
