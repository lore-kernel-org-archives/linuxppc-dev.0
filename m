Return-Path: <anton@samba.org>
Date: Mon, 16 Dec 2013 10:47:54 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Fix endian issues in power7/8 machine check handler
Message-ID: <20131216104754.284ed286@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The SLB save area is shared with the hypervisor and is defined
as big endian, so we need to byte swap on little endian builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index b36e777..27c93f4 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -50,12 +50,12 @@ static void flush_and_reload_slb(void)
 	if (!slb)
 		return;
 
-	n = min_t(u32, slb->persistent, SLB_MIN_SIZE);
+	n = min_t(u32, be32_to_cpu(slb->persistent), SLB_MIN_SIZE);
 
 	/* Load up the SLB entries from shadow SLB */
 	for (i = 0; i < n; i++) {
-		unsigned long rb = slb->save_area[i].esid;
-		unsigned long rs = slb->save_area[i].vsid;
+		unsigned long rb = be64_to_cpu(slb->save_area[i].esid);
+		unsigned long rs = be64_to_cpu(slb->save_area[i].vsid);
 
 		rb = (rb & ~0xFFFul) | i;
 		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
