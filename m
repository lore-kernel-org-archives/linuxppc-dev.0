Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjPpW1nm6zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 20:25:55 +1000 (AEST)
Subject: Re: [PATCH v2 1/9] powerpc/lib/code-patching: Enhance code patching
To: Balbir Singh <bsingharora@gmail.com>
Cc: paulus@samba.org, kbuild-all@01.org, naveen.n.rao@linux.vnet.ibm.com,
 labbott@redhat.com, linuxppc-dev@lists.ozlabs.org, rashmica.g@gmail.com
References: <201706040706.WevfghQQ%fengguang.wu@intel.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <9c856cc0-4a3d-c59f-5215-63437187a289@c-s.fr>
Date: Wed, 7 Jun 2017 12:25:47 +0200
MIME-Version: 1.0
In-Reply-To: <201706040706.WevfghQQ%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir

Le 04/06/2017 à 01:45, kbuild test robot a écrit :
> Hi Balbir,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.12-rc3 next-20170602]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/Enable-STRICT_KERNEL_RWX/20170603-161759
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-kilauea_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc
>
> All errors (new ones prefixed by >>):
>
>     arch/powerpc/lib/code-patching.c: In function 'kernel_map_addr':
>>> arch/powerpc/lib/code-patching.c:93:8: error: implicit declaration of function 'map_kernel_page' [-Werror=implicit-function-declaration]
>       err = map_kernel_page(
>             ^~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors

You should probably include my patch (the one renaming map_page() to 
map_kernel_page() ) in as first patch in your serie in order to get a 
clean serie and avoid such reports from the robot.

Christophe

>
> vim +/map_kernel_page +93 arch/powerpc/lib/code-patching.c
>
>      87	
>      88		if (is_vmalloc_addr(addr))
>      89			pfn = vmalloc_to_pfn(addr);
>      90		else
>      91			pfn = __pa_symbol(addr) >> PAGE_SHIFT;
>      92	
>    > 93		err = map_kernel_page(
>      94				(unsigned long)__this_cpu_read(text_poke_area)->addr,
>      95				(pfn << PAGE_SHIFT), _PAGE_KERNEL_RW | _PAGE_PRESENT);
>      96		pr_devel("Mapped addr %p with pfn %lx\n",
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
