Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 558A8B7177
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 29/35] KVM: PPC: Fix CONFIG_KVM_GUEST && !CONFIG_KVM case
Date: Tue, 31 Aug 2010 04:32:10 +0200
Message-Id: <1283221937-21006-30-git-send-email-agraf@suse.de>
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
index 293d2a8..7f0d6fc 100644
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
