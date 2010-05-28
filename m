Return-Path: <martyn.welch@ge.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7056CB7D12
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 May 2010 01:20:44 +1000 (EST)
From: Martyn Welch <martyn.welch@ge.com>
Subject: [PATCH] PowerPC: Remove hardcoded BAT configuration of IMMR in CPM
	early debug console
To: galak@kernel.crashing.org, benh@kernel.crashing.org
Date: Fri, 28 May 2010 16:18:38 +0100
Message-ID: <20100528151836.5889.10393.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPM early debug console hardcodes the BAT to cover the IMMR at
0xf0000000. The IMMR (on the mpc8270 at the very least) can be set to a
number of locations with bootstrap configuration, which are outside the
hardcoded BAT configuration.

This patch determines the correct location at which to configure a BAT
during the boot process from the supplied PPC_EARLY_DEBUG_CPM_ADDR.

Signed-off-by: Martyn Welch <martyn.welch@ge.com>
---

 arch/powerpc/kernel/head_32.S    |    5 +++--
 arch/powerpc/sysdev/cpm_common.c |    4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index e025e89..861cace 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1194,12 +1194,13 @@ setup_disp_bat:
 #endif /* CONFIG_BOOTX_TEXT */
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+#define PPC_EARLY_DEBUG_CPM_ADDR ASM_CONST(CONFIG_PPC_EARLY_DEBUG_CPM_ADDR)
 setup_cpm_bat:
-	lis	r8, 0xf000
+	lis	r8, PPC_EARLY_DEBUG_CPM_ADDR@ha
 	ori	r8, r8,	0x002a
 	mtspr	SPRN_DBAT1L, r8
 
-	lis	r11, 0xf000
+	lis	r11, PPC_EARLY_DEBUG_CPM_ADDR@ha
 	ori	r11, r11, (BL_1M << 2) | 2
 	mtspr	SPRN_DBAT1U, r11
 
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 88b9812..984614f 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -57,7 +57,9 @@ void __init udbg_init_cpm(void)
 {
 	if (cpm_udbg_txdesc) {
 #ifdef CONFIG_CPM2
-		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
+#define EARLY_DEBUG_CPM_BAT (CONFIG_PPC_EARLY_DEBUG_CPM_ADDR&0xfff00000)
+		setbat(1, EARLY_DEBUG_CPM_BAT, EARLY_DEBUG_CPM_BAT, 1024*1024,
+			PAGE_KERNEL_NCG);
 #endif
 		udbg_putc = udbg_putc_cpm;
 	}


--
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
