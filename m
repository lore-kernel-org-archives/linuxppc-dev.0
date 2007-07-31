Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 433AADDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 17:22:02 +1000 (EST)
Date: Tue, 31 Jul 2007 17:22:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] ps3: Fix section mismatch in ps3/setup.c
Message-Id: <20070731172200.ed4475df.sfr@canb.auug.org.au>
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

WARNING: vmlinux.o(.text+0x605d4): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.prealloc' and '.ps3_power_save')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/ps3/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index aa05288..2952b22 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -109,7 +109,7 @@ static void ps3_panic(char *str)
 
 #if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE) || \
     defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
-static void prealloc(struct ps3_prealloc *p)
+static void __init prealloc(struct ps3_prealloc *p)
 {
 	if (!p->size)
 		return;
-- 
1.5.2.4
