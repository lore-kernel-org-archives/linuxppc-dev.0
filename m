Return-Path: <fengguang.wu@intel.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjjkQ5w1LzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 20:22:22 +1000 (AEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by ozlabs.org (Postfix) with ESMTP id 3rjjkP52qMz9spN
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 20:22:20 +1000 (AEST)
Date: Mon, 4 Jul 2016 18:20:56 +0800
From: kbuild test robot <lkp@intel.com>
To: Daniel Axtens <dja@axtens.net>
Cc: kbuild-all@01.org, linuxppc-dev@ozlabs.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 6/6] powerpc/sparse: Make ppc_md.{halt, restart} __noreturn
Message-ID: <201607041827.0IZXiQeO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
In-Reply-To: <1467616182-30886-6-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test WARNING on powerpc/next]
[also build test WARNING on v4.7-rc6 next-20160701]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Axtens/powerpc-kvm-Clarify-__user-annotations/20160704-152727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   arch/powerpc/platforms/powermac/setup.c: In function 'pmac_power_off':
>> arch/powerpc/platforms/powermac/setup.c:449:1: warning: 'noreturn' function does return
    }
    ^
   arch/powerpc/platforms/powermac/setup.c: In function 'pmac_restart':
   arch/powerpc/platforms/powermac/setup.c:433:1: warning: 'noreturn' function does return
    }
    ^

vim +/noreturn +449 arch/powerpc/platforms/powermac/setup.c

14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  433  }
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  434  
4e1324ee arch/powerpc/platforms/powermac/setup.c      Daniel Axtens  2016-07-04  435  static void __noreturn pmac_power_off(void)
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  436  {
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  437  	switch (sys_ctrler) {
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  438  	case SYS_CTRLER_CUDA:
35499c01 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras 2005-10-22  439  		cuda_shutdown();
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  440  		break;
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  441  	case SYS_CTRLER_PMU:
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  442  		pmu_shutdown();
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  443  		break;
35499c01 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras 2005-10-22  444  	case SYS_CTRLER_SMU:
35499c01 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras 2005-10-22  445  		smu_shutdown();
35499c01 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras 2005-10-22  446  		break;
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  447  	default: ;
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  448  	}
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26 @449  }
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  450  
4e1324ee arch/powerpc/platforms/powermac/setup.c      Daniel Axtens  2016-07-04  451  static void __noreturn
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  452  pmac_halt(void)
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  453  {
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  454  	pmac_power_off();
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  455  }
14cf11af arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  456  
35499c01 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras 2005-10-22  457  /* 

:::::: The code at line 449 was first introduced by commit
:::::: 14cf11af6cf608eb8c23e989ddb17a715ddce109 powerpc: Merge enough to start building in arch/powerpc.

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ikeVEW9yuYc//A+q
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ikeVEW9yuYc//A+q--
