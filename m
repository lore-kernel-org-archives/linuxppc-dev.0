Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H0jz5X9xzF3QR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 03:20:55 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8LHJLKf019381
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 13:20:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mn4u4gaaw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 13:20:53 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Sep 2018 13:20:52 -0400
Date: Fri, 21 Sep 2018 22:50:45 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kbuild-all@01.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] powerpc/sysfs: Add
 topology/smallcore_thread_siblings[_list]
Reply-To: ego@linux.vnet.ibm.com
References: <1537464159-25919-4-git-send-email-ego@linux.vnet.ibm.com>
 <201809211407.677jNLUN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201809211407.677jNLUN%fengguang.wu@intel.com>
Message-Id: <20180921172045.GB12919@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Fri, Sep 21, 2018 at 02:20:15PM +0800, kbuild test robot wrote:
> Hi Gautham,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.19-rc4 next-20180919]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gautham-R-Shenoy/powerpc-Detection-and-scheduler-optimization-for-POWER9-bigcore/20180921-085812
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-mpc837x_mds_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/sysfs.c: In function 'smallcore_thread_siblings_show':
> >> arch/powerpc/kernel/sysfs.c:724:45: error: implicit declaration of function 'cpu_smallcore_mask'; did you mean 'cpu_all_mask'? [-Werror=implicit-function-declaration]
>      return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
>                                                 ^~~~~~~~~~~~~~~~~~


No, the smallcore_thread_siblings_show, and the other functions should
only be compiled for CONFIG_SMP.


Will add this. Thanks bot!

>                                                 cpu_all_mask
> >> arch/powerpc/kernel/sysfs.c:724:45: error: passing argument 3 of 'cpumap_print_to_pagebuf' makes pointer from integer without a cast [-Werror=int-conversion]
>    In file included from include/linux/rcupdate.h:44:0,
>                     from include/linux/radix-tree.h:28,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:14,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from arch/powerpc/kernel/sysfs.c:1:
>    include/linux/cpumask.h:892:1: note: expected 'const struct cpumask *' but argument is of type 'int'
>     cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
>     ^~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/kernel/sysfs.c: In function 'smallcore_thread_siblings_list_show':
>    arch/powerpc/kernel/sysfs.c:734:44: error: passing argument 3 of 'cpumap_print_to_pagebuf' makes pointer from integer without a cast [-Werror=int-conversion]
>      return cpumap_print_to_pagebuf(true, buf, cpu_smallcore_mask(cpu));
>                                                ^~~~~~~~~~~~~~~~~~
>    In file included from include/linux/rcupdate.h:44:0,
>                     from include/linux/radix-tree.h:28,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:14,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from arch/powerpc/kernel/sysfs.c:1:
>    include/linux/cpumask.h:892:1: note: expected 'const struct cpumask *' but argument is of type 'int'
>     cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
>     ^~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +724 arch/powerpc/kernel/sysfs.c
> 
>    717	
>    718	static ssize_t smallcore_thread_siblings_show(struct device *dev,
>    719						struct device_attribute *attr,
>    720						char *buf)
>    721	{
>    722		int cpu = dev->id;
>    723	
>  > 724		return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
>    725	}
>    726	static DEVICE_ATTR_RO(smallcore_thread_siblings);
>    727	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
