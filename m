Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY9VC4LCyzDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 01:43:31 +1000 (AEST)
Date: Thu, 17 Aug 2017 17:43:24 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 05/15] mm: don't accessed uninitialized struct pages
Message-ID: <20170817154324.GB3146@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com>
 <20170811093746.GF30811@dhcp22.suse.cz>
 <8444cb2b-b134-e9fc-a458-1ba7b22a8df1@oracle.com>
 <20170814114755.GI19063@dhcp22.suse.cz>
 <e339a33c-d16b-91bd-5df0-18f5ec03d52b@oracle.com>
 <139b7d83-12a3-d584-0461-d01a79df5d2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <139b7d83-12a3-d584-0461-d01a79df5d2b@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 17-08-17 11:28:23, Pasha Tatashin wrote:
> Hi Michal,
> 
> I've been looking through this code again, and I think your suggestion will
> work. I did not realize this iterator already exist:
> 
> for_each_free_mem_range() basically iterates through (memory && !reserved)
> 
> This is exactly what we need here. So, I will update this patch to use this
> iterator, which will simplify it.

Please have a look at
http://lkml.kernel.org/r/20170815093306.GC29067@dhcp22.suse.cz
I believe we can simply drop the check altogether.
-- 
Michal Hocko
SUSE Labs
