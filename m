Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C8639B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 15:06:24 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ab02e115992881a734e8e90b7d3f2d8617db4bf2.1249880775.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] powerpc/vmlinux.lds: Move _edata down
Date: Mon, 10 Aug 2009 15:06:24 +1000 (EST)
Cc: catalin.marinas@arm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently _edata does not include several data sections, this causes
the kernel's report of memory usage at boot to not match reality, and
also prevents kmemleak from working - because it scan between _sdata
and _edata for pointers to allocated memory.

This mirrors a similar change made recently to the x86 linker script.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8ef8a14..3bb0997 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -245,10 +245,6 @@ SECTIONS
 	}
 #endif
 
-	. = ALIGN(PAGE_SIZE);
-	_edata  =  .;
-	PROVIDE32 (edata = .);
-
 	/* The initial task and kernel stack */
 #ifdef CONFIG_PPC32
 	. = ALIGN(8192);
@@ -282,6 +278,10 @@ SECTIONS
 		__nosave_end = .;
 	}
 
+	. = ALIGN(PAGE_SIZE);
+	_edata  =  .;
+	PROVIDE32 (edata = .);
+
 /*
  * And finally the bss
  */
-- 
1.6.2.1
