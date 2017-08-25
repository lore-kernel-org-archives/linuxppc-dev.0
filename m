Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xf0qP0lhnzDrVh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 22:30:08 +1000 (AEST)
Date: Fri, 25 Aug 2017 15:28:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: aneesh.kumar@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powerpc/mm/cxl: Add the fault handling cpu to mm cpumask
Message-ID: <20170825122825.zrp4x65xv23poimp@mwanda>
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

This is a semi-automatic email about new static checker warnings.

The patch 0f4bc0932e51: "powerpc/mm/cxl: Add the fault handling cpu
to mm cpumask" from Jul 27, 2017, leads to the following Smatch
complaint:

    drivers/misc/cxl/fault.c:161 cxl_handle_mm_fault()
    warn: variable dereferenced before check 'mm' (see line 146)

drivers/misc/cxl/fault.c
   145		 */
   146		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
                                                               ^^
The patch adds an unchecked dereference.

   147		if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
   148			pr_devel("copro_handle_mm_fault failed: %#x\n", result);
   149			return result;
   150		}
   151	
   152		if (!radix_enabled()) {
   153			/*
   154			 * update_mmu_cache() will not have loaded the hash since current->trap
   155			 * is not a 0x400 or 0x300, so just call hash_page_mm() here.
   156			 */
   157			access = _PAGE_PRESENT | _PAGE_READ;
   158			if (dsisr & CXL_PSL_DSISR_An_S)
   159				access |= _PAGE_WRITE;
   160	
   161			if (!mm && (REGION_ID(dar) != USER_REGION_ID))
                             ^^
But the existing code is careful to check "mm" for NULL.  The
copro_handle_mm_fault() and hash_page_mm() both have checks built in.

   162				access |= _PAGE_PRIVILEGED;
   163	

regards,
dan carpenter
