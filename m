Return-Path: <fengguang.wu@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzGrb6pJWzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 19:00:30 +1000 (AEST)
Date: Thu, 6 Apr 2017 16:59:49 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] powerpc/64s: cpufeatures: add initial implementation
 for cpufeatures
Message-ID: <201704061608.7qHsw9bE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
In-Reply-To: <20170405123706.6081-4-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.11-rc5 next-20170406]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/latest-cpufeatures-patch-series/20170406-140710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/prom.c: In function 'early_init_dt_scan_cpufeatures':
>> arch/powerpc/kernel/prom.c:508:2: error: 'has_cpufeatures_node' undeclared (first use in this function)
     has_cpufeatures_node = 1;
     ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/prom.c:508:2: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/kernel/prom.c: In function 'early_init_dt_scan_cpus':
   arch/powerpc/kernel/prom.c:631:7: error: 'has_cpufeatures_node' undeclared (first use in this function)
     if (!has_cpufeatures_node) {
          ^~~~~~~~~~~~~~~~~~~~

vim +/has_cpufeatures_node +508 arch/powerpc/kernel/prom.c

   502			printk("cpu-features node has missing property \"isa\"\n");
   503			return 0;
   504		}
   505	
   506		isa = be32_to_cpup(prop);
   507	
 > 508		has_cpufeatures_node = 1;
   509	
   510		/* Count and allocate space for cpu features */
   511		of_scan_flat_dt_subnodes(node, count_cpufeatures_subnodes,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Djvc8rarU2/6PdKa/QGrih1IElYAAA==

--+HP7ph2BbKc20aGI--
