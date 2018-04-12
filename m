Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MMbT38zmzDqxs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 23:44:52 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3CDi5Nb093487
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 09:44:50 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ha7ynt6sb-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 09:44:50 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 12 Apr 2018 14:44:46 +0100
Subject: Re: [PATCH v9 21/24] perf tools: Add support for the SPF perf event
To: David Rientjes <rientjes@google.com>, Andi Kleen <ak@linux.intel.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
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
 <1520963994-28477-22-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803261443560.255554@chino.kir.corp.google.com>
 <20180327034936.GO13724@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1804092346090.225864@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2018 15:44:36 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804092346090.225864@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <de5f854b-fd39-21e1-1ce9-1c5c2d292eb8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/04/2018 08:47, David Rientjes wrote:
> On Mon, 26 Mar 2018, Andi Kleen wrote:
> 
>>> Aside: should there be a new spec_flt field for struct task_struct that 
>>> complements maj_flt and min_flt and be exported through /proc/pid/stat?
>>
>> No. task_struct is already too bloated. If you need per process tracking 
>> you can always get it through trace points.
>>
> 
> Hi Andi,
> 
> We have
> 
> 	count_vm_event(PGFAULT);
> 	count_memcg_event_mm(vma->vm_mm, PGFAULT);
> 
> in handle_mm_fault() but not counterpart for spf.  I think it would be 
> helpful to be able to determine how much faulting can be done 
> speculatively if there is no per-process tracking without tracing.

That sounds to be a good idea, I will create a separate patch a dedicated
speculative_pgfault counter as PGFAULT is.

Thanks,
Laurent.
