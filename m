Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A25C167CCC
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 14:58:12 +1000 (EST)
Date: Wed, 4 Oct 2006 14:58:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/7] [POWERPC] Allow combined iSeries and MULTIPLATFORM build
Message-Id: <20061004145805.4a4a4a8d.sfr@canb.auug.org.au>
In-Reply-To: <17696.59682.815576.910102@cargo.ozlabs.ibm.com>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
	<20060926133756.071a981f.sfr@canb.auug.org.au>
	<20060926133910.23948614.sfr@canb.auug.org.au>
	<17696.59682.815576.910102@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Oct 2006 20:25:38 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> What have you got against my powerbook? :P
> 
> With this patch, I only get the option of building an EMBEDDED6xx
> kernel - PPC_MULTIPLATFORM has disappeared for 32-bit, and the 32-bit
> powermac kernel build with it.

Sorry about that, how about the patch below instead.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

This will build with ISERIES, PSERIES and PMAC64 selected, but will only
boot on iSeries so far.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index de1ef2f..0969fe8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -338,10 +338,6 @@ config PPC_MULTIPLATFORM
 	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
 	  Maple or Cell-based machine.
 
-config PPC_ISERIES
-	bool "IBM Legacy iSeries"
-	depends on PPC64
-
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based board"
 	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
@@ -365,6 +361,10 @@ config PPC_PSERIES
 	select PPC_UDBG_16550
 	default y
 
+config PPC_ISERIES
+	bool "IBM Legacy iSeries"
+	depends on PPC_MULTIPLATFORM && PPC64
+
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
 	depends on PPC_MULTIPLATFORM && PPC32
-- 
1.4.2.1
