Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41b9TP1LMgzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 19:50:47 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel RFC 0/3] powerpc/pseries/iommu: GPU coherent memory
 pass through
Date: Wed, 25 Jul 2018 19:50:29 +1000
Message-Id: <20180725095032.2196-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I am trying to pass through a 3D controller:
[0302]: NVIDIA Corporation GV100GL [Tesla V100 SXM2] [10de:1db1] (rev a1)

which has a quite unique feature as coherent memory directly accessible
from a POWER9 CPU via an NVLink2 transport.

So in addition to passing a PCI device + accompanying NPU devices,
we will also be passing the host physical address range as it is done
on the bare metal system.

The memory on the host is presented as:

===
[aik@yc02goos ~]$ lsprop /proc/device-tree/memory@42000000000
ibm,chip-id      000000fe (254)
device_type      "memory"
compatible       "ibm,coherent-device-memory"
reg              00000420 00000000 00000020 00000000
linux,usable-memory
                 00000420 00000000 00000000 00000000
phandle          00000726 (1830)
name             "memory"
ibm,associativity
                 00000004 000000fe 000000fe 000000fe 000000fe
===

and the host does not touch it as the second 64bit value of
"linux,usable-memory" - the size - is null. Later on the NVIDIA driver
trains the NVLink2 and probes this memory and this is how it becomes
onlined.

In the virtual environment I am planning on doing the same thing,
however there is a difference in 64bit DMA handling. The powernv
platform uses a PHB3 bypass mode and that just works but
the pseries platform uses DDW RTAS API to achieve the same
result and the problem with this is that we need a huge DMA
window to start from zero (because this GPU supports less than
50bits for DMA address space) and cover not just present memory
but also this new coherent memory.


This is based on sha1
d72e90f3 Linus Torvalds "Linux 4.18-rc6".

Please comment. Thanks.



Alexey Kardashevskiy (3):
  powerpc/pseries/iommu: Allow dynamic window to start from zero
  powerpc/pseries/iommu: Force default DMA window removal
  powerpc/pseries/iommu: Use memory@ nodes in max RAM address
    calculation

 arch/powerpc/platforms/pseries/iommu.c | 77 ++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

-- 
2.11.0
