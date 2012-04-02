Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1F7D1B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 13:36:02 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q323ZuFG012028
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Apr 2012 22:35:58 -0500
Message-ID: <1333337753.30734.28.camel@pasglop>
Subject: powerpc/kvm: Fallout from system.h disintegration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 02 Apr 2012 13:35:53 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a missing include to fix build

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kvm/book3s_emulate.c        |    1 +
 arch/powerpc/kvm/book3s_paired_singles.c |    1 +
 arch/powerpc/kvm/book3s_pr.c             |    1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index f1950d1..135663a 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -21,6 +21,7 @@
 #include <asm/disassemble.h>
 #include <asm/kvm_book3s.h>
 #include <asm/reg.h>
+#include <asm/switch_to.h>
 
 #define OP_19_XOP_RFID		18
 #define OP_19_XOP_RFI		50
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index e70ef2d..a59a25a 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -24,6 +24,7 @@
 #include <asm/kvm_fpu.h>
 #include <asm/reg.h>
 #include <asm/cacheflush.h>
+#include <asm/switch_to.h>
 #include <linux/vmalloc.h>
 
 /* #define DEBUG */
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 7340e10..642d885 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -33,6 +33,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/mmu_context.h>
+#include <asm/switch_to.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
-- 
1.7.9.5
