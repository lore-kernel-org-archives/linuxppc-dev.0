Date: Wed, 8 Aug 2001 05:39:55 -0700
From: Matt Porter <mporter@mvista.com>
To: John F Davis <johndavi@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVista: CDK 1.2 2.2.14 for SBS-K2 (750) Module Support
Message-ID: <20010808053955.A22983@cx258813-a.chnd1.az.home.com>
References: <OF205CEC3C.F52A4B97-ON85256AA2.0049AD5B@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF205CEC3C.F52A4B97-ON85256AA2.0049AD5B@raleigh.ibm.com>; from johndavi@us.ibm.com on Wed, Aug 08, 2001 at 09:10:22AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 08, 2001 at 09:10:22AM -0400, John F Davis wrote:
>
> Hello
>
> We are trying to build a kernel with loadable modules support using a stock
> mvista CDK 1.2 toolset.  The
> error is that many symbols are not resolved correctly.  If I build without
> module
> support the kernel builds fine.

Yep.

> For what its worth, we noticed that pci_io_base (one of the undefined
> symbols) was defined in the powermac tree.
>
> Lastly, does Mvista release different releases or patches for the same
> kernel?  ie., We build 2.2.14 kernels
> with module support on other machines here in the lab.  However, building
> this kernel on a newly installed machine fails.

There was a bug in the released MV 2.2.14 K2 port.  I sent the following
patch to customers at the time (the actual LSP was never updated).  The
hhl-2.0 LSP (2.4.2-based) doesn't have this problem.

-Matt

===== arch/ppc/kernel/ppc_ksyms.c 1.2 vs edited =====
--- 1.2/linux/arch/ppc/kernel/ppc_ksyms.c	Fri Jun 16 17:50:57 2000
+++ edited/arch/ppc/kernel/ppc_ksyms.c	Fri Aug 18 10:54:06 2000
@@ -80,10 +80,10 @@
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
-#ifndef CONFIG_8xx
+#ifndef CONFIG_PPC_EMBEDDED
 EXPORT_SYMBOL(_prep_type);
 EXPORT_SYMBOL(ucSystemType);
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_PPC_EMBEDDED */

 EXPORT_SYMBOL(atomic_add);
 EXPORT_SYMBOL(atomic_sub);
@@ -188,21 +188,21 @@
 EXPORT_SYMBOL(_machine);
 EXPORT_SYMBOL(ppc_md);

-#ifndef CONFIG_8xx
+#ifndef CONFIG_PPC_EMBEDDED
 EXPORT_SYMBOL(adb_request);
 EXPORT_SYMBOL(adb_register);
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_PPC_EMBEDDED */
 #ifdef CONFIG_PMAC_PBOOK
 EXPORT_SYMBOL(pmu_register_sleep_notifier);
 EXPORT_SYMBOL(pmu_unregister_sleep_notifier);
 EXPORT_SYMBOL(pmu_enable_irled);
 #endif CONFIG_PMAC_PBOOK
 EXPORT_SYMBOL(abort);
-#ifndef CONFIG_8xx
+#ifndef CONFIG_PPC_EMBEDDED
 EXPORT_SYMBOL(find_devices);
 EXPORT_SYMBOL(find_type_devices);
 EXPORT_SYMBOL(find_compatible_devices);
@@ -216,7 +216,7 @@
 EXPORT_SYMBOL(feature_set);
 EXPORT_SYMBOL(feature_clear);
 EXPORT_SYMBOL(feature_test);
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_PPC_EMBEDDED */
 #ifdef CONFIG_SCSI
 EXPORT_SYMBOL(note_scsi_host);
 #endif

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
