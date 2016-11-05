Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9lhd4mHbzDvXd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 15:14:25 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t9lhc6bY3z9t26
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Nov 2016 15:14:24 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so9670859pfk.2
 for <linuxppc-dev@ozlabs.org>; Fri, 04 Nov 2016 21:14:24 -0700 (PDT)
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Fix the message in facility unavailable exception
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <60df3f67-f217-378a-2244-319d265c0f1c@gmail.com>
Date: Sat, 5 Nov 2016 15:14:15 +1100
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
 arch/powerpc/kernel/traps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d26605d..da0f634 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1520,8 +1520,14 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	}
 
 	if ((status < ARRAY_SIZE(facility_strings)) &&
-	    facility_strings[status])
-		facility = facility_strings[status];
+	    facility_strings[status]) {
+		if (!hv && status < 2) {
+			pr_warn("Unexpected facility unavailable exception "
+				"interruption cause %d\n", status);
+			facility = "Unknown";
+		} else
+			facility = facility_strings[status];
+	}
 
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
-- 
2.5.5
