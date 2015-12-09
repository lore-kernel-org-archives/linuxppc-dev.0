Return-Path: <fengguang.wu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id B2CF61A101F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 16:09:24 +1100 (AEDT)
Date: Wed, 9 Dec 2015 13:08:55 +0800
From: kbuild test robot <lkp@intel.com>
To: Anton Blanchard <anton@samba.org>
Cc: kbuild-all@01.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, cyrilbur@gmail.com, scottwood@freescale.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Call restore_sprs() on initial context switch
Message-ID: <201512091341.XMocusYY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <20151209153040.6e8f527b@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anton,

[auto build test ERROR on powerpc/next]
[also build test ERROR on next-20151208]
[cannot apply to v4.4-rc4]

url:    https://github.com/0day-ci/linux/commits/Anton-Blanchard/powerpc-Call-restore_sprs-on-initial-context-switch/20151209-123550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/process.c: In function 'restore_sprs':
>> arch/powerpc/kernel/process.c:861:24: error: unused variable 'new_thread' [-Werror=unused-variable]
     struct thread_struct *new_thread = &new->thread;
                           ^
>> arch/powerpc/kernel/process.c:860:24: error: unused variable 'old_thread' [-Werror=unused-variable]
     struct thread_struct *old_thread = &old->thread;
                           ^
   cc1: all warnings being treated as errors

vim +/new_thread +861 arch/powerpc/kernel/process.c

   854	#endif
   855	}
   856	
   857	struct task_struct *restore_sprs(struct task_struct *old,
   858					 struct task_struct *new)
   859	{
 > 860		struct thread_struct *old_thread = &old->thread;
 > 861		struct thread_struct *new_thread = &new->thread;
   862	
   863	#ifdef CONFIG_ALTIVEC
   864		if (cpu_has_feature(CPU_FTR_ALTIVEC) &&

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--bg08WKrSYDhXBjb5
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bg08WKrSYDhXBjb5--
