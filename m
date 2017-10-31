Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR3Hk0RqlzDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 18:43:29 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id b192so13955147pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 00:43:29 -0700 (PDT)
Date: Tue, 31 Oct 2017 18:43:07 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc: use NMI IPI for smp_send_stop
Message-ID: <20171031184307.2e0317c4@roar.ozlabs.ibm.com>
In-Reply-To: <201710240753.BWnpBvpH%fengguang.wu@intel.com>
References: <20171023080507.21974-3-npiggin@gmail.com>
 <201710240753.BWnpBvpH%fengguang.wu@intel.com>
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

On Tue, 24 Oct 2017 07:15:30 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Nicholas,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.14-rc6 next-20171018]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/avoid-secondary-hold-spinloop-when-possible/20171023-173012
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-iss476-smp_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/smp.o: In function `smp_send_stop':
> >> arch/powerpc/kernel/smp.c:563: undefined reference to `smp_send_nmi_ipi'  
> 
> vim +563 arch/powerpc/kernel/smp.c
> 
>    560	
>    561	void smp_send_stop(void)
>    562	{
>  > 563		smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, stop_this_cpu, 1000000);  
>    564	}
>    565	

Good catch, 0day. Thanks.

Rather than have all architectures select NMI_IPI just for this, I
think I'll make it depend on whether NMI_IPI was selected at all.
Otherwise just keep using the normal smp_call_function().

Thanks,
Nick
