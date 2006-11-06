Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (host32.eke.fi [194.100.64.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F7C067C47
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 00:29:53 +1100 (EST)
Date: Mon, 6 Nov 2006 15:29:47 +0200 (EET)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: linuxppc-embedded@ozlabs.org, Vitaly Bordug <vbordug@ru.mvista.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
Message-ID: <Pine.LNX.4.64.0611061523360.12023@host32.eke.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

SMC handling is broken in two places when using then platform device
approach with CPM2 devices.

1. The resources in pq2_devices are not named "regs" and "pram", thus they
    are not found in cpm_uart_drv_get_platform_data().

2. The code in cpm_uart_drv_get_platform_data() assumes the parameter RAM
    is at "pram". With SMCs of CPM2 devices, "pram" is just a pointer to the
    actual parameter RAM, which the code should reserve somewhere in DPRAM.

This patch renames these the two existing resources, and introduces a new one,
"pram_base", which is a pointer to the parameter RAM. The parameter RAM for SMC1
and SMC2 is put in the first 128 bytes of the DPRAM. This memory was already
reserved from the DPRAM memory allocator for this purpose.

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
---
  arch/ppc/syslib/pq2_devices.c           |   24 ++++++++++++++++++------
  drivers/serial/cpm_uart/cpm_uart_core.c |    8 +++++++-
  2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/ppc/syslib/pq2_devices.c b/arch/ppc/syslib/pq2_devices.c
index fefbc21..e8f7ba2 100644
--- a/arch/ppc/syslib/pq2_devices.c
+++ b/arch/ppc/syslib/pq2_devices.c
@@ -286,16 +286,22 @@ struct platform_device ppc_sys_platform_
  	[MPC82xx_CPM_SMC1] = {
  		.name = "fsl-cpm-smc",
  		.id	= 1,
-		.num_resources	 = 3,
+		.num_resources	 = 4,
  		.resource = (struct resource[]) {
  			{
-				.name	= "smc_mem",
+				.name	= "regs",
  				.start	= 0x11A80,
  				.end	= 0x11A8F,
  				.flags	= IORESOURCE_MEM,
  			},
  			{
-				.name	= "smc_pram",
+				.name	= "pram",
+				.start	= PROFF_SMC1,
+				.end	= PROFF_SMC1 + 63,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "pram_base",
  				.start	= 0x87fc,
  				.end	= 0x87fd,
  				.flags	= IORESOURCE_MEM,
@@ -310,16 +316,22 @@ struct platform_device ppc_sys_platform_
  	[MPC82xx_CPM_SMC2] = {
  		.name = "fsl-cpm-smc",
  		.id	= 2,
-		.num_resources	 = 3,
+		.num_resources	 = 4,
  		.resource = (struct resource[]) {
  			{
-				.name	= "smc_mem",
+				.name	= "regs",
  				.start	= 0x11A90,
  				.end	= 0x11A9F,
  				.flags	= IORESOURCE_MEM,
  			},
  			{
-				.name	= "smc_pram",
+				.name	= "pram",
+				.start	= PROFF_SMC2,
+				.end	= PROFF_SMC2 + 63,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "pram_base",
  				.start	= 0x88fc,
  				.end	= 0x88fd,
  				.flags	= IORESOURCE_MEM,
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 4047530..55419b1 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1024,7 +1024,7 @@ int cpm_uart_drv_get_platform_data(struc
  	int idx = pdata->fs_no;	/* It is UART_SMCx or UART_SCCx index */
  	struct uart_cpm_port *pinfo;
  	int line;
-	u32 mem, pram;
+	u32 mem, pram, pram_base;

  	line = cpm_uart_id2nr(idx);
  	if(line < 0) {
@@ -1049,6 +1049,12 @@ int cpm_uart_drv_get_platform_data(struc
  		return -EINVAL;
  	pram = r->start;

+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram_base");
+	if (r) {
+		pram_base = r->start;
+		out_be16((u16 *)pram_base, pram & 0xffff);
+	}
+
  	if(idx > fsid_smc2_uart) {
  		pinfo->sccp = (scc_t *)mem;
  		pinfo->sccup = (scc_uart_t *)pram;
-- 
1.4.1.1
