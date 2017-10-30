Return-Path: <fengguang.wu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQVxr3Y0dzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 21:26:06 +1100 (AEDT)
Date: Mon, 30 Oct 2017 18:26:00 +0800
From: kbuild test robot <lkp@intel.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/kernel/sysfs: Export ldbar spr to sysfs
Message-ID: <201710301858.NHxEeFGi%fengguang.wu@intel.com>
References: <1509096890-22655-1-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <1509096890-22655-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anju,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.14-rc7 next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anju-T-Sudhakar/powerpc-kernel-sysfs-Export-ldbar-spr-to-sysfs/20171030-155220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-storcenter_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

>> arch/powerpc/kernel/sysfs.c:419:16: error: 'show_ldbar' defined but not used [-Werror=unused-function]
    static ssize_t show_##NAME(struct device *dev, \
                   ^
>> arch/powerpc/kernel/sysfs.c:443:2: note: in expansion of macro '__SYSFS_SPRSETUP_SHOW_STORE'
     __SYSFS_SPRSETUP_SHOW_STORE(NAME)
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sysfs.c:469:1: note: in expansion of macro 'SYSFS_PMCSETUP'
    SYSFS_PMCSETUP(ldbar, SPRN_LDBAR);
    ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/show_ldbar +419 arch/powerpc/kernel/sysfs.c

39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  417  
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  418  #define __SYSFS_SPRSETUP_SHOW_STORE(NAME) \
8a25a2fd arch/powerpc/kernel/sysfs.c Kay Sievers            2011-12-21 @419  static ssize_t show_##NAME(struct device *dev, \
8a25a2fd arch/powerpc/kernel/sysfs.c Kay Sievers            2011-12-21  420  			struct device_attribute *attr, \
4a0b2b4d arch/powerpc/kernel/sysfs.c Andi Kleen             2008-07-01  421  			char *buf) \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  422  { \
8a25a2fd arch/powerpc/kernel/sysfs.c Kay Sievers            2011-12-21  423  	struct cpu *cpu = container_of(dev, struct cpu, dev); \
9a371934 arch/powerpc/kernel/sysfs.c Rusty Russell          2009-03-11  424  	unsigned long val; \
8a25a2fd arch/powerpc/kernel/sysfs.c Kay Sievers            2011-12-21  425  	smp_call_function_single(cpu->dev.id, read_##NAME, &val, 1);	\
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  426  	return sprintf(buf, "%lx\n", val); \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  427  } \
3ff6eecc arch/powerpc/kernel/sysfs.c Adrian Bunk            2008-01-24  428  static ssize_t __used \
8a25a2fd arch/powerpc/kernel/sysfs.c Kay Sievers            2011-12-21  429  	store_##NAME(struct device *dev, struct device_attribute *attr, \
4a0b2b4d arch/powerpc/kernel/sysfs.c Andi Kleen             2008-07-01  430  			const char *buf, size_t count) \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  431  { \
8a25a2fd arch/powerpc/kernel/sysfs.c Kay Sievers            2011-12-21  432  	struct cpu *cpu = container_of(dev, struct cpu, dev); \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  433  	unsigned long val; \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  434  	int ret = sscanf(buf, "%lx", &val); \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  435  	if (ret != 1) \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  436  		return -EINVAL; \
8a25a2fd arch/powerpc/kernel/sysfs.c Kay Sievers            2011-12-21  437  	smp_call_function_single(cpu->dev.id, write_##NAME, &val, 1); \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  438  	return count; \
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  439  }
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  440  
fd7e4296 arch/powerpc/kernel/sysfs.c Madhavan Srinivasan    2013-10-03  441  #define SYSFS_PMCSETUP(NAME, ADDRESS) \
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  442  	__SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, ppc_enable_pmcs()) \
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21 @443  	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
fd7e4296 arch/powerpc/kernel/sysfs.c Madhavan Srinivasan    2013-10-03  444  #define SYSFS_SPRSETUP(NAME, ADDRESS) \
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  445  	__SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, ) \
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  446  	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  447  
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  448  #define SYSFS_SPRSETUP_SHOW_STORE(NAME) \
39a360ef arch/powerpc/kernel/sysfs.c Sam bobroff            2014-05-21  449  	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
6529c13d arch/powerpc/kernel/sysfs.c Olof Johansson         2007-01-28  450  
6529c13d arch/powerpc/kernel/sysfs.c Olof Johansson         2007-01-28  451  /* Let's define all possible registers, we'll only hook up the ones
6529c13d arch/powerpc/kernel/sysfs.c Olof Johansson         2007-01-28  452   * that are implemented on the current processor
6529c13d arch/powerpc/kernel/sysfs.c Olof Johansson         2007-01-28  453   */
6529c13d arch/powerpc/kernel/sysfs.c Olof Johansson         2007-01-28  454  
33a7f122 arch/powerpc/kernel/sysfs.c Kumar Gala             2008-09-18  455  #if defined(CONFIG_PPC64)
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  456  #define HAS_PPC_PMC_CLASSIC	1
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  457  #define HAS_PPC_PMC_IBM		1
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  458  #define HAS_PPC_PMC_PA6T	1
33a7f122 arch/powerpc/kernel/sysfs.c Kumar Gala             2008-09-18  459  #elif defined(CONFIG_6xx)
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  460  #define HAS_PPC_PMC_CLASSIC	1
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  461  #define HAS_PPC_PMC_IBM		1
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  462  #define HAS_PPC_PMC_G4		1
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  463  #endif
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  464  
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  465  
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  466  #ifdef HAS_PPC_PMC_CLASSIC
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  467  SYSFS_PMCSETUP(mmcr0, SPRN_MMCR0);
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  468  SYSFS_PMCSETUP(mmcr1, SPRN_MMCR1);
080163db arch/powerpc/kernel/sysfs.c Anju T Sudhakar        2017-10-27 @469  SYSFS_PMCSETUP(ldbar, SPRN_LDBAR);
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  470  SYSFS_PMCSETUP(pmc1, SPRN_PMC1);
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  471  SYSFS_PMCSETUP(pmc2, SPRN_PMC2);
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  472  SYSFS_PMCSETUP(pmc3, SPRN_PMC3);
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  473  SYSFS_PMCSETUP(pmc4, SPRN_PMC4);
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  474  SYSFS_PMCSETUP(pmc5, SPRN_PMC5);
^1da177e arch/ppc64/kernel/sysfs.c   Linus Torvalds         2005-04-16  475  SYSFS_PMCSETUP(pmc6, SPRN_PMC6);
b950bdd0 arch/powerpc/kernel/sysfs.c Benjamin Herrenschmidt 2008-08-18  476  

:::::: The code at line 419 was first introduced by commit
:::::: 8a25a2fd126c621f44f3aeaef80d51f00fc11639 cpu: convert 'cpu' and 'machinecheck' sysdev_class to a regular subsystem

:::::: TO: Kay Sievers <kay.sievers@vrfy.org>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--a8Wt8u1KmwUX3Y2C
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--a8Wt8u1KmwUX3Y2C--
