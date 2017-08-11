Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTbqq3fmhzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 06:16:23 +1000 (AEST)
Date: Fri, 11 Aug 2017 23:15:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powerpc/mm/radix: Avoid flushing the PWC on every
 flush_tlb_range
Message-ID: <20170811201544.jybwkrtd2oebtlld@mwanda>
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

Hello Benjamin Herrenschmidt,

This is a semi-automatic email about new static checker warnings.

The patch 424de9c6e3f8: "powerpc/mm/radix: Avoid flushing the PWC on 
every flush_tlb_range" from Jul 19, 2017, leads to the following 
Smatch complaint:

arch/powerpc/mm/tlb-radix.c:368 radix__flush_tlb_collapsed_pmd()
	 error: we previously assumed 'mm' could be null (see line 362)

arch/powerpc/mm/tlb-radix.c
   361	
   362		pid = mm ? mm->context.id : 0;
                      ^^
Check for NULL.

   363		if (unlikely(pid == MMU_NO_CONTEXT))
   364			goto no_context;
   365	
   366		/* 4k page size, just blow the world */
   367		if (PAGE_SIZE == 0x1000) {
   368			radix__flush_all_mm(mm);
                                            ^^
Unchecked dereference.

   369			return;
   370		}

regards,
dan carpenter
