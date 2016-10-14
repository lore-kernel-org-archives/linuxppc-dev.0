Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw8HX1vhWzDt2f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:54:00 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id fn2so4490752pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:54:00 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net
Cc: paulus@samba.org, mpe@ellerman.id.au, sam.bobroff@au1.ibm.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-doc@vger.kernel.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 4/6] powerpc/kvm: Decrease the powerpc default halt poll max
 value
Date: Fri, 14 Oct 2016 11:53:22 +1100
Message-Id: <1476406404-32752-5-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM_HALT_POLL_NS_DEFAULT is an arch specific constant which sets the
default value of the halt_poll_ns kvm module parameter which determines
the global maximum halt polling interval.

The current value for powerpc is 500000 (500us) which means that any
repetitive workload with a period of less than that can drive the cpu
usage to 100% where it may have been mostly idle without halt polling.
This presents the possibility of a large increase in power usage with
a comparatively small performance benefit.

Reduce the default to 10000 (10us) and a user can tune this themselves
to set their affinity for halt polling based on the trade off between power
and performance which they are willing to make.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 28350a2..037b6a1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -48,7 +48,7 @@
 #ifdef CONFIG_KVM_MMIO
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #endif
-#define KVM_HALT_POLL_NS_DEFAULT 500000
+#define KVM_HALT_POLL_NS_DEFAULT 10000	/* 10 us */
 
 /* These values are internal and can be increased later */
 #define KVM_NR_IRQCHIPS          1
-- 
2.5.5
