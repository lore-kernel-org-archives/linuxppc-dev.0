Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F05D679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 02:26:49 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/4] ppc32: odd fixes and improvements in ppc_sys
Date: Tue, 25 Apr 2006 20:26:33 +0400
Message-Id: <20060425162633.23551.85273.stgit@vitb.ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This consists of offsets fix in ..._devices.c, and update of
ppc_sys_fixup_mem_resource() function to prevent subsequent fixups

Sigbed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/syslib/mpc8xx_devices.c |   25 +++++++++++++++++++------
 arch/ppc/syslib/ppc_sys.c        |    4 +++-
 arch/ppc/syslib/pq2_sys.c        |    8 ++++----
 include/asm-ppc/ppc_sys.h        |    2 ++
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
index bd41ed8..6f53638 100644
--- a/arch/ppc/syslib/mpc8xx_devices.c
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -170,12 +170,18 @@ struct platform_device ppc_sys_platform_
 	[MPC8xx_CPM_SMC1] = {
 		.name = "fsl-cpm-smc",
 		.id	= 1,
-		.num_resources	= 2,
+		.num_resources	= 3,
 		.resource = (struct resource[]) {
 			{
 				.name	= "regs",
-				.start	= 0xa82,
-				.end	= 0xa91,
+				.start	= 0xa80,
+				.end	= 0xa8f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "pram",
+				.start	= 0x3e80,
+				.end	= 0x3ebf,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
@@ -189,15 +195,22 @@ struct platform_device ppc_sys_platform_
 	[MPC8xx_CPM_SMC2] = {
 		.name = "fsl-cpm-smc",
 		.id	= 2,
-		.num_resources	= 2,
+		.num_resources	= 3,
 		.resource = (struct resource[]) {
 			{
 				.name	= "regs",
-				.start	= 0xa92,
-				.end	= 0xaa1,
+				.start	= 0xa90,
+				.end	= 0xa9f,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
+ 				.name	= "pram",
+ 				.start	= 0x3f80,
+ 				.end	= 0x3fbf,
+ 				.flags	= IORESOURCE_MEM,
+
+			},
+			{
 				.name	= "interrupt",
 				.start	= MPC8xx_INT_SMC2,
 				.end	= MPC8xx_INT_SMC2,
diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
index 7662c4e..2d48018 100644
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -109,9 +109,11 @@ ppc_sys_fixup_mem_resource(struct platfo
 	int i;
 	for (i = 0; i < pdev->num_resources; i++) {
 		struct resource *r = &pdev->resource[i];
-		if ((r->flags & IORESOURCE_MEM) == IORESOURCE_MEM) {
+		if (((r->flags & IORESOURCE_MEM) == IORESOURCE_MEM) && 
+			((r->flags & PPC_SYS_IORESOURCE_FIXUPPED) != PPC_SYS_IORESOURCE_FIXUPPED)) {
 			r->start += paddr;
 			r->end += paddr;
+			r->flags |= PPC_SYS_IORESOURCE_FIXUPPED;
 		}
 	}
 }
diff --git a/arch/ppc/syslib/pq2_sys.c b/arch/ppc/syslib/pq2_sys.c
index 75e64f1..433b0fa 100644
--- a/arch/ppc/syslib/pq2_sys.c
+++ b/arch/ppc/syslib/pq2_sys.c
@@ -113,13 +113,13 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8248",
 		.mask		= 0x0000ff00,
 		.value		= 0x00000c00,
-		.num_devices	= 11,
+		.num_devices	= 12,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
-			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SMC1,
-			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
-			MPC82xx_CPM_USB, MPC82xx_SEC1,
+			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SCC4,
+			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
+			MPC82xx_CPM_I2C, MPC82xx_CPM_USB, MPC82xx_SEC1,
 		},
 	},
 	{
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index 4b94f70..40f197a 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -39,6 +39,8 @@
 #error "need definition of ppc_sys_devices"
 #endif
 
+#define PPC_SYS_IORESOURCE_FIXUPPED	0x00000001	
+
 struct ppc_sys_spec {
 	/* PPC sys is matched via (ID & mask) == value, id could be
 	 * PVR, SVR, IMMR, * etc. */
