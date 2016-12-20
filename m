Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjRgD4z8FzDwRV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 16:49:12 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	sjitindarsingh@gmail.com
Cc: benh@kernel.crashing.org, thuth@redhat.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2 11/11] powerpc/kvm: Advertise availablity of HPT resizing on
 KVM HV
Date: Tue, 20 Dec 2016 16:49:07 +1100
Message-Id: <20161220054907.9204-12-david@gibson.dropbear.id.au>
In-Reply-To: <20161220054907.9204-1-david@gibson.dropbear.id.au>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This updates the KVM_CAP_SPAPR_RESIZE_HPT capability to advertise the
presence of in-kernel HPT resizing on KVM HV.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/powerpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index efd1183..1f32235 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -605,6 +605,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SPAPR_MULTITCE:
 		r = 1;
 		break;
+	case KVM_CAP_SPAPR_RESIZE_HPT:
+		r = !!hv_enabled;
+		break;
 #endif
 	case KVM_CAP_PPC_HTM:
 		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
-- 
2.9.3
