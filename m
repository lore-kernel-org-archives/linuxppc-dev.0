Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsWWH56fKzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:11:06 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id j16so4126144pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 23:11:06 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 1/5] powerpc/mce.c: Remove unused function
 get_mce_fault_addr()
Date: Wed, 13 Sep 2017 16:10:45 +1000
Message-Id: <20170913061049.13256-2-bsingharora@gmail.com>
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

There are no users of get_mce_fault_addr()

Fixes: b63a0ff ("powerpc/powernv: Machine check exception handling.")

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/mce.h |  2 --
 arch/powerpc/kernel/mce.c      | 39 ---------------------------------------
 2 files changed, 41 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 190d69a..75292c7 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -210,6 +210,4 @@ extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt,
 					   bool user_mode);
-extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
-
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 9b2ea7e..e254399 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -411,45 +411,6 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 }
 EXPORT_SYMBOL_GPL(machine_check_print_event_info);
 
-uint64_t get_mce_fault_addr(struct machine_check_event *evt)
-{
-	switch (evt->error_type) {
-	case MCE_ERROR_TYPE_UE:
-		if (evt->u.ue_error.effective_address_provided)
-			return evt->u.ue_error.effective_address;
-		break;
-	case MCE_ERROR_TYPE_SLB:
-		if (evt->u.slb_error.effective_address_provided)
-			return evt->u.slb_error.effective_address;
-		break;
-	case MCE_ERROR_TYPE_ERAT:
-		if (evt->u.erat_error.effective_address_provided)
-			return evt->u.erat_error.effective_address;
-		break;
-	case MCE_ERROR_TYPE_TLB:
-		if (evt->u.tlb_error.effective_address_provided)
-			return evt->u.tlb_error.effective_address;
-		break;
-	case MCE_ERROR_TYPE_USER:
-		if (evt->u.user_error.effective_address_provided)
-			return evt->u.user_error.effective_address;
-		break;
-	case MCE_ERROR_TYPE_RA:
-		if (evt->u.ra_error.effective_address_provided)
-			return evt->u.ra_error.effective_address;
-		break;
-	case MCE_ERROR_TYPE_LINK:
-		if (evt->u.link_error.effective_address_provided)
-			return evt->u.link_error.effective_address;
-		break;
-	default:
-	case MCE_ERROR_TYPE_UNKNOWN:
-		break;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(get_mce_fault_addr);
-
 /*
  * This function is called in real mode. Strictly no printk's please.
  *
-- 
2.9.5
