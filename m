Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	nfont@linux.vnet.ibm.com
Subject: [PATCH 2/2] powerpc/powernv: Set memory_block_size_bytes to 256MB
Date: Fri, 25 Apr 2014 21:42:29 +1000
Message-Id: <1398426149-27359-2-git-send-email-anton@samba.org>
In-Reply-To: <1398426149-27359-1-git-send-email-anton@samba.org>
References: <1398426149-27359-1-git-send-email-anton@samba.org>
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
 arch/powerpc/platforms/powernv/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 61cf8fa..a55921a 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -178,6 +178,11 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 }
 #endif /* CONFIG_KEXEC */
 
+static unsigned long pnv_memory_block_size(void)
+{
+	return 256UL * 1024 * 1024;
+}
+
 static void __init pnv_setup_machdep_opal(void)
 {
 	ppc_md.get_boot_time = opal_get_boot_time;
@@ -240,4 +245,5 @@ define_machine(powernv) {
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
+	.memory_block_size	= pnv_memory_block_size,
 };
-- 
1.8.3.2
