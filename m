Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC3BF1A0837
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 17:52:42 +1000 (EST)
Date: Wed, 4 Jun 2014 17:52:42 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH v2 2/2] powerpc/powernv: Set memory_block_size_bytes to 256MB
Message-ID: <20140604175242.76ea60eb@kryten>
In-Reply-To: <20140604175047.35b116b3@kryten>
References: <20140604175047.35b116b3@kryten>
MIME-Version: 1.0
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

powerpc sets a low SECTION_SIZE_BITS to accomodate small pseries
boxes. We default to 16MB memory blocks, and boxes with a lot
of memory end up with enormous numbers of sysfs memory nodes.

Set a more reasonable default for powernv of 256MB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 865aab4..8c16a5f 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -244,6 +244,13 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 }
 #endif /* CONFIG_KEXEC */
 
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+static unsigned long pnv_memory_block_size(void)
+{
+	return 256UL * 1024 * 1024;
+}
+#endif
+
 static void __init pnv_setup_machdep_opal(void)
 {
 	ppc_md.get_boot_time = opal_get_boot_time;
@@ -326,4 +333,7 @@ define_machine(powernv) {
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+	.memory_block_size	= pnv_memory_block_size,
+#endif
 };
-- 
1.9.1
