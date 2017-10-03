Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y62zh1CtlzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 02:30:39 +1100 (AEDT)
Subject: Re: [PATCH v9 08/12] mm: zero reserved and unavailable struct pages
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-9-pasha.tatashin@oracle.com>
 <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <691dba28-718c-e9a9-d006-88505eb5cd7e@oracle.com>
Date: Tue, 3 Oct 2017 11:29:16 -0400
MIME-Version: 1.0
In-Reply-To: <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2017 09:18 AM, Michal Hocko wrote:
> On Wed 20-09-17 16:17:10, Pavel Tatashin wrote:
>> Some memory is reserved but unavailable: not present in memblock.memory
>> (because not backed by physical pages), but present in memblock.reserved.
>> Such memory has backing struct pages, but they are not initialized by going
>> through __init_single_page().
> 
> Could you be more specific where is such a memory reserved?
> 

I know of one example: trim_low_memory_range() unconditionally reserves 
from pfn 0, but e820__memblock_setup() might provide the exiting memory 
from pfn 1 (i.e. KVM).

But, there could be more based on this comment from linux/page-flags.h:

  19  * PG_reserved is set for special pages, which can never be swapped 
out. Some
  20  * of them might not even exist (eg empty_bad_page)...

Pasha
