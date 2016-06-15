Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVJ2h1G1dzDqcG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 06:26:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FKIj8t014666
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:26:49 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jfmqd4pr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:26:49 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 14:26:48 -0600
Subject: [PATCH v2] powerpc/pseries: start rtasd before PCI probing
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 15 Jun 2016 22:26:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <146602104462.23192.4267928292361711364.stgit@bahia.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A strange behaviour is observed when comparing PCI hotplug in QEMU, between
x86 and pseries. If you consider the following steps:
- start a VM
- add a PCI device via the QEMU monitor before the rtasd has started (for
  example starting the VM in paused state, or hotplug during FW or boot
  loader)
- resume the VM execution

The x86 kernel detects the PCI device, but the pseries one does not.

This happens because the rtasd kernel worker is currently started under
device_initcall, while PCI probing happens earlier under subsys_initcall.

As a consequence, if we have a pending RTAS event at boot time, a message
is printed and the event is dropped.

This patch moves all the initialization of rtasd to arch_initcall, which is
run before subsys_call: this way, logging_enabled is true when the RTAS
event pops up and it is not lost anymore.

The proc fs bits stay at device_initcall because they cannot be run before
fs_initcall.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
v2: - avoid behaviour change: don't create the proc entry if early init failed

Michael,

This was also tested under PowerVM: it doesn't fix anything there because the
HMC tells it won't honor DLPAR features as long as the RMC isn't here, which
happens later in the boot sequence. It hence seems impossible to have a pending
RTAS event at boot time.

It doesn't seem to break anything either, the kernel boots and hotplug works
okay once the RMC is up.

Cheers.

--
Greg

---
 arch/powerpc/kernel/rtasd.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index e864b7c5884e..a26a02006576 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -526,10 +526,8 @@ void rtas_cancel_event_scan(void)
 }
 EXPORT_SYMBOL_GPL(rtas_cancel_event_scan);
 
-static int __init rtas_init(void)
+static int __init rtas_event_scan_init(void)
 {
-	struct proc_dir_entry *entry;
-
 	if (!machine_is(pseries) && !machine_is(chrp))
 		return 0;
 
@@ -562,13 +560,27 @@ static int __init rtas_init(void)
 		return -ENOMEM;
 	}
 
+	start_event_scan();
+
+	return 0;
+}
+arch_initcall(rtas_event_scan_init);
+
+static int __init rtas_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	if (!machine_is(pseries) && !machine_is(chrp))
+		return 0;
+
+	if (!rtas_log_buf)
+		return -ENODEV;
+
 	entry = proc_create("powerpc/rtas/error_log", S_IRUSR, NULL,
 			    &proc_rtas_log_operations);
 	if (!entry)
 		printk(KERN_ERR "Failed to create error_log proc entry\n");
 
-	start_event_scan();
-
 	return 0;
 }
 __initcall(rtas_init);
