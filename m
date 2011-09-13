Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97901B6F87
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2011 00:14:32 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Fix build failure with HV KVM and CBE
Date: Tue, 13 Sep 2011 16:15:31 +0200
Message-Id: <1315923331-12223-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, dvaleev@suse.de, paulus@samba.org,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running with HV KVM and CBE config options enabled, I get
build failures like the following:

  arch/powerpc/kernel/head_64.o: In function `cbe_system_error_hv':
  (.text+0x1228): undefined reference to `do_kvm_0x1202'
  arch/powerpc/kernel/head_64.o: In function `cbe_maintenance_hv':
  (.text+0x1628): undefined reference to `do_kvm_0x1602'
  arch/powerpc/kernel/head_64.o: In function `cbe_thermal_hv':
  (.text+0x1828): undefined reference to `do_kvm_0x1802'

This is because we jump to a KVM handler when HV is enabled, but we
only generate the handler with PR KVM mode.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/exceptions-64s.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 29ddd8b..396d080 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -267,7 +267,7 @@ vsx_unavailable_pSeries_1:
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
-	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
 #endif /* CONFIG_CBE_RAS */
 
 	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
@@ -275,7 +275,7 @@ vsx_unavailable_pSeries_1:
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1600, 0x1602, cbe_maintenance)
-	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_HV, 0x1602)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1602)
 #endif /* CONFIG_CBE_RAS */
 
 	STD_EXCEPTION_PSERIES(0x1700, 0x1700, altivec_assist)
@@ -283,7 +283,7 @@ vsx_unavailable_pSeries_1:
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1800, 0x1802, cbe_thermal)
-	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_HV, 0x1802)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1802)
 #endif /* CONFIG_CBE_RAS */
 
 	. = 0x3000
-- 
1.6.0.2
