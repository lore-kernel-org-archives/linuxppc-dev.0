Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6cGB06zszDqsg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 00:30:09 +1100 (AEDT)
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
 <691dba28-718c-e9a9-d006-88505eb5cd7e@oracle.com>
 <20171004085636.w2rnwf5xxhahzuy7@dhcp22.suse.cz>
 <9198a33d-cd40-dd70-4823-7f70c57ef9a2@oracle.com>
 <20171004125743.fm6mf2artbga76et@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <d743668c-6b7e-1775-a5b8-d6e997537990@oracle.com>
Date: Wed, 4 Oct 2017 09:28:55 -0400
MIME-Version: 1.0
In-Reply-To: <20171004125743.fm6mf2artbga76et@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> I am not really familiar with the trim_low_memory_range code path. I am
> not even sure we have to care about it because nobody should be walking
> pfns outside of any zone.

According to commit comments first 4K belongs to BIOS, so I think the 
memory exists but BIOS may or may not report it to Linux. So, reserve it 
to make sure we never touch it.

  I am worried that this patch adds a code which
> is not really used and it will just stay that way for ever because
> nobody will dare to change it as it is too obscure and not explained
> very well.

I could explain mine code better. Perhaps add more comments, and explain 
when it can be removed?

  trim_low_memory_range is a good example of this. Why do we
> even reserve this range from the memory block allocator? The memory
> shouldn't be backed by any real memory and thus not in the allocator in
> the first place, no?
> 

Since it is not enforced in memblock that everything in reserved list 
must be part of memory list, we can have it, and we need to make sure 
kernel does not panic. Otherwise, it is very hard to detect such bugs.
