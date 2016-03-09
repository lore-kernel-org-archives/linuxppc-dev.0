Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 548301A004B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:42:38 +1100 (AEDT)
In-Reply-To: <1457090804-9719-13-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v6,12/20] cxl: Add guest-specific code
Message-Id: <20160309124238.37FD414032B@ozlabs.org>
Date: Wed,  9 Mar 2016 23:42:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-03 at 11:26:36 UTC, Frederic Barrat wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> The new of.c file contains code to parse the device tree to find out
> about cxl adapters and AFUs.
> 
> guest.c implements the guest-specific callbacks for the backend API.
> 
> The process element ID is not known until the context is attached, so
> we have to separate the context ID assigned by the cxl driver from the
> process element ID visible to the user applications. In bare-metal,
> the 2 IDs match.
> 
> Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  drivers/misc/cxl/Makefile  |   1 +
>  drivers/misc/cxl/api.c     |   2 +-
>  drivers/misc/cxl/context.c |   6 +-
>  drivers/misc/cxl/cxl.h     |  37 +-
>  drivers/misc/cxl/file.c    |   2 +-
>  drivers/misc/cxl/guest.c   | 950 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/cxl/main.c    |  18 +-
>  drivers/misc/cxl/of.c      | 513 ++++++++++++++++++++++++
>  8 files changed, 1519 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/misc/cxl/guest.c
>  create mode 100644 drivers/misc/cxl/of.c
> 
> diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
> index be2ac5c..a3d4bef 100644
> --- a/drivers/misc/cxl/Makefile
> +++ b/drivers/misc/cxl/Makefile
> @@ -4,6 +4,7 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
>  cxl-y				+= main.o file.o irq.o fault.o native.o
>  cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
>  cxl-y				+= vphb.o api.o
> +cxl-y				+= guest.o of.o hcalls.o
>  obj-$(CONFIG_CXL)		+= cxl.o
>  obj-$(CONFIG_CXL_BASE)		+= base.o

This breaks the (newly added[1]) powernv_defconfig. ie. CONFIG_POWERNV=y, CONFIG_PPC_PSERIES=n.

  ERROR: "plpar_hcall" [drivers/misc/cxl/cxl.ko] undefined!
  ERROR: "rtas_call" [drivers/misc/cxl/cxl.ko] undefined!
  ERROR: "rtas_data_buf" [drivers/misc/cxl/cxl.ko] undefined!
  ERROR: "rtas_token" [drivers/misc/cxl/cxl.ko] undefined!
  ERROR: "plpar_hcall9" [drivers/misc/cxl/cxl.ko] undefined!
  ERROR: "rtas_data_buf_lock" [drivers/misc/cxl/cxl.ko] undefined!


Which is a show-stopper.

I've applied the following patch, let me know if there's anything wrong with
it. It would be great if we could do something cleaner.

cheers

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 9ab874f83df0..8a55c1aa11aa 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -4,7 +4,7 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
 cxl-y				+= vphb.o api.o
-cxl-y				+= flash.o guest.o of.o hcalls.o
+cxl-$(CONFIG_PPC_PSERIES)	+= flash.o guest.o of.o hcalls.o
 obj-$(CONFIG_CXL)		+= cxl.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
 
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index b5eeb71f6a9e..ae68c3201156 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -296,10 +296,13 @@ static int __init init_cxl(void)
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
 		cxl_ops = &cxl_native_ops;
 		rc = pci_register_driver(&cxl_pci_driver);
-	} else {
+	}
+#ifdef CONFIG_PPC_PSERIES
+	else {
 		cxl_ops = &cxl_guest_ops;
 		rc = platform_driver_register(&cxl_of_driver);
 	}
+#endif
 	if (rc)
 		goto err1;
 
@@ -317,8 +320,10 @@ static void exit_cxl(void)
 {
 	if (cpu_has_feature(CPU_FTR_HVMODE))
 		pci_unregister_driver(&cxl_pci_driver);
+#ifdef CONFIG_PPC_PSERIES
 	else
 		platform_driver_unregister(&cxl_of_driver);
+#endif
 
 	cxl_debugfs_exit();
 	cxl_file_exit();
