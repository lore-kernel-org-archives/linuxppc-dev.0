Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 54C06B7174
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 30/35] KVM: PPC: Expose level based interrupt cap
Date: Tue, 31 Aug 2010 04:32:11 +0200
Message-Id: <1283221937-21006-31-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have all the level interrupt magic in place, let's
expose the capability to user space, so it can make use of it!

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/powerpc.c |    1 +
 include/linux/kvm.h        |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 028891c..2f87a16 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -192,6 +192,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_PPC_SEGSTATE:
 	case KVM_CAP_PPC_PAIRED_SINGLES:
 	case KVM_CAP_PPC_UNSET_IRQ:
+	case KVM_CAP_PPC_IRQ_LEVEL:
 	case KVM_CAP_ENABLE_CAP:
 	case KVM_CAP_PPC_OSI:
 	case KVM_CAP_PPC_GET_PVINFO:
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 3707704..919ae53 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -539,6 +539,7 @@ struct kvm_ppc_pvinfo {
 #define KVM_CAP_XCRS 56
 #endif
 #define KVM_CAP_PPC_GET_PVINFO 57
+#define KVM_CAP_PPC_IRQ_LEVEL 58
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.6.0.2
