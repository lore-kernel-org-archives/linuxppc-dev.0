Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjzF2QDkzDw6y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:35:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kbuild test robot <lkp@intel.com>, linuxppc-dev@ozlabs.org,
 kbuild-all@01.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] powerpc/64: Provide functions for accessing POWER9
 partition table
In-Reply-To: <20161122211514.GA6487@fergus.ozlabs.ibm.com>
References: <201611211551.D3xry2wx%fengguang.wu@intel.com>
 <87k2bvvkwl.fsf@concordia.ellerman.id.au>
 <20161122211514.GA6487@fergus.ozlabs.ibm.com>
Date: Wed, 23 Nov 2016 11:35:04 +1100
Message-ID: <8760nfuj7r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Nov 22, 2016 at 10:00:58PM +1100, Michael Ellerman wrote:
>> kbuild test robot <lkp@intel.com> writes:
>> > [auto build test WARNING on powerpc/next]
>> > [cannot apply to v4.9-rc6 next-20161117]
>> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> >
>> > url:    https://github.com/0day-ci/linux/commits/Paul-Mackerras/powerpc-64-Preparation-for-KVM-support-on-POWER9/20161121-133431
>> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>> > config: powerpc-allyesconfig (attached as .config)
>> > compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> > reproduce:
>> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         # save the attached .config to linux build tree
>> >         make.cross ARCH=powerpc 
>> >
>> > All warnings (new ones prefixed by >>):
>> >
>> >>> WARNING: vmlinux.o(.text+0x5c650): Section mismatch in reference from the function .mmu_partition_table_init() to the function .init.text:.memblock_alloc_base()
>> >    The function .mmu_partition_table_init() references
>> >    the function __init .memblock_alloc_base().
>> 
>> >    This is often because .mmu_partition_table_init lacks a __init
>> 
>> Indeed that looks like the problem.
>> 
>> Paul have you already merged the topic branch, or can I squash in a fix
>> for this? Or I'll just do it on top.
>
> I haven't pushed out the merge, so go ahead.

OK done. I also pulled in Mikey's HFSCR patch.

New HEAD is 02ed21aeda0e ("powerpc/powernv: Define and set POWER9 HFSCR
doorbell bit").

cheers
