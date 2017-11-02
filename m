Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS8YX40xzzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 13:44:16 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p9so3776735pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 19:44:16 -0700 (PDT)
Message-ID: <1509590647.13316.2.camel@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Don't enable FP/Altivec if not checkpointed
From: Cyril Bur <cyrilbur@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 andrew@aj.id.au, gromero@linux.vnet.ibm.com, jk@ozlabs.org,
 leitao@debian.org,  sam@mendozajonas.com
Date: Thu, 02 Nov 2017 13:44:07 +1100
In-Reply-To: <201711021042.1na3YaBu%fengguang.wu@intel.com>
References: <20171030053913.20455-1-cyrilbur@gmail.com>
 <201711021042.1na3YaBu%fengguang.wu@intel.com>
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

On Thu, 2017-11-02 at 10:19 +0800, kbuild test robot wrote:
> Hi Cyril,
> 
> Thank you for the patch! Yet something to improve:
> 

Once again robot, you have done brilliantly! You're 100% correct and
the last thing I want to do is break the build with
CONFIG_PPC_TRANSACTIONAL_MEM turned off.

Life saver,
Thanks so much kbuild.

Cyril

> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.14-rc7 next-20171018]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Cyril-Bur/powerpc-Don-t-enable-FP-Altivec-if-not-checkpointed/20171102-073816
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-asp8347_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/process.c: In function 'is_transactionally_fp':
> > > arch/powerpc/kernel/process.c:243:15: error: 'struct thread_struct' has no member named 'ckpt_regs'
> 
>       (tsk->thread.ckpt_regs.msr & MSR_FP);
>                   ^
>    arch/powerpc/kernel/process.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
>     }
>     ^
>    cc1: all warnings being treated as errors
> 
> vim +243 arch/powerpc/kernel/process.c
> 
>    239	
>    240	static int is_transactionally_fp(struct task_struct *tsk)
>    241	{
>    242		return msr_tm_active(tsk->thread.regs->msr) &&
>  > 243			(tsk->thread.ckpt_regs.msr & MSR_FP);
>    244	}
>    245	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
