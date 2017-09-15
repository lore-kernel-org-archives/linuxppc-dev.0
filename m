Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xv6h90h9ZzDrZl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 06:39:19 +1000 (AEST)
Date: Fri, 15 Sep 2017 21:38:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, Steven.Sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
Message-ID: <20170915203852.GA10749@remoulade>
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
 <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 09:30:28PM -0400, Pavel Tatashin wrote:
> Hi Mark,
> 
> Thank you for looking at this. We can't do this because page table is not
> set until cpu_replace_ttbr1() is called. So, we can't do memset() on this
> memory until then.

I see. Sorry, I had missed that we were on the temporary tables at this point
in time.

I'm still not keen on duplicating the iteration. Can we split the vmemmap code
so that we have a variant that takes a GFP? 

That way we could explicitly pass __GFP_ZERO for those cases where we want a
zeroed page, and are happy to pay the cost of initialization.

Thanks
Mark.
