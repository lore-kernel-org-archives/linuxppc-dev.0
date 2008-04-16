Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0CA8DE20D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 23:23:23 +1000 (EST)
Date: Wed, 16 Apr 2008 08:19:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Remove unused machine call outs
Message-ID: <Pine.LNX.4.64.0804160819200.19231@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When we moved to arch/powerpc we actively tried to avoid using the
ppc_md.setup_io_mappings().  Currently no board ports use it so lets
remove it to avoid any new boards using it.

Also, remove early_serial_map() since we don't even have a call out for
it in arch/powerpc.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/init_32.c     |    2 --
 include/asm-powerpc/machdep.h |    3 ---
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 0c66a9f..5316cbc 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -184,8 +184,6 @@ void __init MMU_init(void)
 	/* Map in I/O resources */
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:setio", 0x302);
-	if (ppc_md.setup_io_mappings)
-		ppc_md.setup_io_mappings();

 	/* Initialize the context management stuff */
 	mmu_context_init();
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index b95386a..54ed64d 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -198,9 +198,6 @@ struct machdep_calls {
 	   May be NULL. */
 	void		(*init)(void);

-	void		(*setup_io_mappings)(void);
-
-	void		(*early_serial_map)(void);
 	void		(*kgdb_map_scc)(void);

 	/*
-- 
1.5.4.1
