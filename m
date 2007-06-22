Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4c7183d665eed57f8ef2067c1f2c71b3c0e5246c.1182493056.git.michael@ellerman.id.au>
In-Reply-To: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
References: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/5] Add dcr_map_reg() helper
Date: Fri, 22 Jun 2007 16:18:11 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a helper routine to map dcr's based on the "dcr-reg" property of
a device node.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/dcr.c |   17 +++++++++++++++++
 include/asm-powerpc/dcr.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index f3c5646..da2ac7c 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -123,6 +123,23 @@ dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
 	return ret;
 }
 
+dcr_host_t dcr_map_reg(struct device_node *dev, unsigned int index)
+{
+	dcr_host_t ret = { .token = NULL };
+
+	unsigned int dcr_n, dcr_c;
+
+	dcr_n = dcr_resource_start(dev, index);
+	if (!dcr_n)
+		return ret;
+
+	dcr_c = dcr_resource_len(dev, index);
+	if (!dcr_c)
+		return ret;
+
+	return dcr_map(dev, dcr_n, dcr_c);
+}
+
 void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c)
 {
 	dcr_host_t h = host;
diff --git a/include/asm-powerpc/dcr.h b/include/asm-powerpc/dcr.h
index 9338d50..4d42f01 100644
--- a/include/asm-powerpc/dcr.h
+++ b/include/asm-powerpc/dcr.h
@@ -38,6 +38,7 @@ extern unsigned int dcr_resource_start(struct device_node *np,
 				       unsigned int index);
 extern unsigned int dcr_resource_len(struct device_node *np,
 				     unsigned int index);
+extern dcr_host_t dcr_map_reg(struct device_node *np, unsigned int index);
 #endif /* CONFIG_PPC_MERGE */
 
 #endif /* CONFIG_PPC_DCR */
-- 
1.5.1.3.g7a33b
