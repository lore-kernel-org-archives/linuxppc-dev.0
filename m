Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6147B67C39
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:14:34 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4HAUXoW023917
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 03:30:33 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4HAQ9b5021826
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:26:10 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626D624@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/2.6.17-rc4 7/10]  Powerpc: workaround for tsi108 pci confi
	g read exception
Date: Wed, 17 May 2006 18:14:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Workaround for Tundra Semiconductor tsi108 host bridge pci config read
exception

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

---

 arch/powerpc/kernel/traps.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

0575fbe21e4f1045528bb91ec4b34bb7955c4a92
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 064a525..7468d76 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -262,6 +262,19 @@ #if defined(CONFIG_PPC_PMAC) && defined(
 		}
 	}
 #endif /* CONFIG_PPC_PMAC && CONFIG_PPC32 */
+
+#ifdef CONFIG_TSI108_BRIDGE
+	extern void tsi108_clear_pci_cfg_error(void);
+	const struct exception_table_entry *entry;
+
+	/* Are we prepared to handle this fault?  */
+	if ((entry = search_exception_tables(regs->nip)) != NULL) {
+		tsi108_clear_pci_cfg_error();
+		regs->msr |= MSR_RI;
+		regs->nip = entry->fixup;
+		return 1;
+	}
+#endif /* CONFIG_TSI108_BRIDGE */
 	return 0;
 }
 
-- 
1.3.0
