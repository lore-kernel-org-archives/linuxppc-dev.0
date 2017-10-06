Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7n5G1sLPzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 22:11:29 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pavel Tatashin' <pasha.tatashin@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "willy@infradead.org"
 <willy@infradead.org>, "mhocko@kernel.org" <mhocko@kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "sam@ravnborg.org" <sam@ravnborg.org>, "mgorman@techsingularity.net"
 <mgorman@techsingularity.net>, "steven.sistare@oracle.com"
 <steven.sistare@oracle.com>, "daniel.m.jordan@oracle.com"
 <daniel.m.jordan@oracle.com>, "bob.picco@oracle.com" <bob.picco@oracle.com>
Subject: RE: [PATCH v10 09/10] mm: stop zeroing memory during allocation in
 vmemmap
Date: Fri, 6 Oct 2017 11:10:14 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD008BA85@AcuExch.aculab.com>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
 <20171005211124.26524-10-pasha.tatashin@oracle.com>
In-Reply-To: <20171005211124.26524-10-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pavel Tatashin
> Sent: 05 October 2017 22:11
> vmemmap_alloc_block() will no longer zero the block, so zero memory
> at its call sites for everything except struct pages.  Struct page memory
> is zero'd by struct page initialization.

It seems dangerous to change an allocator to stop zeroing memory.
It is probably saver to add a new function that doesn't zero
the memory and use that is the places where you don't want it
to be zeroed.

	David
