Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4828CB70F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 20:02:02 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Fix CONFIG_KVM_GUEST && !CONFIG_KVM case
Date: Mon, 30 Aug 2010 12:01:56 +0200
Message-Id: <1283162516-29879-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_KVM_GUEST is selected, but CONFIG_KVM is not, we were missing
some defines in asm-offsets.c and included too many headers at other places.

This patch makes above configuration work.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/asm-offsets.c |    6 +++---
 arch/powerpc/kernel/kvm.c         |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 5e54d0f..893ba35 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -48,11 +48,11 @@
 #ifdef CONFIG_PPC_ISERIES
 #include <asm/iseries/alpaca.h>
 #endif
-#ifdef CONFIG_KVM
+#if defined(CONFIG_KVM) || defined(CONFIG_KVM_GUEST)
 #include <linux/kvm_host.h>
-#ifndef CONFIG_BOOKE
-#include <asm/kvm_book3s.h>
 #endif
+#if defined(CONFIG_KVM) && defined(CONFIG_PPC_BOOK3S)
+#include <asm/kvm_book3s.h>
 #endif
 
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 293765a..428d0e5 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -25,7 +25,6 @@
 #include <linux/of.h>
 
 #include <asm/reg.h>
-#include <asm/kvm_ppc.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/disassemble.h>
-- 
1.6.0.2
