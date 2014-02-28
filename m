Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 087F12C0092
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Feb 2014 16:20:38 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s1S5KUEI012669
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Feb 2014 23:20:32 -0600
Message-ID: <1393564829.14012.69.camel@pasglop>
Subject: [PATCH 1/2] powerpc/powernv: Fix opal_xscom_{read,write} prototype
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Fri, 28 Feb 2014 16:20:29 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OPAL firmware functions opal_xscom_read and opal_xscom_write
take a 64-bit argument for the XSCOM (PCB) address in order to
support the indirect mode on P8.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org> [v3.13]
---
 arch/powerpc/include/asm/opal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 40157e2..ed82142 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -816,8 +816,8 @@ int64_t opal_pci_next_error(uint64_t phb_id, uint64_t *first_frozen_pe,
 int64_t opal_pci_poll(uint64_t phb_id);
 int64_t opal_return_cpu(void);
 
-int64_t opal_xscom_read(uint32_t gcid, uint32_t pcb_addr, __be64 *val);
-int64_t opal_xscom_write(uint32_t gcid, uint32_t pcb_addr, uint64_t val);
+int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
+int64_t opal_xscom_write(uint32_t gcid, uint64_t pcb_addr, uint64_t val);
 
 int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		       uint32_t addr, uint32_t data, uint32_t sz);
