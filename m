Return-Path: <laurentiu.tudor@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0072.outbound.protection.outlook.com [104.47.41.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyPyY3gSvzDr5m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:17:57 +1000 (AEST)
From: <laurentiu.tudor@nxp.com>
To: <oss@buserror.net>, <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH] powerpc: allow compiling with GENERIC_MSI_IRQ
Date: Wed, 28 Jun 2017 17:17:38 +0300
Message-ID: <20170628141738.10202-1-laurentiu.tudor@nxp.com>
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This allows building powerpc with the GENERIC_MSI_IRQ Kconfig
by enabling the asm-generic msi.h in Kbuild. Without this,
there's a compilation error [1] because powerpc, as most arches,
doesn't provide an asm/msi.h.

[1] In file included from ./include/linux/kvm_host.h:20:0,
                 from ./arch/powerpc/include/asm/kvm_ppc.h:30,
                 from arch/powerpc/kernel/dbell.c:20:
./include/linux/msi.h:195:21: fatal error: asm/msi.h: No such file or directory

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/powerpc/include/asm/Kbuild | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 5c4fbc8..c4d141c 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -8,3 +8,5 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += vtime.h
+generic-y += msi.h
+
-- 
2.9.4
