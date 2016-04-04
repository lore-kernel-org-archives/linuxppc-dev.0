Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdwBz2FD4zDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 01:00:11 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 01:00:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2D5363578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 01:00:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u34ExqXl66846782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 01:00:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u34ExR2f028580
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 00:59:27 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/65] powerpc/mm/subpage: Clear RWX bit to indicate no
 access
In-Reply-To: <56FC808B.7030704@gmail.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56FC808B.7030704@gmail.com>
Date: Mon, 04 Apr 2016 20:29:08 +0530
Message-ID: <87pou5xvwj.fsf@linux.vnet.ibm.com>
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

Balbir Singh <bsingharora@gmail.com> writes:

> [ text/plain ]
>
>
> On 27/03/16 19:23, Aneesh Kumar K.V wrote:
>> Subpage protection used to depend on _PAGE_USER bit to implement no
>> access mode. This patch switch that to use _PAGE_RWX. We clear READ,
>> Write and Execute access from pte instead of clearing _PAGE_USER now.
>> This was done so that we can switch to _PAGE_PRIVILEGED in later patch.
>> subpage_protection() returns pte bits that need to be cleared.
> Could you please clarify what bit needs to be cleared. I think the underlying
> assumption is that when this routine is called access cannot be _PAGE_RWX


I didn't follow the question. subpage_protection() returns the pte bits
that need to be cleared for a specific access depending on the subpage
prot mask we set using subpage_prot syscall. 

>> Instead of updating the interface to handle no-access in a separate way,
>> it appears simple to clear RWX acecss to indicate no access.
>>

-aneesh
