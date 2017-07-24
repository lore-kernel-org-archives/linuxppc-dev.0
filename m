Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0086.outbound.protection.outlook.com [104.47.32.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGW9f4RsTzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:08:21 +1000 (AEST)
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
Subject: [RFC Part1 PATCH v3 00/17] x86: Secure Encrypted Virtualization (AMD)
Date: Mon, 24 Jul 2017 14:07:40 -0500
Message-Id: <20170724190757.11278-1-brijesh.singh@amd.com>
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

This part of Secure Encrypted Virtualization (SEV) series focuses on the
changes required in a guest OS for SEV support.

When SEV is active, the memory content of guest OS will be transparently encrypted
with a key unique to the guest VM.

SEV guests have concept of private and shared memory. Private memory is encrypted
with the guest-specific key, while shared memory may be encrypted with hypervisor
key. Certain type of memory (namely insruction pages and guest page tables) are
always treated as private. Due to security reasons all DMA operations inside the
guest must be performed on shared memory.

The SEV feature is enabled by the hypervisor, and guest can identify it through
CPUID function and the 0xc0010131 (F17H_SEV) MSR. When enabled, page table entries
will determine how memory is accessed. If a page table entry has the memory
encryption mask set, then that memory will be accessed using guest-specific key.
Certain memory (instruction pages, page tables) will always be accessed using
guest-specific key.

This patch series builds upon the Secure Memory Encryption (SME) feature. Unlike
SME, when SEV is enabled, all the data (e.g EFI, kernel, initrd, etc) will have
been placed into memory as encrypted by the guest BIOS.

The approach that this patch series takes is to encrypt everything possible
starting early in the boot. Since the DMA operations inside guest must be
performed on shared memory hence it uses SW-IOTLB to complete the DMA operations.

The following links provide additional details:

AMD Memory Encryption whitepaper:
http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf

AMD64 Architecture Programmer's Manual:
    http://support.amd.com/TechDocs/24593.pdf
    SME is section 7.10
    SEV is section 15.34

Secure Encrypted Virutualization Key Management:
http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf

KVM Forum Presentation:
http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf

SEV Guest BIOS support:
  SEV support has been accepted into EDKII/OVMF BIOS
  https://github.com/tianocore/edk2/commits/master

---
This RFC is based on tip/master commit : 22db3de (Merge branch 'x86/mm').
Complete git tree is available: https://github.com/codomania/tip/tree/sev-rfc-3

Changes since v2:
 * add documentation
 * update early_set_memory_* to use kernel_physical_mapping_init()
   to split larger page into smaller (recommended by Boris)
 * changes to address v2 feedback

Brijesh Singh (4):
  Documentation/x86: Add AMD Secure Encrypted Virtualization (SEV)
    descrption
  x86: Add support for changing memory encryption attribute in early
    boot
  X86/KVM: Provide support to create Guest and HV shared per-CPU
    variables
  X86/KVM: Clear encryption attribute when SEV is active

Tom Lendacky (13):
  x86/CPU/AMD: Add the Secure Encrypted Virtualization CPU feature
  x86/mm: Secure Encrypted Virtualization (SEV) support
  x86/mm: Don't attempt to encrypt initrd under SEV
  x86, realmode: Don't decrypt trampoline area under SEV
  x86/mm: Use encrypted access of boot related data with SEV
  x86/mm: Include SEV for encryption memory attribute changes
  x86/efi: Access EFI data as encrypted when SEV is active
  resource: Consolidate resource walking code
  resource: Provide resource struct in resource walk callback
  x86/mm, resource: Use PAGE_KERNEL protection for ioremap of memory
    pages
  x86/mm: DMA support for SEV memory encryption
  x86/io: Unroll string I/O when SEV is active
  x86/boot: Add early boot support when running with SEV active

 Documentation/x86/amd-memory-encryption.txt |  29 +++-
 arch/powerpc/kernel/machine_kexec_file_64.c |  12 +-
 arch/x86/boot/compressed/Makefile           |   2 +
 arch/x86/boot/compressed/head_64.S          |  16 ++
 arch/x86/boot/compressed/mem_encrypt.S      | 103 ++++++++++++
 arch/x86/boot/compressed/misc.h             |   2 +
 arch/x86/boot/compressed/pagetable.c        |   8 +-
 arch/x86/entry/vdso/vma.c                   |   5 +-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/io.h                   |  26 ++-
 arch/x86/include/asm/mem_encrypt.h          |  22 +++
 arch/x86/include/asm/msr-index.h            |   5 +
 arch/x86/include/uapi/asm/kvm_para.h        |   1 -
 arch/x86/kernel/cpu/amd.c                   |  30 +++-
 arch/x86/kernel/cpu/scattered.c             |   1 +
 arch/x86/kernel/crash.c                     |  18 +-
 arch/x86/kernel/kvm.c                       |  46 +++++-
 arch/x86/kernel/kvmclock.c                  |  64 ++++++-
 arch/x86/kernel/pmem.c                      |   2 +-
 arch/x86/kernel/setup.c                     |   6 +-
 arch/x86/mm/ioremap.c                       |  72 ++++++--
 arch/x86/mm/mem_encrypt.c                   | 248 +++++++++++++++++++++++++++-
 arch/x86/mm/pageattr.c                      |   4 +-
 arch/x86/platform/efi/efi_64.c              |  15 +-
 arch/x86/realmode/init.c                    |   6 +-
 include/asm-generic/vmlinux.lds.h           |   3 +
 include/linux/ioport.h                      |   7 +-
 include/linux/kexec.h                       |   2 +-
 include/linux/mem_encrypt.h                 |   8 +-
 include/linux/percpu-defs.h                 |  12 ++
 kernel/kexec_file.c                         |   5 +-
 kernel/resource.c                           |  75 +++++----
 lib/swiotlb.c                               |   5 +-
 33 files changed, 755 insertions(+), 106 deletions(-)
 create mode 100644 arch/x86/boot/compressed/mem_encrypt.S

-- 
2.9.4
