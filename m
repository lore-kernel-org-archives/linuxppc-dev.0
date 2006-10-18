Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3B43367C1B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 13:18:43 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9I3IbAa029180
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 20:18:37 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9I3IZBD013102
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 22:18:36 -0500 (CDT)
Subject: [PATCH] Powerpc:  Fix the warining message from the return value
	of function get_property
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1161141538.24931.9.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 18 Oct 2006 11:18:58 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch fixes the warning message from the return value of
function get_property().
Add const constrain for the return value of function get_property()


Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com> 

--

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 11de090..97f37ef 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -48,7 +48,7 @@ phys_addr_t get_csrbase(void)
 	tsi = of_find_node_by_type(NULL, "tsi-bridge");
 	if (tsi) {
 		unsigned int size;
-		void *prop = get_property(tsi, "reg", &size);
+		const void *prop = get_property(tsi, "reg", &size);
 		tsi108_csr_base = of_translate_address(tsi, prop);
 		of_node_put(tsi);
 	};
@@ -79,7 +79,7 @@ static int __init tsi108_eth_of_init(voi
 		hw_info tsi_eth_data;
 		unsigned int *id;
 		unsigned int *phy_id;
-		void *mac_addr;
+		const void *mac_addr;
 		phandle *ph;
 
 		memset(r, 0, sizeof(r));
