Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
From: Emil Medve <Emilian.Medve@Freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] [POWERPC] Fix a mm compile error
Date: Wed,  2 Apr 2008 18:05:33 -0500
Message-Id: <1207177533-30598-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/mm/init_32.c:102: error: conflicting types for '__initial_memory_limit_addr'
arch/powerpc/mm/mmu_decl.h:51: error: previous declaration of '__initial_memory_limit_addr' was here

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/mm/init_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 555bb7e..63c5e3d 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -99,7 +99,7 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
  * address of the limit of what is accessible with initial MMU setup -
  * 256MB usually, but only 16MB on 601.
  */
-unsigned long __initial_memory_limit_addr = 0x10000000;
+phys_addr_t __initial_memory_limit_addr = 0x10000000;
 
 /*
  * Check for command-line options that affect what MMU_init will do.
-- 
1.5.4.GIT
