Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 26/39] powerpc/powernv: Make OPAL NVRAM device tree accesses
 endian safe
Date: Mon, 23 Sep 2013 12:05:00 +1000
Message-Id: <1379901913-5945-27-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal-nvram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
index 3f83e1a..acd9f7e 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -65,7 +65,7 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 void __init opal_nvram_init(void)
 {
 	struct device_node *np;
-	const u32 *nbytes_p;
+	const __be32 *nbytes_p;
 
 	np = of_find_compatible_node(NULL, NULL, "ibm,opal-nvram");
 	if (np == NULL)
@@ -76,7 +76,7 @@ void __init opal_nvram_init(void)
 		of_node_put(np);
 		return;
 	}
-	nvram_size = *nbytes_p;
+	nvram_size = be32_to_cpup(nbytes_p);
 
 	printk(KERN_INFO "OPAL nvram setup, %u bytes\n", nvram_size);
 	of_node_put(np);
-- 
1.8.1.2
