Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1129FDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 21:31:14 +1000 (EST)
Date: Wed, 19 Sep 2007 15:33:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] Fix various build errors seen on MPC885ADS with
	CONFIG_MODULES=y
Message-ID: <20070919113339.GA8187@localhost.localdomain>
References: <20070918120752.GA4859@localhost.localdomain>
	<20070918122925.GA17481@localhost.localdomain>
	<4F1F43EE-214F-4EB0-82CF-9EC04830ECC6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4F1F43EE-214F-4EB0-82CF-9EC04830ECC6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 09:26:18AM -0500, Kumar Gala wrote:
>
> On Sep 18, 2007, at 7:29 AM, Anton Vorontsov wrote:
>
>> cpm_install_handler and cpm_free_handler neither used nor defined
>> for arch/powerpc.
>>
>> This causes MPC8xx build failure, patch used to fix that.
>
> can you add the __res fix, and EXPORT() and do these three as one patch and 
> improve the commit message. I'm guessing this all shows up when we try to 
> build with CONFIG_MODULES=y.  Put the actual compile failures in the commit 
> message.
>
> - k
>

Done, thanks.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [POWERPC] Fix various build errors seen on MPC885ADS with CONFIG_MODULES=y

  CC      arch/powerpc/kernel/ppc_ksyms.o
arch/powerpc/kernel/ppc_ksyms.c:184: error: `__res' undeclared here (not in a function)
arch/powerpc/kernel/ppc_ksyms.c:184: warning: type defaults to `int' in declaration of `__res'
make[1]: *** [arch/powerpc/kernel/ppc_ksyms.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

There is no __res in the arch/powerpc tree.

  LD      .tmp_vmlinux1
arch/powerpc/kernel/built-in.o(__ksymtab+0x1b0): undefined reference to `cpm_free_handler'
arch/powerpc/kernel/built-in.o(__ksymtab+0x1b8): undefined reference to `cpm_install_handler'
make: *** [.tmp_vmlinux1] Error 1

cpm_install_handler and cpm_free_handler neither used nor defined
for arch/powerpc.

  CC      arch/powerpc/sysdev/commproc.o
arch/powerpc/sysdev/commproc.c:390: error: redefinition of '__kstrtab_cpm_dpram_addr'
arch/powerpc/sysdev/commproc.c:384: error: previous definition of '__kstrtab_cpm_dpram_addr' was here
arch/powerpc/sysdev/commproc.c:390: error: redefinition of '__ksymtab_cpm_dpram_addr'
arch/powerpc/sysdev/commproc.c:384: error: previous definition of '__ksymtab_cpm_dpram_addr' was here
make[1]: *** [arch/powerpc/sysdev/commproc.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2

Second export should be for cpm_dpram_phys not cpm_dpram_addr, this
is copy-n-paste problem.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/ppc_ksyms.c |    8 --------
 arch/powerpc/sysdev/commproc.c  |    2 +-
 include/asm-powerpc/commproc.h  |    3 ---
 3 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 430c502..4d28774 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -176,14 +176,6 @@ EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(cacheable_memcpy);
 #endif
 
-#ifdef  CONFIG_8xx
-EXPORT_SYMBOL(cpm_install_handler);
-EXPORT_SYMBOL(cpm_free_handler);
-#endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx)
-EXPORT_SYMBOL(__res);
-#endif
-
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index b562afc..160a8b4 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -387,4 +387,4 @@ uint cpm_dpram_phys(u8* addr)
 {
 	return (dpram_pbase + (uint)(addr - dpram_vbase));
 }
-EXPORT_SYMBOL(cpm_dpram_addr);
+EXPORT_SYMBOL(cpm_dpram_phys);
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index 3972487..0d92012 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -686,7 +686,4 @@ typedef struct risc_timer_pram {
 #define CICR_IEN		((uint)0x00000080)	/* Int. enable */
 #define CICR_SPS		((uint)0x00000001)	/* SCC Spread */
 
-extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
-extern void cpm_free_handler(int vec);
-
 #endif /* __CPM_8XX__ */
-- 
1.5.0.6
