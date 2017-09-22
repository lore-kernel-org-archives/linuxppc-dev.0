Return-Path: <allen.lkml@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzBH41Y54zDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 21:35:12 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i23so355829pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:35:11 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 1/3] powerpc: oprofile: use setup_timer() helper.
Date: Fri, 22 Sep 2017 17:04:58 +0530
Message-Id: <1506080100-5660-2-git-send-email-allen.lkml@gmail.com>
In-Reply-To: <1506080100-5660-1-git-send-email-allen.lkml@gmail.com>
References: <1506080100-5660-1-git-send-email-allen.lkml@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/powerpc/oprofile/op_model_cell.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/oprofile/op_model_cell.c b/arch/powerpc/oprofile/op_model_cell.c
index c82497a..264b6ab 100644
--- a/arch/powerpc/oprofile/op_model_cell.c
+++ b/arch/powerpc/oprofile/op_model_cell.c
@@ -555,9 +555,7 @@ static void cell_virtual_cntr(unsigned long data)
 
 static void start_virt_cntrs(void)
 {
-	init_timer(&timer_virt_cntr);
-	timer_virt_cntr.function = cell_virtual_cntr;
-	timer_virt_cntr.data = 0UL;
+	setup_timer(&timer_virt_cntr, cell_virtual_cntr, 0UL);
 	timer_virt_cntr.expires = jiffies + HZ / 10;
 	add_timer(&timer_virt_cntr);
 }
@@ -679,9 +677,7 @@ static void spu_evnt_swap(unsigned long data)
 
 static void start_spu_event_swap(void)
 {
-	init_timer(&timer_spu_event_swap);
-	timer_spu_event_swap.function = spu_evnt_swap;
-	timer_spu_event_swap.data = 0UL;
+	setup_timer(&timer_spu_event_swap, spu_evnt_swap, 0UL);
 	timer_spu_event_swap.expires = jiffies + HZ / 25;
 	add_timer(&timer_spu_event_swap);
 }
-- 
2.7.4
