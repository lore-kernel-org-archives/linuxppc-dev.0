Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ4Cs0M5RzDvZ2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 21:59:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Define ILLEGAL_POINTER_VALUE for 64-bit
Date: Tue, 15 Nov 2016 21:59:38 +1100
Message-Id: <1479207578-8762-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is used in poison.h to offset poison values so that they don't
point directly into user space.

The value we choose sits roughly between user and kernel space, which
means on their own the poison values don't point anywhere useful. If an
attacker can cause an access at some offset from the poison value then
we may still be in trouble, but by putting the poison values between
user and kernel space we maximise the required size of that offset.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65fba4c34cd7..87705c113452 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -548,6 +548,13 @@ config ARCH_SPARSEMEM_DEFAULT
 config SYS_SUPPORTS_HUGETLBFS
 	bool
 
+config ILLEGAL_POINTER_VALUE
+	hex
+	# This is roughly half way between the top of user space and the bottom
+	# of kernel space, which seems about as good as we can get.
+	default 0x5deadbeef0000000 if PPC64
+	default 0
+
 source "mm/Kconfig"
 
 config ARCH_MEMORY_PROBE
-- 
2.7.4
