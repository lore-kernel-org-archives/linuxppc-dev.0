Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xv7dV3nkdzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 07:22:05 +1000 (AEST)
Subject: Re: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 Steven.Sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
 <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
 <20170915203852.GA10749@remoulade>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <bff836ec-3922-1783-6cb4-94d1be92544b@oracle.com>
Date: Fri, 15 Sep 2017 17:20:59 -0400
MIME-Version: 1.0
In-Reply-To: <20170915203852.GA10749@remoulade>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

I had this option  back upto version 3, where zero flag was passed into 
vmemmap_alloc_block(), but I was asked to remove it, because it required 
too many changes in other places. So, the current approach is cleaner, 
but the idea is that kasan should use its own version of 
vmemmap_populate() for both x86 and ARM, but I think it is outside of 
the scope of this work.

See this comment from Ard Biesheuvel:
https://lkml.org/lkml/2017/8/3/948

"
KASAN uses vmemmap_populate as a convenience: kasan has nothing to do
with vmemmap, but the function already existed and happened to do what
KASAN requires.

Given that that will no longer be the case, it would be far better to
stop using vmemmap_populate altogether, and clone it into a KASAN
specific version (with an appropriate name) with the zeroing folded
into it.
"

If you think I should add these function in this project, than sure I 
can send a new version with kasanmap_populate() functions.

Thank you,
Pasha

On 09/15/2017 04:38 PM, Mark Rutland wrote:
> On Thu, Sep 14, 2017 at 09:30:28PM -0400, Pavel Tatashin wrote:
>> Hi Mark, Thank you for looking at this. We can't do this because page 
>> table is not set until cpu_replace_ttbr1() is called. So, we can't do 
>> memset() on this memory until then. 
> I see. Sorry, I had missed that we were on the temporary tables at 
> this point in time. I'm still not keen on duplicating the iteration. 
> Can we split the vmemmap code so that we have a variant that takes a 
> GFP? That way we could explicitly pass __GFP_ZERO for those cases 
> where we want a zeroed page, and are happy to pay the cost of 
> initialization. Thanks Mark.
