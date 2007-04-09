Return-Path: <mohan@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6ECB8DDEFB
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Apr 2007 18:57:45 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l398tIXG002723
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 04:55:18 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l398ve0D178272
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 02:57:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l398vee0003674
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 02:57:40 -0600
Date: Mon, 9 Apr 2007 14:27:32 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070409085732.GC4281@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2007 at 11:52:32AM +0100, Michael Ellerman wrote:
> There's already maxcpus in init/main.c, that would probably be better,
> though still ugly.
>
Based on Mike's suggestions, I modified the patch. The attached patch
refers max_cpus variable to check whether the kernel is booted with
maxcpus=1 parameter and if maxcpus=1 is specified the patch assigns only
the current boot cpu to be the default distribution server.

Patch is generated over 2.6.20 kernel, cleanly applies to 2.6.21-rc5
kernel.

Any suggestion, comment?


Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |    9 +++++++++
 init/main.c                           |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.20/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.20.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.20/arch/powerpc/platforms/pseries/xics.c
@@ -679,6 +679,8 @@ static struct device_node *cpuid_to_of_n
 	return NULL;
 }
 
+extern unsigned int max_cpus;
+
 void __init xics_init_IRQ(void)
 {
 	int i, j;
@@ -734,6 +736,13 @@ void __init xics_init_IRQ(void)
 skip_gserver_check:
 	of_node_put(np);
 
+	/* Kdump with maxcpus parameter in PPC970xx creates interrupt
+	 * distribution problems. So assign current boot cpu id to
+	 * interrupt distribution server
+	 */
+	if (max_cpus == 1)
+		default_distrib_server = default_server;
+
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ppc_md.get_irq = xics_get_irq_lpar;
 	else
Index: linux-2.6.20/init/main.c
===================================================================
--- linux-2.6.20.orig/init/main.c
+++ linux-2.6.20/init/main.c
@@ -128,7 +128,7 @@ static char *execute_command;
 static char *ramdisk_execute_command;
 
 /* Setup configured maximum number of CPUs to activate */
-static unsigned int max_cpus = NR_CPUS;
+unsigned int max_cpus = NR_CPUS;
 
 /*
  * If set, this is an indication to the drivers that reset the underlying
 
