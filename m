Return-Path: <elohimes@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1pgb27v3zDqFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 22:01:31 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 81so25490515pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 05:01:31 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Subject: [PATCH v10 1/4] PCI: A fix for caculating bridge window's size and
 alignment
Date: Mon, 10 Apr 2017 19:58:11 +0800
Message-Id: <1491825494-19331-2-git-send-email-elohimes@gmail.com>
In-Reply-To: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In case that one device's alignment is greater than its size,
we may get an incorrect size and alignment for its bus's memory
window in pbus_size_mem(). This patch fixes this case.

Signed-off-by: Yongji Xie <elohimes@gmail.com>
---
 drivers/pci/setup-bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index cb389277..958da7d 100644
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
-- 
1.7.9.5
