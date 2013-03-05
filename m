Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA78A2C032D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 17:59:38 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 5 Mar 2013 01:59:34 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EBAB9C9001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 01:59:31 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r256xV7x308890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Mar 2013 01:59:31 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r256xV3F030655
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Mar 2013 03:59:31 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Fix next available MSI IRQ
Date: Tue,  5 Mar 2013 14:59:16 +0800
Message-Id: <1362466756-16113-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The allocation of MSI is implemented based on bitmap and working
like the mechanism of strict round through the traced next available
cursor. However, the next available MSI is never updated in current
implementation. The patch fixes the issue.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 6f464dc..9cf18c4 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -66,6 +66,11 @@ static unsigned int pnv_get_one_msi(struct pnv_phb *phb)
 		rc = 0;
 		goto out;
 	}
+
+	if (id >= phb->msi_count - 1)
+		phb->msi_next = 0;
+	else
+		phb->msi_next = id + 1;
 	__set_bit(id, phb->msi_map);
 	rc = id + phb->msi_base;
 out:
-- 
1.7.5.4
