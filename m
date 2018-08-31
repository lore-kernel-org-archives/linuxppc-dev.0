Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421ndc2vfWzF38C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 15:16:19 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id b11-v6so4960404pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 22:16:19 -0700 (PDT)
Date: Fri, 31 Aug 2018 15:16:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/64s: reimplement book3s idle code in C
Message-ID: <20180831151612.49a9fc1a@roar.ozlabs.ibm.com>
In-Reply-To: <201808311247.QqpNQQ2W%fengguang.wu@intel.com>
References: <20180828123520.1034-1-npiggin@gmail.com>
 <201808311247.QqpNQQ2W%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 31 Aug 2018 12:38:19 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Nicholas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.19-rc1 next-20180830]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-64s-reimplement-book3s-idle-code-in-C/20180829-014912
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-skiroot_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/powerpc/platforms/powernv/idle.c:773:22: error: 'power9_offline_stop' defined but not used [-Werror=unused-function]  
>     static unsigned long power9_offline_stop(unsigned long psscr)
>                          ^~~~~~~~~~~~~~~~~~~
> >> arch/powerpc/platforms/powernv/idle.c:486:22: error: 'power7_offline' defined but not used [-Werror=unused-function]  
>     static unsigned long power7_offline(void)
>                          ^~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +/power9_offline_stop +773 arch/powerpc/platforms/powernv/idle.c
> 
>    772	
>  > 773	static unsigned long power9_offline_stop(unsigned long psscr)  
>    774	{
>    775		unsigned long srr1;
>    776	

Ahh, no hotplug. Good bot.

Thanks,
Nick
