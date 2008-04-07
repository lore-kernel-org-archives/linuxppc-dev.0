Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out1.tiscali.nl (smtp-out1.tiscali.nl [195.241.79.176])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CEA1DDF66
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 08:26:56 +1000 (EST)
Message-ID: <47FA9FA6.8090201@tiscali.nl>
Date: Tue, 08 Apr 2008 00:26:46 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: jwboyer@linux.vnet.ibm.com
Subject: [PATCH 1/1 resend][PPC] replace logical by bitand in
	pci_process_ISA_OF_ranges(), arch/powerpc/kernel/isa-bridge.c
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

in arch/powerpc/kernel/isa-bridge.c:
41:#define ISA_SPACE_MASK 0x1
42:#define ISA_SPACE_IO 0x1
...

83:    if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO) {
...
89:    if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO)

I think these should be single &'s, I can't test it (no hardware)
please consider the patch below.
--
replace logical by bit and for ISA_SPACE_MASK

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index f0f49d1..406a9e6 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -80,13 +80,13 @@ static void __devinit pci_process_ISA_OF_ranges(struct device_node *isa_node,
 	 *			(size depending on dev->n_addr_cells)
 	 *   cell 5:		the size of the range
 	 */
-	if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO) {
+	if ((range->isa_addr.a_hi & ISA_SPACE_MASK) != ISA_SPACE_IO) {
 		range++;
 		rlen -= sizeof(struct isa_range);
 		if (rlen < sizeof(struct isa_range))
 			goto inval_range;
 	}
-	if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO)
+	if ((range->isa_addr.a_hi & ISA_SPACE_MASK) != ISA_SPACE_IO)
 		goto inval_range;
 
 	isa_addr = range->isa_addr.a_lo;
