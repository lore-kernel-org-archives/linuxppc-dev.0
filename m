Date: Wed, 19 Jun 2002 12:11:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Trivial cleanups in ocp.h
Message-ID: <20020619021100.GI15985@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As a followup to your recent ocp cleanup patch, this does a little
more cleanup.  It does nothing except remove a bunch of things from
ocp.h that weren't used anywhere, anyway.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h linux-grinch/include/asm-ppc/ocp.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h	Wed Jun 19 10:32:59 2002
+++ linux-grinch/include/asm-ppc/ocp.h	Wed Jun 19 11:26:57 2002
@@ -51,19 +51,11 @@

 #include <linux/list.h>
 #include <linux/config.h>
-#include <linux/devfs_fs_kernel.h>

 #include <asm/mmu.h>		/* For phys_addr_t */

-#if defined(CONFIG_IBM_OCP)
-#include <platforms/ibm_ocp.h>
-#endif
-
 #define OCP_MAX_IRQS	7
 #define MAX_EMACS	4
-#define MAX_OCP_DEVS	20
-#define OCP_ACTIVE	1
-#define OCP_INACTIVE	2
 #define OCP_IRQ_NA	-1	/* used when ocp device does not have an irq */
 #define OCP_IRQ_MUL	-2	/* used for ocp devices with multiply irqs */
 #define OCP_NULL_TYPE	-1	/* used to mark end of list */
@@ -122,12 +114,6 @@
 	u32 flags;
 	int irq;
 	void *ocpdev;		/* ocp device struct  pointer */
-	u64		dma_mask;	/* Mask of the bits of bus address this
-					   device implements.  Normally this is
-					   0xffffffff.  You only need to change
-					   this if your device has broken DMA
-					   or supports 64-bit transfers.  */
-
 #if defined(CONFIG_PM)
 	u32 current_state;	/* Current operating state. In ACPI-speak,
 				   this is D0-D3, D0 being fully functional,
@@ -139,14 +125,10 @@
 	int (*enable_wake) (u32 state, int enable);	/* Enable wake event */
 #endif
 #if defined(CONFIG_OCP_PROC)
-	struct proc_dir_entry *procdir;	/* dir entry in /proc/bus */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/ocp */
 #endif
 };
 #define ocp_dev_g(n) list_entry(n, struct ocp_dev, ocp_list)
-#define ocp_for_each_dev(dev) \
-	for(dev = ocp_dev_g(ocp_devs.next); dev != ocp_dev_g(&ocp_devs); dev = ocp_dev_g(dev->ocp_list.next))
-
 /* Similar to the helpers above, these manipulate per-ocp_dev
  * driver-specific data.  Currently stored as ocp_dev::ocpdev,
  * a void pointer, but it is not present on older kernels.
@@ -170,7 +152,6 @@
 extern int ocp_proc_attach_device(struct ocp_dev *dev);
 extern int ocp_proc_detach_device(struct ocp_dev *dev);
 extern unsigned long ocp_get_paddr(int type, int dev_num);
-extern int ocp_get_numtypes(int type);
 extern int ocp_get_max(int type);
 extern int ocp_get_irq(int type, int dev_num);



--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
