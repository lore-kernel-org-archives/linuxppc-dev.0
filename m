Return-Path: <david.engraf@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [176.9.12.79])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ102055fzDvhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 19:34:25 +1100 (AEDT)
From: David Engraf <david.engraf@sysgo.com>
To: oss@buserror.net, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] powerpc/85xx/qemu: Enable CONFIG_E500 and CONFIG_PPC_E500MC
Date: Tue, 15 Nov 2016 09:24:27 +0100
Message-Id: <20161115082427.4351-1-david.engraf@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The QEMU e500 board needs to enable CONFIG_E500 to correctly boot. QEMU
for ppc64 uses e5500/e6500 emulation, thus CONFIG_PPC_E500MC is required
as well.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 arch/powerpc/platforms/85xx/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 9dc1d28..47b389d 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -253,6 +253,8 @@ endif # PPC32
 config PPC_QEMU_E500
 	bool "QEMU generic e500 platform"
 	select DEFAULT_UIMAGE
+	select E500
+	select PPC_E500MC if PPC64
 	help
 	  This option enables support for running as a QEMU guest using
 	  QEMU's generic e500 machine.  This is not required if you're
-- 
2.9.3
