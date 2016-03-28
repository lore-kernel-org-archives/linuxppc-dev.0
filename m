Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYbgr5mHNzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 01:21:44 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 00:21:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 57D7A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 01:21:30 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2SELLpI11338096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 01:21:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2SEKvwj009136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 01:20:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, mgorman@suse.de, zhlcindy@linux.vnet.ibm.com
Subject: Re: [RFC] mm: Fix memory corruption caused by deferred page
 initialization
In-Reply-To: <20160326133708.GA382@gwshan>
References: <1458921929-15264-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <3qXFh60DRNz9sDH@ozlabs.org> <20160326133708.GA382@gwshan>
Date: Mon, 28 Mar 2016 19:50:37 +0530
Message-ID: <87zitismyy.fsf@linux.vnet.ibm.com>
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

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> [ text/plain ]
> On Sat, Mar 26, 2016 at 08:47:17PM +1100, Michael Ellerman wrote:
>>Hi Gavin,
>>
>>On Fri, 2016-25-03 at 16:05:29 UTC, Gavin Shan wrote:
>>> During deferred page initialization, the pages are moved from memblock
>>> or bootmem to buddy allocator without checking they were reserved. Those
>>> reserved pages can be reallocated to somebody else by buddy/slab allocator.
>>> It leads to memory corruption and potential kernel crash eventually.
>>
>>Can you give me a bit more detail on what the bug is?
>>
>>I haven't seen any issues on my systems, but I realise now I haven't enabled
>>DEFERRED_STRUCT_PAGE_INIT - I assumed it was enabled by default.
>>
>>How did this get tested before submission?
>
.....

> I think this patch is generic one. I guess bootmem might be supported on other
> platforms other than PPC? If that's the case, it would be fine to have the code
> fixing the bootmem bitmap if you agree. If you want me to split the patch into
> two for bootmem and memblock cases separately, I can do it absolutely. Please
> let me know your preference :-)
>

IMHO it would make it simpler if you split this into two patch. Also
avoid doing variable renames in the patch.

-aneesh
