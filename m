Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DA62DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 21:07:05 +1100 (EST)
Message-ID: <479DA93F.8080804@tiscali.nl>
Date: Mon, 28 Jan 2008 11:06:55 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: jwboyer@linux.vnet.ibm.com
Subject: [PATCH 1/1][PPC] replace logical- by bit-and in
	pci_process_ISA_OF_ranges(), arch/powerpc/kernel/isa-bridge.c
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
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
54:    struct isa_address {
55:             u32 a_hi;
...
65:     const struct isa_range *range;

83:    if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO) {
...
89:    if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO)

shouldn't these be a single &?
then consider the untested patch below.
--
replace logical "&&" by bit "&" for ISA_SPACE_MASK

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
