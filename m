Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03F02DDED0
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 18:37:16 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6N8amvU284306
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:36:48 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6N8alu01937630
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:48 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6N8alYw021882
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
From: ehrhardt@linux.vnet.ibm.com
To: kvm-ppc@vger.kernel.org, embedded-hypervisor@power.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 6/6] kvmppc: kvm-userspace: device tree modification for
	magicpage
Date: Wed, 23 Jul 2008 10:36:47 +0200
Message-Id: <1216802207-32675-7-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This patch to kvm-userspace connects the other host & guest patches in this
series. On guest initialization it checks the hosts capabilities for the
magicpage mechanism. If available the device tree passed to the guest gets the
"hypervisor" node added and in that node the feature flag and the requested
magic page size (read from the host kernel via an ioctl) is stored.

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 libkvm/libkvm-powerpc.c |    6 ++++++
 libkvm/libkvm.h         |    6 ++++++
 qemu/hw/device_tree.c   |   10 ++++++++++
 qemu/hw/device_tree.h   |    1 +
 qemu/hw/ppc440_bamboo.c |   15 +++++++++++++++
 qemu/qemu-kvm-powerpc.c |    5 +++++
 qemu/qemu-kvm.h         |    1 +
 7 files changed, 44 insertions(+)

[diff]
diff --git a/libkvm/libkvm-powerpc.c b/libkvm/libkvm-powerpc.c
--- a/libkvm/libkvm-powerpc.c
+++ b/libkvm/libkvm-powerpc.c
@@ -19,6 +19,7 @@
 
 #include "libkvm.h"
 #include "kvm-powerpc.h"
+#include <sys/ioctl.h>
 #include <errno.h>
 #include <stdio.h>
 #include <inttypes.h>
@@ -105,6 +106,11 @@
 	return 0;
 }
 
+int kvm_get_magicpage_size(kvm_context_t kvm)
+{
+	return ioctl(kvm->fd, KVM_GET_PPCPV_MAGICPAGE_SIZE, 0);
+}
+
 int kvm_arch_run(struct kvm_run *run, kvm_context_t kvm, int vcpu)
 {
 	int ret = 0;
diff --git a/libkvm/libkvm.h b/libkvm/libkvm.h
--- a/libkvm/libkvm.h
+++ b/libkvm/libkvm.h
@@ -639,6 +639,12 @@
 
 #endif
 
+#ifdef KVM_CAP_PPCPV_MAGICPAGE
+
+int kvm_get_magicpage_size(kvm_context_t kvm);
+
+#endif
+
 int kvm_translate(kvm_context_t kvm, int vcpu, struct kvm_translation *tr);
 
 #endif
diff --git a/qemu/hw/device_tree.c b/qemu/hw/device_tree.c
--- a/qemu/hw/device_tree.c
+++ b/qemu/hw/device_tree.c
@@ -190,4 +190,14 @@
 		exit(1);
 	}
 }
+
+void dt_add_subnode(void *fdt, const char *name, char *node_path)
+{
+	int offset;
+	offset = get_offset_of_node(fdt, node_path);
+	if (fdt_add_subnode(fdt, offset, name) < 0) {
+		printf("Unable to create device tree node '%s'\n", name);
+		exit(1);
+	}
+}
 #endif
diff --git a/qemu/hw/device_tree.h b/qemu/hw/device_tree.h
--- a/qemu/hw/device_tree.h
+++ b/qemu/hw/device_tree.h
@@ -23,4 +23,5 @@
 		uint32_t *val_array, int size);
 void dt_string(void *fdt, char *node_path, char *property,
 		char *string);
+void dt_add_subnode(void *fdt, const char *name, char *node_path);
 #endif
diff --git a/qemu/hw/ppc440_bamboo.c b/qemu/hw/ppc440_bamboo.c
--- a/qemu/hw/ppc440_bamboo.c
+++ b/qemu/hw/ppc440_bamboo.c
@@ -51,6 +51,7 @@
 	uint32_t cpu_freq;
 	uint32_t timebase_freq;
 	uint32_t mem_reg_property[]={0, 0, ram_size};
+	int pv_magicpage_size;
 
 	printf("%s: START\n", __func__);
 
@@ -167,6 +168,20 @@
 	dt_cell(fdt, "/chosen", "linux,initrd-end",
 				(initrd_base + initrd_size));
 	dt_string(fdt, "/chosen", "bootargs", (char *)kernel_cmdline);
+
+	if (kvm_enabled()
+	    && kvm_qemu_check_extension(KVM_CAP_PPCPV_MAGICPAGE)) {
+		pv_magicpage_size = kvmppc_pv_get_magicpage_size();
+		if (pv_magicpage_size < 0) {
+			fprintf(stderr, "%s: error reading magic page size\n",
+				 __func__);
+			exit(1);
+		}
+		dt_add_subnode(fdt, "hypervisor", "/");
+		dt_cell(fdt, "/hypervisor", "feature,pv-magicpage", 1);
+		dt_cell(fdt, "/hypervisor", "data,pv-magicpage-size",
+			pv_magicpage_size);
+	}
 #endif
 
 	if (kvm_enabled()) {
diff --git a/qemu/qemu-kvm-powerpc.c b/qemu/qemu-kvm-powerpc.c
--- a/qemu/qemu-kvm-powerpc.c
+++ b/qemu/qemu-kvm-powerpc.c
@@ -214,6 +214,11 @@
     return 0; /* XXX ignore failed DCR ops */
 }
 
+int kvmppc_pv_get_magicpage_size(void)
+{
+	return kvm_get_magicpage_size(kvm_context);
+}
+
 int mmukvm_get_physical_address(CPUState *env, mmu_ctx_t *ctx,
                                 target_ulong eaddr, int rw, int access_type)
 {
diff --git a/qemu/qemu-kvm.h b/qemu/qemu-kvm.h
--- a/qemu/qemu-kvm.h
+++ b/qemu/qemu-kvm.h
@@ -86,6 +86,7 @@
 #ifdef TARGET_PPC
 int handle_powerpc_dcr_read(int vcpu, uint32_t dcrn, uint32_t *data);
 int handle_powerpc_dcr_write(int vcpu,uint32_t dcrn, uint32_t data);
+int kvmppc_pv_get_magicpage_size();
 #endif
 
 #if !defined(SYS_signalfd)
