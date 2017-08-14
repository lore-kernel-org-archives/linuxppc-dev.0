Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWDDw1Fw4zDqkx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:40:16 +1000 (AEST)
Date: Mon, 14 Aug 2017 13:40:11 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 01/15] x86/mm: reserve only exiting low pages
Message-ID: <20170814114011.GG19063@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
 <20170811080706.GC30811@dhcp22.suse.cz>
 <47ebf53b-ea8b-1822-a63a-3682ed2f4753@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47ebf53b-ea8b-1822-a63a-3682ed2f4753@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 11-08-17 11:24:55, Pasha Tatashin wrote:
[...]
> >>In this patchset we will stop zeroing struct page memory during allocation.
> >>Therefore, this bug must be fixed in order to avoid random assert failures
> >>caused by CONFIG_DEBUG_VM_PGFLAGS triggers.
> >>
> >>The fix is to reserve memory from the first existing PFN.
> >
> >Hmm, I assume this is a result of some assert triggering, right? Which
> >one? Why don't we need the same treatment for other than x86 arch?
> 
> Correct, the pgflags asserts were triggered when we were setting reserved
> flags to struct page for PFN 0 in which was never initialized through
> __init_single_page(). The reason they were triggered is because we set all
> uninitialized memory to ones in one of the debug patches.

And why don't we need the same treatment for other architectures?
-- 
Michal Hocko
SUSE Labs
