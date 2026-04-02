Return-Path: <linuxppc-dev+bounces-19231-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7FAD6AB05
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 20:04:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmt9d4P2gz2xls;
	Fri, 03 Apr 2026 07:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775160277;
	cv=none; b=Du2cha4HW70ov+bEfs9HpHCWlU7cFh2tZBOm/eikwW413A4V9ODFKUH3G2iKBvqStQ1VMR8dIw93sppSbUHLsOpDUEQp/YJrxB1p13LEh6517knSzEWoYUG/CNjmZWc1c+qNMs887YcVQDsF+wMJ3xG9mUWypwFTZOcqiXqk0gmJUYCfrRZkZNh9Hq6QmrH/f4EVNwER3IttY3sj71VjthBNS3Yc+zQwBniYABySzke3uXNgbLUgpQIezbgEm8T/F103FVThiyQdav64xQnPnT3DmJmz359eA6bxg5+tkCNQHUGSkEH7ACfu3cpoDHxTMutra59LxL/MQI2kjCl4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775160277; c=relaxed/relaxed;
	bh=0Z8HAfdrffOtq8FHTPZ7CACCD2n0tzmamvz3yN06hhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxiIeyF2Sv6l8DfqztjS2aZZCcSDoWmWd8oTSeajvaAikbnHSIH7+XOgnmgmPx1TJoJ2il7AAql96YR1BJxMgOHMVCJz2hQaGcZDZ7nQ/KxXLUa+lNzwAju+x+AQsbpj81sVuNcrlybaH0KAFiT6wAJM4ZAHiiGWLeweV3Rh8jlplEO0X7zwFBEgTTtQPzP/UnBHG0yEdiOmHLPev5cQwoogajaVkPZTiIk9FDJVgJOzxhNxOV57P+Af3jkh9zHLDMVuzzZx+WzLxSQ/5izECevpKkACjgji5h4BUZL71mjtEnZQmdLc4QyYbtF2Kr3h6fNKVVajpt0clwxH3PUALQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MSCaWTHu; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MSCaWTHu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmt9Y5t59z2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:04:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775160274; x=1806696274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4qv2zdPZEgT5oC3SiH+LBfJp4zAyy2TSrWtsJir3Quk=;
  b=MSCaWTHu316NHATwThFNChHOOAQ9s1cpNW4z7+iS/u9ez/Lz5AlxaP4o
   28oKP1ptMJVabtfl01A3UfEs0D/DGTQxxNmn9nw8zaRZC7xHVfgkYkMzY
   kYvvTBIPOtLU0M8WsTJnAKtLguHcMANiu4ZOPshyOEAYa/yu4Vtnxgqwm
   eYbnfgS2EXZgQxIjfWovFnnLQhpu0s+il7TiOc/1msC4T/ZuWIv1t2x+e
   ZiOFlgg75y3ASZP/u7ZVLxHLEi8kDPl1KPuYPN0UavhwJikl6yZTZ3PFW
   ZdvCVKzcTddlMm0LXzZF25tPMfvzUYro/k3VBkPDsGUdiLahvwfP0lQ/C
   w==;
X-CSE-ConnectionGUID: hGYCxNVwTQKDYkkI9tLjqQ==
X-CSE-MsgGUID: AQtOj13bTu6kQAX32BakNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75947956"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75947956"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 13:04:27 -0700
X-CSE-ConnectionGUID: 9eC3JQUSTwuyBMZyfVDRig==
X-CSE-MsgGUID: 5SWOeqtHSpa8wjMW5l0r5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="231108937"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2026 13:04:25 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8OH8-0000000098H-2Lhf;
	Thu, 02 Apr 2026 20:04:22 +0000
Date: Thu, 2 Apr 2026 22:04:11 +0200
From: kernel test robot <lkp@intel.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	ritesh.list@gmail.com, arnd@arndb.de, chleroy@kernel.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v3] char: nvram: Remove unused nvram_mutex to fix
 -Wunused-variable warning
Message-ID: <202604022248.LErLuuXd-lkp@intel.com>
References: <20260330062201.2581-1-venkat88@linux.ibm.com>
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
In-Reply-To: <20260330062201.2581-1-venkat88@linux.ibm.com>

Hi Venkat,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.0-rc6 next-20260402]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Venkat-Rao-Bagalkote/char-nvram-Remove-unused-nvram_mutex-to-fix-Wunused-variable-warning/20260330-234134
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20260330062201.2581-1-venkat88%40linux.ibm.com
patch subject: [PATCH v3] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable warning
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260402/202604022248.LErLuuXd-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260402/202604022248.LErLuuXd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604022248.LErLuuXd-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/char/nvram.c: In function 'nvram_misc_ioctl':
>> drivers/char/nvram.c:327:37: error: 'nvram_mutex' undeclared (first use in this function)
     327 |                         mutex_lock(&nvram_mutex);
         |                                     ^~~~~~~~~~~
   drivers/char/nvram.c:327:37: note: each undeclared identifier is reported only once for each function it appears in


vim +/nvram_mutex +327 drivers/char/nvram.c

^1da177e4c3f41 Linus Torvalds      2005-04-16  278  
cb8d8006d43f22 Finn Thain          2019-01-15  279  static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
55929332c92e5d Arnd Bergmann       2010-04-27  280  			     unsigned long arg)
^1da177e4c3f41 Linus Torvalds      2005-04-16  281  {
2d58636e0af724 Finn Thain          2019-01-15  282  	long ret = -ENOTTY;
^1da177e4c3f41 Linus Torvalds      2005-04-16  283  
^1da177e4c3f41 Linus Torvalds      2005-04-16  284  	switch (cmd) {
95ac14b8a32817 Finn Thain          2019-01-15  285  #ifdef CONFIG_PPC
95ac14b8a32817 Finn Thain          2019-01-15  286  	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
95ac14b8a32817 Finn Thain          2019-01-15  287  		pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  288  		fallthrough;
95ac14b8a32817 Finn Thain          2019-01-15  289  	case IOC_NVRAM_GET_OFFSET:
95ac14b8a32817 Finn Thain          2019-01-15  290  		ret = -EINVAL;
95ac14b8a32817 Finn Thain          2019-01-15  291  #ifdef CONFIG_PPC_PMAC
95ac14b8a32817 Finn Thain          2019-01-15  292  		if (machine_is(powermac)) {
95ac14b8a32817 Finn Thain          2019-01-15  293  			int part, offset;
95ac14b8a32817 Finn Thain          2019-01-15  294  
95ac14b8a32817 Finn Thain          2019-01-15  295  			if (copy_from_user(&part, (void __user *)arg,
95ac14b8a32817 Finn Thain          2019-01-15  296  					   sizeof(part)) != 0)
95ac14b8a32817 Finn Thain          2019-01-15  297  				return -EFAULT;
95ac14b8a32817 Finn Thain          2019-01-15  298  			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
95ac14b8a32817 Finn Thain          2019-01-15  299  				return -EINVAL;
95ac14b8a32817 Finn Thain          2019-01-15  300  			offset = pmac_get_partition(part);
20e07af71f34d9 Finn Thain          2019-01-15  301  			if (offset < 0)
20e07af71f34d9 Finn Thain          2019-01-15  302  				return -EINVAL;
95ac14b8a32817 Finn Thain          2019-01-15  303  			if (copy_to_user((void __user *)arg,
95ac14b8a32817 Finn Thain          2019-01-15  304  					 &offset, sizeof(offset)) != 0)
95ac14b8a32817 Finn Thain          2019-01-15  305  				return -EFAULT;
95ac14b8a32817 Finn Thain          2019-01-15  306  			ret = 0;
95ac14b8a32817 Finn Thain          2019-01-15  307  		}
95ac14b8a32817 Finn Thain          2019-01-15  308  #endif
95ac14b8a32817 Finn Thain          2019-01-15  309  		break;
20e07af71f34d9 Finn Thain          2019-01-15  310  #ifdef CONFIG_PPC32
95ac14b8a32817 Finn Thain          2019-01-15  311  	case IOC_NVRAM_SYNC:
95ac14b8a32817 Finn Thain          2019-01-15  312  		if (ppc_md.nvram_sync != NULL) {
95ac14b8a32817 Finn Thain          2019-01-15  313  			mutex_lock(&nvram_mutex);
95ac14b8a32817 Finn Thain          2019-01-15  314  			ppc_md.nvram_sync();
95ac14b8a32817 Finn Thain          2019-01-15  315  			mutex_unlock(&nvram_mutex);
95ac14b8a32817 Finn Thain          2019-01-15  316  		}
95ac14b8a32817 Finn Thain          2019-01-15  317  		ret = 0;
95ac14b8a32817 Finn Thain          2019-01-15  318  		break;
20e07af71f34d9 Finn Thain          2019-01-15  319  #endif
95ac14b8a32817 Finn Thain          2019-01-15  320  #elif defined(CONFIG_X86) || defined(CONFIG_M68K)
^1da177e4c3f41 Linus Torvalds      2005-04-16  321  	case NVRAM_INIT:
^1da177e4c3f41 Linus Torvalds      2005-04-16  322  		/* initialize NVRAM contents and checksum */
^1da177e4c3f41 Linus Torvalds      2005-04-16  323  		if (!capable(CAP_SYS_ADMIN))
^1da177e4c3f41 Linus Torvalds      2005-04-16  324  			return -EACCES;
^1da177e4c3f41 Linus Torvalds      2005-04-16  325  
2d58636e0af724 Finn Thain          2019-01-15  326  		if (arch_nvram_ops.initialize != NULL) {
613655fa39ff69 Arnd Bergmann       2010-06-02 @327  			mutex_lock(&nvram_mutex);
2d58636e0af724 Finn Thain          2019-01-15  328  			ret = arch_nvram_ops.initialize();
613655fa39ff69 Arnd Bergmann       2010-06-02  329  			mutex_unlock(&nvram_mutex);
2d58636e0af724 Finn Thain          2019-01-15  330  		}
2d58636e0af724 Finn Thain          2019-01-15  331  		break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  332  	case NVRAM_SETCKS:
^1da177e4c3f41 Linus Torvalds      2005-04-16  333  		/* just set checksum, contents unchanged (maybe useful after
^1da177e4c3f41 Linus Torvalds      2005-04-16  334  		 * checksum garbaged somehow...) */
^1da177e4c3f41 Linus Torvalds      2005-04-16  335  		if (!capable(CAP_SYS_ADMIN))
^1da177e4c3f41 Linus Torvalds      2005-04-16  336  			return -EACCES;
^1da177e4c3f41 Linus Torvalds      2005-04-16  337  
2d58636e0af724 Finn Thain          2019-01-15  338  		if (arch_nvram_ops.set_checksum != NULL) {
613655fa39ff69 Arnd Bergmann       2010-06-02  339  			mutex_lock(&nvram_mutex);
2d58636e0af724 Finn Thain          2019-01-15  340  			ret = arch_nvram_ops.set_checksum();
613655fa39ff69 Arnd Bergmann       2010-06-02  341  			mutex_unlock(&nvram_mutex);
^1da177e4c3f41 Linus Torvalds      2005-04-16  342  		}
2d58636e0af724 Finn Thain          2019-01-15  343  		break;
95ac14b8a32817 Finn Thain          2019-01-15  344  #endif /* CONFIG_X86 || CONFIG_M68K */
2d58636e0af724 Finn Thain          2019-01-15  345  	}
2d58636e0af724 Finn Thain          2019-01-15  346  	return ret;
^1da177e4c3f41 Linus Torvalds      2005-04-16  347  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  348  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

