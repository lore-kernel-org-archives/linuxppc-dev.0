Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id ACE23DE060
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:57:19 +1100 (EST)
Date: Wed, 24 Jan 2007 15:57:06 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] maple: don't override bus-range supplied by firmware
Message-ID: <20070124215706.GE16486@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This workaround was copy-pasted from the powermac code.  It's not
necessary for maple.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/maple/pci.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 011f0f1..73c5990 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -425,14 +425,6 @@ static void __init setup_u4_pcie(struct pci_controller* hose)
         hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
         hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
 
-        /* The bus contains a bridge from root -> device, we need to
-         * make it visible on bus 0 so that we pick the right type
-         * of config cycles. If we didn't, we would have to force all
-         * config cycles to be type 1. So we override the "bus-range"
-         * property here
-         */
-        hose->first_busno = 0x00;
-        hose->last_busno = 0xff;
         u4_pcie = hose;
 }
 
-- 
1.4.4.3
