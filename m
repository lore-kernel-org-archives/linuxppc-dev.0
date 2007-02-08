Return-Path: <ahuja@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B473DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 09:01:30 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l18M1MDx021619
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 17:01:22 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l18M1MOk268426
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 17:01:22 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l18M1L8Q011020
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 17:01:22 -0500
Message-ID: <45CB9DAD.3060609@austin.ibm.com>
Date: Thu, 08 Feb 2007 16:01:17 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
References: <45707469.9060604@austin.ibm.com>	<4575E76C.7030300@austin.ibm.com>	<17785.415.574041.518517@cargo.ozlabs.ibm.com>	<458EBE02.3010401@austin.ibm.com>	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>	<45C40C97.807@austin.ibm.com>
	<17865.14407.190426.642030@cargo.ozlabs.ibm.com>
In-Reply-To: <17865.14407.190426.642030@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed; boundary="------------060600000908060103030909"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060600000908060103030909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Re-spun as suggested. I think this should be i-series friendly.

------------------------------------------------------------------------------------------------------------------------- 




During power outages, the ups notifies the system for a shutdown. In the
current setup, it isn't possible to poweron when power is restored. This
patch fixes the issue by calling the right ibm,power-off-ups token
during such events. It also adds a sysfs interface so that rc.powerfail
can parse the epow events and modify the power-off behavior accordingly
to enable the right token to be called.

Signed-off-by: Manish Ahuja <ahuja@austin.ibm.com>






--------------060600000908060103030909
Content-Type: text/plain;
 name="Auto-poweron-patch-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Auto-poweron-patch-1"

---
 arch/powerpc/platforms/pseries/Makefile  |    2 
 arch/powerpc/platforms/pseries/power.c   |   87 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |    3 +
 arch/powerpc/platforms/pseries/setup.c   |   30 ++++++++++
 4 files changed, 120 insertions(+), 2 deletions(-)

Index: 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/power.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/power.c	2007-02-08 12:37:30.000000000 -0800
@@ -0,0 +1,87 @@
+/*
+ *  Interface for power-management for ppc64 compliant platform
+ *
+ *  Manish Ahuja <mahuja@us.ibm.com>
+ *
+ *  Feb 2007
+ *
+ *  Copyright (C) 2007 IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+unsigned long rtas_poweron_auto; /* default and normal state is 0 */
+
+static ssize_t auto_poweron_show(struct subsystem * subsys, char * buf)
+{
+        return sprintf(buf, "%lu\n", rtas_poweron_auto);
+}
+
+static ssize_t
+auto_poweron_store(struct subsystem * subsys, const char * buf, size_t n)
+{
+	int ret;
+	unsigned long ups_restart;
+	ret = sscanf(buf, "%lu", &ups_restart);
+
+	if ((ret == 1) && ((ups_restart == 1) || (ups_restart == 0))){
+		rtas_poweron_auto = ups_restart;
+		return n;
+	}
+	return -EINVAL;
+}
+
+static struct subsys_attribute auto_poweron_attr = {
+        .attr   = {
+                .name = __stringify(auto_poweron),
+                .mode = 0644,
+        },
+        .show   = auto_poweron_show,
+        .store  = auto_poweron_store,
+};
+
+#ifndef CONFIG_PM
+decl_subsys(power,NULL,NULL);
+
+static struct attribute * g[] = {
+        &auto_poweron_attr.attr,
+        NULL,
+};
+
+static struct attribute_group attr_group = {
+        .attrs = g,
+};
+
+static int __init pm_init(void)
+{
+        int error = subsystem_register(&power_subsys);
+        if (!error)
+                error = sysfs_create_group(&power_subsys.kset.kobj,&attr_group);
+        return error;
+}
+core_initcall(pm_init);
+#else
+extern struct subsystem power_subsys;
+
+static int __init apo_pm_init(void)
+{
+	return(subsys_create_file(&power_subsys, &auto_poweron_attr));
+}
+__initcall(apo_pm_init);
+#endif
Index: 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- 2.6.20-rc6-git1-t2.orig/arch/powerpc/platforms/pseries/Makefile	2007-02-08 12:37:28.000000000 -0800
+++ 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/Makefile	2007-02-08 12:37:30.000000000 -0800
@@ -4,7 +4,7 @@ endif
 
 obj-y			:= pci.o lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o ras.o rtasd.o pci_dlpar.o \
-			   firmware.o
+			   firmware.o power.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
Index: 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- 2.6.20-rc6-git1-t2.orig/arch/powerpc/platforms/pseries/setup.c	2007-02-08 12:37:28.000000000 -0800
+++ 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/setup.c	2007-02-08 12:37:30.000000000 -0800
@@ -486,6 +486,34 @@ static int pSeries_pci_probe_mode(struct
 	return PCI_PROBE_NORMAL;
 }
 
+/**
+ * pSeries_power_off - tell firmware about how to power off the system.
+ *
+ * This function calls either the power-off rtas token in normal cases
+ * or the ibm,power-off-ups token (if present & requested) in case of
+ * a power failure. If power-off token is used, power on will only be
+ * possible with power button press. If ibm,power-off-ups token is used
+ * it will allow auto poweron after power is restored.
+ */
+void pSeries_power_off(void)
+{
+	int rc;
+	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
+
+	if (rtas_flash_term_hook)
+		rtas_flash_term_hook(SYS_POWER_OFF);
+
+	if (rtas_poweron_auto == 0 ||
+		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
+		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
+		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
+	} else {
+		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
+		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
+	}
+	for (;;);
+}
+
 define_machine(pseries) {
 	.name			= "pSeries",
 	.probe			= pSeries_probe,
@@ -496,7 +524,7 @@ define_machine(pseries) {
 	.pcibios_fixup		= pSeries_final_fixup,
 	.pci_probe_mode		= pSeries_pci_probe_mode,
 	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
+	.power_off		= pSeries_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
 	.get_boot_time		= rtas_get_boot_time,
Index: 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- 2.6.20-rc6-git1-t2.orig/arch/powerpc/platforms/pseries/pseries.h	2007-02-08 12:37:28.000000000 -0800
+++ 2.6.20-rc6-git1-t2/arch/powerpc/platforms/pseries/pseries.h	2007-02-08 12:48:10.000000000 -0800
@@ -33,4 +33,7 @@ static inline setup_kexec_cpu_down_xics(
 static inline setup_kexec_cpu_down_mpic(void) { };
 #endif
 
+/* Poweron buffer used for enabling auto ups restart */
+extern unsigned long rtas_poweron_auto;
+
 #endif /* _PSERIES_PSERIES_H */


--------------060600000908060103030909--
