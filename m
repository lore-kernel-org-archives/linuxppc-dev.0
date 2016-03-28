Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYhTy43bvzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 04:58:30 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 28 Mar 2016 23:28:25 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2SHvcwv19988776
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 23:27:39 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2SHwGrm008854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 23:28:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 37/65] powerpc/mm/radix: Add tlbflush routines
In-Reply-To: <201603271729.OvhxxyUr%fengguang.wu@intel.com>
References: <201603271729.OvhxxyUr%fengguang.wu@intel.com>
Date: Mon, 28 Mar 2016 23:28:15 +0530
Message-ID: <87shzao56w.fsf@linux.vnet.ibm.com>
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

> [ text/plain ]
> Hi Aneesh,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.6-rc1 next-20160324]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/powerpc-mm-Use-big-endian-page-table-for-book3s-64/20160327-174557
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: x86_64-randconfig-x001-201613 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
>
> All errors (new ones prefixed by >>):
>
>    kernel/fork.c: In function 'mm_alloc':
>>> kernel/fork.c:675:13: error: 'mm_context_t {aka struct <anonymous>}' has no member named 'id'
>      mm->context.id = MMU_NO_CONTEXT;
>                 ^
>>> kernel/fork.c:675:19: error: 'MMU_NO_CONTEXT' undeclared (first use in this function)
>      mm->context.id = MMU_NO_CONTEXT;
>                       ^
>    kernel/fork.c:675:19: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +675 kernel/fork.c
>
>    669			return NULL;
>    670	
>    671		memset(mm, 0, sizeof(*mm));
>    672		/*
>    673		 * FIXME!! we need a better way handle this
>    674		 */
>  > 675		mm->context.id = MMU_NO_CONTEXT;
>    676		return mm_init(mm, current);
>    677	}
>    678	
>

I added that change during development, based on some issue I hit that
time (with a note to fix this correctly later). Now looking back I don't
recollect what the bug was about. AFAIU the following mm_init() should
properly initialize the context.id and we should not hit a tlbflush in between.

Hence for now I will remove this hunk.

-aneesh
