Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: stable@kernel.org
MIME-Version: 1.0
Subject: [stable 3.1] [PATCH] powerpc/kvm: Fix build failure with HV KVM and
 CBE
Date: Thu, 10 Nov 2011 11:04:56 +1100
Message-ID: <18823.1320883496@neuling.org>
Cc: Alexander Graf <agraf@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexander Graf <agraf@suse.de>

powerpc/kvm: Fix build failure with HV KVM and CBE

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

Upstream commit 5ccf55dd8177295813b68780f0a3c85e47306be1

Signed-off-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
CC: stable@kernel.org (3.1 only)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a54d92f..cf9c69b 100644
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
