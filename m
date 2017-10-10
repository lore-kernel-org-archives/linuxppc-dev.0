Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBJ9q4F84zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 00:39:11 +1100 (AEDT)
Date: Tue, 10 Oct 2017 15:39:06 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v10 05/10] mm: zero reserved and unavailable struct pages
Message-ID: <20171010133906.l2anyahcvgn6mg7o@dhcp22.suse.cz>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
 <20171005211124.26524-6-pasha.tatashin@oracle.com>
 <20171006123057.6gu5xnk3usw2hvzb@dhcp22.suse.cz>
 <bcf24369-ac37-cedd-a264-3396fb5cf39e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bcf24369-ac37-cedd-a264-3396fb5cf39e@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 06-10-17 11:25:16, Pasha Tatashin wrote:
> Hi Michal,
> 
> > 
> > As I've said in other reply this should go in only if the scenario you
> > describe is real. I am somehow suspicious to be honest. I simply do not
> > see how those weird struct pages would be in a valid pfn range of any
> > zone.
> > 
> 
> There are examples of both when unavailable memory is not part of any zone,
> and where it is part of zones.
> 
> I run Linux in kvm with these arguments:
> 
>         qemu-system-x86_64
>         -enable-kvm
>         -cpu kvm64
>         -kernel $kernel
>         -initrd $initrd
>         -m 512
>         -smp 2
>         -device e1000,netdev=net0
>         -netdev user,id=net0
>         -boot order=nc
>         -no-reboot
>         -watchdog i6300esb
>         -watchdog-action debug
>         -rtc base=localtime
>         -serial stdio
>         -display none
>         -monitor null
> 
> This patch reports that there are 98 unavailable pages.
> 
> They are: pfn 0 and pfns in range [159, 255].
> 
> Note, trim_low_memory_range() reserves only pfns in range [0, 15], it does
> not reserve [159, 255] ones.
> 
> e820__memblock_setup() reports linux that the following physical ranges are
> available:
>     [1 , 158]
> [256, 130783]
> 
> Notice, that exactly unavailable pfns are missing!
> 
> Now, lets check what we have in zone 0: [1, 131039]
> 
> pfn 0, is not part of the zone, but pfns [1, 158], are.
> 
> However, the bigger problem we have if we do not initialize these struct
> pages is with memory hotplug. Because, that path operates at 2M boundaries
> (section_nr). And checks if 2M range of pages is hot removable. It starts
> with first pfn from zone, rounds it down to 2M boundary (sturct pages are
> allocated at 2M boundaries when vmemmap is created), and and checks if that
> section is hot removable. In this case start with pfn 1 and convert it down
> to pfn 0.

Hmm, this is really interesting! I thought each memblock is guaranteed
to be section size aligned. But I suspect this is more of a wishful
thinking. But now I see what is the problem.
-- 
Michal Hocko
SUSE Labs
