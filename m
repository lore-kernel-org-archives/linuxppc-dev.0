Return-Path: <dan.carpenter@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWndl0KJszF0RY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 02:45:46 +1100 (AEDT)
Date: Wed, 31 Jan 2018 18:45:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: aneesh.kumar@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powerpc/mm/radix: Add tlbflush routines
Message-ID: <20180131154521.GA21698@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Aneesh Kumar K.V,

The patch 1a472c9dba6b: "powerpc/mm/radix: Add tlbflush routines"
from Apr 29, 2016, leads to the following static checker warning:

	arch/powerpc/mm/tlb_nohash.c:218 __local_flush_tlb_page()
	warn: always true condition '(pid != ~0) => (0-u32max != u64max)'

arch/powerpc/mm/tlb_nohash.c
   211  void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
   212                              int tsize, int ind)
   213  {
   214          unsigned int pid;
   215  
   216          preempt_disable();
   217          pid = mm ? mm->context.id : 0;
   218          if (pid != MMU_NO_CONTEXT)
                    ^^^^^^^^^^^^^^^^^^^^^
   219                  _tlbil_va(vmaddr, pid, tsize, ind);
   220          preempt_enable();
   221  }

I don't know very much about PowerPC.  The static checker is guessing
which headers to pull in instead of relying on the build system so there
are a lot of false positives.  It's apparently using the
arch/powerpc/include/asm/book3s/64/tlbflush.h header which does:

#define MMU_NO_CONTEXT ~0UL

so it's UINT_MAX vs U64_MAX which is making the checker complain.

regards,
dan carpenter
