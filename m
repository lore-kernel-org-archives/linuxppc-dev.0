Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4257FQ2VYvzF38h
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 01:40:23 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 47C17418F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 15:40:20 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajl8o_SCY9u2 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  5 Sep 2018 18:40:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A177A418FB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 18:40:18 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH 4/5] powerpc/powernv/pci: Enable reassigning the bus numbers
Date: Wed, 5 Sep 2018 18:40:07 +0300
Message-ID: <20180905154008.11130-5-s.miroshnichenko@yadro.com>
In-Reply-To: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
References: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
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

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/platforms/powernv/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 6d4280086a08..f6eaca3123cd 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -1104,6 +1104,7 @@ void __init pnv_pci_init(void)
 	struct device_node *np;
 
 	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
+	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
 	/* If we don't have OPAL, eg. in sim, just skip PCI probe */
 	if (!firmware_has_feature(FW_FEATURE_OPAL))
-- 
2.17.1
