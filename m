Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbq0w1pDCzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 18:00:32 +1000 (AEST)
Subject: Re: [PATCH v1 7/8] powerpc/Kconfig: Enable STRICT_KERNEL_RWX
To: kbuild test robot <lkp@intel.com>, Balbir Singh <bsingharora@gmail.com>,
 Laura Abbott <labbott@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: paulus@samba.org, kbuild-all@01.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, rashmica.g@gmail.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <201705260000.CDMt1Ieh%fengguang.wu@intel.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6dcd8ea3-e953-3319-0e0e-8543018e882f@c-s.fr>
Date: Mon, 29 May 2017 10:00:18 +0200
MIME-Version: 1.0
In-Reply-To: <201705260000.CDMt1Ieh%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/05/2017 à 18:45, kbuild test robot a écrit :
> Hi Balbir,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.12-rc2 next-20170525]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/Enable-STRICT_KERNEL_RWX/20170525-150234
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-allmodconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel//power/snapshot.c:40:28: fatal error: asm/set_memory.h: No such file or directory
>      #include <asm/set_memory.h>

Looks like it is linked to commit 50327ddfb ("kernel/power/snapshot.c: 
use set_memory.h header").
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50327ddfb

I believe that inclusion should be conditional to 
CONFIG_ARCH_HAS_SET_MEMORY, which is not set by powerpc arch, just like 
in include/linux/filter.c

Christophe


>                                 ^
>     compilation terminated.
> 
> vim +40 kernel//power/snapshot.c
> 
> 25761b6eb Rafael J. Wysocki    2005-10-30  24  #include <linux/bootmem.h>
> 38b8d208a Ingo Molnar          2017-02-08  25  #include <linux/nmi.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  26  #include <linux/syscalls.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  27  #include <linux/console.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  28  #include <linux/highmem.h>
> 846705deb Rafael J. Wysocki    2008-11-26  29  #include <linux/list.h>
> 5a0e3ad6a Tejun Heo            2010-03-24  30  #include <linux/slab.h>
> 52f5684c8 Gideon Israel Dsouza 2014-04-07  31  #include <linux/compiler.h>
> db5976058 Tina Ruchandani      2014-10-30  32  #include <linux/ktime.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  33
> 7c0f6ba68 Linus Torvalds       2016-12-24  34  #include <linux/uaccess.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  35  #include <asm/mmu_context.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  36  #include <asm/pgtable.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  37  #include <asm/tlbflush.h>
> 25761b6eb Rafael J. Wysocki    2005-10-30  38  #include <asm/io.h>
> 50327ddfb Laura Abbott         2017-05-08  39  #ifdef CONFIG_STRICT_KERNEL_RWX
> 50327ddfb Laura Abbott         2017-05-08 @40  #include <asm/set_memory.h>
> 50327ddfb Laura Abbott         2017-05-08  41  #endif
> 25761b6eb Rafael J. Wysocki    2005-10-30  42
> 25761b6eb Rafael J. Wysocki    2005-10-30  43  #include "power.h"
> 25761b6eb Rafael J. Wysocki    2005-10-30  44
> 0f5bf6d0a Laura Abbott         2017-02-06  45  #ifdef CONFIG_STRICT_KERNEL_RWX
> 4c0b6c10f Rafael J. Wysocki    2016-07-10  46  static bool hibernate_restore_protection;
> 4c0b6c10f Rafael J. Wysocki    2016-07-10  47  static bool hibernate_restore_protection_active;
> 4c0b6c10f Rafael J. Wysocki    2016-07-10  48
> 
> :::::: The code at line 40 was first introduced by commit
> :::::: 50327ddfbc926e68da1958e4fac51f1106f5e730 kernel/power/snapshot.c: use set_memory.h header
> 
> :::::: TO: Laura Abbott <labbott@redhat.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
