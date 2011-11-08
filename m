Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8EB541007D4
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2011 17:58:32 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 8 Nov 2011 01:58:28 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA86vw3R219778
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Nov 2011 01:57:59 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA86vw9v002436
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Nov 2011 04:57:58 -0200
Date: Tue, 8 Nov 2011 12:28:11 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
Message-ID: <20111108065811.GA9109@in.ibm.com>
References: <20111107044750.GB4361@in.ibm.com> <4EB812E8.9090107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EB812E8.9090107@freescale.com>
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

On Mon, Nov 07, 2011 at 11:18:32AM -0600, Scott Wood wrote:
> On 11/06/2011 10:47 PM, Ananth N Mavinakayanahalli wrote:
> > The Processor Identification Register (PIR) on powerpc provides
> > information to decode the processor identification tag. Decoding
> > this information platform specfic.
> > 
> > Export PIR data via sysfs.
> > 
> > (Powerpc manuals state this register is 'optional'. I am not sure
> > though if there are any Linux supported powerpc platforms that
> > don't have it. Code in the kernel referencing PIR isn't under
> > a platform ifdef).
> 
> Those references are in platform-specific files, under #ifdef
> CONFIG_SMP, often in areas that would only be executed in the presence
> of multiple CPUs (e.g. secondary release).  The reference in misc_32.S
> is inside #ifdef CONFIG_KEXEC and is fairly recent -- it may not have
> been tested on these systems.
> 
> I don't see PIR (other than in the acronym definition section) in
> manuals for UP-only cores such as e300, 8xx, and 750.

I saw that SPRN_PIR is defined for booke in reg_booke.h but wasn't sure
if it is applicable to all platforms. Thanks for the clarification.

> What use does userspace have for this?  If you want to return the
> currently executing CPU (which unless you're pinned could change as soon
> as the value is read...), why not just return smp_processor_id() or
> hard_smp_processor_id()?

Its not just the current cpu. Decoding PIR can tell you the core id,
thread id in case of SMT, and this information can be used by userspace
apps to set affinities, etc.

How does the following look?

Ananth
---

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

The Processor Identification Register (PIR) on powerpc provides
information to decode the processor identification tag. Decoding
this information platform specfic.

Export PIR data via sysfs.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/sysfs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-3.1/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-3.1.orig/arch/powerpc/kernel/sysfs.c
+++ linux-3.1/arch/powerpc/kernel/sysfs.c
@@ -330,6 +330,11 @@ static struct sysdev_attribute pa6t_attr
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
 
+#if defined(CONFIG_SMP) && defined(SPRN_PIR)
+SYSFS_PMCSETUP(pir, SPRN_PIR);
+static SYSDEV_ATTR(pir, 0400, show_pir, NULL);
+#endif
+
 static void __cpuinit register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -394,6 +399,10 @@ static void __cpuinit register_cpu_onlin
 		sysdev_create_file(s, &attr_dscr);
 #endif /* CONFIG_PPC64 */
 
+#if defined(CONFIG_SMP) && defined(SPRN_PIR)
+	sysdev_create_file(s, &attr_pir);
+#endif
+
 	cacheinfo_cpu_online(cpu);
 }
 
@@ -464,6 +473,10 @@ static void unregister_cpu_online(unsign
 		sysdev_remove_file(s, &attr_dscr);
 #endif /* CONFIG_PPC64 */
 
+#if defined(CONFIG_SMP) && defined(SPRN_PIR)
+	sysdev_remove_file(s, &attr_pir);
+#endif
+
 	cacheinfo_cpu_offline(cpu);
 }
 
