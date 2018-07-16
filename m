Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TX1k5QYHzF36j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 15:25:46 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6G5Nite012969
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 01:25:44 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k8gg80nhv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 01:25:44 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 16 Jul 2018 01:25:42 -0400
Date: Mon, 16 Jul 2018 10:55:36 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kbuild-all@01.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved
 big-cores
Reply-To: ego@linux.vnet.ibm.com
References: <03b97f95b42a9044a4280c318a92ac5e53e79828.1530867876.git.ego@linux.vnet.ibm.com>
 <201807111509.TCWIHpaa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201807111509.TCWIHpaa%fengguang.wu@intel.com>
Message-Id: <20180716052536.GA13503@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wed, Jul 11, 2018 at 04:32:30PM +0800, kbuild test robot wrote:
> Hi Gautham,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.18-rc4 next-20180710]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gautham-R-Shenoy/powerpc-Detect-the-presence-of-big-cores-via-ibm-thread-groups/20180706-174756
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-g5_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/static_key.h:1:0,
>                     from include/linux/context_tracking_state.h:6,
>                     from include/linux/vtime.h:5,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/serial_core.h:25,
>                     from include/linux/serial_8250.h:14,
>                     from arch/powerpc/kernel/setup-common.c:33:
>    arch/powerpc/kernel/setup-common.c: In function 'smp_setup_cpu_maps':
> >> arch/powerpc/kernel/setup-common.c:777:25: error: 'cpu_feature_keys' undeclared (first use in this function); did you mean 'setup_feature_keys'?
>       static_branch_enable(&cpu_feature_keys[key]);

Ok, so this needs to be enabled only on CONFIG_PPC_PSERIES and
CONFIG_PPC_POWERNV. Will fix this.


--
Thanks and Regards
gautham.
