Return-Path: <linuxppc-dev+bounces-19943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AC6F9B5E7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:55:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0tNJ6wMwz2yr6;
	Wed, 22 Apr 2026 18:55:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776848128;
	cv=none; b=jwIIr52jneLrwfDgYBFkf68DPTwKChFmZXB8Cj2SKWS9t1qstvTpdj8l128aavTVAJmjuY+oAkxzasKlgKUYJglpIeMe3U9b3/hX3YNYwDTr15GL17r0yKoPkX5L5I4xDSkqAQ7ANC9SuafkvNsbnCiSX0HOxbjfWX3uFm8LFv1H4S4TrgYH0SidSrNLBpTOQl0kAhjq8ZLK1nmHCLulF4MSjXEn+/pBuQAubj4/T95W2u3ZJeSAM0xDCTjkU1Q2YZr1FbCWyIc4Y+vdz9kbWPXUrO9j8cBzFXq0D9XC/T9CxO80yhjrXiMgBRHQ1zwueJC1clE/kpmFQVNN9N8uiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776848128; c=relaxed/relaxed;
	bh=cS1onSEoWT3bwYC+pq9zeyFLgj+o/rV0W5+Uf30+b1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISVVXPheBmz/GJgoj17U62b1Xs2ifnK26w51qK0w1ZZ9IjVhGNqELitayr7odREBke4Tylos0LJMk7+WRW/6myZaX/AKcqpU1qMmRn72m7cC0HG4toFoF6B+XZdJfsQ9HYrjXJ/R2nzJEJuOm3/LkyBydgRrhWgVRYPUNVvT9VzfHcYObRhZW/PIz8LJr92/XBttJqweeUhYAHVs/+Xn02QdNoo0EY6aTDiubsYNEZdlS5eEuqamRyMhFvOlvxGBgNFW09qaLYMKla3a7CdChduMDBt5qAgHzvpKDX2CZZ+KdTujYT4dMSFw4DXqwefED0lgRyIMc5PBI95aLHmhWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iRf9ynAx; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iRf9ynAx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0tNF68t9z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:55:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776848126; x=1808384126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eOkmPRPYTp5oCLIg6v7jpCiPYUCRmqpat94cyp5tfUg=;
  b=iRf9ynAxhuLza1IFAis/LaioOEdYzHg/3TGN6JOWnkdXjW+xZdqzXrQU
   w0VaEoSIC0kLOktT57jcePwzw+sRBiaE9torzsWeJRn9yvZd24FUFooM7
   8B2nj5H8pMjXqdpmbJyvpni4VNyk4q/wFx6MRXP06r1yfq7AQ+xYESyit
   7223M+PGbc/1BLbpX1SYguD3qbAHW1G60RxaZGQEHTzWwM4lDjMCe+Ng2
   8TC4BiMNYYhdE8Fj0alwMA0D1Eg+yVuX9vHSQmErUtVGh/T0XOboKTi+P
   39t+OPk2+or6gxfCDOVkKXMFAMGzC8Jy17ezBRSUDns6auIcjCxpTGTdm
   g==;
X-CSE-ConnectionGUID: 9vaK50lRQSyZQe7p4aTkeQ==
X-CSE-MsgGUID: yVoh9VDfR4G5/xJCcIQODg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76958552"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="76958552"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:55:19 -0700
X-CSE-ConnectionGUID: BufUmKSQSnqvnke0qTAdQA==
X-CSE-MsgGUID: YFpuhfBWSr+3MjDBZSbH1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232204588"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 Apr 2026 01:55:16 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFTMX-000000000Ll-0gKp;
	Wed, 22 Apr 2026 08:55:13 +0000
Date: Wed, 22 Apr 2026 16:54:41 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in
 handle creation
Message-ID: <202604221653.KzDQsCY8-lkp@intel.com>
References: <20260420132429.128075-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20260420132429.128075-1-lgs201920130244@gmail.com>

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v7.0 next-20260421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/powerpc-pseries-papr-hvpipe-fix-NULL-dereference-in-handle-creation/20260420-224327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20260420132429.128075-1-lgs201920130244%40gmail.com
patch subject: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260422/202604221653.KzDQsCY8-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260422/202604221653.KzDQsCY8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604221653.KzDQsCY8-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/pseries/papr-hvpipe.c: In function 'papr_hvpipe_dev_create_handle':
>> arch/powerpc/platforms/pseries/papr-hvpipe.c:513:24: error: invalid use of void expression
     513 |         owned_src_info = retain_and_null_ptr(src_info);
         |                        ^


vim +513 arch/powerpc/platforms/pseries/papr-hvpipe.c

   479	
   480	static int papr_hvpipe_dev_create_handle(u32 srcID)
   481	{
   482		struct hvpipe_source_info *src_info __free(kfree) = NULL;
   483		struct hvpipe_source_info *owned_src_info;
   484	
   485		spin_lock(&hvpipe_src_list_lock);
   486		/*
   487		 * Do not allow more than one process communicates with
   488		 * each source.
   489		 */
   490		src_info = hvpipe_find_source(srcID);
   491		if (src_info) {
   492			spin_unlock(&hvpipe_src_list_lock);
   493			pr_err("pid(%d) is already using the source(%d)\n",
   494					src_info->tsk->pid, srcID);
   495			return -EALREADY;
   496		}
   497		spin_unlock(&hvpipe_src_list_lock);
   498	
   499		src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
   500		if (!src_info)
   501			return -ENOMEM;
   502	
   503		src_info->srcID = srcID;
   504		src_info->tsk = current;
   505		init_waitqueue_head(&src_info->recv_wqh);
   506	
   507		FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
   508			   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
   509					      (void *)src_info, O_RDWR));
   510		if (fdf.err)
   511			return fdf.err;
   512	
 > 513		owned_src_info = retain_and_null_ptr(src_info);
   514		spin_lock(&hvpipe_src_list_lock);
   515		/*
   516		 * If two processes are executing ioctl() for the same
   517		 * source ID concurrently, prevent the second process to
   518		 * acquire FD.
   519		 */
   520		if (hvpipe_find_source(srcID)) {
   521			spin_unlock(&hvpipe_src_list_lock);
   522			return -EALREADY;
   523		}
   524		list_add(&owned_src_info->list, &hvpipe_src_list);
   525		spin_unlock(&hvpipe_src_list_lock);
   526		return fd_publish(fdf);
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

