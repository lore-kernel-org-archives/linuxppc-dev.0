Return-Path: <sjitindarsingh@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS94C4m8GzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 17:06:35 +1100 (AEDT)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS94B6kSFz9s7N
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 17:06:34 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 5so16462300pgj.0
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 22:06:34 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ruscur@russell.cc, sam.bobroff@au1.ibm.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [RFC NO-MERGE 1/2] arch/powerpc/prom_init: Parse the command line
 before calling CAS
Date: Tue, 21 Feb 2017 17:06:10 +1100
Message-Id: <1487657171-17260-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CAS now requires the guest to tell the host whether it would like to use
a hash or radix mmu. It is possible to disable radix by passing
"disable_radix" on the command line. The next patch will add support for
the new CAS format, thus we need to parse the command line before calling
CAS so we can correctly represent which mmu we would like to use.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kernel/prom_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d3db1bc..37b5a29 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2993,6 +2993,11 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 */
 	prom_check_initrd(r3, r4);
 
+	/*
+	 * Do early parsing of command line
+	 */
+	early_cmdline_parse();
+
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 	/*
 	 * On pSeries, inform the firmware about our capabilities
@@ -3009,11 +3014,6 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 		copy_and_flush(0, kbase, 0x100, 0);
 
 	/*
-	 * Do early parsing of command line
-	 */
-	early_cmdline_parse();
-
-	/*
 	 * Initialize memory management within prom_init
 	 */
 	prom_init_mem();
-- 
2.5.5
