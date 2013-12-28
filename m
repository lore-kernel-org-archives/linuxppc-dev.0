Return-Path: <olof@lixom.net>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 139902C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Dec 2013 08:00:53 +1100 (EST)
Received: by mail-pd0-f177.google.com with SMTP id q10so10033659pdj.22
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 13:00:50 -0800 (PST)
From: Olof Johansson <olof@lixom.net>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix alignment of secondary cpu spin vars
Date: Sat, 28 Dec 2013 13:01:47 -0800
Message-Id: <1388264507-5100-1-git-send-email-olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5c0484e25ec0 ('powerpc: Endian safe trampoline') resulted in
losing proper alignment of the spinlock variables used when booting
secondary CPUs, causing some quite odd issues with failing to boot on
PA Semi-based systems.

This showed itself on ppc64_defconfig, but not on pasemi_defconfig,
so it had gone unnoticed when I initially tested the LE patch set.

Fix is to add explicit alignment instead of relying on good luck. :)

Fixes: 5c0484e25ec0 ('powerpc: Endian safe trampoline')
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=67811
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/powerpc/kernel/head_64.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2ae41ab..4d94477 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -80,6 +80,7 @@ END_FTR_SECTION(0, 1)
 	 * of the function that the cpu should jump to to continue
 	 * initialization.
 	 */
+	.balign 8
 	.globl  __secondary_hold_spinloop
 __secondary_hold_spinloop:
 	.llong	0x0
-- 
1.7.10.4
