Return-Path: <prvs=0625baffd6=ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B7zr08CYzF2Jy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 00:30:24 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2SDT9VJ044434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 09:30:22 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h0bpnh2he-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 09:30:22 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 14:30:19 +0100
Subject: Re: [mm] b1f0502d04: INFO:trying_to_register_non-static_key
To: David Rientjes <rientjes@google.com>
Cc: kernel test robot <fengguang.wu@intel.com>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
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
 x86@kernel.org, lkp@01.org
References: <20180317075119.u6yuem2bhxvggbz3@inn>
 <792c0f75-7e7f-cd81-44ae-4205f6e4affc@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803251510040.80485@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 15:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803251510040.80485@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <aa6f2ff1-ff67-106a-e0e4-522ac82a7bf0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/03/2018 00:10, David Rientjes wrote:
> On Wed, 21 Mar 2018, Laurent Dufour wrote:
> 
>> I found the root cause of this lockdep warning.
>>
>> In mmap_region(), unmap_region() may be called while vma_link() has not been
>> called. This happens during the error path if call_mmap() failed.
>>
>> The only to fix that particular case is to call
>> seqcount_init(&vma->vm_sequence) when initializing the vma in mmap_region().
>>
> 
> Ack, although that would require a fixup to dup_mmap() as well.

You're right, I'll fix that too.

Thanks a lot.
Laurent.
