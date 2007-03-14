Return-Path: <pochini@shiny.it>
Received: from smtp-out19.alice.it (smtp-out19.alice.it [85.33.2.19])
	by ozlabs.org (Postfix) with ESMTP id 45F9DDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 10:38:55 +1100 (EST)
Date: Thu, 15 Mar 2007 00:30:20 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: /sys/devices/system/cpu/cpuX/online are missing
Message-Id: <20070315003020.250097b1.pochini@shiny.it>
In-Reply-To: <20070313095652.GB20518@flint.arm.linux.org.uk>
References: <20070311222652.5ea40da1.pochini@shiny.it>
	<20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0703122337350.25919@denise.shiny.it>
	<je6496asea.fsf@sykes.suse.de>
	<20070313090350.GA9890@osiris.boeblingen.de.ibm.com>
	<20070313091159.GB9890@osiris.boeblingen.de.ibm.com>
	<20070313094038.GA20518@flint.arm.linux.org.uk>
	<20070313095652.GB20518@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: suresh.b.siddha@intel.com, heiko.carstens@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	pochini@denise.shiny.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Mar 2007 09:56:52 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Right, here's the ARM fix which is now in the ARM tree:
> [...]


The following patch seems to fix the issue (+ minor style fix). I'm not sure
it's ok due to my poor knowledge of this code.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- linux-2.6.21rc3/arch/powerpc/kernel/setup_32.c__orig	2007-03-15 00:05:02.000000000 +0100
+++ linux-2.6.21rc3/arch/powerpc/kernel/setup_32.c	2007-03-15 00:07:02.000000000 +0100
@@ -195,18 +195,22 @@ EXPORT_SYMBOL(nvram_sync);
 
 #endif /* CONFIG_NVRAM */
 
-static struct cpu cpu_devices[NR_CPUS];
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 int __init ppc_init(void)
 {
-	int i;
+	int cpu;
 
 	/* clear the progress line */
-	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);
+	if (ppc_md.progress)
+		ppc_md.progress("             ", 0xffff);
 
 	/* register CPU devices */
-	for_each_possible_cpu(i)
-		register_cpu(&cpu_devices[i], i);
+	for_each_possible_cpu(cpu) {
+		struct cpu *c = &per_cpu(cpu_devices, cpu);
+		c->hotpluggable = 1;
+		register_cpu(c, cpu);
+	}
 
 	/* call platform init */
 	if (ppc_md.init != NULL) {


--
Giuliano.
