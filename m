Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E5341A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:58:57 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 14:58:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DB5E12BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:58:53 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8S4wjup41353288
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:58:53 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8S4wK18025572
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:58:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 24/31] powerpc/mm: Convert __hash_page_64K to C
In-Reply-To: <5602AF78.501@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-25-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5602AF78.501@linux.vnet.ibm.com>
Date: Mon, 28 Sep 2015 10:28:01 +0530
Message-ID: <87wpvbgmxy.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 09/21/2015 12:10 PM, Aneesh Kumar K.V wrote:
>> Convert from asm to C
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> +		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
>> +		new_pte |= (slot << _PAGE_F_GIX_SHIFT) & (_PAGE_F_SECOND | _PAGE_F_GIX);
>
>
> I know this is already part of the function __hash_page_huge(), but its
> just coincidence that _PAGE_F_SECOND is the left bit of _PAGE_F_GIX 3 bit
> positions, so we dont check exclusively for the fourth bit on the returned
> 'slot' value from hpte_insert() function and explicitly set _PAGE_F_SECOND
> flag for the pte. This hack does the work but makes it pretty confusing.

slot number should be looked at as a 4 bit entity, of format

[ 1 bit (secondary or not) | 3 bit hash pte slot ]


-aneesh
