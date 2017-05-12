Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPYZq4jzQzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 May 2017 01:20:51 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id i63so8004063pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 08:20:51 -0700 (PDT)
Date: Sat, 13 May 2017 01:20:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] powerpc/64: do not link crtsaveres.o in boot
Message-ID: <20170513012034.4a1e1e0b@roar.ozlabs.ibm.com>
In-Reply-To: <201705122254.NcdH9aIB%fengguang.wu@intel.com>
References: <20170511155652.8287-4-npiggin@gmail.com>
 <201705122254.NcdH9aIB%fengguang.wu@intel.com>
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

On Fri, 12 May 2017 22:19:29 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Nicholas,
> 
> [auto build test ERROR on next-20170511]
> [also build test ERROR on v4.11]
> [cannot apply to powerpc/next v4.9-rc8 v4.9-rc7 v4.9-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/Register-save-restore-function-build-improvements/20170512-075435
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/boot/of.o: In function `of_try_claim':
> >> of.c:(.text+0x88): undefined reference to `_restgpr_28_x'  

I didn't account for PPC64 && !PPC64_BOOT_WRAPPER case there. Will fix.
