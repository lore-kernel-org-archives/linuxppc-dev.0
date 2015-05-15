Return-Path: <alex.bennee@linaro.org>
Received: from socrates.bennee.com
 (static.88-198-71-155.clients.your-server.de [88.198.71.155])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86E911A0A84
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 00:27:33 +1000 (AEST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, christoffer.dall@linaro.org,
 marc.zyngier@arm.com, peter.maydell@linaro.org, agraf@suse.de,
 drjones@redhat.com, pbonzini@redhat.com, zhichao.huang@linaro.org
Subject: [PATCH v4 02/12] KVM: define common KVM_GUESTDBG_USE_SW/HW_BP bits
Date: Fri, 15 May 2015 15:27:05 +0100
Message-Id: <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
In-Reply-To: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "open list:S390" <linux-s390@vger.kernel.org>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Nadav Amit <namit@cs.technion.ac.il>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, jan.kiszka@siemens.com,
 Mihai Caraman <mihai.caraman@freescale.com>, bp@suse.de,
 Gleb Natapov <gleb@kernel.org>, r65777@freescale.com,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Farman <farman@linux.vnet.ibm.com>,
 "open list:ABI/API" <linux-api@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>, dahi@linux.vnet.ibm.com,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "supporter:S390" <linux390@de.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently x86, powerpc and soon arm64 use the same two architecture
specific bits for guest debug support for software and hardware
breakpoints. This makes the shared values explicit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>

-
v4
  - claim more bits for the common functionality
v5
  - don't use __ mechanism to move values common

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index ab4d473..6ea24a5 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -307,11 +307,9 @@ struct kvm_guest_debug_arch {
 /* Debug related defines */
 /*
  * kvm_guest_debug->control is a 32 bit field. The lower 16 bits are generic
- * and upper 16 bits are architecture specific. Architecture specific defines
+ * and upper 14 bits are architecture specific. Architecture specific defines
  * that ioctl is for setting hardware breakpoint or software breakpoint.
  */
-#define KVM_GUESTDBG_USE_SW_BP		0x00010000
-#define KVM_GUESTDBG_USE_HW_BP		0x00020000
 
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index ef1a5fc..aca4f86 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -114,8 +114,6 @@ struct kvm_fpu {
 	__u64 fprs[16];
 };
 
-#define KVM_GUESTDBG_USE_HW_BP		0x00010000
-
 #define KVM_HW_BP			1
 #define KVM_HW_WP_WRITE			2
 #define KVM_SINGLESTEP			4
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index d7dcef5..ca51d4c 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -250,8 +250,6 @@ struct kvm_debug_exit_arch {
 	__u64 dr7;
 };
 
-#define KVM_GUESTDBG_USE_SW_BP		0x00010000
-#define KVM_GUESTDBG_USE_HW_BP		0x00020000
 #define KVM_GUESTDBG_INJECT_DB		0x00040000
 #define KVM_GUESTDBG_INJECT_BP		0x00080000
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 70ac641..7c5dd11 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -570,8 +570,10 @@ struct kvm_s390_irq_state {
 
 /* for KVM_SET_GUEST_DEBUG */
 
-#define KVM_GUESTDBG_ENABLE		0x00000001
-#define KVM_GUESTDBG_SINGLESTEP		0x00000002
+#define KVM_GUESTDBG_ENABLE		(1 << 0)
+#define KVM_GUESTDBG_SINGLESTEP	(1 << 1)
+#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
+#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)
 
 struct kvm_guest_debug {
 	__u32 control;
-- 
2.3.5
