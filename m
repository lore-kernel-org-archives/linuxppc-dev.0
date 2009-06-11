Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 64604B70F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 18:22:10 +1000 (EST)
Date: Thu, 11 Jun 2009 18:22:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: wire up sys_rt_tgsigqueueinfo
Message-Id: <20090611182208.93fbe3df.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/systbl.h |    1 +
 arch/powerpc/include/asm/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

This new syscall turned up in Linus' tree today and has been in
linux-next for some time.  This has been build tested for ppc64_defconfig
and ppc44x_defconfig.

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index d98a30d..43e23dc 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -325,3 +325,4 @@ SYSCALL(inotify_init1)
 SYSCALL(ni_syscall)
 COMPAT_SYS_SPU(preadv)
 COMPAT_SYS_SPU(pwritev)
+COMPAT_SYS(rt_tgsigqueueinfo)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 3f06f8e..e8472c4 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -343,10 +343,11 @@
 #define __NR_inotify_init1	318
 #define __NR_preadv		320
 #define __NR_pwritev		321
+#define __NR_rt_tgsigqueueinfo	322
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		322
+#define __NR_syscalls		323
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.6.3.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
