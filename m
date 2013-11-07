Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "aserp1050.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C00C62C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 01:32:18 +1100 (EST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id
 rA7Dh1WE011508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 13:43:01 GMT
MIME-Version: 1.0
Message-ID: <20131107131247.GA13911@elgon.mountain>
Date: Thu, 7 Nov 2013 05:12:47 -0800 (PST)
From: Dan Carpenter <dan.carpenter@oracle.com>
To: beckyb@kernel.crashing.org
Subject: re: powerpc: Hugetlb for BookE
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

Hello Becky Bruce,

This is a semi-automatic email about new static checker warnings.

The patch 41151e77a4d9: "powerpc: Hugetlb for BookE" from Jun 28, 
2011, leads to the following Smatch complaint:

arch/powerpc/mm/hugetlbpage-book3e.c:120 flush_hugetlb_page()
	 warn: variable dereferenced before check 'vma' (see line 117)

arch/powerpc/mm/hugetlbpage-book3e.c
   116	{
   117		struct hstate *hstate = hstate_file(vma->vm_file);
                                                    ^^^^^^^^^^^^
Dereference.

   118		unsigned long tsize = huge_page_shift(hstate) - 10;
   119	
   120		__flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr, tsize, 0);
                                 ^^^
Check is too late.

   121	
   122	}

Also in the caller:

arch/powerpc/mm/tlb_nohash.c
   305  void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
   306  {
   307  #ifdef CONFIG_HUGETLB_PAGE
   308          if (is_vm_hugetlb_page(vma))
                    ^^^^^^^^^^^^^^^^^^^^^^
Dereferenced inside is_vm_hugetlb_page().

   309                  flush_hugetlb_page(vma, vmaddr);
   310  #endif
   311  
   312          __flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
   313                           mmu_get_tsize(mmu_virtual_psize), 0);
   314  }

regards,
dan carpenter
