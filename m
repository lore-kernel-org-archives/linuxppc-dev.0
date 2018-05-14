Return-Path: <fengguang.wu@intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kt2h43GpzF3Rh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 17:42:32 +1000 (AEST)
Date: Mon, 14 May 2018 15:42:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, linux-kbuild@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 4/4] powerpc/kbuild: move -mprofile-kernel check to
 Kconfig
Message-ID: <201805141437.vHS2TLQv%fengguang.wu@intel.com>
References: <20180514035228.21316-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514035228.21316-5-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-patches-for-new-Kconfig-language/20180514-120748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-defconfig
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        make.cross ARCH=powerpc  defconfig
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
>> arch/powerpc/Kconfig:468: syntax error
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
>> arch/powerpc/Kconfig:467: invalid option
   make[2]: *** [defconfig] Error 1
   make[1]: *** [defconfig] Error 2
   make: *** [sub-make] Error 2
--
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
>> arch/powerpc/Kconfig:468: syntax error
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
>> arch/powerpc/Kconfig:467: invalid option
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
>> arch/powerpc/Kconfig:468: syntax error
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
   arch/powerpc/Kconfig:467:warning: ignoring unsupported character '$'
>> arch/powerpc/Kconfig:467: invalid option
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2

vim +468 arch/powerpc/Kconfig

e05c0e81 Kevin Hao       2013-07-16  443  
3d72bbc4 Michael Neuling 2013-02-13  444  config PPC_TRANSACTIONAL_MEM
3d72bbc4 Michael Neuling 2013-02-13  445         bool "Transactional Memory support for POWERPC"
3d72bbc4 Michael Neuling 2013-02-13  446         depends on PPC_BOOK3S_64
3d72bbc4 Michael Neuling 2013-02-13  447         depends on SMP
7b37a123 Michael Neuling 2014-01-08  448         select ALTIVEC
7b37a123 Michael Neuling 2014-01-08  449         select VSX
3d72bbc4 Michael Neuling 2013-02-13  450         default n
3d72bbc4 Michael Neuling 2013-02-13  451         ---help---
3d72bbc4 Michael Neuling 2013-02-13  452           Support user-mode Transactional Memory on POWERPC.
3d72bbc4 Michael Neuling 2013-02-13  453  
951eedeb Nicholas Piggin 2017-05-29  454  config LD_HEAD_STUB_CATCH
951eedeb Nicholas Piggin 2017-05-29  455  	bool "Reserve 256 bytes to cope with linker stubs in HEAD text" if EXPERT
951eedeb Nicholas Piggin 2017-05-29  456  	depends on PPC64
951eedeb Nicholas Piggin 2017-05-29  457  	default n
951eedeb Nicholas Piggin 2017-05-29  458  	help
951eedeb Nicholas Piggin 2017-05-29  459  	  Very large kernels can cause linker branch stubs to be generated by
951eedeb Nicholas Piggin 2017-05-29  460  	  code in head_64.S, which moves the head text sections out of their
951eedeb Nicholas Piggin 2017-05-29  461  	  specified location. This option can work around the problem.
951eedeb Nicholas Piggin 2017-05-29  462  
951eedeb Nicholas Piggin 2017-05-29  463  	  If unsure, say "N".
951eedeb Nicholas Piggin 2017-05-29  464  
8c50b72a Torsten Duwe    2016-03-03  465  config MPROFILE_KERNEL
8c50b72a Torsten Duwe    2016-03-03  466  	depends on PPC64 && CPU_LITTLE_ENDIAN
53561d2c Nicholas Piggin 2018-05-14 @467  	def_bool $(success $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)
8c50b72a Torsten Duwe    2016-03-03 @468  

:::::: The code at line 468 was first introduced by commit
:::::: 8c50b72a3b4f1f7cdfdfebd233b1cbd121262e65 powerpc/ftrace: Add Kconfig & Make glue for mprofile-kernel

:::::: TO: Torsten Duwe <duwe@lst.de>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
