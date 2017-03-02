Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYs9N36c8zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 23:30:47 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v22CT7oa121955
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 07:30:46 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xcv49rc3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 07:30:45 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 2 Mar 2017 12:30:42 -0000
Subject: Re: [PATCH 0/3] powerpc/mm: page fault handler cleaning
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, npiggin@gmail.com
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 2 Mar 2017 13:30:38 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f4693d88-9142-dfd5-4182-9921e67c1c2c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kindly ping...

On 14/02/2017 17:45, Laurent Dufour wrote:
> This series attempts to clean the page fault handler in the way it has
> been done previously for the x86 architecture [1].
> 
> The goal is to manage the mmap_sem earlier and only in
> do_page_fault(). This done by handling the retry case earlier, before
> handling the error case.  This way the semaphore can be released
> earlier and the error path processed without holding it.
> 
> The first patch is just moving a unlock to the caller of the service,
> which as no functional impact.
> 
> The second patch is handling the retry case earlier in
> do_page_fault(). This is where most the change are done, but I was
> conservative here, not changing the use of mm_fault_error() in the
> case of the second retry. It may be smarter to handle that case
> separately but this may create duplicate code.
> 
> The last patch is moving up semaphore releasing from mm_fault_error()
> to do_page_fault().
> 
> [1] see commits from Linus Torvalds
>  26178ec11ef3 ("x86: mm: consolidate VM_FAULT_RETRY handling")
>  7fb08eca4527 ("x86: mm: move mmap_sem unlock from mm_fault_error() to
> caller")
> 
> Laurent Dufour (3):
>   powerpc/mm: move mmap_sem unlock up from do_sigbus
>   powerpc/mm: handle VM_FAULT_RETRY earlier
>   powerpc/mm: move mmap_sem unlocking in do_page_fault()
> 
>  arch/powerpc/mm/fault.c | 82 ++++++++++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 42 deletions(-)
> 
