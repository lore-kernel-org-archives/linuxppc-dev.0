Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsWWL2mfbzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:11:10 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id e69so5350197pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 23:11:10 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 2/5] powerpc/mce: align the print of physical address better
Date: Wed, 13 Sep 2017 16:10:46 +1000
Message-Id: <20170913061049.13256-3-bsingharora@gmail.com>
In-Reply-To: <20170913061049.13256-1-bsingharora@gmail.com>
References: <20170913061049.13256-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the same alignment as Effective address and rename
phyiscal address to Page Frame Number

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index e254399..f351adf 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -340,7 +340,7 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 			printk("%s    Effective address: %016llx\n",
 			       level, evt->u.ue_error.effective_address);
 		if (evt->u.ue_error.physical_address_provided)
-			printk("%s      Physical address: %016llx\n",
+			printk("%s    Page Frame Number: %016llx\n",
 			       level, evt->u.ue_error.physical_address);
 		break;
 	case MCE_ERROR_TYPE_SLB:
-- 
2.9.5
