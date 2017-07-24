Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0086.outbound.protection.outlook.com [104.47.32.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGWBN5h1tzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:08:59 +1000 (AEST)
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
Subject: [RFC Part1 PATCH v3 17/17] X86/KVM: Clear encryption attribute when
 SEV is active
Date: Mon, 24 Jul 2017 14:07:57 -0500
Message-Id: <20170724190757.11278-18-brijesh.singh@amd.com>
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

The guest physical memory area holding the struct pvclock_wall_clock and
struct pvclock_vcpu_time_info are shared with the hypervisor. Hypervisor
periodically updates the contents of the memory. When SEV is active, we
must clear the encryption attributes from the shared memory pages so that
both hypervisor and guest can access the data.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/entry/vdso/vma.c  |  5 ++--
 arch/x86/kernel/kvmclock.c | 64 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 726355c..ff50251 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -114,10 +114,11 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 		struct pvclock_vsyscall_time_info *pvti =
 			pvclock_pvti_cpu0_va();
 		if (pvti && vclock_was_used(VCLOCK_PVCLOCK)) {
-			ret = vm_insert_pfn(
+			ret = vm_insert_pfn_prot(
 				vma,
 				vmf->address,
-				__pa(pvti) >> PAGE_SHIFT);
+				__pa(pvti) >> PAGE_SHIFT,
+				pgprot_decrypted(vma->vm_page_prot));
 		}
 	} else if (sym_offset == image->sym_hvclock_page) {
 		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index d889676..f3a8101 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 
+#include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
 #include <asm/reboot.h>
 #include <asm/kvmclock.h>
@@ -45,7 +46,7 @@ early_param("no-kvmclock", parse_no_kvmclock);
 
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
-static struct pvclock_wall_clock wall_clock;
+static struct pvclock_wall_clock *wall_clock;
 
 struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
 {
@@ -64,15 +65,18 @@ static void kvm_get_wallclock(struct timespec *now)
 	int low, high;
 	int cpu;
 
-	low = (int)__pa_symbol(&wall_clock);
-	high = ((u64)__pa_symbol(&wall_clock) >> 32);
+	if (!wall_clock)
+		return;
+
+	low = (int)slow_virt_to_phys(wall_clock);
+	high = ((u64)slow_virt_to_phys(wall_clock) >> 32);
 
 	native_write_msr(msr_kvm_wall_clock, low, high);
 
 	cpu = get_cpu();
 
 	vcpu_time = &hv_clock[cpu].pvti;
-	pvclock_read_wallclock(&wall_clock, vcpu_time, now);
+	pvclock_read_wallclock(wall_clock, vcpu_time, now);
 
 	put_cpu();
 }
@@ -249,11 +253,39 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
+static phys_addr_t __init kvm_memblock_alloc(phys_addr_t size,
+					     phys_addr_t align)
+{
+	phys_addr_t mem;
+
+	mem = memblock_alloc(size, align);
+	if (!mem)
+		return 0;
+
+	if (sev_active()) {
+		if (early_set_memory_decrypted(mem, size))
+			goto e_free;
+	}
+
+	return mem;
+e_free:
+	memblock_free(mem, size);
+	return 0;
+}
+
+static void __init kvm_memblock_free(phys_addr_t addr, phys_addr_t size)
+{
+	if (sev_active())
+		early_set_memory_encrypted(addr, size);
+
+	memblock_free(addr, size);
+}
+
 void __init kvmclock_init(void)
 {
 	struct pvclock_vcpu_time_info *vcpu_time;
-	unsigned long mem;
-	int size, cpu;
+	unsigned long mem, mem_wall_clock;
+	int size, cpu, wall_clock_size;
 	u8 flags;
 
 	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
@@ -270,15 +302,29 @@ void __init kvmclock_init(void)
 	printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
-	mem = memblock_alloc(size, PAGE_SIZE);
-	if (!mem)
+	wall_clock_size = PAGE_ALIGN(sizeof(struct pvclock_wall_clock));
+	mem_wall_clock = kvm_memblock_alloc(wall_clock_size, PAGE_SIZE);
+	if (!mem_wall_clock)
 		return;
+
+	wall_clock = __va(mem_wall_clock);
+	memset(wall_clock, 0, wall_clock_size);
+
+	mem = kvm_memblock_alloc(size, PAGE_SIZE);
+	if (!mem) {
+		kvm_memblock_free(mem_wall_clock, wall_clock_size);
+		wall_clock = NULL;
+		return;
+	}
+
 	hv_clock = __va(mem);
 	memset(hv_clock, 0, size);
 
 	if (kvm_register_clock("primary cpu clock")) {
 		hv_clock = NULL;
-		memblock_free(mem, size);
+		kvm_memblock_free(mem, size);
+		kvm_memblock_free(mem_wall_clock, wall_clock_size);
+		wall_clock = NULL;
 		return;
 	}
 
-- 
2.9.4
