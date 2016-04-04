Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdqQs3bpYzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 21:25:09 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 4 Apr 2016 16:55:05 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u34BP0VE7799220
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Apr 2016 16:55:00 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u34BOtV7020120
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Apr 2016 16:54:58 +0530
Date: Mon, 4 Apr 2016 21:24:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@suse.de>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, zhlcindy@linux.vnet.ibm.com
Subject: Re: [RFC] mm: Fix memory corruption caused by deferred page
 initialization
Message-ID: <20160404112433.GA9567@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1458921929-15264-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <3qXFh60DRNz9sDH@ozlabs.org> <20160326133708.GA382@gwshan>
 <20160327134827.GA24644@gwshan> <20160331022734.GA12552@gwshan>
 <20160404083939.GC21128@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160404083939.GC21128@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 04, 2016 at 09:39:39AM +0100, Mel Gorman wrote:
>On Thu, Mar 31, 2016 at 01:27:34PM +1100, Gavin Shan wrote:
>> >So the issue is only existing when CONFIG_NO_BOOTMEM=n. The alternative fix would
>> >be similar to what we have on !CONFIG_NO_BOOTMEM: In early stage, all page structs
>> >for bootmem reserved pages are initialized and mark them with PG_reserved. I'm
>> >not sure it's worthy to fix it as we won't support bootmem as Michael mentioned.
>> >
>> 
>> Mel, could you please confirm if we need a fix on !CONFIG_NO_BOOTMEM? If we need,
>> I'll respin and send a patch for review.
>> 
>
>Given that CONFIG_NO_BOOTMEM is not supported and bootmem is meant to be
>slowly retiring, I would suggest instead making deferred memory init
>depend on NO_BOOTMEM. 
>

Thanks for confirm, Mel. It would be the best strategy to have simplest
fix for this issue. I'll send a followup patch to address it.

Thanks,
Gavin

>-- 
>Mel Gorman
>SUSE Labs
>
