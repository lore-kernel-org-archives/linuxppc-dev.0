Return-Path: <daniel.m.jordan@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqpSM2Q5WzF1Jk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 04:18:04 +1100 (AEDT)
Subject: Re: [PATCH v8 18/24] mm: Provide speculative fault infrastructure
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1518794738-4186-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1518794738-4186-19-git-send-email-ldufour@linux.vnet.ibm.com>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <5b16d6ce-6b62-e4ca-2d78-c25bb008e27e@oracle.com>
Date: Mon, 26 Feb 2018 12:16:09 -0500
MIME-Version: 1.0
In-Reply-To: <1518794738-4186-19-git-send-email-ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Laurent,

This series doesn't build for me[*] when CONFIG_TRANSPARENT_HUGEPAGE is unset.

The problem seems to be that the BUILD_BUG() version of pmd_same is called in pte_map_lock:

On 02/16/2018 10:25 AM, Laurent Dufour wrote:
> +static bool pte_map_lock(struct vm_fault *vmf)
> +{
...snip...
> +	if (!pmd_same(pmdval, vmf->orig_pmd))
> +		goto out;

Since SPF can now call pmd_same without THP, maybe the way to fix it is just

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 2cfa3075d148..e130692db24a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -375,7 +375,8 @@ static inline int pte_unused(pte_t pte)
  #endif
  
  #ifndef __HAVE_ARCH_PMD_SAME
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
+    defined(CONFIG_SPECULATIVE_PAGE_FAULT)
  static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
  {
         return pmd_val(pmd_a) == pmd_val(pmd_b);

?

Daniel


[*]  The errors are:

In file included from /home/dmjordan/src/linux/include/linux/kernel.h:10:0,
                  from /home/dmjordan/src/linux/include/linux/list.h:9,
                  from /home/dmjordan/src/linux/include/linux/smp.h:12,
                  from /home/dmjordan/src/linux/include/linux/kernel_stat.h:5,
                  from /home/dmjordan/src/linux/mm/memory.c:41:
In function ‘pmd_same.isra.104’,
     inlined from ‘pte_map_lock’ at /home/dmjordan/src/linux/mm/memory.c:2380:7:
/home/dmjordan/src/linux/include/linux/compiler.h:324:38: error: call to ‘__compiletime_assert_391’ declared with attribute error: BUILD_BUG failed
   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                       ^
/home/dmjordan/src/linux/include/linux/compiler.h:304:4: note: in definition of macro ‘__compiletime_assert’
     prefix ## suffix();    \
     ^~~~~~
/home/dmjordan/src/linux/include/linux/compiler.h:324:2: note: in expansion of macro ‘_compiletime_assert’
   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
   ^~~~~~~~~~~~~~~~~~~
/home/dmjordan/src/linux/include/linux/build_bug.h:45:37: note: in expansion of macro ‘compiletime_assert’
  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                      ^~~~~~~~~~~~~~~~~~
/home/dmjordan/src/linux/include/linux/build_bug.h:79:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                      ^~~~~~~~~~~~~~~~
/home/dmjordan/src/linux/include/asm-generic/pgtable.h:391:2: note: in expansion of macro ‘BUILD_BUG’
   BUILD_BUG();
   ^~~~~~~~~
   CC      block/elevator.o
   CC      crypto/crypto_wq.o
In function ‘pmd_same.isra.104’,
     inlined from ‘pte_spinlock’ at /home/dmjordan/src/linux/mm/memory.c:2326:7,
     inlined from ‘handle_pte_fault’ at /home/dmjordan/src/linux/mm/memory.c:4181:7:
/home/dmjordan/src/linux/include/linux/compiler.h:324:38: error: call to ‘__compiletime_assert_391’ declared with attribute error: BUILD_BUG failed
   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                       ^
/home/dmjordan/src/linux/include/linux/compiler.h:304:4: note: in definition of macro ‘__compiletime_assert’
     prefix ## suffix();    \
     ^~~~~~
/home/dmjordan/src/linux/include/linux/compiler.h:324:2: note: in expansion of macro ‘_compiletime_assert’
   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
   ^~~~~~~~~~~~~~~~~~~
/home/dmjordan/src/linux/include/linux/build_bug.h:45:37: note: in expansion of macro ‘compiletime_assert’
  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                      ^~~~~~~~~~~~~~~~~~
/home/dmjordan/src/linux/include/linux/build_bug.h:79:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                      ^~~~~~~~~~~~~~~~
/home/dmjordan/src/linux/include/asm-generic/pgtable.h:391:2: note: in expansion of macro ‘BUILD_BUG’
   BUILD_BUG();
   ^~~~~~~~~
...
make[2]: *** [/home/dmjordan/src/linux/scripts/Makefile.build:316: mm/memory.o] Error 1
make[1]: *** [/home/dmjordan/src/linux/Makefile:1047: mm] Error 2
