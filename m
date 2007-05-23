Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1ED24DDE32
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:26:22 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4N3QHf9008624
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 20:26:18 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4N3QG8c007327
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:26:17 -0500 (CDT)
Message-ID: <4653B4C3.8090107@freescale.com>
Date: Wed, 23 May 2007 11:28:03 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] powerpc: Fix Section mismatch warnings
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sl@bplan-gmbh.de, Linux Kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fix the following Section mismatch warnings
in powerpc code.

WARNING: arch/powerpc/platforms/built-in.o - Section mismatch: reference to .init.data:mv643xx_eth_pd_devs from .text between 'mv643xx_eth_add_pds' (at offset 0x9ed2) and 'gg2_read_config'
WARNING: arch/powerpc/platforms/built-in.o - Section mismatch: reference to .init.data:mv643xx_eth_pd_devs from .text between 'mv643xx_eth_add_pds' (at offset 0x9ed6) and 'gg2_read_config'
WARNING: arch/powerpc/platforms/built-in.o - Section mismatch: reference to .init.text:note_scsi_host from __ksymtab between '__ksymtab_note_scsi_host' (at offset 0x8) and '__ksymtab_sys_ctrler'

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/chrp/pegasos_eth.c |    2 +-
 arch/powerpc/platforms/powermac/setup.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/pegasos_eth.c b/arch/powerpc/platforms/chrp/pegasos_eth.c
index 7104567..5bcc58d 100644
--- a/arch/powerpc/platforms/chrp/pegasos_eth.c
+++ b/arch/powerpc/platforms/chrp/pegasos_eth.c
@@ -169,7 +169,7 @@ static int Enable_SRAM(void)
 
 /***********/
 /***********/
-int mv643xx_eth_add_pds(void)
+static int __init mv643xx_eth_add_pds(void)
 {
 	int ret = 0;
 	static struct pci_device_id pci_marvell_mv64360[] = {
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index a410bc7..07b1c4e 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -384,7 +384,7 @@ int boot_part;
 static dev_t boot_dev;
 
 #ifdef CONFIG_SCSI
-void __init note_scsi_host(struct device_node *node, void *host)
+void note_scsi_host(struct device_node *node, void *host)
 {
 	int l;
 	char *p;
