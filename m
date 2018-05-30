Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wn2G2Zl4zDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 20:31:33 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id r11-v6so1252210pfl.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 03:31:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s: Fix compiler store ordering to SLB shadow area
Date: Wed, 30 May 2018 20:31:22 +1000
Message-Id: <20180530103122.27674-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The stores to update the SLB shadow area must be made as they appear
in the C code, so that the hypervisor does not see an entry with
mismatched vsid and esid. Use WRITE_ONCE for this.

GCC has been observed to elide the first store to esid in the update,
which means that if the hypervisor interrupts the guest after storing
to vsid, it could see an entry with old esid and new vsid, which may
possibly result in memory corruption.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 66577cc66dc9..2f4b33b24b3b 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -63,14 +63,14 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
 	 * updating it.  No write barriers are needed here, provided
 	 * we only update the current CPU's SLB shadow buffer.
 	 */
-	p->save_area[index].esid = 0;
-	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
-	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));
+	WRITE_ONCE(p->save_area[index].esid, 0);
+	WRITE_ONCE(p->save_area[index].vsid, cpu_to_be64(mk_vsid_data(ea, ssize, flags)));
+	WRITE_ONCE(p->save_area[index].esid, cpu_to_be64(mk_esid_data(ea, ssize, index)));
 }
 
 static inline void slb_shadow_clear(enum slb_index index)
 {
-	get_slb_shadow()->save_area[index].esid = 0;
+	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
 }
 
 static inline void create_shadowed_slbe(unsigned long ea, int ssize,
-- 
2.17.0
