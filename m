Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A36301A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 21:16:44 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 24 Feb 2016 10:16:40 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5D9CD219005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 10:16:22 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OAGccn49283234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 10:16:38 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1O9GbJW004281
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 02:16:39 -0700
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
To: Will Deacon <will.deacon@arm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad> <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad>
 <20160223193345.GC21820@node.shutemov.name> <20160223202233.GE27281@arm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <56CD8302.9080202@de.ibm.com>
Date: Wed, 24 Feb 2016 11:16:34 +0100
MIME-Version: 1.0
In-Reply-To: <20160223202233.GE27281@arm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2016 09:22 PM, Will Deacon wrote:
> On Tue, Feb 23, 2016 at 10:33:45PM +0300, Kirill A. Shutemov wrote:
>> On Tue, Feb 23, 2016 at 07:19:07PM +0100, Gerald Schaefer wrote:
>>> I'll check with Martin, maybe it is actually trivial, then we can
>>> do a quick test it to rule that one out.
>>
>> Oh. I found a bug in __split_huge_pmd_locked(). Although, not sure if it's
>> _the_ bug.
>>
>> pmdp_invalidate() is called for the wrong address :-/
>> I guess that can be destructive on the architecture, right?
> 
> FWIW, arm64 ignores the address parameter for set_pmd_at, so this would
> only result in the TLBI nuking the wrong entries, which is going to be
> tricky to observe in practice given that we install a table entry
> immediately afterwards that maps the same pages. If s390 does more here
> (I see some magic asm using the address), that could be the answer...

This patch does not change the address for set_pmd_at, it does that for the 
pmdp_invalidate here (by keeping haddr at the start of the pmd)

--->    pmdp_invalidate(vma, haddr, pmd);
        pmd_populate(mm, pmd, pgtable);
 



Without that fix we would clearly have stale tlb entries, no?
