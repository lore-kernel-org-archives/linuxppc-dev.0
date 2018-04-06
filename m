Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Hhkv3pvGzF1wk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 00:23:34 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w36ELJVl090264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Apr 2018 10:23:31 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h68g9e4dp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Apr 2018 10:23:30 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 6 Apr 2018 15:23:28 +0100
Subject: Re: [PATCH v9 17/24] mm: Protect mm_rb tree with a rwlock
To: David Rientjes <rientjes@google.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, Daniel Jordan
 <daniel.m.jordan@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-18-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1804021711090.34466@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 16:23:18 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804021711090.34466@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <dd22fde2-ea3d-5492-9f1d-4f39c72b2a68@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/04/2018 02:11, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> This change is inspired by the Peter's proposal patch [1] which was
>> protecting the VMA using SRCU. Unfortunately, SRCU is not scaling well in
>> that particular case, and it is introducing major performance degradation
>> due to excessive scheduling operations.
>>
>> To allow access to the mm_rb tree without grabbing the mmap_sem, this patch
>> is protecting it access using a rwlock.  As the mm_rb tree is a O(log n)
>> search it is safe to protect it using such a lock.  The VMA cache is not
>> protected by the new rwlock and it should not be used without holding the
>> mmap_sem.
>>
>> To allow the picked VMA structure to be used once the rwlock is released, a
>> use count is added to the VMA structure. When the VMA is allocated it is
>> set to 1.  Each time the VMA is picked with the rwlock held its use count
>> is incremented. Each time the VMA is released it is decremented. When the
>> use count hits zero, this means that the VMA is no more used and should be
>> freed.
>>
>> This patch is preparing for 2 kind of VMA access :
>>  - as usual, under the control of the mmap_sem,
>>  - without holding the mmap_sem for the speculative page fault handler.
>>
>> Access done under the control the mmap_sem doesn't require to grab the
>> rwlock to protect read access to the mm_rb tree, but access in write must
>> be done under the protection of the rwlock too. This affects inserting and
>> removing of elements in the RB tree.
>>
>> The patch is introducing 2 new functions:
>>  - vma_get() to find a VMA based on an address by holding the new rwlock.
>>  - vma_put() to release the VMA when its no more used.
>> These services are designed to be used when access are made to the RB tree
>> without holding the mmap_sem.
>>
>> When a VMA is removed from the RB tree, its vma->vm_rb field is cleared and
>> we rely on the WMB done when releasing the rwlock to serialize the write
>> with the RMB done in a later patch to check for the VMA's validity.
>>
>> When free_vma is called, the file associated with the VMA is closed
>> immediately, but the policy and the file structure remained in used until
>> the VMA's use count reach 0, which may happens later when exiting an
>> in progress speculative page fault.
>>
>> [1] https://patchwork.kernel.org/patch/5108281/
>>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> Can __free_vma() be generalized for mm/nommu.c's delete_vma() and 
> do_mmap()?

To be honest I didn't look at mm/nommu.c assuming that such architecture would
probably be monothreaded. Am I wrong ?
