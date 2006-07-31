Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06CE267A3E
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 22:59:10 +1000 (EST)
Date: Mon, 31 Jul 2006 14:59:04 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] remove bogomips from /proc/cpuinfo
Message-ID: <20060731125904.GA1997@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove bogomips from /proc/cpuinfo.
It is now really bogus since "timebase-frequency" is shown.

Signed-off-by: Olaf Hering <olh@suse.de>
---
 arch/powerpc/kernel/setup-common.c |   14 --------------
 1 file changed, 14 deletions(-)

Index: linux-2.6.18-rc3/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6.18-rc3.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6.18-rc3/arch/powerpc/kernel/setup-common.c
@@ -163,14 +163,6 @@ static int show_cpuinfo(struct seq_file 
 	unsigned short min;
 
 	if (cpu_id == NR_CPUS) {
-#if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
-		unsigned long bogosum = 0;
-		int i;
-		for_each_online_cpu(i)
-			bogosum += loops_per_jiffy;
-		seq_printf(m, "total bogomips\t: %lu.%02lu\n",
-			   bogosum/(500000/HZ), bogosum/(5000/HZ) % 100);
-#endif /* CONFIG_SMP && CONFIG_PPC32 */
 		seq_printf(m, "timebase\t: %lu\n", ppc_tb_freq);
 		if (ppc_md.name)
 			seq_printf(m, "platform\t: %s\n", ppc_md.name);
@@ -263,12 +255,6 @@ static int show_cpuinfo(struct seq_file 
 	seq_printf(m, "revision\t: %hd.%hd (pvr %04x %04x)\n",
 		   maj, min, PVR_VER(pvr), PVR_REV(pvr));
 
-#ifdef CONFIG_PPC32
-	seq_printf(m, "bogomips\t: %lu.%02lu\n",
-		   loops_per_jiffy / (500000/HZ),
-		   (loops_per_jiffy / (5000/HZ)) % 100);
-#endif
-
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
 #endif
