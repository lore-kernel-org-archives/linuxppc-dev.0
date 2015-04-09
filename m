Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 446C51A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 12:52:59 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 rric@kernel.org
Subject: [PATCH 1/2] oprofile: Disable oprofile NMI timer on ppc64
Date: Thu,  9 Apr 2015 12:52:55 +1000
Message-Id: <1428547976-24890-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to enable the hard lockup detector on ppc64, but right now
that enables the oprofile NMI timer too.

We'd prefer not to enable the oprofile NMI timer, it adds another
element to our PMU testing and it requires us to increase our
exported symbols (eg cpu_khz).

Modify the config entry for OPROFILE_NMI_TIMER to disable it on PPC64.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a..0cc605d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -32,7 +32,7 @@ config HAVE_OPROFILE
 
 config OPROFILE_NMI_TIMER
 	def_bool y
-	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !PPC64
 
 config KPROBES
 	bool "Kprobes"
-- 
2.1.0
