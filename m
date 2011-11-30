Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1103B7300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 15:23:01 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAU4MuUK016558
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 22:22:57 -0600
Message-ID: <1322626976.21641.27.camel@pasglop>
Subject: [PATCH 3/3] powerpc/powernv: Workaround OFW issues in prom_init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 30 Nov 2011 15:22:56 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Open Firmware on OPAL machines seems to have issues if we close
stdin and/or we try to print things after calling "quiesce" so
we avoid doing both.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index cc58486..6d2987b 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2969,9 +2969,11 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	/*
 	 * in case stdin is USB and still active on IBM machines...
 	 * Unfortunately quiesce crashes on some powermacs if we have
-	 * closed stdin already (in particular the powerbook 101).
+	 * closed stdin already (in particular the powerbook 101). It
+	 * appears that the OPAL version of OFW doesn't like it either. 
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC)
+	if (RELOC(of_platform) != PLATFORM_POWERMAC &&
+	    RELOC(of_platform) != PLATFORM_OPAL)
 		prom_close_stdin();
 
 	/*
@@ -2987,8 +2989,12 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 * is common to us and kexec
 	 */
 	hdr = RELOC(dt_header_start);
-	prom_printf("returning from prom_init\n");
-	prom_debug("->dt_header_start=0x%x\n", hdr);
+
+	/* Don't print anything after quiesce under OPAL, it crashes OFW */
+	if (RELOC(of_platform) != PLATFORM_OPAL) {
+		prom_printf("returning from prom_init\n");
+		prom_debug("->dt_header_start=0x%x\n", hdr);
+	}
 
 #ifdef CONFIG_PPC32
 	reloc_got2(-offset);
-- 
1.7.7.2
