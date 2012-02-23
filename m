Return-Path: <B13201@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04F0BB6FAC
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2012 20:27:51 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v6 2/4] KVM: PPC: epapr: Add idle hcall support for host
Date: Thu, 23 Feb 2012 17:22:20 +0800
Message-ID: <1329988942-19610-2-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329988942-19610-1-git-send-email-yu.liu@freescale.com>
References: <1329988942-19610-1-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Liu Yu <yu.liu@freescale.com>,
 B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And add a new flag definition in kvm_ppc_pvinfo to indicate
whether host support EV_IDLE hcall.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
v6: no change

 arch/powerpc/include/asm/Kbuild     |    1 +
 arch/powerpc/include/asm/kvm_para.h |   14 ++++++++++++--
 arch/powerpc/kvm/powerpc.c          |    6 ++++++
 include/linux/kvm.h                 |    2 ++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 7e313f1..13d6b7b 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -34,5 +34,6 @@ header-y += termios.h
 header-y += types.h
 header-y += ucontext.h
 header-y += unistd.h
+header-y += epapr_hcalls.h
 
 generic-y += rwsem.h
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 7b754e7..81a34c9 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -75,9 +75,19 @@ struct kvm_vcpu_arch_shared {
 };
 
 #define KVM_SC_MAGIC_R0		0x4b564d21 /* "KVM!" */
-#define HC_VENDOR_KVM		(42 << 16)
+
+#include <asm/epapr_hcalls.h>
+
+/* ePAPR Hypercall Vendor ID */
+#define HC_VENDOR_EPAPR		(EV_EPAPR_VENDOR_ID << 16)
+#define HC_VENDOR_KVM		(EV_KVM_VENDOR_ID << 16)
+
+/* ePAPR Hypercall Token */
+#define HC_EV_IDLE		EV_IDLE
+
+/* ePAPR Hypercall Return Codes */
 #define HC_EV_SUCCESS		0
-#define HC_EV_UNIMPLEMENTED	12
+#define HC_EV_UNIMPLEMENTED	EV_UNIMPLEMENTED
 
 #define KVM_FEATURE_MAGIC_PAGE	1
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 0e21d15..7098840 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -81,6 +81,10 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 
 		/* Second return value is in r4 */
 		break;
+	case HC_VENDOR_EPAPR | HC_EV_IDLE:
+		r = HC_EV_SUCCESS;
+		kvm_vcpu_block(vcpu);
+		break;
 	default:
 		r = HC_EV_UNIMPLEMENTED;
 		break;
@@ -746,6 +750,8 @@ static int kvm_vm_ioctl_get_pvinfo(struct kvm_ppc_pvinfo *pvinfo)
 	pvinfo->hcall[2] = inst_sc;
 	pvinfo->hcall[3] = inst_nop;
 
+	pvinfo->flags = KVM_PPC_PVINFO_FLAGS_EV_IDLE;
+
 	return 0;
 }
 
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index acbe429..6b2c70e 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -449,6 +449,8 @@ struct kvm_ppc_pvinfo {
 	__u8  pad[108];
 };
 
+#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
+
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
-- 
1.7.0.4
