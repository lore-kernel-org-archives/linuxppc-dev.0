Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x22b.google.com (mail-pg0-x22b.google.com
 [IPv6:2607:f8b0:400e:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XySD75l2zDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 14:26:51 +1000 (AEST)
Received: by mail-pg0-x22b.google.com with SMTP id i29-v6so2882825pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 21:26:51 -0700 (PDT)
Date: Fri, 27 Apr 2018 18:21:00 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] KVM: PPC: add pt_regs into kvm_vcpu_arch and move
 vcpu->arch.gpr[] into it
Message-ID: <20180427102031.GA8588@simonLocalRHEL7.x64>
References: <1524657284-16706-2-git-send-email-wei.guo.simon@gmail.com>
 <201804271051.wQFsyZAy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201804271051.wQFsyZAy%fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2018 at 11:47:21AM +0800, kbuild test robot wrote:
> Hi Simon,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.17-rc2 next-20180426]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/wei-guo-simon-gmail-com/KVM-PPC-add-pt_regs-into-kvm_vcpu_arch-and-move-vcpu-arch-gpr-into-it/20180427-055410
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> Note: the linux-review/wei-guo-simon-gmail-com/KVM-PPC-add-pt_regs-into-kvm_vcpu_arch-and-move-vcpu-arch-gpr-into-it/20180427-055410 HEAD 92a7de2f1920f80f57d625d6d07731a00ea99161 builds fine.
>       It only hurts bisectibility.
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/powerpc/include/asm/kvm_book3s.h:271:0,
>                     from arch/powerpc/kernel/asm-offsets.c:57:
>    arch/powerpc/include/asm/kvm_book3s_64.h: In function 'copy_from_checkpoint':
> >> arch/powerpc/include/asm/kvm_book3s_64.h:493:20: error: 'struct kvm_vcpu_arch' has no member named 'gpr'; did you mean 'qpr'?
>      memcpy(vcpu->arch.gpr, vcpu->arch.gpr_tm,
>                        ^~~
>                        qpr
>    arch/powerpc/include/asm/kvm_book3s_64.h:494:27: error: 'struct kvm_vcpu_arch' has no member named 'gpr'; did you mean 'qpr'?
>             sizeof(vcpu->arch.gpr));
>                               ^~~
>                               qpr
>    arch/powerpc/include/asm/kvm_book3s_64.h: In function 'copy_to_checkpoint':
>    arch/powerpc/include/asm/kvm_book3s_64.h:510:39: error: 'struct kvm_vcpu_arch' has no member named 'gpr'; did you mean 'qpr'?
>      memcpy(vcpu->arch.gpr_tm, vcpu->arch.gpr,
>                                           ^~~
>                                           qpr
>    arch/powerpc/include/asm/kvm_book3s_64.h:511:27: error: 'struct kvm_vcpu_arch' has no member named 'gpr'; did you mean 'qpr'?
>             sizeof(vcpu->arch.gpr));
>                               ^~~
>                               qpr
>    In file included from arch/powerpc/kernel/asm-offsets.c:30:0:
>    arch/powerpc/kernel/asm-offsets.c: In function 'main':
> >> include/linux/compiler-gcc.h:170:2: error: 'struct kvm_vcpu_arch' has no member named 'nip'
>      __builtin_offsetof(a, b)
>      ^
>    include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
>      asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
>                                                                  ^~~
>    include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
>     #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
>                                    ^~~~~~~~~~~~~~~~~~~
> >> include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
>      DEFINE(sym, offsetof(struct str, mem))
>                  ^~~~~~~~
> >> arch/powerpc/kernel/asm-offsets.c:441:2: note: in expansion of macro 'OFFSET'
>      OFFSET(VCPU_PC, kvm_vcpu, arch.nip);
>      ^~~~~~
>    make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
> 
> vim +493 arch/powerpc/include/asm/kvm_book3s_64.h
> 
> 4bb3c7a0 Paul Mackerras 2018-03-21  481  
> 4bb3c7a0 Paul Mackerras 2018-03-21  482  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> 4bb3c7a0 Paul Mackerras 2018-03-21  483  static inline void copy_from_checkpoint(struct kvm_vcpu *vcpu)
> 4bb3c7a0 Paul Mackerras 2018-03-21  484  {
> 4bb3c7a0 Paul Mackerras 2018-03-21  485  	vcpu->arch.cr  = vcpu->arch.cr_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  486  	vcpu->arch.xer = vcpu->arch.xer_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  487  	vcpu->arch.lr  = vcpu->arch.lr_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  488  	vcpu->arch.ctr = vcpu->arch.ctr_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  489  	vcpu->arch.amr = vcpu->arch.amr_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  490  	vcpu->arch.ppr = vcpu->arch.ppr_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  491  	vcpu->arch.dscr = vcpu->arch.dscr_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  492  	vcpu->arch.tar = vcpu->arch.tar_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21 @493  	memcpy(vcpu->arch.gpr, vcpu->arch.gpr_tm,
> 4bb3c7a0 Paul Mackerras 2018-03-21  494  	       sizeof(vcpu->arch.gpr));
> 4bb3c7a0 Paul Mackerras 2018-03-21  495  	vcpu->arch.fp  = vcpu->arch.fp_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  496  	vcpu->arch.vr  = vcpu->arch.vr_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  497  	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
> 4bb3c7a0 Paul Mackerras 2018-03-21  498  }
> 4bb3c7a0 Paul Mackerras 2018-03-21  499  
> 
> :::::: The code at line 493 was first introduced by commit
> :::::: 4bb3c7a0208fc13ca70598efd109901a7cd45ae7 KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9
> 
> :::::: TO: Paul Mackerras <paulus@ozlabs.org>
> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Somehow I put some code (which should have been in PATCH 01) into
PATCH 02 while splitting the patches, and it lead to the error. I
will correct it in V2.

Thanks,
- Simon
