Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C3533DDF71
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 01:22:12 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id CCF782279B6
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 15:07:49 +0100 (CET)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id E4010908CE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 15:05:50 +0100 (CET)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id EVxcaxDW3fHw for <linuxppc-dev@ozlabs.org>;
	Wed,  9 Jan 2008 15:05:50 +0100 (CET)
Received: from ibook.aepfle.de (DSL01.83.171.178.115.ip-pool.NEFkom.net
	[83.171.178.115]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 15:05:50 +0100 (CET)
Date: Wed, 9 Jan 2008 15:06:08 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: add phy-handle property for fec_mpc52xx
Message-ID: <20080109140608.GA15673@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The new network driver fec_mpc52xx will not work on efika because the
firmware does not provide all required properties.
http://www.powerdeveloper.org/asset/by-id/46 has a Forth script to
create more properties. But only the phy stuff is required to get a
working network.

This should go into the kernel because its appearently
impossible to boot the script via tftp and then load the real boot
binary (yaboot or zimage).

---
 arch/powerpc/kernel/prom_init.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1487,6 +1487,34 @@ static void __init prom_find_mmu(void)
 	else if (strncmp(version, "FirmWorks,3.", 12) == 0) {
 		of_workarounds = OF_WA_CLAIM | OF_WA_LONGTRAIL;
 		call_prom("interpret", 1, 1, "dev /memory 0 to allow-reclaim");
+#ifdef CONFIG_PPC_MPC52xx
+	} else if (strcmp(version, "EFIKA5K2") == 0) {
+		call_prom("interpret", 1, 1,
+			" .\" Adding EFIKA5K2 Ethernet PHY\" cr"
+			" s\" /builtin\" find-device"
+			" new-device"
+				" 1 encode-int s\" #address-cells\" property"
+				" 0 encode-int s\" #size-cells\" property"
+				" s\" mdio\" 2dup device-name device-type"
+				" s\" mpc5200b-fec-phy\" encode-string s\" compatible\" property"
+				" 0xf0003000 0x400 reg"
+				" 0x2 encode-int"
+				" 0x5 encode-int encode+"
+				" 0x3 encode-int encode+"
+				" s\" interrupts\" property"
+				" new-device"
+					" s\" ethernet-phy\" 2dup device-name device-type"
+					" 0x10 encode-int s\" reg\" property"
+					" my-self"
+					" ihandle>phandle"
+				" finish-device"
+			" finish-device"
+			" s\" /builtin/ethernet\" find-device"
+				" encode-int"
+				" s\" phy-handle\" property"
+			" device-end"
+			);
+#endif
 	} else
 		return;
 	_prom->memory = call_prom("open", 1, 1, ADDR("/memory"));
