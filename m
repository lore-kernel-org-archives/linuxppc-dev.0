Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4pWG5RpjzDqRF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:04:26 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>, rtd@a-eon.com,
 Pat Wall <pjwall@mac.com>, aperez@alexperez.com
Date: Fri, 20 Jan 2017 17:46:13 +0000 (GMT)
Message-ID: <49760dd82b0.759fd78a@auth.smtp.1and1.co.uk>
Subject: [PATCH] powerpc/pasemi/nemo: Fix low memory values for boot.
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5c0484e25ec0 ('powerpc: Endian safe trampoline') added a
macro 'FIXUP_ENDIAN' to head_64.S. The CFE on Nemo has a bug 
that shows up when this is included, the system hangs right after
printing the initial memory map, before the CPU's are started.

Clearing the long long at addr 8 has been shown to fix this, so
add an initalisation to head_64.S so the system will boot.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1dc5eae..032b317 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -79,6 +79,13 @@ _GLOBAL(__start)
    /* NOP this out unconditionally */
 BEGIN_FTR_SECTION
    FIXUP_ENDIAN
+#ifdef CONFIG_PPC_PASEMI_NEMO
+   /*
+    * Zero address 8 so Nemo will boot
+    */
+   li  r0,0
+   std 0,8(0)
+#endif
    b   __start_initialization_multiplatform
 END_FTR_SECTION(0, 1)
 
