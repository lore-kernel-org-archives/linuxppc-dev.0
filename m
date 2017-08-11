Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVh16bHMzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:24:17 +1000 (AEST)
Subject: Re: [v6 04/15] mm: discard memblock data later
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, Mel Gorman <mgorman@suse.de>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
 <6366171f-1a30-2faa-d776-01983fcb5a00@oracle.com>
 <20170811160436.GS30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <a63eb223-455f-ae57-122f-7b2655e3de26@oracle.com>
Date: Fri, 11 Aug 2017 12:22:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170811160436.GS30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I will address your comment, and send out a new patch. Should I send it out
>> separately from the series or should I keep it inside?
> 
> I would post it separatelly. It doesn't depend on the rest.

OK, I will post it separately. No it does not depend on the rest, but 
the reset depends on this. So, I am not sure how to enforce that this 
comes before the rest.

> 
>> Also, before I send out a new patch, I will need to root cause and resolve
>> problem found by kernel test robot <fengguang.wu@intel.com>, and bisected
>> down to this patch.
>>
>> [  156.659400] BUG: Bad page state in process swapper  pfn:03147
>> [  156.660051] page:ffff88001ed8a1c0 count:0 mapcount:-127 mapping:
>> (null) index:0x1
>> [  156.660917] flags: 0x0()
>> [  156.661198] raw: 0000000000000000 0000000000000000 0000000000000001
>> 00000000ffffff80
>> [  156.662006] raw: ffff88001f4a8120 ffff88001ed85ce0 0000000000000000
>> 0000000000000000
>> [  156.662811] page dumped because: nonzero mapcount
>> [  156.663307] CPU: 0 PID: 1 Comm: swapper Not tainted
>> 4.13.0-rc3-00220-g1aad694 #1
>> [  156.664077] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.9.3-20161025_171302-gandalf 04/01/2014
>> [  156.665129] Call Trace:
>> [  156.665422]  dump_stack+0x1e/0x20
>> [  156.665802]  bad_page+0x122/0x148
> 
> Was the report related with this patch?

Yes, they said that the problem was bisected down to this patch. Do you 
know if there is a way to submit a patch to this test robot?

Thank you,
Pasha
