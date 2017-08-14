Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWHPj1lypzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 00:03:05 +1000 (AEST)
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
 <87d84cad-f03a-88f0-7828-6d3bf7ac473c@oracle.com>
 <20170814115000.GJ19063@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <b4eb28ad-2d58-fb23-2139-427df46c2773@oracle.com>
Date: Mon, 14 Aug 2017 10:01:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170814115000.GJ19063@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> However, now thinking about it, I will change it to CONFIG_MEMBLOCK_DEBUG,
>> and let users decide what other debugging configs need to be enabled, as
>> this is also OK.
> 
> Actually the more I think about it the more I am convinced that a kernel
> boot parameter would be better because it doesn't need the kernel to be
> recompiled and it is a single branch in not so hot path.

The main reason I do not like kernel parameter is that automated test 
suits for every platform would need to be updated to include this new 
parameter in order to test it.

Yet, I think it is important at least initially to test it on every 
platform unconditionally when certain debug configs are enabled.

This patch series allows boot allocator to return uninitialized memory, 
this behavior Linux never had before, but way too often firmware 
explicitly zero all the memory before starting OS. Therefore, it would 
be hard to debug issues that might be only seen during kinit type of 
reboots.

In the future, when memory sizes will increase so that this memset will 
become unacceptable even on debug kernels, it can always be removed, but 
at least at that time we will know that the code has been tested for 
many years.
