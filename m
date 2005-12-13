Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8ABA68897
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2005 07:50:45 +1100 (EST)
Date: Tue, 13 Dec 2005 14:46:29 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512131445410.6332-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Detect prefetchable windows in
	pci_process_bridge_OF_ranges
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added the ability to determine if an outbound window in the PCI host
controller is for prefetchable memory and report it as such.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 6a050a749ac14613057a2adec0e3dbaa7697a824
tree 254dedb89aac5444c6d387bd1b6ef20c954538a5
parent 761e102769add7e86d510f7605c06f4a82575015
author Kumar Gala <galak@kernel.crashing.org> Tue, 13 Dec 2005 14:46:34 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 13 Dec 2005 14:46:34 -0600

 arch/ppc/kernel/pci.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
index df4b11c..8a58fe8 100644
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -941,7 +941,7 @@ pci_process_bridge_OF_ranges(struct pci_
 	while (ranges && (rlen -= np * sizeof(unsigned int)) >= 0) {
 		res = NULL;
 		size = ranges[na+4];
-		switch (ranges[0] >> 24) {
+		switch ((ranges[0] >> 24) & 0x3) {
 		case 1:		/* I/O space */
 			if (ranges[2] != 0)
 				break;
@@ -955,6 +955,8 @@ pci_process_bridge_OF_ranges(struct pci_
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
 			res->start = ranges[2];
+			DBG("PCI: IO 0x%lx -> 0x%lx\n",
+				    res->start, res->start + size - 1);
 			break;
 		case 2:		/* memory space */
 			memno = 0;
@@ -972,7 +974,11 @@ pci_process_bridge_OF_ranges(struct pci_
 			if (memno < 3) {
 				res = &hose->mem_resources[memno];
 				res->flags = IORESOURCE_MEM;
+				if(ranges[0] & 0x40000000)
+					res->flags |= IORESOURCE_PREFETCH;
 				res->start = ranges[na+2];
+				DBG("PCI: MEM[%d] 0x%lx -> 0x%lx\n", memno,
+					    res->start, res->start + size - 1);
 			}
 			break;
 		}
