Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNVCf22jLzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 17:45:18 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F6hkRq171771
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:45:15 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mf8pcwv6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:45:15 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 23:45:14 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Subject: [PATCH v9 1/3] PCI: A fix for caculating bridge window's size and
 alignment
Date: Wed, 15 Feb 2017 14:45:04 +0800
In-Reply-To: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1487141106-2503-2-git-send-email-xyjxie@linux.vnet.ibm.com>
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

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f30ca75..b3cabc2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1075,10 +1075,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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
1.7.1
