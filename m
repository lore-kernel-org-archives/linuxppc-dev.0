Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0086.outbound.protection.outlook.com [104.47.32.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGW9z4YpbzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:08:39 +1000 (AEST)
From: Brijesh Singh <brijesh.singh@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [RFC Part1 PATCH v3 06/17] x86/mm: Use encrypted access of boot
 related data with SEV
Date: Mon, 24 Jul 2017 14:07:46 -0500
Message-Id: <20170724190757.11278-7-brijesh.singh@amd.com>
In-Reply-To: <20170724190757.11278-1-brijesh.singh@amd.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tom Lendacky <thomas.lendacky@amd.com>

When Secure Encrypted Virtualization (SEV) is active, boot data (such as
EFI related data, setup data) is encrypted and needs to be accessed as
such when mapped. Update the architecture override in early_memremap to
keep the encryption attribute when mapping this data.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/mm/ioremap.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 34f0e18..c0be7cf 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -422,6 +422,9 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
  * areas should be mapped decrypted. And since the encryption key can
  * change across reboots, persistent memory should also be mapped
  * decrypted.
+ *
+ * If SEV is active, that implies that BIOS/UEFI also ran encrypted so
+ * only persistent memory should be mapped decrypted.
  */
 static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 					  unsigned long size)
@@ -458,6 +461,11 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 	case E820_TYPE_ACPI:
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
+		/* For SEV, these areas are encrypted */
+		if (sev_active())
+			break;
+		/* Fallthrough */
+
 	case E820_TYPE_PRAM:
 		return true;
 	default:
@@ -581,7 +589,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 				 unsigned long flags)
 {
-	if (!sme_active())
+	if (!sme_active() && !sev_active())
 		return true;
 
 	if (flags & MEMREMAP_ENC)
@@ -590,10 +598,15 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 	if (flags & MEMREMAP_DEC)
 		return false;
 
-	if (memremap_is_setup_data(phys_addr, size) ||
-	    memremap_is_efi_data(phys_addr, size) ||
-	    memremap_should_map_decrypted(phys_addr, size))
-		return false;
+	if (sme_active()) {
+		if (memremap_is_setup_data(phys_addr, size) ||
+		    memremap_is_efi_data(phys_addr, size) ||
+		    memremap_should_map_decrypted(phys_addr, size))
+			return false;
+	} else if (sev_active()) {
+		if (memremap_should_map_decrypted(phys_addr, size))
+			return false;
+	}
 
 	return true;
 }
@@ -608,15 +621,22 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 					     unsigned long size,
 					     pgprot_t prot)
 {
-	if (!sme_active())
+	if (!sme_active() && !sev_active())
 		return prot;
 
-	if (early_memremap_is_setup_data(phys_addr, size) ||
-	    memremap_is_efi_data(phys_addr, size) ||
-	    memremap_should_map_decrypted(phys_addr, size))
-		prot = pgprot_decrypted(prot);
-	else
-		prot = pgprot_encrypted(prot);
+	if (sme_active()) {
+		if (early_memremap_is_setup_data(phys_addr, size) ||
+		    memremap_is_efi_data(phys_addr, size) ||
+		    memremap_should_map_decrypted(phys_addr, size))
+			prot = pgprot_decrypted(prot);
+		else
+			prot = pgprot_encrypted(prot);
+	} else if (sev_active()) {
+		if (memremap_should_map_decrypted(phys_addr, size))
+			prot = pgprot_decrypted(prot);
+		else
+			prot = pgprot_encrypted(prot);
+	}
 
 	return prot;
 }
-- 
2.9.4
