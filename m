Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 696001A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 21:02:19 +1100 (AEDT)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 sACA2Hvx013691
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 10:02:17 GMT
Date: Wed, 12 Nov 2014 13:02:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: anton@samba.org
Subject: re: powerpc: Remove bootmem allocator
Message-ID: <20141112100203.GA14571@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anton Blanchard,

The patch 10239733ee86: "powerpc: Remove bootmem allocator" from Sep
17, 2014, leads to the following static checker warning:

	arch/powerpc/mm/pgtable_32.c:108 pte_alloc_one_kernel()
	warn: 'pte' can't be NULL.

arch/powerpc/mm/pgtable_32.c
    99  __init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
   100  {
   101          pte_t *pte;
   102          extern int mem_init_done;
   103  
   104          if (mem_init_done) {
   105                  pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
   106          } else {
   107                  pte = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
   108                  if (pte)

It's complaining because we need to check the return from
memblock_alloc() instead of the return from __va().

   109                          clear_page(pte);
   110          }
   111          return pte;
   112  }

regards,
dan carpenter
