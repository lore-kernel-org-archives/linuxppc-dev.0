Return-Path: <yang.shi@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2EB30B712D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 12:56:00 +1000 (EST)
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B52F1DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 12:55:58 +1000 (EST)
From: Yang Shi <yang.shi@windriver.com>
To: yu.liu@freescale.com, hollisb@us.ibm.com, avi@redhat.com
Subject: [PATCH 2/2] KVM/PPC: Fix kvm_main.c build error for PPC KVM
Date: Thu,  2 Jul 2009 10:55:30 +0800
Message-Id: <a3371dff010b57f832d47de0c15f4eb965041628.1246502441.git.yang.shi@windriver.com>
In-Reply-To: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
References: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
In-Reply-To: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
References: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the latest kernel building KVM for PPC, got integer overflow
error in kvm_main.c file. The root cause is that compiler consider
KVM_PAGES_PER_HPAGE as signed long type, however it should be
unsigned long type.

So, change it to unsigned long type in include/asm/kvm_host.h

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/powerpc/include/asm/kvm_host.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index dfdf13c..fddc3ed 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -34,7 +34,7 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
 /* We don't currently support large pages. */
-#define KVM_PAGES_PER_HPAGE (1<<31)
+#define KVM_PAGES_PER_HPAGE (1UL << 31)
 
 struct kvm;
 struct kvm_run;
-- 
1.6.0.4
