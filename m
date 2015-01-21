Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFDB71A0D1A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 14:46:24 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 rric@kernel.org
Subject: [PATCH 1/2] oprofile: Add HAVE_OPROFILE_NMI_TIMER
Date: Wed, 21 Jan 2015 14:46:22 +1100
Message-Id: <1421811983-22788-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HAVE_PERF_EVENTS_NMI is used for two things - the oprofile NMI timer
and the hardlockup detector.

Create HAVE_OPROFILE_NMI_TIMER so an architecture can select them
separately. On ppc64 we want to add the hardlockup detector, but not
the oprofile NMI timer fallback.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/Kconfig     | 5 ++++-
 arch/x86/Kconfig | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a..3d50e42 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -30,9 +30,12 @@ config OPROFILE_EVENT_MULTIPLEX
 config HAVE_OPROFILE
 	bool
 
+config HAVE_OPROFILE_NMI_TIMER
+	bool
+
 config OPROFILE_NMI_TIMER
 	def_bool y
-	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	depends on PERF_EVENTS && HAVE_OPROFILE_NMI_TIMER
 
 config KPROBES
 	bool "Kprobes"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba397bd..98d9c72 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -138,6 +138,7 @@ config X86
 	select HAVE_ACPI_APEI_NMI if ACPI
 	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
 	select X86_FEATURE_NAMES if PROC_FS
+	select HAVE_OPROFILE_NMI_TIMER
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
2.1.0
