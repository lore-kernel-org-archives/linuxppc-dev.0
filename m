Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e7d461c6fbf2cdc3d255ebaed8ebfcc66ff2a7e9.1182493056.git.michael@ellerman.id.au>
In-Reply-To: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
References: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/5] Add dcr_host_t.base in dcr_read()/dcr_write()
Date: Fri, 22 Jun 2007 16:18:09 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that all users of dcr_read()/dcr_write() add the dcr_host_t.base, we can
save them the trouble and do it in dcr_read()/dcr_write().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/mpic.c          |    4 ++--
 drivers/net/ibm_emac/ibm_emac_mal.h |    4 ++--
 include/asm-powerpc/dcr-mmio.h      |    4 ++--
 include/asm-powerpc/dcr-native.h    |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 6c2e467..8cb8e13 100644
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
index 6b1fbeb..10dc978 100644
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
