Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE3E41A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 03:00:41 +1100 (AEDT)
Received: by wevl61 with SMTP id l61so10224561wev.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 09:00:38 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
 mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux@arm.linux.org.uk, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 4/5] arm64/efi: ensure that Image does not cross a 512 MB
 boundary
Date: Wed, 11 Mar 2015 17:00:19 +0100
Message-Id: <1426089620-9459-5-git-send-email-ard.biesheuvel@linaro.org>
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

Update the Image placement logic used by the stub to make absolutely
sure that the Image is placed such that the early init code will
always be able to map it. This means the entire static memory footprint
of the Image should be inside the same naturally aligned 512 MB region.

First of all, the preferred offset of dram_base + TEXT_OFFSET is only
suitable if it doesn't result in the Image crossing a 512 MB
alignment boundary, which could be the case if dram_base itself is
close to the end of a naturally aligned 512 MB region.

Also, when moving the kernel Image, we need to verify that the new
destination region does not cross a 512 MB alignment boundary either.
If that is the case, we retry the allocation with the alignment
chosen such that the resulting region will always be suitable.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-stub.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index f5374065ad53..3b67ca4e2f2e 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -21,15 +21,40 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table,
 					unsigned long dram_base,
 					efi_loaded_image_t *image)
 {
+	const unsigned long kernel_size = _edata - _text;
+	const unsigned long kernel_memsize = _end - _text;
+	unsigned long preferred_offset;
 	efi_status_t status;
-	unsigned long kernel_size, kernel_memsize = 0;
-
-	/* Relocate the image, if required. */
-	kernel_size = _edata - _text;
-	if (*image_addr != (dram_base + TEXT_OFFSET)) {
-		kernel_memsize = kernel_size + (_end - _edata);
-		status = efi_low_alloc(sys_table, kernel_memsize + TEXT_OFFSET,
-				       SZ_2M, reserve_addr);
+
+	/*
+	 * The kernel Image should be located as close as possible to the
+	 * base of system RAM, but its static memory footprint must not
+	 * cross a 512 MB alignment boundary.
+	 */
+	preferred_offset = dram_base + TEXT_OFFSET;
+	if ((preferred_offset & (SZ_512M - 1)) + kernel_memsize > SZ_512M)
+		preferred_offset = round_up(dram_base, SZ_512M) + TEXT_OFFSET;
+
+	if (*image_addr != preferred_offset) {
+		const unsigned long alloc_size = kernel_memsize + TEXT_OFFSET;
+
+		status = efi_low_alloc(sys_table, alloc_size, SZ_2M,
+				       reserve_addr);
+
+		/*
+		 * Check whether the new allocation crosses a 512 MB alignment
+		 * boundary. If so, retry with the alignment set to a power of
+		 * two upper bound of the allocation size. That is guaranteed
+		 * to produce a suitable allocation, but may waste more memory.
+		 */
+		if (status == EFI_SUCCESS &&
+		    ((*reserve_addr & (SZ_512M - 1)) + alloc_size) > SZ_512M) {
+			efi_free(sys_table, alloc_size, *reserve_addr);
+
+			status = efi_low_alloc(sys_table, alloc_size,
+					       roundup_pow_of_two(alloc_size),
+					       reserve_addr);
+		}
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table, "Failed to relocate kernel\n");
 			return status;
-- 
1.8.3.2
