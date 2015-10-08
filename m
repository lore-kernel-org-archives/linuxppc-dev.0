Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52B7C1A027F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:09:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: thuth@redhat.com
Subject: [PATCH 5/6] powerpc/kconfig: Move cpu options after platform options
Date: Fri,  9 Oct 2015 08:09:16 +1100
Message-Id: <1444338557-14988-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In general platforms are a more important configuration decision than
cpus, so the platforms should come first.

My basis for saying that is that our cpu selection options are generally
just about tuning for a cpu, rather than enabling/disabling support for
a cpu. On the other hand disabling a platform means you can't boot on
those machines, and any associated cpu options should vanish.

With this applied the start of menuconfig looks like:

     [*] 64-bit kernel
         Endianness selection (Build little endian kernel)
         General setup
     [*] Enable loadable module support
     -*- Enable the block layer
         Platform support
         Processor support
         Kernel options
         Bus options

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ea9377259f15..0f8c51279147 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -34,8 +34,6 @@ config CPU_LITTLE_ENDIAN
 
 endchoice
 
-source "arch/powerpc/platforms/Kconfig.cputype"
-
 config PPC32
 	bool
 	default y if !PPC64
@@ -339,6 +337,7 @@ source "init/Kconfig"
 source "kernel/Kconfig.freezer"
 
 source "arch/powerpc/platforms/Kconfig"
+source "arch/powerpc/platforms/Kconfig.cputype"
 
 menu "Kernel options"
 
-- 
2.1.4
