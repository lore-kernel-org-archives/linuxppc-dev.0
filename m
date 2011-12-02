Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FBAFB6F69
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 09:26:34 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 2 Dec 2011 17:26:30 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB2MQSn43285242
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Dec 2011 17:26:28 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB2MQSTe017173
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Dec 2011 20:26:28 -0200
Date: Fri, 2 Dec 2011 14:26:23 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 1/1] Punch a hole in /dev/mem for librtas
Message-ID: <20111202222623.GA31354@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sbest@us.ibm.com, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Subject: [PATCH 1/1] Punch a hole in /dev/mem for librtas

With CONFIG_STRICT_DEVMEM=y, user space cannot read any part of /dev/mem.
Since this breaks librtas, punch a hole in /dev/mem to allow access to the
rmo_buffer that librtas needs.

Anton Blanchard reported the problem and helped with the fix.

A quick test for this patch:

       # cat /proc/rtas/rmo_buffer
       000000000f190000 10000

       # python -c "print 0x000000000f190000 / 0x10000"
       3865

       # dd if=/dev/mem of=/tmp/foo count=1 bs=64k skip=3865
       1+0 records in
       1+0 records out
       65536 bytes (66 kB) copied, 0.000205235 s, 319 MB/s

       # dd if=/dev/mem of=/tmp/foo
       dd: reading `/dev/mem': Operation not permitted
       0+0 records in
       0+0 records out
       0 bytes (0 B) copied, 0.00022519 s, 0.0 kB/s

Changelog[v3]:  [Ben Harrenschmidt]: Incremental patch for the punched hole,
		since CONFIG_STRICT_DEVMEM was merged into the -next branch.

		[Ben Harrenschmidt]: Rename interface to page_is_rtas_user_buf()
		move declaration to a header file and ensure it doesn't break
		CONFIG_PPC_RTAS=n.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |   12 ++++++++++++
 arch/powerpc/mm/mem.c           |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 58625d1..c2d3c9f 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -305,5 +305,17 @@ static inline u32 rtas_config_addr(int busno, int devfn, int reg)
 extern void __cpuinit rtas_give_timebase(void);
 extern void __cpuinit rtas_take_timebase(void);
 
+#ifdef CONFIG_PPC_RTAS
+static inline int page_is_rtas_user_buf(unsigned long pfn)
+{
+	unsigned long paddr = (pfn << PAGE_SHIFT);
+	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf + RTAS_RMOBUF_MAX))
+		return 1;
+	return 0;
+}
+#else
+static inline int page_is_rtas_user_buf(unsigned long pfn) { return 0;}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_RTAS_H */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 553fb41..05abd49 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -50,6 +50,7 @@
 #include <asm/vdso.h>
 #include <asm/fixmap.h>
 #include <asm/swiotlb.h>
+#include <asm/rtas.h>
 
 #include "mmu_decl.h"
 
@@ -564,6 +565,8 @@ int devmem_is_allowed(unsigned long pfn)
 		return 0;
 	if (!page_is_ram(pfn))
 		return 1;
+	if (page_is_rtas_user_buf(pfn))
+		return 1;
 	return 0;
 }
 #endif /* CONFIG_STRICT_DEVMEM */
-- 
1.7.0.4
