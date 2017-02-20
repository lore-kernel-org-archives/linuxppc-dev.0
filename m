Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRvGq575SzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:44:51 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 5so14193304pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 11:44:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 1/9] powerpc/64s: machine check print NIP
Date: Tue, 21 Feb 2017 05:44:22 +1000
Message-Id: <20170220194430.32602-2-npiggin@gmail.com>
In-Reply-To: <20170220194430.32602-1-npiggin@gmail.com>
References: <20170220194430.32602-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Print the faulting address of the machine check that may help
with debugging. The effective address reported can be a target
memory address rather than an instruction address.

Fix up a dangling bracket while here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index c6923ff45131..335f8a53f154 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -268,7 +268,8 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 
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
