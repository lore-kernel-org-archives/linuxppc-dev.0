Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDF511A1684
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 11:54:14 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: mpe@ellerman.id.au,
	paulus@samba.org
Cc: benh@redhat.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] vfio: Enable VFIO device for powerpc
Date: Mon, 21 Dec 2015 11:54:57 +1100
Message-Id: <1450659297-28993-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ec53500f "kvm: Add VFIO device" added a special KVM pseudo-device which is
used to handle any necessary interactions between KVM and VFIO.

Currently that device is built on x86 and ARM, but not powerpc, although
powerpc does support both KVM and VFIO.  This makes things awkward in
userspace

Currently qemu prints an alarming error message if you attempt to use VFIO
and it can't initialize the KVM VFIO device.  We don't want to remove the
warning, because lack of the KVM VFIO device could mean coherency problems
on x86.  On powerpc, however, the error is harmless but looks disturbing,
and a test based on host architecture in qemu would be ugly, and break if
we do need the KVM VFIO device for something important in future.

There's nothing preventing the KVM VFIO device from being built for
powerpc, so this patch turns it on.  It won't actually do anything, since
we don't define any of the arch_*() hooks, but it will make qemu happy and
we can extend it in future if we need to.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
---
 arch/powerpc/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

[RESEND?] I thought I sent this out some time ago.  Not sure if I
forgot, or if it fell through the cracks somewhere else.  In any case,
please apply.

diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 0570eef..7f7b6d8 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -8,7 +8,7 @@ ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
 KVM := ../../../virt/kvm
 
 common-objs-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
-		$(KVM)/eventfd.o
+		$(KVM)/eventfd.o $(KVM)/vfio.o
 
 CFLAGS_e500_mmu.o := -I.
 CFLAGS_e500_mmu_host.o := -I.
-- 
2.5.0
