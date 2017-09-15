Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xv8m61dgJzDrZq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 08:12:53 +1000 (AEST)
Date: Fri, 15 Sep 2017 22:51:48 +0100
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
Message-ID: <20170915215147.GA11849@remoulade>
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
 <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
 <20170915203852.GA10749@remoulade>
 <bff836ec-3922-1783-6cb4-94d1be92544b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <bff836ec-3922-1783-6cb4-94d1be92544b@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 15, 2017 at 05:20:59PM -0400, Pavel Tatashin wrote:
> Hi Mark,
> 
> I had this option  back upto version 3, where zero flag was passed into
> vmemmap_alloc_block(), but I was asked to remove it, because it required too
> many changes in other places.

Ok. Sorry for bringing back a point that had already been covered.

> So, the current approach is cleaner, but the idea is that kasan should use
> its own version of vmemmap_populate() for both x86 and ARM, but I think it is
> outside of the scope of this work.

I appreciate that this is unrelated to your ultimate goal, and that this is
somewhat frustrating given the KASAN code is arguably abusing the
vmemmap_populate() interface.

However, I do think we need to migrate the KASAN code to a proper interface
immediately, rather than making it worse in the interim.

> If you think I should add these function in this project, than sure I can
> send a new version with kasanmap_populate() functions.

I would very much appreciate if you could send a version with a
kasan_map_populate() interface. I'm more than happy to review/test that portion
of the series, or to help if there's some problem which makes that difficult.

Thanks,
Mark.
