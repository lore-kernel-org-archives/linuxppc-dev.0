Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com
	[209.85.215.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47CE2B75C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:55:03 +1000 (EST)
Received: by eyh6 with SMTP id 6so2714397eyh.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:55:00 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 09/14] 85xx/sbc8548: read hardware revision when it's required
	for first time
Date: Tue, 19 Jul 2011 12:53:46 +0400
Message-Id: <1311065631-3429-10-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently sbc8548 reads hardware revision during bootup. To simplify
things read it when it's first required when the kernel is up and
running.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/sbc8548.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index ecdd8c0..2eeb376 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -49,7 +49,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
-static int sbc_rev;
+static int sbc_rev = -EINVAL;
 
 static void __init sbc8548_pic_init(void)
 {
@@ -82,7 +82,7 @@ static void __init sbc8548_pic_init(void)
 }
 
 /* Extract the HW Rev from the EPLD on the board */
-static int __init sbc8548_hw_rev(void)
+static int sbc8548_hw_rev(void)
 {
 	struct device_node *np;
 	struct resource res;
@@ -130,7 +130,6 @@ static void __init sbc8548_setup_arch(void)
 		}
 	}
 #endif
-	sbc_rev = sbc8548_hw_rev();
 }
 
 static void sbc8548_show_cpuinfo(struct seq_file *m)
@@ -140,6 +139,9 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
 
+	if (sbc_rev == -EINVAL)
+		sbc_rev = sbc8548_hw_rev();
+
 	seq_printf(m, "Vendor\t\t: Wind River\n");
 	seq_printf(m, "Machine\t\t: SBC8548 v%d\n", sbc_rev);
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
-- 
1.7.2.5
