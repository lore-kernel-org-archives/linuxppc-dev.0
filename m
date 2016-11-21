Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMdqF0xcszDt1l
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:24:25 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tMdqD2yGhz9t1F
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2016 17:24:24 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so27644934pga.2
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2016 22:24:24 -0800 (PST)
Subject: Re: [PATCH] powerpc/xmon: Add support for dump in reverse
To: kbuild test robot <lkp@intel.com>
References: <201611181011.JmH0m3H9%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <044f9dc1-c2aa-9798-f5ca-5bfb4796ef42@gmail.com>
Date: Mon, 21 Nov 2016 17:24:17 +1100
MIME-Version: 1.0
In-Reply-To: <201611181011.JmH0m3H9%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18/11/16 13:02, kbuild test robot wrote:
> Hi Balbir,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.9-rc5 next-20161117]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/powerpc-xmon-Add-support-for-dump-in-reverse/20161118-081358
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-ppc64e_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/xmon/xmon.c: In function 'prdump':
>>> arch/powerpc/xmon/xmon.c:2431:10: error: 'idx' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>          idx -= 2;
>          ~~~~^~~~
>    cc1: all warnings being treated as errors
> 
> vim +/idx +2431 arch/powerpc/xmon/xmon.c
> 
>   2425				}
>   2426	
>   2427				if (m < nr) {
>   2428					if (reverse) {
>   2429						buf[idx + 1] = digithex(temp[m] % 16);
>   2430						buf[idx] = digithex(temp[m] / 16);
>> 2431						idx -= 2;
>   2432					} else
>   2433						printf("%.2x", temp[m]);
>   2434				} else
> 

This seems like a false positive, I don't see it with gcc 5.3.1 on my system. I also tried with gcc 6.2.0
I tried with the same config as attached with the email in the reported failure. I'll try to get the debian
6.1.1 compiler and see how that goes.

Balbir Singh.
