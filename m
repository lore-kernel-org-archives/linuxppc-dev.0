Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfN6X4QWJzDt2L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 16:58:44 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 00/11] KVM implementation of PAPR HPT resizing extension
Date: Thu, 15 Dec 2016 16:53:53 +1100
Message-Id: <20161215055404.29351-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is the KVM implementation for the proposed PAPR extension which
allows the runtime resizing of a PAPR guest's Hashed Page Table (HPT).

Using this requires a guest kernel with support for the extension.
Patches for guest side support in Linux were posted earlier:
  https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-December/152164.html

It also requires userspace (i.e. qemu) to intercept the HPT resizing
hypercalls and invoke the KVM ioctl()s to implement them.  This is
done instead of having KVM direclty intercept the hypercalls, so that
userspace can, if useful, impose additional restrictions on resizes:
for example it could refuse them entirely if policy for the VM
precludes resizing, or it could limit the size of HPT the guest can
request to meet resource limits.

Patches to implement the userspace part of HPT resizing are proposed
for qemu-2.9, and can be found at:
  https://github.com/dgibson/qemu/tree/upstream/hpt-resize

I'm posting these now, in the hopes that both these and the
corresponding guest side patches can be staged and merged for the 4.11
window.

David Gibson (11):
  powerpc/kvm: Reserve capabilities and ioctls for HPT resizing
  powerpc/kvm: Rename kvm_alloc_hpt() for clarity
  powerpc/kvm: Gather HPT related variables into sub-structure
  powerpc/kvm: Don't store values derivable from HPT order
  powerpc/kvm: Split HPT allocation from activation
  powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to change HPT size
  powerpc/kvm: Create kvmppc_unmap_hpte_helper()
  powerpc/kvm: KVM-HV HPT resizing stub implementation
  powerpc/kvm: Outline of KVM-HV HPT resizing implementation
  powerpc/kvm: KVM-HV HPT resizing implementation
  powerpc/kvm: Advertise availablity of HPT resizing on KVM HV

 arch/powerpc/include/asm/kvm_book3s_64.h |  15 +
 arch/powerpc/include/asm/kvm_host.h      |  17 +-
 arch/powerpc/include/asm/kvm_ppc.h       |  15 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 629 +++++++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv.c             |  50 ++-
 arch/powerpc/kvm/book3s_hv_builtin.c     |   8 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  62 +--
 arch/powerpc/kvm/powerpc.c               |   6 +
 include/uapi/linux/kvm.h                 |  10 +
 9 files changed, 637 insertions(+), 175 deletions(-)

-- 
2.9.3
