Return-Path: <mohan@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08BB1DDF1E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 00:58:19 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l26DwGKR011717
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 08:58:16 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l26DwG0A554396
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 06:58:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l26DwFas010895
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 06:58:16 -0700
Date: Tue, 6 Mar 2007 19:27:54 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070306135754.GB7476@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061218105706.GB3911@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Here comes the revised version of patch to fix the interrupt missing
problem when a kdump kernel is booted with "maxcpus=1" kernel parameter.

In the xics initialization code a check is made to detemine whether
maxcpus kernel parameter is present and if its present then
default_distrib_server variable is initialized to the current boot cpu
id (by default_server variable). So that when ever a kernel is booted
with maxcpus kernel parameter all interrupts are routed to the boot cpu
only.

Tested on POWER5 and JS20 systems.

Any comment?

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>

---
 arch/powerpc/platforms/pseries/xics.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.20/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.20.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.20/arch/powerpc/platforms/pseries/xics.c
@@ -734,6 +734,13 @@ void __init xics_init_IRQ(void)
 skip_gserver_check:
 	of_node_put(np);
 
+	/* Kdump with maxcpus parameter in PPC970xx creates interrupt
+	 * distribution problems. So assign current boot cpu id to
+	 * interrupt distribution server
+	 */
+	if (strstr(saved_command_line, "maxcpus="))
+		default_distrib_server = default_server;
+
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ppc_md.get_irq = xics_get_irq_lpar;
 	else
