Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 217631A0324
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Mar 2016 09:33:44 +1100 (AEDT)
Message-ID: <1457217217.5360.106.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Tang Yuantian <Yuantian.Tang@feescale.com>, jwboyer@linux.vnet.ibm.com,
 mporter@kernel.crashing.org, chenhui zhao <chenhui.zhao@freescale.com>
Date: Sat, 05 Mar 2016 16:33:37 -0600
In-Reply-To: <201603052223.m2Exz413%fengguang.wu@intel.com>
References: <201603052223.m2Exz413%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [scottwood:next 14/16] warning: (PPC_PSERIES && ..) selects
 HOTPLUG_CPU which has unmet direct dependencies (SMP && ..))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-03-05 at 22:37 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux next
> head:   ea6370d23c919127b2cd204af213223a89457477
> commit: 2f4f1f815bc6d03ea42d4f67dd1e284525e7524e [14/16] powerpc/mpc85xx:
> Add hotplug support on E5500 and E500MC cores
> config: powerpc-iss476-smp_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp
> -tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 2f4f1f815bc6d03ea42d4f67dd1e284525e7524e
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All warnings (new ones prefixed by >>):
> 
> warning: (PPC_PSERIES && PM_SLEEP_SMP) selects HOTPLUG_CPU which has unmet
> direct dependencies (SMP && (PPC_PSERIES || PPC_PMAC || PPC_POWERNV ||
> FSL_SOC_BOOKE))

I see this with the attached config without the above commit, or anything else
I've pushed.  I see it with vanilla v4.4, v4.0, v3.0...

I guess it's flagged because the list of dependencies changed, but it's a 4xx
problem, not FSL.  4xx should not claim that suspend/hibernate is possible
with SMP, unless it supports CPU hotplug.

-Scott
