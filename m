Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 327001A03AB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 00:29:00 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 13 Jun 2014 19:58:56 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 93E50394003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 19:58:54 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5DETol346596262
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 19:59:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5DESr2p031911
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 19:58:54 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Use base page size when comparing
 against slb value
In-Reply-To: <539ACC62.1040004@suse.de>
References: <1402644190-15604-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <539ACC62.1040004@suse.de>
Date: Fri, 13 Jun 2014 19:58:53 +0530
Message-ID: <87vbs4dgt6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 13.06.14 09:23, Aneesh Kumar K.V wrote:
>> With guest supporting Multiple page size per segment (MPSS),
>> hpte_page_size returns actual page size used. Add a new function to
>> return base page size and use that to compare against the the page size
>> calculated from SLB
>
> Why? What does this fix? Is this a bug fix, an enhancement? Don't 
> describe only what you do, but also why you do it.
>
>

This could result in page fault failures (unhandled page fault) because
even though we have a valid hpte entry mapping a 16MB page, since we
were comparing actual page size against page size calculated from SLB
bits kvmppc_hv_find_lock_hpte will fail and return -1. I did not observe
a failure in real and the bug was found during code audit. That could be
because with THP we have guest ram backed by hugetlbfs and we always
find the page in the host linux page table. The will result in do_h_enter always
inserting HPTE_V_VALID entry and hence we might not really end up calling
kvmppc_hv_find_lock_hpte.

-aneesh
