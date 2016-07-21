Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45m5GW2zDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:45:00 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g202so4910986pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:45:00 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 06/14] powerpc/pseries: h_facility_unavailable realmode
 exception location
Date: Thu, 21 Jul 2016 16:44:05 +1000
Message-Id: <1469083453-9279-7-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 0xf80 hv_facility_unavailable trampoline branches to the 0xf60
handler. This works because they both do the same thing, but it should
be fixed.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 111e327..e567da6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -620,7 +620,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf40)
 	STD_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf60)
-	STD_EXCEPTION_HV_OOL(0xf82, facility_unavailable)
+	STD_EXCEPTION_HV_OOL(0xf82, hv_facility_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf82)
 
 /*
-- 
2.8.1
