Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVQN4fz4zDr2M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:12:28 +1000 (AEST)
Subject: Re: [v6 13/15] mm: stop zeroing memory during allocation in vmemmap
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-14-git-send-email-pasha.tatashin@oracle.com>
 <20170811130449.GL30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <16bdfd76-d28a-0732-9a15-29cc373e1236@oracle.com>
Date: Fri, 11 Aug 2017 12:11:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170811130449.GL30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2017 09:04 AM, Michal Hocko wrote:
> On Mon 07-08-17 16:38:47, Pavel Tatashin wrote:
>> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
>> we will get the performance improvement by zeroing the memory in parallel
>> when struct pages are zeroed.
> 
> First of all this should be probably merged with the previous patch. The
> I think vmemmap_alloc_block would be better to split up into
> __vmemmap_alloc_block which doesn't zero and vmemmap_alloc_block which
> does zero which would reduce the memset callsites and it would make it
> slightly more robust interface.

Ok, I will add: vmemmap_alloc_block_zero() call, and merge this and the 
previous patches together.
