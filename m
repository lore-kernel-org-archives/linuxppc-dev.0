Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWGjq0YdczDqgc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:31:58 +1000 (AEST)
Subject: Re: [v6 01/15] x86/mm: reserve only exiting low pages
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
 <20170811080706.GC30811@dhcp22.suse.cz>
 <47ebf53b-ea8b-1822-a63a-3682ed2f4753@oracle.com>
 <20170814114011.GG19063@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <8da779a0-ade4-e43e-3b14-2686e347f8ab@oracle.com>
Date: Mon, 14 Aug 2017 09:30:35 -0400
MIME-Version: 1.0
In-Reply-To: <20170814114011.GG19063@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Correct, the pgflags asserts were triggered when we were setting reserved
>> flags to struct page for PFN 0 in which was never initialized through
>> __init_single_page(). The reason they were triggered is because we set all
>> uninitialized memory to ones in one of the debug patches.
> 
> And why don't we need the same treatment for other architectures?
> 

I have not seen similar issues on other architectures. At least this low 
memory reserve is x86 specific for BIOS purposes:

Documentation/admin-guide/kernel-parameters.txt
3624	reservelow=	[X86]
3625			Format: nn[K]
3626			Set the amount of memory to reserve for BIOS at
3627			the bottom of the address space.

If there are similar cases with other architectures, they will be caught 
by the last patch in this series, where all allocated memory is set to 
ones, and page flags asserts will be triggered. I have boot-tested on 
SPARC, ARM, and x86.

Pasha
