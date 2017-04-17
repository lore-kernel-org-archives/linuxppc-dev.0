Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6M640RgXzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 07:36:44 +1000 (AEST)
Subject: [PATCH v11 2/7] PCI: A fix for caculating bridge window's size and
 alignment
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:36:39 -0500
Message-ID: <20170417213639.21092.22951.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yongji Xie <elohimes@gmail.com>

In case that one device's alignment is greater than its size,
we may get an incorrect size and alignment for its bus's memory
window in pbus_size_mem(). This patch fixes this case.

Signed-off-by: Yongji Xie <elohimes@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index cb389277df41..958da7db9033 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1066,10 +1066,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				r->flags = 0;
 				continue;
 			}
-			size += r_size;
+			size += max(r_size, align);
 			/* Exclude ranges with size > align from
 			   calculation of the alignment. */
-			if (r_size == align)
+			if (r_size <= align)
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
