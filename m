Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSjvp3Nn4zDvkS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 23:45:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com,
 stewart@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com
Subject: [PATCH v11 0/8] powerpc: Implement kexec_file_load()
Date: Tue, 29 Nov 2016 23:45:46 +1100
Message-Id: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v11 of the kexec_file_load() for powerpc series.

I've stripped this down to the minimum we need, so we can get this in for 4.10.
Any additions can come later incrementally.

If no one objects I'll merge this via the powerpc tree. The three kexec patches
have been acked by Dave Young (since forever), and have been in linux-next (via
akpm's tree) also for a long time.

cheers


v11 (Michael Ellerman):
 - Strip back purgatory to the minimal trampoline required. This avoids
   complexity in the purgatory environment where all exceptions are fatal.
 - Reorder the series so we don't start advertising the config symbol, or more
   importantly the syscall, until they're actually implemented.


Original cover letter by Thiago:

This patch series implements the kexec_file_load system call on PowerPC.

This system call moves the reading of the kernel, initrd and the device tree
from the userspace kexec tool to the kernel. This is needed if you want to
do one or both of the following:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
   command line and other boot inputs for the Integrity Measurement
   Architecture subsystem.

The above are the functions kexec already has built into kexec_file_load.
Yesterday I posted a set of patches which allows a third feature:

3. have IMA pass-on its event log (where integrity measurements are
   registered) accross kexec to the second kernel, so that the event
   history is preserved.

Because OpenPower uses an intermediary Linux instance as a boot loader
(skiroot), feature 1 is needed to implement secure boot for the platform,
while features 2 and 3 are needed to implement trusted boot.

This patch series starts by removing an x86 assumption from kexec_file:
kexec_add_buffer uses iomem to find reserved memory ranges, but PowerPC
uses the memblock subsystem.  A hook is added so that each arch can
specify how memory ranges can be found.

Also, the memory-walking logic in kexec_add_buffer is useful in this
implementation to find a free area for the purgatory's stack, so the
next patch moves that logic to kexec_locate_mem_hole.

The kexec_file_load system call needs to apply relocations to the
purgatory but adding code for that would duplicate functionality with
the module loading mechanism, which also needs to apply relocations to
the kernel modules.  Therefore, this patch series factors out the module
relocation code so that it can be shared.

One thing that is still missing is crashkernel support, which I intend
to submit shortly. For now, arch_kexec_kernel_image_probe rejects crash
kernels.

This code is based on kexec-tools, but with many modifications to adapt
it to the kernel environment and facilities.
