Return-Path: <ananth@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A3B17B70C1
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 16:58:59 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 10 Nov 2011 22:58:53 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAB5wgIX108258
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 22:58:43 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAB5wfeq029888
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 22:58:41 -0700
Date: Fri, 11 Nov 2011 11:28:53 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH V2] powerpc: Export PIR data through sysfs
Message-ID: <20111111055853.GB19107@in.ibm.com>
References: <20111107044750.GB4361@in.ibm.com>
 <4EB812E8.9090107@freescale.com> <20111108065811.GA9109@in.ibm.com>
 <4EB96002.5030605@freescale.com> <20111109044124.GA10961@in.ibm.com>
 <20111109154825.GB7839@schlenkerla.am.freescale.net>
 <20111110084807.GA16323@in.ibm.com> <1320985094.21206.35.camel@pasglop>
 <20111111044755.GA19107@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111111044755.GA19107@in.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, mahesh@linux.vnet.ibm.com
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 11, 2011 at 10:17:55AM +0530, Ananth N Mavinakayanahalli wrote:
> > 
> > At this rate we're going to end up with no bits left for CPU features
> > way too quickly... Especially for something we only care about once at
> > boot time.
> >
> > Wouldn't CPU_FTR_PPCAS_ARCH_V2 be a good enough test ?
> 
> /me checks Cell manuals... yes, that test would be good enough. I will
> cook up a patch to use this.

Here it is...
---

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

The Processor Identification Register (PIR) on some powerpc platforms
provides information to decode the processor identification tag that
can be used for node/core/thread affinity tests and for debugging.
Decoding this information is platform specific.

Export PIR contents through sysfs.

[V2] Use CPU_FTR_PPCAS_ARCH_V2 as a test for PIR's presence per
BenH's suggestion.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/sysfs.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-3.2-rc1/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-3.2-rc1.orig/arch/powerpc/kernel/sysfs.c
+++ linux-3.2-rc1/arch/powerpc/kernel/sysfs.c
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
@@ -392,6 +394,9 @@ static void __cpuinit register_cpu_onlin
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_create_file(s, &attr_dscr);
+
+	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
+		sysdev_create_file(s, &attr_pir);
 #endif /* CONFIG_PPC64 */
 
 	cacheinfo_cpu_online(cpu);
@@ -462,6 +467,9 @@ static void unregister_cpu_online(unsign
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_remove_file(s, &attr_dscr);
+
+	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
+		sysdev_remove_file(s, &attr_pir);
 #endif /* CONFIG_PPC64 */
 
 	cacheinfo_cpu_offline(cpu);
