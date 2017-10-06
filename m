Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7ntw1NJfzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 22:47:35 +1100 (AEDT)
Date: Fri, 6 Oct 2017 13:47:29 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Pavel Tatashin' <pasha.tatashin@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "willy@infradead.org" <willy@infradead.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "sam@ravnborg.org" <sam@ravnborg.org>,
 "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
 "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
 "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
 "bob.picco@oracle.com" <bob.picco@oracle.com>
Subject: Re: [PATCH v10 09/10] mm: stop zeroing memory during allocation in
 vmemmap
Message-ID: <20171006114729.fexwklupkhyxdpt3@dhcp22.suse.cz>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
 <20171005211124.26524-10-pasha.tatashin@oracle.com>
 <063D6719AE5E284EB5DD2968C1650D6DD008BA85@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD008BA85@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 06-10-17 11:10:14, David Laight wrote:
> From: Pavel Tatashin
> > Sent: 05 October 2017 22:11
> > vmemmap_alloc_block() will no longer zero the block, so zero memory
> > at its call sites for everything except struct pages.  Struct page memory
> > is zero'd by struct page initialization.
> 
> It seems dangerous to change an allocator to stop zeroing memory.
> It is probably saver to add a new function that doesn't zero
> the memory and use that is the places where you don't want it
> to be zeroed.

Not sure what you mean. memblock_virt_alloc_try_nid_raw is a new
function which doesn't zero out...
-- 
Michal Hocko
SUSE Labs
