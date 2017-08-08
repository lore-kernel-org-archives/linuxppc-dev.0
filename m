Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xRYdx1HPyzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 22:30:44 +1000 (AEST)
Date: Tue, 8 Aug 2017 13:30:43 +0100
From: Will Deacon <will.deacon@arm.com>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
Message-ID: <20170808123042.GG13355@arm.com>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2017 at 07:49:22AM -0400, Pasha Tatashin wrote:
> Hi Will,
> 
> Thank you for looking at this change. What you described was in my previous
> iterations of this project.
> 
> See for example here: https://lkml.org/lkml/2017/5/5/369
> 
> I was asked to remove that flag, and only zero memory in place when needed.
> Overall the current approach is better everywhere else in the kernel, but it
> adds a little extra code to kasan initialization.

Damn, I actually prefer the flag :)

But actually, if you look at our implementation of vmemmap_populate, then we
have our own version of vmemmap_populate_basepages that terminates at the
pmd level anyway if ARM64_SWAPPER_USES_SECTION_MAPS. If there's resistance
to do this in the core code, then I'd be inclined to replace our
vmemmap_populate implementation in the arm64 code with a single version that
can terminate at either the PMD or the PTE level, and do zeroing if
required. We're already special-casing it, so we don't really lose anything
imo.

Will
