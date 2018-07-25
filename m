Return-Path: <alex@ghiti.fr>
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b6Z84chmzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 17:39:42 +1000 (AEST)
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To: Paul Burton <paul.burton@mips.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com,
 tony.luck@intel.com, fenghua.yu@intel.com, ralf@linux-mips.org,
 jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
 arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180725003428.jsklz7pj4m7lj3m4@pburton-laptop>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <7c187058-12c7-ee2d-3ceb-d17ba94875b8@ghiti.fr>
Date: Wed, 25 Jul 2018 09:38:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180725003428.jsklz7pj4m7lj3m4@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

Thanks for having tested it, I remove mips from my list.

Thanks again,

Alex


On 07/25/2018 02:34 AM, Paul Burton wrote:
> Hi Alexandre,
>
> On Thu, Jul 05, 2018 at 11:07:05AM +0000, Alexandre Ghiti wrote:
>> In order to reduce copy/paste of functions across architectures and then
>> make riscv hugetlb port (and future ports) simpler and smaller, this
>> patchset intends to factorize the numerous hugetlb primitives that are
>> defined across all the architectures.
>>
>> Except for prepare_hugepage_range, this patchset moves the versions that
>> are just pass-through to standard pte primitives into
>> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
>> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
>>
>> s390 architecture has not been tackled in this serie since it does not
>> use asm-generic/hugetlb.h at all.
>> powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).
>>
>> This patchset has been compiled on x86 only.
> For MIPS these look good - I don't see any issues & they pass a build
> test (using cavium_octeon_defconfig which enables huge pages), so:
>
>      Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
>
> Thanks,
>      Paul
