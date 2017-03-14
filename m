Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDl434JdzDr6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:37:04 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 25so24276993pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:37:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/6] powerpc/64s: machine check print NIP
Date: Tue, 14 Mar 2017 22:36:43 +1000
Message-Id: <20170314123648.26068-2-npiggin@gmail.com>
In-Reply-To: <20170314123648.26068-1-npiggin@gmail.com>
References: <20170314123648.26068-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Print the faulting address of the machine check that may help with
debugging. The effective address reported can be a target memory address
rather than the faulting instruction address.

Fix up a dangling bracket while here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index a1475e6aef3a..399aeafb7dd4 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -310,7 +310,8 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 
 	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
 	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
-	       "Recovered" : "[Not recovered");
+	       "Recovered" : "Not recovered");
+	printk("%s  NIP: %016llx\n", level, evt->srr0);
 	printk("%s  Initiator: %s\n", level,
 	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
 	switch (evt->error_type) {
-- 
2.11.0
