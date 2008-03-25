Return-Path: <bob@qbjnet.com>
Received: from kunk.qbjnet.com (vci-113.dsl.onvoy.net [137.192.135.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "qbjnet.com", Issuer "qbjnet.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CC212DE652
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 04:52:33 +1100 (EST)
Message-ID: <20080325174549.24653.qmail@kunk.qbjnet.com>
Subject: [PATCH] powerpc: add kernel parameter to set l3cr for G4 cpu
To: linuxppc-dev@ozlabs.org
Date: Tue, 25 Mar 2008 12:45:49 -0500 (CDT)
Sender: bob@qbjnet.com
From: Robert Brose <linuxppcdev@lists.qbjnet.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ELM1206467149-24313-0_"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ELM1206467149-24313-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="US-ASCII"

Old-world powermacs don't set L2CR or L3CR on processor upgrade cards.
This simple patch allows the setting of L3CR via a kernel parameter
(like the existing kernel parameter to set L2CR).

This is the first time I've posted a patch, please excuse me if I've
broken protocol in any way.

Signed-off-by: Robert Brose <bob@qbjnet.com>


--ELM1206467149-24313-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Content-Disposition: attachment; filename="l3cr_patch.txt"
Content-Description: 

--- linux-2.6.24/arch/powerpc/kernel/setup_32.c.orig	2008-03-10 11:24:16.566354597 -0500
+++ linux-2.6.24/arch/powerpc/kernel/setup_32.c	2008-03-10 11:22:22.711626305 -0500
@@ -172,6 +172,18 @@ int __init ppc_setup_l2cr(char *str)
 }
 __setup("l2cr=", ppc_setup_l2cr);
 
+/* Checks "l3cr=xxxx" command-line option REB */
+int __init ppc_setup_l3cr(char *str)
+{
+	if (cpu_has_feature(CPU_FTR_L3CR)) {
+		unsigned long val = simple_strtoul(str, NULL, 0);
+		printk(KERN_INFO "l3cr set to %lx\n", val);
+		_set_L3CR(val);		/* and enable it */
+	}
+	return 1;
+}
+__setup("l3cr=", ppc_setup_l3cr);
+
 #ifdef CONFIG_GENERIC_NVRAM
 
 /* Generic nvram hooks used by drivers/char/gen_nvram.c */

--- linux-2.6.24/Documentation/kernel-parameters.txt.orig	2008-03-25 12:30:09.688082305 -0500
+++ linux-2.6.24/Documentation/kernel-parameters.txt	2008-03-25 12:30:29.816083202 -0500
@@ -877,6 +877,8 @@ and is between 256 and 4096 characters. 
 
 	l2cr=		[PPC]
 
+	l3cr=		[PPC]
+
 	lapic		[X86-32,APIC] Enable the local APIC even if BIOS
 			disabled it.
 

--ELM1206467149-24313-0_--
