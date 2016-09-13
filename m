Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYK2g4ZT3zDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 19:22:35 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id pp5so8992298pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:22:35 -0700 (PDT)
Date: Tue, 13 Sep 2016 19:22:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: Re: [PATCH 3/8] powerpc/pseries: exception vector macros
Message-ID: <20160913192226.4f9829da@roar.ozlabs.ibm.com>
In-Reply-To: <201609131452.RDEmDTIt%fengguang.wu@intel.com>
References: <20160913030846.29790-4-npiggin@gmail.com>
 <201609131452.RDEmDTIt%fengguang.wu@intel.com>
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

On Tue, 13 Sep 2016 14:56:47 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Nicholas,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.8-rc6 next-20160912]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-64-use-asm-sections-for-head-exception-layout/20160913-113052
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/built-in.o: In function `.arch_local_irq_restore':
> >> (.text+0x7390): undefined reference to `.__replay_interrupt'  

Ah, __replay_interrupt lost its _GLOBAL annotation, that must be
it. I'm not sure why I didn't see this -- I tested big endian build...
I'll fix that up.
