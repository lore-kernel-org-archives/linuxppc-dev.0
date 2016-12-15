Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfN6b00GlzDvk5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 16:58:47 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 11/11] powerpc/kvm: Advertise availablity of HPT resizing on
 KVM HV
Date: Thu, 15 Dec 2016 16:54:04 +1100
Message-Id: <20161215055404.29351-12-david@gibson.dropbear.id.au>
In-Reply-To: <20161215055404.29351-1-david@gibson.dropbear.id.au>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This updates the KVM_CAP_SPAPR_RESIZE_HPT capability to advertise the
presence of in-kernel HPT resizing on KVM HV.  In fact the HPT resizing
isn't fully implemented, but this allows us to experiment with what's
there.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/powerpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index bb23923..965d26b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -606,7 +606,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 	case KVM_CAP_SPAPR_RESIZE_HPT:
-		r = 1; /* resize allowed only if HPT is outside kernel */
+		if (hv_enabled)
+			r = 2; /* In-kernel resize implementation */
+		else
+			r = 1; /* outside kernel resize allowed */
 		break;
 #endif
 	case KVM_CAP_PPC_HTM:
-- 
2.9.3
