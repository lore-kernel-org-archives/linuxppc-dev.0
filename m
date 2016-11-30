Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT9sQ6xbyzDvt6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 17:45:30 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tT9sQ0VQdz9t2g
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 17:45:30 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e9so400061pgc.1
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 22:45:29 -0800 (PST)
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] Fix the message in facility unavailable exception
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <d7b1e63e-7b9f-1f0e-df57-5f2e08e0ca6e@gmail.com>
Date: Wed, 30 Nov 2016 17:45:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I ran into this during some testing on qemu. The current
facility_strings[] are correct when the trap address is
0xf80 (hypervisor facility unavailable). When the trap
address is 0xf60, IC (Interruption Cause) a.k.a status
in the code is undefined for values 0 and 1. This patch
adds a check to prevent printing the wrong information
and helps better direct debugging effort.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 Changelog v2:
   Redo conditional checks as suggested by Michael

 arch/powerpc/kernel/traps.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 023a462..010b11d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1519,9 +1519,13 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		return;
 	}
 
-	if ((status < ARRAY_SIZE(facility_strings)) &&
-	    facility_strings[status])
-		facility = facility_strings[status];
+	if ((hv || status >= 2) &&
+		(status < ARRAY_SIZE(facility_strings)) &&
+		facility_strings[status])
+			facility = facility_strings[status];
+	else
+		pr_warn_ratelimited("Unexpected facility unavailable exception "
+			"interruption cause %d\n", status);
 
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
-- 
2.5.5
