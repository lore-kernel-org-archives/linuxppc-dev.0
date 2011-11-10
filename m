Return-Path: <ananth@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AD5031007D1
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 19:48:02 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 10 Nov 2011 01:48:00 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAA8luiw159038
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 01:47:56 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAA8lt4f026102
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 01:47:56 -0700
Date: Thu, 10 Nov 2011 14:18:07 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
Message-ID: <20111110084807.GA16323@in.ibm.com>
References: <20111107044750.GB4361@in.ibm.com>
 <4EB812E8.9090107@freescale.com> <20111108065811.GA9109@in.ibm.com>
 <4EB96002.5030605@freescale.com> <20111109044124.GA10961@in.ibm.com>
 <20111109154825.GB7839@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111109154825.GB7839@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 mahesh@linux.vnet.ibm.com
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2011 at 09:48:25AM -0600, Scott Wood wrote:
> On Wed, Nov 09, 2011 at 10:11:24AM +0530, Ananth N Mavinakayanahalli wrote:
> > On Tue, Nov 08, 2011 at 10:59:46AM -0600, Scott Wood wrote:
> > > On 11/08/2011 12:58 AM, Ananth N Mavinakayanahalli wrote:
> > > > On Mon, Nov 07, 2011 at 11:18:32AM -0600, Scott Wood wrote:
> > > >> What use does userspace have for this?  If you want to return the
> > > >> currently executing CPU (which unless you're pinned could change as soon
> > > >> as the value is read...), why not just return smp_processor_id() or
> > > >> hard_smp_processor_id()?
> > > > 
> > > > Its not just the current cpu. Decoding PIR can tell you the core id,
> > > > thread id in case of SMT, and this information can be used by userspace
> > > > apps to set affinities, etc.
> > > 
> > > Wouldn't it make more sense to expose the thread to core mappings in a
> > > general way, not tied to hardware or what thread we're currently running on?
> > 
> > AFAIK, the information encoding in PIR is platform dependent. There is
> > no general way to expose this information unless you want have a
> > per-platform ifdef. Even then, I am not sure if that information will
> > generally be available or provided.
> > 
> > > What's the use case for knowing this information only about the current
> > > thread (or rather the state the current thread was in a few moments ago)?
> > 
> > Its not information about the thread but about the cpu. Unless you have
> > a shared LPAR environment, the data will be consistent and can be used
> > by applications with knowledge of the platform.
> 
> I'm not sure what a "shared LPAR environment" is, but unless you're
> pinned there's no guarantee the CPU you're running on once the read()
> syscall returns is the same as the one that PIR was read on.  Do you mean
> you're expecting this to be run from inside a partition that runs only on
> one CPU, and thus whichever thread you'll be migrated to will have the
> other data remain the same?

This will be used from a partition with a dedicated set of cpus and so
the data will remain consistent.

> > I think this calls for a CPU_FTR_PIR. What do you suggest?
> 
> Unless someone wants to test what actually happens when you read PIR on
> all these CPUs...
> 
> What platform is this meant to be useful for?  Perhaps it could just be a
> platform-specific sysfs entry?

Currently I only care about pseries and have tested the following patch
on them. I've therefore made the code similar to what currently exists
for other features unique to POWER.

Ananth
---

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

The Processor Identification Register (PIR) on some powerpc platforms
provides information to decode the processor identification tag.
Decoding this information is platform specific.

We currently need this information for POWERx processors and hence
follows a similar model as adopted for the other POWERx specific
features.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/include/asm/cputable.h |    9 +++++----
 arch/powerpc/kernel/sysfs.c         |    8 ++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

Index: linux-3.2-rc1/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-3.2-rc1.orig/arch/powerpc/include/asm/cputable.h
+++ linux-3.2-rc1/arch/powerpc/include/asm/cputable.h
@@ -201,6 +201,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_PIR			LONG_ASM_CONST(0x2000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -400,7 +401,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_PIR)
 #define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_201 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
@@ -408,19 +409,19 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_HVMODE)
 #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | CPU_FTR_PIR | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_PURR | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
 #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | CPU_FTR_PIR | \
 	    CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_CFAR)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
-	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | CPU_FTR_PIR | \
 	    CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
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
+	if (cpu_has_feature(CPU_FTR_PIR))
+		sysdev_create_file(s, &attr_pir);
 #endif /* CONFIG_PPC64 */
 
 	cacheinfo_cpu_online(cpu);
@@ -462,6 +467,9 @@ static void unregister_cpu_online(unsign
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_remove_file(s, &attr_dscr);
+
+	if (cpu_has_feature(CPU_FTR_PIR))
+		sysdev_remove_file(s, &attr_pir);
 #endif /* CONFIG_PPC64 */
 
 	cacheinfo_cpu_offline(cpu);
