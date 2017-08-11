Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVHv5RHXzDrD2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:06:51 +1000 (AEST)
Date: Fri, 11 Aug 2017 18:06:46 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 07/15] mm: defining memblock_virt_alloc_try_nid_raw
Message-ID: <20170811160646.GT30811@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-8-git-send-email-pasha.tatashin@oracle.com>
 <20170811123953.GI30811@dhcp22.suse.cz>
 <545b7230-2c09-d2f9-f26a-05ef395c36d4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <545b7230-2c09-d2f9-f26a-05ef395c36d4@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 11-08-17 11:58:46, Pasha Tatashin wrote:
> On 08/11/2017 08:39 AM, Michal Hocko wrote:
> >On Mon 07-08-17 16:38:41, Pavel Tatashin wrote:
> >>A new variant of memblock_virt_alloc_* allocations:
> >>memblock_virt_alloc_try_nid_raw()
> >>     - Does not zero the allocated memory
> >>     - Does not panic if request cannot be satisfied
> >
> >OK, this looks good but I would not introduce memblock_virt_alloc_raw
> >here because we do not have any users. Please move that to "mm: optimize
> >early system hash allocations" which actually uses the API. It would be
> >easier to review it that way.
> >
> >>Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> >>Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> >>Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> >>Reviewed-by: Bob Picco <bob.picco@oracle.com>
> >
> >other than that
> >Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Sure, I could do this, but as I understood from earlier Dave Miller's
> comments, we should do one logical change at a time. Hence, introduce API in
> one patch use it in another. So, this is how I tried to organize this patch
> set. Is this assumption incorrect?

Well, it really depends. If the patch is really small then adding a new
API along with users is easier to review and backport because you have a
clear view of the usage. I believe this is the case here. But if others
feel otherwise I will not object.

-- 
Michal Hocko
SUSE Labs
