Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A2771A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 18:31:58 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 17:31:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9A7323578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 18:31:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB27Vrtg37093478
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 18:31:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB27VqLg020262
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 18:31:53 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
In-Reply-To: <1417473849.7182.9.camel@kernel.crashing.org>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-4-git-send-email-mgorman@suse.de>
 <1417473849.7182.9.camel@kernel.crashing.org>
Date: Tue, 02 Dec 2014 13:01:29 +0530
Message-ID: <87h9xeh5im.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Sasha Levin <sasha.levin@oracle.com>,
 Dave Jones <davej@redhat.com>, LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2014-11-21 at 13:57 +0000, Mel Gorman wrote:
>> void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>>                 pte_t pte)
>>  {
>> -#ifdef CONFIG_DEBUG_VM
>> -       WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);
>> -#endif
>> +       /*
>> +        * When handling numa faults, we already have the pte marked
>> +        * _PAGE_PRESENT, but we can be sure that it is not in hpte.
>> +        * Hence we can use set_pte_at for them.
>> +        */
>> +       VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
>> +               (_PAGE_PRESENT | _PAGE_USER));
>> +
>
> His is that going to fare with set_pte_at() called for kernel pages ?
>

Yes, we won't capture those errors now. But is there any other debug
check i could use to capture the wrong usage of set_pte_at ?

-aneesh
