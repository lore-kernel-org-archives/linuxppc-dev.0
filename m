Return-Path: <linuxppc-dev+bounces-25871-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A0C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:42:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM61m430Nz2yRP;
	Sat, 15 Aug 2026 01:42:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786722172;
	cv=none; b=PS8s4tA6C4rOqevDEKak/W3kJ5EeC+BSOOBBIcBDTchTksEij5MJTX1wtnzz7bPcAMJV4DQDZP81jRkWj7Gtyk/gHNXyXaoWHpKC1g2HRyp5C5fsDuCTNUtJBKmpaLIeER3juiXgXmHCm0C9TuP+VIFO2PXZKsT+alWts4MK6FpyH5SaUytZL1IkONDjygkyEphjdiWGy6meT2o0ObFzNYthJxY2Z1E9tos+1kyPgFAGZcnamiYSw6FGeFC8IEBTFhA/uH2lefWbc+BY/dc+tiWlxwNqp5RmpU4/e1cTaSmLJzxIHC/Z8oLqdhyG7S804p8QKjktpc7XnlI4DkVrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786722172; c=relaxed/relaxed;
	bh=HrCq79AU+KgQBc3hczsRFI1XL6XhXT4TgvuRbwKh7uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doNNfsngDBDWbIxTp1+YqbK8xfLKyIfTx/AMfESDAJOxaO9YXYXo3ER4P0Gx+RZV0TzJ974FMOAnoMFATVJBVFmV+UO3/DyBgoir9wRgPWRZYgl5E4DFO25QD1d87YvHyG5CS52O+FWgpcMJOskv2WpMWwd0V46/r+CA2nzv6Mo4rmyWgl56cmvQhhXWN8PTQohcO5hrURR3mIbnxxYzNq2ZFO4QtZ/5tXMJ/DpYmCmZaL9mpJ7Q5hOivFWYr95rfPL8ZSc5vubBb1UvjgVDLrZ1jV5RVYHaVdx/6dN/5ncsZYAkmaNnA7p11R6b4DAN3LVEe56DxtgpS+hNI4bJDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TwPSHGZP; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TwPSHGZP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM61h3mRmz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 01:42:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786722169; x=1818258169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fxbnJdrTRr0um+4aluXhGRJ2r0C9VsyrarcgZbWR7PM=;
  b=TwPSHGZPFU6g4Eje9XOeF/k9PEowToBg0Hv5LztJtjMbpPLCAQE2ToQE
   9FI/xvjOVMS0aQStTeDYYuiPXfzve42tOjn33wODdrcSzwXtWMy4Aajz1
   fEyY9khTAkzCdoLcLQoEcZ2+eYjrDJtUdyoRCTppT1cfRSFgg3+ihIIC+
   qd0htdAuxMsM4ivSq78lA3oxjuD7eCFHXr3xaiXiPqyetp+j6m1wGS2F9
   4TRs9b4JnpGOBYXudRyfrt47wn+Vw3pWC69jin7rRzvcFl5ygLo0ihwgK
   w/6E4pPjlISQvIPtaxpcBN9Yzj0b5DxjKJZZBcHfa48S2AwHKR0QiYpJU
   g==;
X-CSE-ConnectionGUID: i+hJ3dfHTTuztdmcRIhuVg==
X-CSE-MsgGUID: Wlqzv/3gREekWSjujB6xrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="89820548"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89820548"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 08:42:42 -0700
X-CSE-ConnectionGUID: IGYQR30JQT2Ruf8uvJmfew==
X-CSE-MsgGUID: uof/TsuUTduvQU8tZcs3HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260468820"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2026 08:42:40 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuu3J-00000000ZQY-2zpm;
	Fri, 14 Aug 2026 15:42:37 +0000
Date: Fri, 14 Aug 2026 23:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"(open list:LINUX FOR POWERPC \\(32-BIT AND 64-BIT\\))" <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Connecting the SB600's i8259 controller rather in
 pasemi's pci.c than in pasemi's setup.c.
Message-ID: <202608142355.4AeDorvg-lkp@intel.com>
References: <20260701125941.906-2-chzigotzky@xenosoft.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701125941.906-2-chzigotzky@xenosoft.de>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes linus/master v7.2-rc7 next-20260813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Zigotzky/Connecting-the-SB600-s-i8259-controller-rather-in-pasemi-s-pci-c-than-in-pasemi-s-setup-c/20260813-054214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20260701125941.906-2-chzigotzky%40xenosoft.de
patch subject: [PATCH] Connecting the SB600's i8259 controller rather in pasemi's pci.c than in pasemi's setup.c.
config: powerpc64-randconfig-r052-20260814 (https://download.01.org/0day-ci/archive/20260814/202608142355.4AeDorvg-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260814/202608142355.4AeDorvg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608142355.4AeDorvg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/pasemi/setup.c:217:6: warning: no previous prototype for function 'nemo_init_IRQ' [-Wmissing-prototypes]
     217 | void nemo_init_IRQ(void)
         |      ^
   arch/powerpc/platforms/pasemi/setup.c:217:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     217 | void nemo_init_IRQ(void)
         | ^
         | static 
   1 warning generated.


vim +/nemo_init_IRQ +217 arch/powerpc/platforms/pasemi/setup.c

   216	
 > 217	void nemo_init_IRQ(void)
   218	{
   219		struct device_node *np;
   220		int gpio_virq;
   221	        struct mpic *mpic;
   222	
   223		/* Connect the SB600's legacy i8259 controller */
   224		np = of_find_node_by_path("/pxp@0,e0000000");
   225		i8259_init(np, 0);
   226		of_node_put(np);
   227	
   228		gpio_virq = irq_create_mapping(NULL, 3);
   229		irq_set_irq_type(gpio_virq, IRQ_TYPE_LEVEL_HIGH);
   230		irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
   231		mpic_unmask_irq(irq_get_irq_data(gpio_virq));
   232	
   233		mpic = irq_get_chip_data(gpio_virq);
   234		irq_set_default_domain(mpic->irqhost);
   235	}
   236	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

