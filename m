Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYVsW0sllzDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 11:45:02 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1hXWc043679
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:00 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n0et1vm0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:00 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:44:58 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 0EF73352006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:44:39 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1itBu29753666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:55 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1isPe029970
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:55 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 2/6] powerpc: kexec_file: Add buffer hand-over support for the
 next kernel
Date: Mon, 20 Jun 2016 22:44:32 -0300
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466473476-10104-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The buffer hand-over mechanism allows the currently running kernel to pass
data to kernel that will be kexec'd via a kexec segment. The second kernel
can check whether the previous kernel sent data and retrieve it.

This is the architecture-specific part.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kexec.h       |  9 +++++
 arch/powerpc/kernel/kexec_elf_64.c     | 44 +++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c | 64 ++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index a46f5f45570c..9b1ff59bc188 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -55,6 +55,15 @@ typedef void (*crash_shutdown_t)(void);
 
 #ifdef CONFIG_KEXEC
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	phys_addr_t handover_buffer_addr;
+	unsigned long handover_buffer_size;
+};
+#endif
+
 /*
  * This function is responsible for capturing register states if coming
  * via panic or invoking dump using sysrq-trigger.
diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index 4e71595300ed..5d2b7036fee7 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -96,6 +96,46 @@ static int elf64_probe(const char *buf, unsigned long len)
 	return elf_check_arch(&ehdr)? 0 : -ENOEXEC;
 }
 
+static int setup_handover_buffer(struct kimage *image, void *fdt,
+				 int chosen_node)
+{
+	int ret;
+
+	if (image->arch.handover_buffer_addr) {
+		ret = fdt_setprop_u64(fdt, chosen_node,
+				      "linux,kexec-handover-buffer-start",
+				      image->arch.handover_buffer_addr);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+
+		/* -end is the first address after the buffer. */
+		ret = fdt_setprop_u64(fdt, chosen_node,
+				      "linux,kexec-handover-buffer-end",
+				      image->arch.handover_buffer_addr +
+				      image->arch.handover_buffer_size);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+
+		ret = fdt_add_mem_rsv(fdt, image->arch.handover_buffer_addr,
+				      image->arch.handover_buffer_size);
+		if (ret) {
+			pr_err("Error reserving kexec handover buffer: %s\n",
+			       fdt_strerror(ret));
+			return -EINVAL;
+		}
+
+		pr_debug("kexec handover buffer at 0x%llx, size = 0x%lx\n",
+			 image->arch.handover_buffer_addr,
+			 image->arch.handover_buffer_size);
+	}
+
+	return 0;
+}
+
 static bool find_debug_console(void *fdt, int chosen_node)
 {
 	int len;
@@ -494,6 +534,10 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
 		}
 	}
 
+	ret = setup_handover_buffer(image, fdt, chosen_node);
+	if (ret)
+		goto out;
+
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
 	if (ret) {
 		pr_err("Error setting up the new device tree.\n");
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 43e8185ab6f7..c582abf726f5 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -19,6 +19,7 @@
 #include <linux/cpu.h>
 #include <linux/hardirq.h>
 #include <linux/memblock.h>
+#include <linux/libfdt.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -481,6 +482,69 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
 }
 
+bool kexec_can_hand_over_buffer(void)
+{
+	return true;
+}
+
+int arch_kexec_add_handover_buffer(struct kimage *image,
+				   unsigned long load_addr, unsigned long size)
+{
+	image->arch.handover_buffer_addr = load_addr;
+	image->arch.handover_buffer_size = size;
+
+	return 0;
+}
+
+int kexec_get_handover_buffer(void **addr, unsigned long *size)
+{
+	int chosen_node;
+	int startsz, endsz;
+	const void *startp, *endp;
+	unsigned long start_addr, end_addr;
+
+	chosen_node = fdt_path_offset(initial_boot_params, "/chosen");
+	if (chosen_node < 0) {
+		pr_err("Malformed device tree: /chosen not found.\n");
+		return -EINVAL;
+	}
+
+	startp = of_get_flat_dt_prop(chosen_node,
+				     "linux,kexec-handover-buffer-start",
+				     &startsz);
+	endp = of_get_flat_dt_prop(chosen_node,
+				   "linux,kexec-handover-buffer-end",
+				   &endsz);
+	if (!startp || !endp) {
+		pr_debug("kexec handover buffer not found in the device tree.\n");
+		return -ENOENT;
+	}
+
+	start_addr = of_read_number(startp, startsz/4);
+	end_addr = of_read_number(endp, endsz/4);
+
+	*addr =  __va(start_addr);
+	/* -end is the first address after the buffer. */
+	*size = end_addr - start_addr;
+
+	pr_debug("kexec handover buffer at %p, size = %lu\n", *addr, *size);
+
+	return 0;
+}
+
+int kexec_free_handover_buffer(void)
+{
+	int ret;
+	void *addr;
+	unsigned long size;
+
+	ret = kexec_get_handover_buffer(&addr, &size);
+	if (ret)
+		return ret;
+
+	return memblock_free((phys_addr_t) addr, size);
+}
+
 /**
  * arch_kexec_walk_mem - call func(data) for each unreserved memory block
  * @image_type:	kimage.type
-- 
1.9.1
