Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <d2af1539a019b73526f6b603536a19b8429a43ef.1192440801.git.michael@ellerman.id.au>
In-Reply-To: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
References: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/5] Use dcr_host_t.base in dcr_unmap()
Date: Mon, 15 Oct 2007 19:34:37 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the base stored in dcr_host_t, there's no need for callers to pass
the dcr_n into dcr_unmap(). In fact this removes the possibility of them
passing the incorrect value, which would then be iounmap()'ed.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/dcr.c        |    4 ++--
 drivers/net/ibm_newemac/mal.c    |    2 +-
 include/asm-powerpc/dcr-mmio.h   |    2 +-
 include/asm-powerpc/dcr-native.h |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index ab11c0b..427027c 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -126,13 +126,13 @@ dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
 }
 EXPORT_SYMBOL_GPL(dcr_map);
 
-void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c)
+void dcr_unmap(dcr_host_t host, unsigned int dcr_c)
 {
 	dcr_host_t h = host;
 
 	if (h.token == NULL)
 		return;
-	h.token += dcr_n * h.stride;
+	h.token += host.base * h.stride;
 	iounmap(h.token);
 	h.token = NULL;
 }
diff --git a/drivers/net/ibm_newemac/mal.c b/drivers/net/ibm_newemac/mal.c
index 748a869..39f4cb6 100644
--- a/drivers/net/ibm_newemac/mal.c
+++ b/drivers/net/ibm_newemac/mal.c
@@ -627,7 +627,7 @@ static int __devinit mal_probe(struct of_device *ofdev,
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
  fail_unmap:
-	dcr_unmap(mal->dcr_host, dcr_base, 0x100);
+	dcr_unmap(mal->dcr_host, 0x100);
  fail:
 	kfree(mal);
 
diff --git a/include/asm-powerpc/dcr-mmio.h b/include/asm-powerpc/dcr-mmio.h
index a7d9eaf..08532ff 100644
--- a/include/asm-powerpc/dcr-mmio.h
+++ b/include/asm-powerpc/dcr-mmio.h
@@ -33,7 +33,7 @@ typedef struct {
 
 extern dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
 			  unsigned int dcr_c);
-extern void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c);
+extern void dcr_unmap(dcr_host_t host, unsigned int dcr_c);
 
 static inline u32 dcr_read(dcr_host_t host, unsigned int dcr_n)
 {
diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
index 3bc780f..8dbb1ab 100644
--- a/include/asm-powerpc/dcr-native.h
+++ b/include/asm-powerpc/dcr-native.h
@@ -29,7 +29,7 @@ typedef struct {
 #define DCR_MAP_OK(host)	(1)
 
 #define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){ .base = (dcr_n) })
-#define dcr_unmap(host, dcr_n, dcr_c)	do {} while (0)
+#define dcr_unmap(host, dcr_c)		do {} while (0)
 #define dcr_read(host, dcr_n)		mfdcr(dcr_n + host.base)
 #define dcr_write(host, dcr_n, value)	mtdcr(dcr_n + host.base, value)
 
-- 
1.5.1.3.g7a33b
