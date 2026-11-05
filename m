Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A7606EE96
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hj1BJVjL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL0dS2pMXz2xSV;
	Thu, 05 Nov 2026 22:36:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793878604;
	cv=none; b=SCw6YfRMCa6qo9g69DGTxDQyrwGlN2QqP3HhkycBOoi2bDiLdH76VqmAb+158kOJGPjso8ybeOzGMCZGWziVCDrbWcMS7ayz55vhJ6Od0u2u5FipeNiR/IiJBjr7TroGH3Az0Y36BzuNLYRsnWM382UtLDaOy2/Lfy0swjxgjEJ+zB5lJzEIF93TnKrtcFljG7pXCDmX4U2o9YS7F1+8lurne24kEPY9Wg5HNNlfAesQesDDpq+bDfwnYejWULHm1GrHtfxKZeJ2yki20KWhyOsq4pApZND7rnaV/yB5A5YuqQdK6XmS7C1m2av6LiXHAOUCy5ZTzflxYrVRr+JXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793878604; c=relaxed/relaxed;
	bh=30J4sbOlYJiNq7Z4tRszcjWu8hBcWrg7tEn3jlctPwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdOUzAPm1E+QRJcaDkwqCsqN/QG1Vdd42uXE1j4Mk/Wei4wW5fo/8FIUn4D+nO8gpvzlj1HVD+uXSpGCXXeDm1FCuwblyyR6rliWFzr+YLFQKb/ZKNmsX1jkRdV8jI78W95jVybovfeoH1x3Vh9C7EexQBr3rTn28XeFImodBd8a7UtuKA83weAhPPFQsNVhZQV2iB7cbIS/vrkG5n1JaR4JWVHksfN/QlYaUnXBBmK4PQMqpwgfymHqeAnZ/ZebQCygm7q0Rvaphm8K48c4aMiZ3Vr4LeWCKJLl25f5UrOKInyMhzOEDW7kpdd+LoTBb540LuiqS39nTmchkM0f3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hj1BJVjL; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hj1BJVjL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL0dQ01ccz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 22:36:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793878603; x=1825414603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9dOmPMshDIpYmZ/TrqPMjz7mHsp3Z6+Ou1qHQ88q2c=;
  b=hj1BJVjLpBaGHa3jDMbwdWBmgdPILj9UMgCh5nTq6ogKdANxl1FUO5Vv
   l4cxYyJALM6DGQ8UlDmrVwFQL7tVcsSfB1UXznuj7dhO3uQV17tUro5Nr
   HPb/umZWBjQEJeGiaXMA/fQ3wAFp8GR+NbXKxEfZSVSVKvViNKYdCvawQ
   eYjN9YuBYJZiCFv3paIacO5ZERuw8yjlqucImxPqXsEyhY5RuZNyY7UZ0
   ErzJ44anP/mtJih3PPnkBl33DHobqZX2xGke7t+RWz4Rv/CPeLK04JG1e
   CviDrjIu0UUOX80ZbJbXqNScMRZJk4zXNIHW3xBq2gaCUSnLLrlkyWXNh
   g==;
X-CSE-ConnectionGUID: tLLyyx9FTZ2lQXlxDJsgrw==
X-CSE-MsgGUID: T4ClAdsgTieC1i1Yz85GCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2547429"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2547429"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 03:36:37 -0800
X-CSE-ConnectionGUID: NU49M+y7SoqJQQ7rq8Z1Cw==
X-CSE-MsgGUID: /gbM1bnkQwynnPU6B2caeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7163862"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Nov 2026 03:36:29 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOvlZ-00000000m7v-0S9w;
	Thu, 05 Nov 2026 11:36:25 +0000
Date: Thu, 5 Nov 2026 19:35:46 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <chris.mason@fusionio.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v2 01/51] alloc_tag: don't remove /proc/allocinfo
 under the codetag module lock
Message-ID: <202611051923.pLSSWWkA-lkp@intel.com>
References: <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/alloc_tag-don-t-remove-proc-allocinfo-under-the-codetag-module-lock/20261104-200606
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261104-work-procfs-bugfixes-v2-1-021c84d852e0%40kernel.org
patch subject: [PATCH RESEND v2 01/51] alloc_tag: don't remove /proc/allocinfo under the codetag module lock
config: sh-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261105/202611051923.pLSSWWkA-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051923.pLSSWWkA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051923.pLSSWWkA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/alloc_tag.c:620:13: warning: 'shutdown_mem_profiling_async' defined but not used [-Wunused-function]
     620 | static void shutdown_mem_profiling_async(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/shutdown_mem_profiling_async +620 mm/alloc_tag.c

   613	
   614	/*
   615	 * A module's tags are reserved with the codetag module lock held for
   616	 * writing, and a reader of /proc/allocinfo takes that lock with the entry
   617	 * pinned. Removing the entry there would wait for that reader for good, so
   618	 * let a work item do it.
   619	 */
 > 620	static void shutdown_mem_profiling_async(void)
   621	{
   622		if (!mem_profiling_support)
   623			return;
   624		shutdown_mem_profiling(false);
   625		schedule_work(&remove_allocinfo_work);
   626	}
   627	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

