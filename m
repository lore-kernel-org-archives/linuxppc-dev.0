Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D000B7C3B
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:40 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 24/27] Include Book3s_64 target in buildsystem
Date: Fri, 30 Oct 2009 16:47:24 +0100
Message-Id: <1256917647-6200-25-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we have everything in place to be able to build KVM, so let's add it
as config option and in the Makefile.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/Kconfig  |   17 +++++++++++++++++
 arch/powerpc/kvm/Makefile |   27 +++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index c299268..07703f7 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -21,6 +21,23 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
 
+config KVM_BOOK3S_64_HANDLER
+	bool
+
+config KVM_BOOK3S_64
+	tristate "KVM support for PowerPC book3s_64 processors"
+	depends on EXPERIMENTAL && PPC64
+	select KVM
+	select KVM_BOOK3S_64_HANDLER
+	---help---
+	  Support running unmodified book3s_64 and book3s_32 guest kernels
+	  in virtual machines on book3s_64 host processors.
+
+	  This module provides access to the hardware capabilities through
+	  a character device node named /dev/kvm.
+
+	  If unsure, say N.
+
 config KVM_440
 	bool "KVM support for PowerPC 440 processors"
 	depends on EXPERIMENTAL && 44x
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 37655fe..56484d6 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -12,26 +12,45 @@ CFLAGS_44x_tlb.o  := -I.
 CFLAGS_e500_tlb.o := -I.
 CFLAGS_emulate.o  := -I.
 
-kvm-objs := $(common-objs-y) powerpc.o emulate.o
+common-objs-y += powerpc.o emulate.o
 obj-$(CONFIG_KVM_EXIT_TIMING) += timing.o
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM_BOOK3S_64_HANDLER) += book3s_64_exports.o
 
 AFLAGS_booke_interrupts.o := -I$(obj)
 
 kvm-440-objs := \
+	$(common-objs-y) \
 	booke.o \
 	booke_emulate.o \
 	booke_interrupts.o \
 	44x.o \
 	44x_tlb.o \
 	44x_emulate.o
-obj-$(CONFIG_KVM_440) += kvm-440.o
+kvm-objs-$(CONFIG_KVM_440) := $(kvm-440-objs)
 
 kvm-e500-objs := \
+	$(common-objs-y) \
 	booke.o \
 	booke_emulate.o \
 	booke_interrupts.o \
 	e500.o \
 	e500_tlb.o \
 	e500_emulate.o
-obj-$(CONFIG_KVM_E500) += kvm-e500.o
+kvm-objs-$(CONFIG_KVM_E500) := $(kvm-e500-objs)
+
+kvm-book3s_64-objs := \
+	$(common-objs-y) \
+	book3s.o \
+	book3s_64_emulate.o \
+	book3s_64_interrupts.o \
+	book3s_64_mmu_host.o \
+	book3s_64_mmu.o \
+	book3s_32_mmu.o
+kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-objs)
+
+kvm-objs := $(kvm-objs-m) $(kvm-objs-y)
+
+obj-$(CONFIG_KVM_440) += kvm.o
+obj-$(CONFIG_KVM_E500) += kvm.o
+obj-$(CONFIG_KVM_BOOK3S_64) += kvm.o
+
-- 
1.6.0.2
