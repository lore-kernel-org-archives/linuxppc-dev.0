Return-Path: <lkp@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gk524DbCzF3PZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 16:21:24 +1000 (AEST)
Date: Fri, 21 Sep 2018 14:20:15 +0800
From: kbuild test robot <lkp@intel.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 3/3] powerpc/sysfs: Add
 topology/smallcore_thread_siblings[_list]
Message-ID: <201809211407.677jNLUN%fengguang.wu@intel.com>
References: <1537464159-25919-4-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <1537464159-25919-4-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gautham,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gautham-R-Shenoy/powerpc-Detection-and-scheduler-optimization-for-POWER9-bigcore/20180921-085812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-mpc837x_mds_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/sysfs.c: In function 'smallcore_thread_siblings_show':
>> arch/powerpc/kernel/sysfs.c:724:45: error: implicit declaration of function 'cpu_smallcore_mask'; did you mean 'cpu_all_mask'? [-Werror=implicit-function-declaration]
     return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
                                                ^~~~~~~~~~~~~~~~~~
                                                cpu_all_mask
>> arch/powerpc/kernel/sysfs.c:724:45: error: passing argument 3 of 'cpumap_print_to_pagebuf' makes pointer from integer without a cast [-Werror=int-conversion]
   In file included from include/linux/rcupdate.h:44:0,
                    from include/linux/radix-tree.h:28,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from arch/powerpc/kernel/sysfs.c:1:
   include/linux/cpumask.h:892:1: note: expected 'const struct cpumask *' but argument is of type 'int'
    cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
    ^~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/sysfs.c: In function 'smallcore_thread_siblings_list_show':
   arch/powerpc/kernel/sysfs.c:734:44: error: passing argument 3 of 'cpumap_print_to_pagebuf' makes pointer from integer without a cast [-Werror=int-conversion]
     return cpumap_print_to_pagebuf(true, buf, cpu_smallcore_mask(cpu));
                                               ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/rcupdate.h:44:0,
                    from include/linux/radix-tree.h:28,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from arch/powerpc/kernel/sysfs.c:1:
   include/linux/cpumask.h:892:1: note: expected 'const struct cpumask *' but argument is of type 'int'
    cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
    ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +724 arch/powerpc/kernel/sysfs.c

   717	
   718	static ssize_t smallcore_thread_siblings_show(struct device *dev,
   719						struct device_attribute *attr,
   720						char *buf)
   721	{
   722		int cpu = dev->id;
   723	
 > 724		return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
   725	}
   726	static DEVICE_ATTR_RO(smallcore_thread_siblings);
   727	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
