Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CCCB1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 23:50:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 23:50:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 249552BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 23:50:18 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t91Do5PQ39583848
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 23:50:14 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t91DniMW031201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 23:49:45 +1000
Message-ID: <560D39E6.7030502@linux.vnet.ibm.com>
Date: Thu, 01 Oct 2015 19:19:26 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 19/31] powerpc/mm: Convert 4k hash insert to C
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1443580044-30659-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <560BD07B.60202@linux.vnet.ibm.com>
 <1443644298.2828.16.camel@kernel.crashing.org>
In-Reply-To: <1443644298.2828.16.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/2015 01:48 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2015-09-30 at 17:37 +0530, Anshuman Khandual wrote:
>>> +             if (unlikely(old_pte & _PAGE_BUSY))
>>> +                     return 0;
>>> +             /* If PTE permissions don't match, take page fault */
>>
>> We are already in page fault interrupt path,  will it be better
>> if we call it "take Linux page fault" instead as we will go back
>> walking the page table.
> 
> A better wording would be "escalate the page fault"

Right. There is one more thing. hash_page_mm function can have
these following return values after completion.

/* Result code is:
 *  0 - handled
 *  1 - normal page fault---> Escalate into linux page fault
 * -1 - critical hash insertion error 
 * -2 - access not permitted by subpage protection mechanism
 */

-2 is returned after looking into the sub page protection bits.
 0 is returned when hash page insert succeeds
       - ppc_md.hpte_insert returns actual slot number
       - Multiple retries after ppc_md.hpte_insert returns -1
         indicating that HPTEG is full and try secondary hash

 1 is returned when PTE in the page table does not contain PFN
-1 is returned when hash page did not succeed
	- ppc_md.hpte_insert returns -2 when it cannot insert HPTE

The point is, there are multiple combinations of (0, 1, -1, -2)
out there in various paths without much documentation which can be
cleaned up. Not in this series but may be later.
