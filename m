Return-Path: <srs0=cfcn=ag=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmYLN1SwWzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xmYLN0jNyz8t2N
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:12 +1000 (AEST)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xmYLM5M3Cz9s9Y
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2017 14:16:11 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id j6so1264352pgc.4
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Sep 2017 21:16:11 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com,
	alistair@popple.id.au
Cc: linuxppc-dev@ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [rfc 1/3] powerpc/mce.c: Remove unused function get_mce_fault_addr()
Date: Tue,  5 Sep 2017 14:15:53 +1000
Message-Id: <20170905041555.27696-2-bsingharora@gmail.com>
In-Reply-To: <20170905041555.27696-1-bsingharora@gmail.com>
References: <20170905041555.27696-1-bsingharora@gmail.com>
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
