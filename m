Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 699F52C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:31 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 12 Apr 2013 12:12:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 70C2A2BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:25 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3C23tUZ1179924
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:03:56 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3C2HNbB018988
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:23 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 0/4] try secondary hash before BUG in
 kernel_map_linear_page()
Date: Fri, 12 Apr 2013 10:16:56 +0800
Message-Id: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael, 

Here is the updated version,  could you please help to review it again? 

As you suggested, this version didn't copy the code, but splitted
the logic into a helper function, so both kernel_map_linear_page() and
__hash_page_huge() can use. 

Also patch #1 moves some unnecessary code out of the repeating loop, so the 
splitting is easier. Patch #3 removes the HPTE_V_BOLTED flag in 
kernel_map_linear_page(), it seems not needed based on my understanding. 

Changes are split into smaller ones, so each one did only one thing. 

Thanks, Zhong

Li Zhong (4):
  powerpc: Move the setting of rflags out of loop in __hash_page_huge
  powerpc: Split the code trying to insert hpte repeatedly as an helper
    function
  powerpc: Don't bolt the hpte in kernel_map_linear_page()
  powerpc: Try to insert the hptes repeatedly in
    kernel_map_linear_page()

 arch/powerpc/mm/hash_utils_64.c      |   45 +++++++++++++++++++++++++++++++---
 arch/powerpc/mm/hugetlbpage-hash64.c |   31 +++++------------------
 2 files changed, 47 insertions(+), 29 deletions(-)

-- 
1.7.9.5
