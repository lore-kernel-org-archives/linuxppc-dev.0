Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.205])
	by ozlabs.org (Postfix) with ESMTP id A00332BDD3
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 11:18:49 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so3175841rnk
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 18:18:47 -0700 (PDT)
Message-ID: <35fb2e59040922181249d18af6@mail.gmail.com>
Date: Thu, 23 Sep 2004 02:12:07 +0100
From: Jon Masters <jonmasters@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <35fb2e59040919131864c26952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <35fb2e5904090607241087442d@mail.gmail.com>
	<35fb2e59040919131864c26952@mail.gmail.com>
Cc: 
Subject: [PATCH] xsa_use_interrupts flag [WAS: xilinx_sysace]
Reply-To: jonathan@jonmasters.org
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 19 Sep 2004 21:18:14 +0100, Jon Masters <jonmasters@gmail.com> wrote:

> It's as I thought on and off and then on again - the code checks out
> ok (it's not pretty but it works) - and I seem to be getting unwanted
> extra unhandled interrupts from the hardware. This driver needs a lot
> of cleanup anyway - it doesn't handle these kinds of error state, nor
> does it handle the removal of a mounted CompactFlash, and a dozen
> other typical problems. I'll post a patch when I've solved the main
> problem - moan at me by private mail if you're using this, having
> similar issues, and feel like helping.

Hi all,

I have spoken to a number of people about this ongoing issue with the
Xilinx System ACE hardware that I am using (I have a Memec board - not
the Xilinx one) and the fact that the hardware insists on generating
an extra interrupt on SectorWrite operations which is neither
documented nor otherwise explainable (but I'd love it if someone would
enlighten me).

So I've added a trivial patch to xilinx_sysace to provide a flag for
disabling interrupts at least for now. I am working on a bunch of
other Virtex II Pro bits and pieces that I'll feed upstream when
they're ready but for now xsa_interrupt should probably also check
whether the request queue is empty in the case that it's called with
no good reason.

The following patch has been briefly tested on a modified inhouse
2.4.23 kernel which uses a few drivers from the Monta tree (like
xilinux_sysace) but otherwise differs quite heavily - I don't rely on
any generated xparameters and other EDK nonesense and I don't want to
rely on that in any way either - least of all for determining whether
or not to use interrupts.

Jon.

diff --unified --recursive --new-file xilinx_sysace_mvista/adapter.c
xilinx_sysace_nointr/adapter.c
--- xilinx_sysace_mvista/adapter.c	2004-03-15 11:41:30.000000000 +0000
+++ xilinx_sysace_nointr/adapter.c	2004-09-22 17:31:58.000000000 +0100
@@ -6,6 +6,10 @@
  * Author: MontaVista Software, Inc.
  *         source@mvista.com
  *
+ * History:
+ *         22/09/2004 - Added xsa_use_interrupts.
+ *         Jon Masters <jcm@jonmasters.org>.
+ *
  * 2002 (c) MontaVista, Software, Inc.  This file is licensed under the terms
  * of the GNU General Public License version 2.  This program is licensed
  * "as is" without any warranty of any kind, whether express or implied.
@@ -59,9 +63,17 @@
 #include <xbasic_types.h>
 #include "xsysace.h"
 
+/*
+ * We have to disable interrupts on certain boards where writing causes an
+ * additional unexpected hardware interrupt on sector write completion.
+ */
+
+static int xsa_use_interrupts = 0;
+
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
 MODULE_DESCRIPTION("Xilinx System ACE block driver");
 MODULE_LICENSE("GPL");
+MODULE_PARM(xsa_enable_interrupts,"i");
 
 /*
  * We have to wait for a lock and for the CompactFlash to not be busy
@@ -497,11 +509,17 @@
 			       DEVICE_NAME, stat, req_str, sector);
 			xsa_complete_request(0);	/* Request failed. */
 		}
+
+		if ((!xsa_use_interrupts) && (stat == XST_SUCCESS)) {
+			printk("RIQC: request complete.\n");
+			xsa_complete_request(1);
+		}
 	}
 
-      exit:
+	
+ exit:
 	remove_wait_queue(&req_wait, &wait);
-
+	
 	xsa_task = NULL;
 	complete_and_exit(&task_sync, 0);
 }
@@ -757,16 +775,25 @@
 		return -ENODEV;
 	}
 
-	i = request_irq(XSA_IRQ, xsysace_interrupt, 0, DEVICE_NAME, NULL);
-	if (i) {
-		printk(KERN_ERR "%s: Could not allocate interrupt %d.\n",
-		       DEVICE_NAME, XSA_IRQ);
-		cleanup();
-		return i;
+	if (xsa_use_interrupts) {
+
+		i = request_irq(XSA_IRQ, xsysace_interrupt, 0, DEVICE_NAME, NULL);
+		if (i) {
+			printk(KERN_ERR "%s: Could not allocate interrupt %d.\n",
+			       DEVICE_NAME, XSA_IRQ);
+			cleanup();
+			return i;
+		}
+		reqirq = 1;
 	}
-	reqirq = 1;
+
 	XSysAce_SetEventHandler(&SysAce, EventHandler, (void *) NULL);
-	XSysAce_EnableInterrupt(&SysAce);
+	
+	if (xsa_use_interrupts) {
+		XSysAce_EnableInterrupt(&SysAce);
+	} else {
+		XSysAce_DisableInterrupt(&SysAce);
+	}
 
 	/* Time to identify the drive. */
 	while (XSysAce_Lock(&SysAce, 0) == XST_DEVICE_BUSY)
@@ -832,10 +859,17 @@
 	register_disk(&xsa_gendisk, MKDEV(xsa_major, 0),
 		      NR_HD << PARTN_BITS, &xsa_fops, size);
 
-	printk(KERN_INFO
-	       "%s at 0x%08X mapped to 0x%08X, irq=%d, %ldKB\n",
-	       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress, XSA_IRQ,
-	       size / 2);
+	if (xsa_use_interrupts) {
+		printk(KERN_INFO
+		       "%s at 0x%08X mapped to 0x%08X, irq=%d, %ldKB\n",
+		       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress, XSA_IRQ,
+		       size / 2);
+	} else {
+		printk(KERN_INFO
+		       "%s at 0x%08X mapped to 0x%08X, polled IO, %ldKB\n",
+		       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress, XSA_IRQ,
+		       size / 2);
+	}
 
 	/* Hook our reset function into system's restart code. */
 	old_restart = ppc_md.restart;
