Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4E3852C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 13:19:12 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 7 Jan 2014 12:19:10 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E8E013578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 13:19:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s072IrWM5439902
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jan 2014 13:18:54 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s072J5X7022398
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jan 2014 13:19:05 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V3 1/2] powerpc: mm: Move ppc64 page table range
 definitions to separate header
In-Reply-To: <1389050101.12906.13.camel@pasglop>
References: <1388999012-14424-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1389050101.12906.13.camel@pasglop>
Date: Tue, 07 Jan 2014 07:49:01 +0530
Message-ID: <87mwj8wn3e.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aarcange@redhat.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 kirill.shutemov@linux.intel.com, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2014-01-06 at 14:33 +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This avoid mmu-hash64.h including pagetable-ppc64.h. That inclusion
>> cause issues like
>
> I don't like this. We have that stuff split into too many includes
> already it's a mess.

I understand. Let me know, if you have any suggestion on cleaning that
up. I can do that.

>
> Why do we need to include it from mmu*.h ?

in mmu-hash64.h added by me via 78f1dbde9fd020419313c2a0c3b602ea2427118f

/*
 * This is necessary to get the definition of PGTABLE_RANGE which we
 * need for various slices related matters. Note that this isn't the
 * complete pgtable.h but only a portion of it.
 */
#include <asm/pgtable-ppc64.h>

-aneesh
