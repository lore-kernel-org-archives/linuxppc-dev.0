Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1BDF1A0DEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 22:54:10 +1100 (AEDT)
Date: Wed, 21 Jan 2015 22:54:08 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 rric@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Subject: [PATCH 1/2] oprofile: Add HAVE_OPROFILE_NMI_TIMER
Message-ID: <20150121225408.33194932@kryten>
In-Reply-To: <1421811983-22788-1-git-send-email-anton@samba.org>
References: <1421811983-22788-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: oprofile-list@lists.sf.net, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HAVE_PERF_EVENTS_NMI is used for two things - the oprofile NMI timer
and the hard lockup detector.

Create HAVE_OPROFILE_NMI_TIMER so an architecture can select them
separately. On ppc64 we want to add the hard lockup detector, but not
the oprofile NMI timer fallback.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Resending, because I forgot to cc the x86 guys.

How would you like us to handle it? Michael Ellerman says
we can put it in a topic branch, or just merge it and cop
any conflicts.

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
