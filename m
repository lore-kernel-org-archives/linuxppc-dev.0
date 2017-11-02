Return-Path: <philip.li@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS8zz3qmLzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 14:03:40 +1100 (AEDT)
Date: Thu, 2 Nov 2017 11:06:49 +0800
From: Philip Li <philip.li@intel.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, andrew@aj.id.au,
 gromero@linux.vnet.ibm.com, jk@ozlabs.org, leitao@debian.org,
 sam@mendozajonas.com
Subject: Re: [PATCH 1/2] powerpc: Don't enable FP/Altivec if not checkpointed
Message-ID: <20171102030649.GA7418@intel.com>
References: <20171030053913.20455-1-cyrilbur@gmail.com>
 <201711021042.1na3YaBu%fengguang.wu@intel.com>
 <1509590647.13316.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509590647.13316.2.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 02, 2017 at 01:44:07PM +1100, Cyril Bur wrote:
> On Thu, 2017-11-02 at 10:19 +0800, kbuild test robot wrote:
> > Hi Cyril,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> 
> Once again robot, you have done brilliantly! You're 100% correct and
> the last thing I want to do is break the build with
> CONFIG_PPC_TRANSACTIONAL_MEM turned off.
> 
> Life saver,
> Thanks so much kbuild.
Thanks Cyril, we are glad to do some help.

> 
> Cyril
> 
> > [auto build test ERROR on powerpc/next]
> > [also build test ERROR on v4.14-rc7 next-20171018]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Cyril-Bur/powerpc-Don-t-enable-FP-Altivec-if-not-checkpointed/20171102-073816
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> > config: powerpc-asp8347_defconfig (attached as .config)
> > compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=powerpc 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/powerpc/kernel/process.c: In function 'is_transactionally_fp':
> > > > arch/powerpc/kernel/process.c:243:15: error: 'struct thread_struct' has no member named 'ckpt_regs'
> > 
> >       (tsk->thread.ckpt_regs.msr & MSR_FP);
> >                   ^
> >    arch/powerpc/kernel/process.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
> >     }
> >     ^
> >    cc1: all warnings being treated as errors
> > 
> > vim +243 arch/powerpc/kernel/process.c
> > 
> >    239	
> >    240	static int is_transactionally_fp(struct task_struct *tsk)
> >    241	{
> >    242		return msr_tm_active(tsk->thread.regs->msr) &&
> >  > 243			(tsk->thread.ckpt_regs.msr & MSR_FP);
> >    244	}
> >    245	
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
