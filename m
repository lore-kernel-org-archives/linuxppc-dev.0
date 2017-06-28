Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyTfv2Zp0zDr48
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:04:39 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id d5so9779553pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 10:04:39 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v5 2/7] powerpc/vmlinux.lds: Align __init_begin to 16M
Date: Thu, 29 Jun 2017 03:04:06 +1000
Message-Id: <20170628170411.28864-3-bsingharora@gmail.com>
In-Reply-To: <20170628170411.28864-1-bsingharora@gmail.com>
References: <20170628170411.28864-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For CONFIG_STRICT_KERNEL_RWX align __init_begin to 16M.
We use 16M since its the larger of 2M on radix and 16M
on hash for our linear mapping. The plan is to have
.text, .rodata and everything upto __init_begin marked
as RX. Note we still have executable read only data.
We could further align rodata to another 16M boundary.
I've used keeping text plus rodata as read-only-executable
as a trade-off to doing read-only-executable for text and
read-only for rodata.

We don't use multi PT_LOAD in PHDRS because we are
not sure if all bootloaders support them. This patch keeps
PHDRS in vmlinux.lds.S as the same they are with just one
PT_LOAD for all of the kernel marked as RWX (7).

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index ace6b65..b1a2505 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -8,6 +8,12 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+#define STRICT_ALIGN_SIZE	(1 << 24)
+#else
+#define STRICT_ALIGN_SIZE	PAGE_SIZE
+#endif
+
 ENTRY(_stext)
 
 PHDRS {
@@ -123,7 +129,7 @@ SECTIONS
 	PROVIDE32 (etext = .);
 
 	/* Read-only data */
-	RODATA
+	RO_DATA(PAGE_SIZE)
 
 	EXCEPTION_TABLE(0)
 
@@ -140,7 +146,7 @@ SECTIONS
 /*
  * Init sections discarded at runtime
  */
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(STRICT_ALIGN_SIZE);
 	__init_begin = .;
 	INIT_TEXT_SECTION(PAGE_SIZE) :kernel
 
-- 
2.9.4
