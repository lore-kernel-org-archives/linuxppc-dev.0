Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4C87DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:13:20 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4A3DFN1022474
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 20:13:15 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l4A3DEee018923
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 22:13:15 -0500 (CDT)
Message-ID: <46428E31.3090007@freescale.com>
Date: Thu, 10 May 2007 11:14:57 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 1/2] Suppress warning when CONFIG_PCI is not defined
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Suppress warning when CONFIG_PCI is not defined.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |    2 ++
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    2 ++
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 32e9e94..96970ac 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -40,7 +40,9 @@ unsigned long isa_mem_base = 0;
  */
 static void __init mpc8313_rdb_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8313_rdb_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 3c009f6..40a0194 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -50,7 +50,9 @@ unsigned long isa_mem_base = 0;
  */
 static void __init mpc834x_itx_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_itx_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 8aa9a93..10394b2 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -120,7 +120,9 @@ static int mpc834x_usb_cfg(void)
  */
 static void __init mpc834x_mds_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_mds_setup_arch()", 0);
