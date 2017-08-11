Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVZZ5Sk9zDqrP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:19:34 +1000 (AEST)
Subject: Re: [v6 15/15] mm: debug for raw alloctor
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-16-git-send-email-pasha.tatashin@oracle.com>
 <20170811130831.GN30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <87d84cad-f03a-88f0-7828-6d3bf7ac473c@oracle.com>
Date: Fri, 11 Aug 2017 12:18:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170811130831.GN30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> When CONFIG_DEBUG_VM is enabled, this patch sets all the memory that is
>> returned by memblock_virt_alloc_try_nid_raw() to ones to ensure that no
>> places excpect zeroed memory.
> 
> Please fold this into the patch which introduces
> memblock_virt_alloc_try_nid_raw.

OK

  I am not sure CONFIG_DEBUG_VM is the
> best config because that tends to be enabled quite often. Maybe
> CONFIG_MEMBLOCK_DEBUG? Or even make it kernel command line parameter?
> 

Initially, I did not want to make it CONFIG_MEMBLOCK_DEBUG because we 
really benefit from this debugging code when VM debug is enabled, and 
especially struct page debugging asserts which also depend on 
CONFIG_DEBUG_VM.

However, now thinking about it, I will change it to 
CONFIG_MEMBLOCK_DEBUG, and let users decide what other debugging configs 
need to be enabled, as this is also OK.

Thank you,
Pasha
