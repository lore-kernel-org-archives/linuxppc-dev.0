Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qknbn4vbVzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:20:05 +1000 (AEST)
Message-ID: <1460467199.23581.3.camel@ellerman.id.au>
Subject: Re: [PATCH] lib/test-hexdump: Changed to work on BE
From: Michael Ellerman <mpe@ellerman.id.au>
To: kbuild test robot <lkp@intel.com>, Rashmica Gupta <rashmicy@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Apr 2016 23:19:59 +1000
In-Reply-To: <201604121734.YNETaRqP%fengguang.wu@intel.com>
References: <201604121734.YNETaRqP%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-04-12 at 17:39 +0800, kbuild test robot wrote:
> Hi Rashmica,
> 
> [auto build test WARNING on v4.6-rc3]
> [also build test WARNING on next-20160412]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Rashmica-Gupta/lib-test-hexdump-Changed-to-work-on-BE/20160412-133656
> config: mn10300-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mn10300 
> 
> All warnings (new ones prefixed by >>):

> > > /kbuild/src/defs/lib/test_hexdump.c:45:7: warning: "__BIG_ENDIAN" is not defined [-Wundef]
>     #elif __BIG_ENDIAN

I think you want:

#elif __BYTE_ORDER == __BIG_ENDIAN

?

cheers
