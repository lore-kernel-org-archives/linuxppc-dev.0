Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E742C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 11:36:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E142077C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 11:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E142077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pLy80j18zDqMT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44pLwN1rHZzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 21:35:15 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B672DA78;
 Tue, 23 Apr 2019 04:35:13 -0700 (PDT)
Received: from [10.163.1.68] (unknown [10.163.1.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DC143F557;
 Tue, 23 Apr 2019 04:35:00 -0700 (PDT)
Subject: Re: [PATCH v12 00/31] Speculative page faults
To: Laurent Dufour <ldufour@linux.ibm.com>, akpm@linux-foundation.org,
 mhocko@kernel.org, peterz@infradead.org, kirill@shutemov.name,
 ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, aneesh.kumar@linux.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 sergey.senozhatsky.work@gmail.com, Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Minchan Kim <minchan@kernel.org>, Punit Agrawal <punitagrawal@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, zhong jiang <zhongjiang@huawei.com>,
 Haiyan Song <haiyanx.song@intel.com>, Balbir Singh <bsingharora@gmail.com>,
 sj38.park@gmail.com, Michel Lespinasse <walken@google.com>,
 Mike Rapoport <rppt@linux.ibm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ecd1eb8c-d685-8c2e-1e1a-b167c8965075@arm.com>
Date: Tue, 23 Apr 2019 17:05:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, linux-mm@kvack.org, paulmck@linux.vnet.ibm.com,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04/16/2019 07:14 PM, Laurent Dufour wrote:
> In pseudo code, this could be seen as:
>     speculative_page_fault()
>     {
> 	    vma = find_vma_rcu()
> 	    check vma sequence count
> 	    check vma's support
> 	    disable interrupt
> 		  check pgd,p4d,...,pte
> 		  save pmd and pte in vmf
> 		  save vma sequence counter in vmf
> 	    enable interrupt
> 	    check vma sequence count
> 	    handle_pte_fault(vma)
> 		    ..
> 		    page = alloc_page()
> 		    pte_map_lock()
> 			    disable interrupt
> 				    abort if sequence counter has changed
> 				    abort if pmd or pte has changed
> 				    pte map and lock
> 			    enable interrupt
> 		    if abort
> 		       free page
> 		       abort

Would not it be better if the 'page' allocated here can be passed on to handle_pte_fault()
below so that in the fallback path it does not have to enter the buddy again ? Of course
it will require changes to handle_pte_fault() to accommodate a pre-allocated non-NULL
struct page to operate on or free back into the buddy if fallback path fails for some
other reason. This will probably make SPF path less overhead for cases where it has to
fallback on handle_pte_fault() after pte_map_lock() in speculative_page_fault().

> 		    ...
> 	    put_vma(vma)
>     }
>     
>     arch_fault_handler()
>     {
> 	    if (speculative_page_fault(&vma))
> 	       goto done
>     again:
> 	    lock(mmap_sem)
> 	    vma = find_vma();
> 	    handle_pte_fault(vma);
> 	    if retry
> 	       unlock(mmap_sem)
> 	       goto again;
>     done:
> 	    handle fault error
>     }

- Anshuman
