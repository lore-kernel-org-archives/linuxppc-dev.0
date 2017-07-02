Return-Path: <srs0=ijva=6f=intel.com=fengguang.wu@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x0lP92YwYzDr2P
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jul 2017 19:30:37 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3x0lP90VGhz8vwr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jul 2017 19:30:37 +1000 (AEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3x0lP61lZjz9s65
 for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2017 19:30:25 +1000 (AEST)
Date: Sun, 2 Jul 2017 17:30:05 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kbuild-all@01.org, linuxppc-dev@ozlabs.org, npiggin@gmail.com
Subject: Re: [PATCH 2/2] powerpc: use spin loop primitives in some functions
Message-ID: <201707021731.2m4fORfG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1498652022-10417-2-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.12-rc7 next-20170630]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michael-Ellerman/powerpc-64-implement-spin-loop-primitives/20170630-210421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-ppc6xx_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/io.h:32:0,
                    from arch/powerpc/include/asm/book3s/32/pgtable.h:95,
                    from arch/powerpc/include/asm/book3s/pgtable.h:7,
                    from arch/powerpc/include/asm/pgtable.h:16,
                    from include/linux/mm.h:70,
                    from drivers/soc/fsl/qe/qe.c:23:
   drivers/soc/fsl/qe/qe.c: In function 'qe_issue_cmd':
>> arch/powerpc/include/asm/delay.h:67:3: error: implicit declaration of function 'spin_begin' [-Werror=implicit-function-declaration]
      spin_begin();                                                  \
      ^
>> drivers/soc/fsl/qe/qe.c:142:8: note: in expansion of macro 'spin_event_timeout'
     ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
           ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/include/asm/delay.h:70:4: error: implicit declaration of function 'spin_cpu_relax' [-Werror=implicit-function-declaration]
       spin_cpu_relax();                                      \
       ^
>> drivers/soc/fsl/qe/qe.c:142:8: note: in expansion of macro 'spin_event_timeout'
     ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
           ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/include/asm/delay.h:71:3: error: implicit declaration of function 'spin_end' [-Werror=implicit-function-declaration]
      spin_end();                                                    \
      ^
>> drivers/soc/fsl/qe/qe.c:142:8: note: in expansion of macro 'spin_event_timeout'
     ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
           ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/powerpc/include/asm/io.h:32:0,
                    from arch/powerpc/include/asm/book3s/32/pgtable.h:95,
                    from arch/powerpc/include/asm/book3s/pgtable.h:7,
                    from arch/powerpc/include/asm/pgtable.h:16,
                    from include/linux/mm.h:70,
                    from drivers/soc//fsl/qe/qe.c:23:
   drivers/soc//fsl/qe/qe.c: In function 'qe_issue_cmd':
>> arch/powerpc/include/asm/delay.h:67:3: error: implicit declaration of function 'spin_begin' [-Werror=implicit-function-declaration]
      spin_begin();                                                  \
      ^
   drivers/soc//fsl/qe/qe.c:142:8: note: in expansion of macro 'spin_event_timeout'
     ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
           ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/include/asm/delay.h:70:4: error: implicit declaration of function 'spin_cpu_relax' [-Werror=implicit-function-declaration]
       spin_cpu_relax();                                      \
       ^
   drivers/soc//fsl/qe/qe.c:142:8: note: in expansion of macro 'spin_event_timeout'
     ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
           ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/include/asm/delay.h:71:3: error: implicit declaration of function 'spin_end' [-Werror=implicit-function-declaration]
      spin_end();                                                    \
      ^
   drivers/soc//fsl/qe/qe.c:142:8: note: in expansion of macro 'spin_event_timeout'
     ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
           ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/spin_begin +67 arch/powerpc/include/asm/delay.h

    61	                                                                               \
    62		if (delay) {                                                           \
    63			while (!(__ret = (condition)) &&                               \
    64					(tb_ticks_since(__start) <= __loops))          \
    65				udelay(delay);                                         \
    66		} else {                                                               \
  > 67			spin_begin();                                                  \
    68			while (!(__ret = (condition)) &&                               \
    69					(tb_ticks_since(__start) <= __loops))          \
  > 70				spin_cpu_relax();                                      \
  > 71			spin_end();                                                    \
    72		}                                                                      \
    73		if (!__ret)                                                            \
    74			__ret = (condition);                                           \

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ByA59GJS0gEA

--azLHFNyN32YCQGCU--
