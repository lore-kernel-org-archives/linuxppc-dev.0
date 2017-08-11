Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTV7q4XcHzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 01:59:51 +1000 (AEST)
Subject: Re: [v6 07/15] mm: defining memblock_virt_alloc_try_nid_raw
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-8-git-send-email-pasha.tatashin@oracle.com>
 <20170811123953.GI30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <545b7230-2c09-d2f9-f26a-05ef395c36d4@oracle.com>
Date: Fri, 11 Aug 2017 11:58:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170811123953.GI30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2017 08:39 AM, Michal Hocko wrote:
> On Mon 07-08-17 16:38:41, Pavel Tatashin wrote:
>> A new variant of memblock_virt_alloc_* allocations:
>> memblock_virt_alloc_try_nid_raw()
>>      - Does not zero the allocated memory
>>      - Does not panic if request cannot be satisfied
> 
> OK, this looks good but I would not introduce memblock_virt_alloc_raw
> here because we do not have any users. Please move that to "mm: optimize
> early system hash allocations" which actually uses the API. It would be
> easier to review it that way.
> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> other than that
> Acked-by: Michal Hocko <mhocko@suse.com>

Sure, I could do this, but as I understood from earlier Dave Miller's 
comments, we should do one logical change at a time. Hence, introduce 
API in one patch use it in another. So, this is how I tried to organize 
this patch set. Is this assumption incorrect?
