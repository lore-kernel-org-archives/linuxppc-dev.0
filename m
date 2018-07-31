Return-Path: <acolin@isi.edu>
Received: from mail-d.ads.isi.edu (mail-d.ads.isi.edu [128.9.180.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fzP12kwvzF162
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 00:30:12 +1000 (AEST)
From: Alexei Colin <acolin@isi.edu>
To: Alexandre Bounine <alex.bou9@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Alexei Colin <acolin@isi.edu>, Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>, John Paul Walters <jwalters@isi.edu>,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 3/6] powerpc: factor out RapidIO Kconfig menu entry
Date: Tue, 31 Jul 2018 10:29:51 -0400
Message-Id: <20180731142954.30345-4-acolin@isi.edu>
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The menu entry is now defined in the rapidio subtree.  Also, re-order
the bus menu so tha the platform-specific RapidIO controller appears
after the entry for the RapidIO subsystem.

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mips@linux-mips.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/powerpc/Kconfig | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 25d005af0a5b..17ea8a5f90a0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -993,16 +993,7 @@ source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
+source "drivers/rapidio/Kconfig"
 
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
@@ -1012,8 +1003,6 @@ config FSL_RIO
 	  Include support for RapidIO controller on Freescale embedded
 	  processors (MPC8548, MPC8641, etc).
 
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config NONSTATIC_KERNEL
-- 
2.18.0
