Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0101.outbound.protection.outlook.com [65.55.169.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D50811A0689
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 02:31:50 +1100 (AEDT)
Message-ID: <5514264A.6020502@Freescale.com>
Date: Thu, 26 Mar 2015 10:31:22 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: Use PFN_PHYS() to avoid truncating the
 physical address
References: <1427291352-31256-1-git-send-email-Emilian.Medve@Freescale.com>
 <FB8A0580-9A76-4F83-BDE7-2EECC0063C1C@kernel.crashing.org>
In-Reply-To: <FB8A0580-9A76-4F83-BDE7-2EECC0063C1C@kernel.crashing.org>
Content-Type: text/plain; charset="windows-1252"
Cc: scottwood@Freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar,


On 03/26/2015 10:18 AM, Kumar Gala wrote:
> Why no commit message with what issue this change was trying to fix?

A while back, when I attempted to remove bootmem (in favor of just plain
memblock as in powerpc land bootmem was just a wrapper to memblock
anyway) I run at some point into a problem with an intermediate address
value because of this '<< PAGE_SHIFT' on the wrong width variable. Using
PFN_PHYS() took care of it (it has a cast) so I decided to get this
defensive patch applied. Since, I dropped my bootmem/memblock patches in
favor to Anton's (Blanchard) work so my concrete issue example is
somewhat gone


Cheers,


> - k
> 
> On Mar 25, 2015, at 8:49 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
> 
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>> ---
>>
>> v3: Rebased and updated due to upstream changes since v2
>>
>> v2: Rebased and updated due to upstream changes since v1
>>
>> arch/powerpc/include/asm/io.h          | 2 +-
>> arch/powerpc/include/asm/page.h        | 2 +-
>> arch/powerpc/include/asm/pgalloc-32.h  | 2 +-
>> arch/powerpc/include/asm/rtas.h        | 3 ++-
>> arch/powerpc/kernel/crash_dump.c       | 2 +-
>> arch/powerpc/kernel/eeh.c              | 4 +---
>> arch/powerpc/kernel/io-workarounds.c   | 2 +-
>> arch/powerpc/kernel/pci-common.c       | 2 +-
>> arch/powerpc/kernel/vdso.c             | 6 +++---
>> arch/powerpc/kvm/book3s_64_mmu_host.c  | 2 +-
>> arch/powerpc/kvm/book3s_64_mmu_hv.c    | 2 +-
>> arch/powerpc/kvm/book3s_hv_rm_mmu.c    | 4 ++--
>> arch/powerpc/kvm/e500_mmu_host.c       | 5 ++---
>> arch/powerpc/mm/hugepage-hash64.c      | 2 +-
>> arch/powerpc/mm/hugetlbpage-book3e.c   | 2 +-
>> arch/powerpc/mm/hugetlbpage-hash64.c   | 2 +-
>> arch/powerpc/mm/mem.c                  | 9 ++++-----
>> arch/powerpc/mm/numa.c                 | 5 ++---
>> arch/powerpc/platforms/powernv/opal.c  | 2 +-
>> arch/powerpc/platforms/pseries/iommu.c | 8 ++++----
>> 20 files changed, 32 insertions(+), 36 deletions(-)
