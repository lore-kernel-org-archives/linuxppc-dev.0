Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/2] arch/powerpc: Make slb_shadow a local
Message-Id: <1386214268.68092.227432126043.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 05 Dec 2013 11:31:08 +0800
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only external user of slb_shadow is the pseries lpar code, and it
can access through the paca array instead.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/include/asm/lppaca.h     |    2 --
 arch/powerpc/kernel/paca.c            |    2 +-
 arch/powerpc/platforms/pseries/lpar.c |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 844c28de..d0a2a2f9 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -132,8 +132,6 @@ struct slb_shadow {
 	} save_area[SLB_NUM_BOLTED];
 } ____cacheline_aligned;
 
-extern struct slb_shadow slb_shadow[];
-
 /*
  * Layout of entries in the hypervisor's dispatch trace log buffer.
  */
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0620eaaa..9095a6f7 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -99,7 +99,7 @@ static inline void free_lppacas(void) { }
  * 3 persistent SLBs are registered here.  The buffer will be zero
  * initially, hence will all be invaild until we actually write them.
  */
-struct slb_shadow slb_shadow[] __cacheline_aligned = {
+static struct slb_shadow slb_shadow[] __cacheline_aligned = {
 	[0 ... (NR_CPUS-1)] = {
 		.persistent = cpu_to_be32(SLB_NUM_BOLTED),
 		.buffer_length = cpu_to_be32(sizeof(struct slb_shadow)),
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 4fca3def..28cf0f33 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -92,7 +92,7 @@ void vpa_init(int cpu)
 	 * PAPR says this feature is SLB-Buffer but firmware never
 	 * reports that.  All SPLPAR support SLB shadow buffer.
 	 */
-	addr = __pa(&slb_shadow[cpu]);
+	addr = __pa(paca[cpu].slb_shadow_ptr);
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		ret = register_slb_shadow(hwcpu, addr);
 		if (ret)
