Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB16A1A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 16:28:55 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 15:28:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 05B812CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 16:28:48 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u215SdUi3277224
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 16:28:48 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u215SFCt030169
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 16:28:15 +1100
Message-ID: <56D5285E.5090607@linux.vnet.ibm.com>
Date: Tue, 01 Mar 2016 10:57:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/lpar: Don't crash on H_PROTECT errors
References: <20160229230141.A8B4F140B99@ozlabs.org>
In-Reply-To: <20160229230141.A8B4F140B99@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/01/2016 04:31 AM, Michael Ellerman wrote:
> On Mon, 2016-29-02 at 11:52:32 UTC, Anshuman Khandual wrote:
>> There are certain condition in which H_PROTECT can return error code
>> other than H_NOT_FOUND and H_SUCCESS. One such being an attempt to
>> update an hpte owned by adjunct partition. Return 0 in that case so
>> that user space will retry the access. In adjunct case this mean we
>> will not make much progress in the user space. But atleast we get a
>> chance to kill the task and avoid taking down the entire box.
> 
> Why is it OK to do nothing and return 0?
> 
> The function's contract is that it either does the update or returns -1, you

Right, the semantics of the function will change with it. The callers of
the function include these places.

(1) __hash_page_4K   (arch/powerpc/mm/hash64_4k.c)
(2) __hash_page_4K   (arch/powerpc/mm/hash64_64k.c)
(3) __hash_page_64K  (arch/powerpc/mm/hash64_64k.c)
(4) __hash_page_huge (arch/powerpc/mm/hugetlbpage-hash64.c)
(5) __hash_page_thp  (arch/powerpc/mm/hugepage-hash64.c)

All of them get called from hash_page_mm (in turn from hash_page)
which is triggered from page fault interrupt (0x300 or 0x400). A
return value of 0 from these individual HPTE management functions
will return 0 from hash_page_mm as well. This returns the control
back to the user space/kernel which would have caused the page
fault but without actually setting the right HPTE. This will cause
fault again. The semantics change does not affect these callers
in any bad way but fakes a correct page fault handling if I am not
missing anything.

But only __hash_page_4K and __hash_page_64K functions get called
from hash_preload (in turn from update_mmu_cache) which is called
from a lot of code path including linux page fault handling path
through handle_pte_fault. Inside hash_preload, the return value
from __hash_page_4K(|64K) function is checked only for -1, detecting
which hash_failure_debug is called. The return value is not passed
up in the call chain. With H_RESOURCE, hash_preload will pretend as
if it did what it was suppose to do and but none of it's callers will
explicitly know about it other than the WARN_RATELIMIT message. I
believed that hash_preload is a best attempt approach and anything
missed here will be corrected with future page faults when the process
starts executing. Please correct me if I am wrong.

> can't change that without auditing all callers - and describing that in the
> change log.

Did not get it, you would like to have something like the above code
path description in the change log ?
