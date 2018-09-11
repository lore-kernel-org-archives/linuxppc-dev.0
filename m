Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428k0J4NB5zF38k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:56:32 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 82F6D41905
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 11:56:29 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BP7_RTUl3QqP for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 11 Sep 2018 14:56:28 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id D6C3241907
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 14:56:27 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v3 3/6] powerpc/pci: Use DT to create pci_dn for root bridges
 only
Date: Tue, 11 Sep 2018 14:56:17 +0300
Message-ID: <20180911115620.10507-4-s.miroshnichenko@yadro.com>
In-Reply-To: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
References: <20180911115620.10507-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Endpoint's pci_dn can be created dynamically.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci_dn.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index e2b39b562b53..8bcf10fb13ad 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -552,8 +552,10 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 		phb->pci_data = pdn;
 	}
 
-	/* Update dn->phb ptrs for new phb and children devices */
-	pci_traverse_device_nodes(dn, add_pdn, phb);
+	if (!pci_has_flag(PCI_REASSIGN_ALL_BUS)) {
+		/* Update dn->phb ptrs for new phb and children devices */
+		pci_traverse_device_nodes(dn, add_pdn, phb);
+	}
 }
 
 /** 
-- 
2.17.1
