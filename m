Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 194DB1A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 17:21:13 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 25 Jan 2016 11:51:10 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0P6L7Dv21561612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:51:07 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0P6L5nO020536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:51:06 +0530
Message-ID: <56A5BED1.9070704@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 11:51:05 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
CC: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [kernel] powerpc: Make vmalloc_to_phys() public
References: <20160125054603.5D55B140326@ozlabs.org>
In-Reply-To: <20160125054603.5D55B140326@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2016 11:16 AM, Michael Ellerman wrote:
> On Thu, 2016-21-01 at 07:35:08 UTC, Alexey Kardashevskiy wrote:
>> > This makes vmalloc_to_phys() public as there will be another user
>> > (in-kernel VFIO acceleration) for it soon.
>> > 
>> > As a part of future little optimization, this changes the helper to call
>> > vmalloc_to_pfn() instead of vmalloc_to_page() as the size of the
>> > struct page may not be power-of-two aligned which will make gcc use
>> > multiply instructions instead of shifts.
> You should also mention why you need to export it, presumably because whatever
> new user you have in mind can be built as a module.

Unless the change specifically mentions about the use case, there
are a tons of static helper functions which can be exported to public
for module usage. Ideally this change should be part of the series
which actually needs the helper function to be available in public
not a stand alone one.
