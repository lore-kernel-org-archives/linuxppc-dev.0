Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY8lk6ThNzDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:09:06 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id x24so8934306pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 20:09:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/8] powerpc/pseries: hypervisor facility unavailable use
 correct handler
Date: Tue, 13 Sep 2016 13:08:39 +1000
Message-Id: <20160913030846.29790-2-npiggin@gmail.com>
In-Reply-To: <20160913030846.29790-1-npiggin@gmail.com>
References: <20160913030846.29790-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index bffec73..4015f71 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -355,7 +355,7 @@ facility_unavailable_trampoline:
 hv_facility_unavailable_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	facility_unavailable_hv
+	b	hv_facility_unavailable_hv
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
@@ -600,7 +600,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf40)
 	STD_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf60)
-	STD_EXCEPTION_HV_OOL(0xf82, facility_unavailable)
+	STD_EXCEPTION_HV_OOL(0xf82, hv_facility_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf82)
 
 /*
-- 
2.9.3
