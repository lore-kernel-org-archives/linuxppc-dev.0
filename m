Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xQxd1DZZzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 13:00:01 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7O2x4Bf023945
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:59:59 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m265w6s55-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:59:59 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 23 Aug 2018 22:59:58 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 00/11] Secure Virtual Machine Enablement
Date: Thu, 23 Aug 2018 23:59:22 -0300
Message-Id: <20180824025933.24319-1-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series contains preliminary work to enable Secure Virtual Machines
(SVM) on powerpc. SVMs request to be migrated to secure memory very early in
the boot process (in prom_init()), so by default all of their memory is
inaccessible to the hypervisor. There is an ultravisor call that the VM can
use to request certain pages to be made accessible (aka shared).

The objective of these patches is to have the guest perform this request for
buffers that need to be shared with the hypervisor, such as the LPPACAs, the
SWIOTLB buffer and the Debug Trace Log. This work is incomplete: there are
surely other memory regions that need to be made accessible, but I'm posting
it early to get comments on whether the approach being taken is appropriate.

It should be applied on top of the generic virtio DMA API rework series
posted earlier, which adds a platform hook to override any arch based DMA
API operations for any virtio device:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/175994.html

I'm aware that changes need to be made to the patch series above, but IIUC
it depends on upcoming virtio cleanup from Christoph Hellwig so for now the
patch series above will be used as a stepping stone for this series.

This code has been tested with virtio block, net and scsi devices with and
without VIRTIO_F_IOMMU_PLATFORM flag. Please let me know what you think.

For now I am testing on a regular guest with a couple of patches on top
forcing is_svm_platform() to always return true and adding debug messages to
confirm that mem_convert_shared() is being called in the expected places.

These are the commands I'm using to start up the guest:

Without VIRTIO_F_IOMMU_PLATFORM:

qemu-system-ppc64 \
  -enable-kvm \
  -kernel /home/bauermann/src/linux/arch/powerpc/boot/zImage \
  -append "root=PARTUUID=e550ad6f-05 ro" \
  -machine pseries-2.6 \
  -m 8G \
  -smp 2 \
  -serial mon:stdio \
  -nographic \
  -nodefaults \
  -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4 \
  -drive file=/home/bauermann/VMs/svm.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 \
  -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0 \
  -drive file=/home/bauermann/VMs/svm-blk.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
  -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0 \
  -device virtio-net,netdev=hostnet0,id=net0,mac=52:54:00:96:70:1f \
  -netdev user,id=hostnet0 \
  -set netdev.hostnet0.hostfwd=tcp::42022-:22

With VIRTIO_F_IOMMU_PLATFORM. Same as above plus some -global options so
that the virtio devices use the modern interface rather than the
transitional one:

qemu-system-ppc64 \
  -enable-kvm \
  -kernel /home/bauermann/src/linux/arch/powerpc/boot/zImage \
  -append "root=PARTUUID=e550ad6f-05 ro" \
  -machine pseries-2.6 \
  -m 8G \
  -smp 2 \
  -serial mon:stdio \
  -nographic \
  -nodefaults \
  -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4 \
  -drive file=/home/bauermann/VMs/svm.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 \
  -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0 \
  -drive file=/home/bauermann/VMs/svm-blk.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
  -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0 \
  -device virtio-net,netdev=hostnet0,id=net0,mac=52:54:00:96:70:1f \
  -netdev user,id=hostnet0 \
  -set netdev.hostnet0.hostfwd=tcp::42022-:22 \
  -global virtio-blk-pci.iommu_platform=true \
  -global virtio-blk-pci.disable-legacy=on \
  -global virtio-blk-pci.disable-modern=off \
  -global virtio-net-pci.iommu_platform=true \
  -global virtio-net-pci.disable-legacy=on \
  -global virtio-net-pci.disable-modern=off \
  -global virtio-scsi-pci.iommu_platform=true \
  -global virtio-scsi-pci.disable-legacy=on \
  -global virtio-scsi-pci.disable-modern=off

The code was tested with a couple of other permutations where one virtio
device has the flag VIRTIO_F_IOMMU_PLATFORM and others don't. Please suggest
some other scenarios which need to be tested as well.

Anshuman Khandual (10):
  powerpc/svm: Detect Secure Virtual Machine (SVM) platform
  powerpc/svm: Select CONFIG_DMA_DIRECT_OPS and CONFIG_SWIOTLB
  powerpc/svm: Add memory conversion (shared/secure) helper functions
  powerpc/svm: Convert SWIOTLB buffers to shared memory
  powerpc/svm: Don't release SWIOTLB buffers on secure guests
  powerpc/svm: Use SWIOTLB DMA API for all virtio devices
  powerpc/svm: Use shared memory for Debug Trace Log (DTL)
  powerpc/svm: Use shared memory for LPPACA structures
  powerpc/svm: Force the use of bounce buffers
  powerpc/svm: Increase SWIOTLB buffer size

Thiago Jung Bauermann (1):
  powerpc: Add and use LPPACA_SIZE constant

 arch/powerpc/Kconfig                   | 22 ++++++++
 arch/powerpc/include/asm/mem_encrypt.h | 19 +++++++
 arch/powerpc/include/asm/reg.h         |  3 ++
 arch/powerpc/include/asm/svm.h         | 26 +++++++++
 arch/powerpc/kernel/Makefile           |  1 +
 arch/powerpc/kernel/paca.c             | 41 ++++++++++++--
 arch/powerpc/kernel/svm.c              | 99 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/iommu.c |  6 ++-
 arch/powerpc/platforms/pseries/setup.c |  5 +-
 kernel/dma/swiotlb.c                   |  5 ++
 10 files changed, 221 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mem_encrypt.h
 create mode 100644 arch/powerpc/include/asm/svm.h
 create mode 100644 arch/powerpc/kernel/svm.c
