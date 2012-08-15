Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02D812C01CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 19:25:41 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <benh@kernel.crashing.org>
Subject: [PATCH V7 1/3] powerpc/pci: Make sure ISA IO base is not zero
Date: Wed, 15 Aug 2012 16:57:04 +0800
Message-ID: <1345021026-10886-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1345021026-10886-1-git-send-email-B38951@freescale.com>
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Some platforms like QEMU treat 0 as an invalid address for ISA IO base.
So we make sure that ISA IO base will never be zero. By functionality this
is equivalent to assgin the first pci bus detected as a primary bus.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f75bd5..2a09aa5 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -734,7 +734,7 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			hose->io_base_virt = ioremap(cpu_addr, size);
 
 			/* Expect trouble if pci_addr is not 0 */
-			if (primary)
+			if (primary || !isa_io_base)
 				isa_io_base =
 					(unsigned long)hose->io_base_virt;
 #endif /* CONFIG_PPC32 */
-- 
1.7.5.1
