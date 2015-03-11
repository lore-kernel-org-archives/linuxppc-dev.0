Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E1061A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 03:00:44 +1100 (AEDT)
Received: by wgha1 with SMTP id a1so10348394wgh.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 09:00:41 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
 mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux@arm.linux.org.uk, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 5/5] arm64/efi: adapt to relaxed FDT placement requirements
Date: Wed, 11 Mar 2015 17:00:20 +0100
Message-Id: <1426089620-9459-6-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1426089620-9459-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426089620-9459-1-git-send-email-ard.biesheuvel@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the relaxed FDT placement requirements in place, we can change
the allocation strategy used by the stub to put the FDT image higher
up in memory. At the same time, reduce the minimal alignment to a
power of 2 upper bound of the size: this way, we are still guaranteed
not to cross a 2 MB boundary, but will potentially waste less memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/efi.h            |  8 +++-----
 drivers/firmware/efi/libstub/arm-stub.c |  5 ++---
 drivers/firmware/efi/libstub/efistub.h  |  1 -
 drivers/firmware/efi/libstub/fdt.c      | 10 +++-------
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index ef572206f1c3..6f526fcc6b70 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -39,12 +39,10 @@ extern void efi_init(void);
 /* arch specific definitions used by the stub code */
 
 /*
- * AArch64 requires the DTB to be 8-byte aligned in the first 512MiB from
- * start of kernel and may not cross a 2MiB boundary. We set alignment to
- * 2MiB so we know it won't cross a 2MiB boundary.
+ * AArch64 requires the DTB to be 8-byte aligned and not cross a 2MiB boundary.
+ * So align to a power of 2 upper bound of the FDT size.
  */
-#define EFI_FDT_ALIGN	SZ_2M   /* used by allocate_new_fdt_and_exit_boot() */
-#define MAX_FDT_OFFSET	SZ_512M
+#define EFI_FDT_ALIGN(x)	roundup_pow_of_two(x)
 
 #define efi_call_early(f, ...) sys_table_arg->boottime->f(__VA_ARGS__)
 
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index dcae482a9a17..f54c76a4fd32 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -269,9 +269,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 
 	new_fdt_addr = fdt_addr;
 	status = allocate_new_fdt_and_exit_boot(sys_table, handle,
-				&new_fdt_addr, dram_base + MAX_FDT_OFFSET,
-				initrd_addr, initrd_size, cmdline_ptr,
-				fdt_addr, fdt_size);
+				&new_fdt_addr, initrd_addr, initrd_size,
+				cmdline_ptr, fdt_addr, fdt_size);
 
 	/*
 	 * If all went well, we need to return the FDT address to the
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 47437b16b186..c8e096094ea9 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -35,7 +35,6 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 					    void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 91da56c4fd54..48218e91cce1 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -165,10 +165,6 @@ fdt_set_fail:
 	return EFI_LOAD_ERROR;
 }
 
-#ifndef EFI_FDT_ALIGN
-#define EFI_FDT_ALIGN EFI_PAGE_SIZE
-#endif
-
 /*
  * Allocate memory for a new FDT, then add EFI, commandline, and
  * initrd related fields to the FDT.  This routine increases the
@@ -186,7 +182,6 @@ fdt_set_fail:
 efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 					    void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
@@ -223,8 +218,9 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	 */
 	new_fdt_size = fdt_size + EFI_PAGE_SIZE;
 	while (1) {
-		status = efi_high_alloc(sys_table, new_fdt_size, EFI_FDT_ALIGN,
-					new_fdt_addr, max_addr);
+		status = efi_high_alloc(sys_table, new_fdt_size,
+					EFI_FDT_ALIGN(new_fdt_size),
+					new_fdt_addr, ULONG_MAX);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table, "Unable to allocate memory for new device tree.\n");
 			goto fail;
-- 
1.8.3.2
