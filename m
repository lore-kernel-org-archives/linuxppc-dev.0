Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <a8a7d2c5e5ae1773da220c9eb1f0769bf2d85cfb.1192440801.git.michael@ellerman.id.au>
In-Reply-To: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
References: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/5] Add dcr_host_t.base in dcr_read()/dcr_write()
Date: Mon, 15 Oct 2007 19:34:36 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that all users of dcr_read()/dcr_write() add the dcr_host_t.base, we
can save them the trouble and do it in dcr_read()/dcr_write().

As some background to why we just went through all this jiggery-pokery,
benh sayeth:

 Initially the goal of the dcr_read/dcr_write routines was to operate like
 mfdcr/mtdcr which take absolute DCR numbers. The reason is that on 4xx
 hardware, indirect DCR access is a pain (goes through a table of
 instructions) and it's useful to have the compiler resolve an absolute DCR
 inline.

 We decided that wasn't worth the API bastardisation since most places
 where absolute DCR values are used are low level 4xx-only code which may
 as well continue using mfdcr/mtdcr, while the new API is designed for
 device "instances" that can exist on 4xx and Axon type platforms and may
 be located at variable DCR offsets.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |    4 ++--
 arch/powerpc/sysdev/mpic.c             |    4 ++--
 drivers/net/ibm_emac/ibm_emac_mal.h    |    4 ++--
 drivers/net/ibm_newemac/mal.h          |    4 ++--
 include/asm-powerpc/dcr-mmio.h         |    4 ++--
 include/asm-powerpc/dcr-native.h       |    4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 1245b2f..aca1500 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -77,12 +77,12 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 {
 	pr_debug("axon_msi: dcr_write(0x%x, 0x%x)\n", val, dcr_n);
 
-	dcr_write(msic->dcr_host, msic->dcr_host.base + dcr_n, val);
+	dcr_write(msic->dcr_host, dcr_n, val);
 }
 
 static u32 msic_dcr_read(struct axon_msic *msic, unsigned int dcr_n)
 {
-	return dcr_read(msic->dcr_host, msic->dcr_host.base + dcr_n);
+	return dcr_read(msic->dcr_host, dcr_n);
 }
 
 static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 893e654..e479388 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -156,7 +156,7 @@ static inline u32 _mpic_read(enum mpic_reg_type type,
 	switch(type) {
 #ifdef CONFIG_PPC_DCR
 	case mpic_access_dcr:
-		return dcr_read(rb->dhost, rb->dhost.base + reg);
+		return dcr_read(rb->dhost, reg);
 #endif
 	case mpic_access_mmio_be:
 		return in_be32(rb->base + (reg >> 2));
@@ -173,7 +173,7 @@ static inline void _mpic_write(enum mpic_reg_type type,
 	switch(type) {
 #ifdef CONFIG_PPC_DCR
 	case mpic_access_dcr:
-		return dcr_write(rb->dhost, rb->dhost.base + reg, value);
+		return dcr_write(rb->dhost, reg, value);
 #endif
 	case mpic_access_mmio_be:
 		return out_be32(rb->base + (reg >> 2), value);
diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
index aa76d3f..b8adbe6 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.h
+++ b/drivers/net/ibm_emac/ibm_emac_mal.h
@@ -208,12 +208,12 @@ struct ibm_ocp_mal {
 
 static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
 {
-	return dcr_read(mal->dcrhost, mal->dcrhost.base + reg);
+	return dcr_read(mal->dcrhost, reg);
 }
 
 static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
 {
-	dcr_write(mal->dcrhost, mal->dcrhost.base + reg, val);
+	dcr_write(mal->dcrhost, reg, val);
 }
 
 /* Register MAL devices */
diff --git a/drivers/net/ibm_newemac/mal.h b/drivers/net/ibm_newemac/mal.h
index 6daa98e..784edb8 100644
--- a/drivers/net/ibm_newemac/mal.h
+++ b/drivers/net/ibm_newemac/mal.h
@@ -212,12 +212,12 @@ struct mal_instance {
 
 static inline u32 get_mal_dcrn(struct mal_instance *mal, int reg)
 {
-	return dcr_read(mal->dcr_host, mal->dcr_host.base + reg);
+	return dcr_read(mal->dcr_host, reg);
 }
 
 static inline void set_mal_dcrn(struct mal_instance *mal, int reg, u32 val)
 {
-	dcr_write(mal->dcr_host, mal->dcr_host.base + reg, val);
+	dcr_write(mal->dcr_host, reg, val);
 }
 
 /* Register MAL devices */
diff --git a/include/asm-powerpc/dcr-mmio.h b/include/asm-powerpc/dcr-mmio.h
index 6b82c3b..a7d9eaf 100644
--- a/include/asm-powerpc/dcr-mmio.h
+++ b/include/asm-powerpc/dcr-mmio.h
@@ -37,12 +37,12 @@ extern void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c);
 
 static inline u32 dcr_read(dcr_host_t host, unsigned int dcr_n)
 {
-	return in_be32(host.token + dcr_n * host.stride);
+	return in_be32(host.token + ((host.base + dcr_n) * host.stride));
 }
 
 static inline void dcr_write(dcr_host_t host, unsigned int dcr_n, u32 value)
 {
-	out_be32(host.token + dcr_n * host.stride, value);
+	out_be32(host.token + ((host.base + dcr_n) * host.stride), value);
 }
 
 extern u64 of_translate_dcr_address(struct device_node *dev,
diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
index f41058c..3bc780f 100644
--- a/include/asm-powerpc/dcr-native.h
+++ b/include/asm-powerpc/dcr-native.h
@@ -30,8 +30,8 @@ typedef struct {
 
 #define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){ .base = (dcr_n) })
 #define dcr_unmap(host, dcr_n, dcr_c)	do {} while (0)
-#define dcr_read(host, dcr_n)		mfdcr(dcr_n)
-#define dcr_write(host, dcr_n, value)	mtdcr(dcr_n, value)
+#define dcr_read(host, dcr_n)		mfdcr(dcr_n + host.base)
+#define dcr_write(host, dcr_n, value)	mtdcr(dcr_n + host.base, value)
 
 /* Device Control Registers */
 void __mtdcr(int reg, unsigned int val);
-- 
1.5.1.3.g7a33b
