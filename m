Return-Path: <ananth@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 84CB9B6F7D
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 15:47:44 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Sun, 6 Nov 2011 23:47:40 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA74lcBi321230
 for <linuxppc-dev@ozlabs.org>; Sun, 6 Nov 2011 23:47:38 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA74lbQD027281
 for <linuxppc-dev@ozlabs.org>; Sun, 6 Nov 2011 21:47:37 -0700
Date: Mon, 7 Nov 2011 10:17:50 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Export PIR data through sysfs
Message-ID: <20111107044750.GB4361@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Blanchard <anton@samba.org>, mahesh@linux.vnet.ibm.com
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Processor Identification Register (PIR) on powerpc provides
information to decode the processor identification tag. Decoding
this information platform specfic.

Export PIR data via sysfs.

(Powerpc manuals state this register is 'optional'. I am not sure
though if there are any Linux supported powerpc platforms that
don't have it. Code in the kernel referencing PIR isn't under
a platform ifdef).

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/sysfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-3.1/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-3.1.orig/arch/powerpc/kernel/sysfs.c
+++ linux-3.1/arch/powerpc/kernel/sysfs.c
@@ -177,11 +177,13 @@ SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
 SYSFS_PMCSETUP(purr, SPRN_PURR);
 SYSFS_PMCSETUP(spurr, SPRN_SPURR);
 SYSFS_PMCSETUP(dscr, SPRN_DSCR);
+SYSFS_PMCSETUP(pir, SPRN_PIR);
 
 static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
 static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
 static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
 static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
+static SYSDEV_ATTR(pir, 0400, show_pir, NULL);
 
 unsigned long dscr_default = 0;
 EXPORT_SYMBOL(dscr_default);
@@ -394,6 +396,8 @@ static void __cpuinit register_cpu_onlin
 		sysdev_create_file(s, &attr_dscr);
 #endif /* CONFIG_PPC64 */
 
+	sysdev_create_file(s, &attr_pir);
+
 	cacheinfo_cpu_online(cpu);
 }
 
@@ -464,6 +468,8 @@ static void unregister_cpu_online(unsign
 		sysdev_remove_file(s, &attr_dscr);
 #endif /* CONFIG_PPC64 */
 
+	sysdev_remove_file(s, &attr_pir);
+
 	cacheinfo_cpu_offline(cpu);
 }
 
