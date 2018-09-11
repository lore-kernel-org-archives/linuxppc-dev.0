Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428k0K17hTzF38l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:56:32 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 10B5341907
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 11:56:30 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aizWl2PxrQod for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 11 Sep 2018 14:56:29 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 1286241908
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 14:56:28 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v3 4/6] powerpc/powernv/pci: Enable reassigning the bus numbers
Date: Tue, 11 Sep 2018 14:56:18 +0300
Message-ID: <20180911115620.10507-5-s.miroshnichenko@yadro.com>
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

PowerNV doesn't depend on PCIe topology info from DT anymore, and now
it is able to enumerate the fabric and assign the bus numbers.

This is enabled by the pci=realloc command line switch.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci_dn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 8bcf10fb13ad..863d00561c50 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -592,3 +592,15 @@ static void pci_dev_pdn_setup(struct pci_dev *pdev)
 	pdev->dev.archdata.pci_data = pdn;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
+
+char * __init pcibios_setup(char *str)
+{
+	if (!strncmp(str, "realloc=", 8)) {
+		if (!strncmp(str + 8, "on", 2))
+			pci_add_flags(PCI_REASSIGN_ALL_BUS);
+	} else if (!strncmp(str, "realloc", 7)) {
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+	}
+
+	return str;
+}
-- 
2.17.1
