Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBb9854sJzDrFj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 19:54:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xBb980Yy3z9t2J
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2017 19:54:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/mm: Mark __init memory no-execute when
 STRICT_KERNEL_RWX=y
In-Reply-To: <201707150643.fR3sYXES%fengguang.wu@intel.com>
References: <201707150643.fR3sYXES%fengguang.wu@intel.com>
Date: Tue, 18 Jul 2017 19:54:18 +1000
Message-ID: <87y3rmhxyt.fsf@concordia.ellerman.id.au>
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

kbuild test robot <lkp@intel.com> writes:

> Hi Michael,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on next-20170714]
> [cannot apply to v4.12]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Michael-Ellerman/powerpc-mm-radix-Refactor-radix__mark_rodata_ro/20170715-043340
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-allnoconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/mm/mem.c: In function 'free_initmem':
>>> arch/powerpc/mm/mem.c:413:2: error: implicit declaration of function 'mark_initmem_nx' [-Werror=implicit-function-declaration]
>      mark_initmem_nx();
>      ^~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

Gah, 32-bit.

Fixed with:

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 3d562b210c65..d1da415e283c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1193,11 +1193,5 @@ static inline const int pud_pfn(pud_t pud)
 	return 0;
 }
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
-void mark_initmem_nx(void);
-#else
-static inline void mark_initmem_nx(void) { }
-#endif
-
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index dd01212935ac..afae9a336136 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -80,6 +80,13 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void mark_initmem_nx(void);
+#else
+static inline void mark_initmem_nx(void) { }
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
