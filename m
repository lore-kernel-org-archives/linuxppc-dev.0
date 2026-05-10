Return-Path: <linuxppc-dev+bounces-20659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5BBCD37B2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2026 16:16:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gD7JH6HCbz2xlr;
	Mon, 11 May 2026 02:15:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778429759;
	cv=none; b=MvMhxjgk/M1NFsgPb4rz8kMgI1nXBcOEjDV7tnI7KUJCVH1D7QVDzpd6Cun4CGDICWYCftZKjmPr39niN9Ww4hHCKoIR3BB/Hc+jtZvRDhG03MWEj0n/SlDAqJ2cqENOjyv61PIxrnOKuc/p+Inzm/nH36gynjEq4/4sh+uzXcMUel5ygI00VweQk4yx6UoG3foAA+V2lFNAzh7WKGjjzJFNF167n5FsMyNz3J7EEnyFEQeLzy8G0NHUb5sFFodo0DBZCrOYgbYAgkdL17ufGf4LKX1jDayUpYwYR5Vzk9RXbQp0k0hhnUv0pRsybdTubgbKngZdnTC7FipV2KW7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778429759; c=relaxed/relaxed;
	bh=Z4WON5HBiky4MENrDPJykkWnK8mi0fYZGXBvqrGDrhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc8YwrI2fboW/Er+auyEb0s+1ourbDTFLG3JjXGJJujKCKp5GZPekmncGUk1Kx1bRunGvjefEpq9YdTTc/8/tdAJsEqitMOVXtCRqSt792zBp6MJln38Pj0jftIa58OoAStxwcHZDA4YdLT0USKrCLPMR9yQFDYcI7m1TeW4wRIeoWnbUYiULugofn0LjzQc1ntmPkaFSKNH6lUqiuuyfd6hUaBMtA3L9BtwIk2BnZjdzHI8QxBpwAd1ox67Kw+YS8xofbWNi9jOXd92rblTQm25G7+ITnrmIhjpPiJIImQISppcMSZuPjc++ilf+DAYCUCQnKm0MiuckdV/Kc/asA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LihR95wz; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LihR95wz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gD7JD5rDcz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:15:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778429757; x=1809965757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HupmRejFkybmBtAWAKmjljvXHZ0NmF6l1vTvqbQNWUU=;
  b=LihR95wzttJbfdROefQkS/yBQd91piDTGDVRuvB9pCspun1EIPqYIyr2
   CP49PMnvNv7MaTCVpkoRfXDXCIMeGtOUOfT3Sj3YMH6dwB6ZNjM6K/8Ra
   audOCixhgya3eJbuAkIid1BV3JLrl8eaWje4wz1yi4JWzWwV58yR88nDF
   kc7EcOiMV29LGO6zq8ouxx9YPmJH3KDwjqJtw4cuhNWBp0MlOJyuhdrGJ
   wQnvIDV1We/TEQCd/8CjTAchMDFjhSoLyGQAqs9nmqxyUX9Ufx8X5oQyH
   GBeSWER4rRydbNq9no/FkQ2/xsyapZtHNl9sOTpn2nyvZmUA954iWYV6M
   g==;
X-CSE-ConnectionGUID: OTp8nyYuQoixX1aioOHyJg==
X-CSE-MsgGUID: DNN9jb+8RwSHwOkSlIuQkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79232017"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79232017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 09:15:48 -0700
X-CSE-ConnectionGUID: yDlc9PidRvSc3mLRG0+kKA==
X-CSE-MsgGUID: bv+ywnRdSTCR/UJPZGPiiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237339824"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 10 May 2026 09:15:47 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wM6oi-000000007kb-0mLS;
	Sun, 10 May 2026 16:15:44 +0000
Date: Sun, 10 May 2026 18:15:21 +0200
From: kernel test robot <lkp@intel.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	sbhat@linux.ibm.com, vaibhav@linux.ibm.com, ritesh.list@gmail.com,
	Gaurav Batra <gbatra@linux.ibm.com>,
	Brian King <brking@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries/iommu: export DMA window data to user
 space
Message-ID: <202605101820.ZpQl79bh-lkp@intel.com>
References: <20260507180646.40356-1-gbatra@linux.ibm.com>
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
In-Reply-To: <20260507180646.40356-1-gbatra@linux.ibm.com>

Hi Gaurav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 192c0159402e6bfbe13de6f8379546943297783d]

url:    https://github.com/intel-lab-lkp/linux/commits/Gaurav-Batra/powerpc-pseries-iommu-export-DMA-window-data-to-user-space/20260510-175116
base:   192c0159402e6bfbe13de6f8379546943297783d
patch link:    https://lore.kernel.org/r/20260507180646.40356-1-gbatra%40linux.ibm.com
patch subject: [PATCH v2] powerpc/pseries/iommu: export DMA window data to user space
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260510/202605101820.ZpQl79bh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101820.ZpQl79bh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/landlock:453: ./include/uapi/linux/landlock.h:45: ERROR: Unknown target name: "network flags". [docutils]
   Documentation/userspace-api/landlock:453: ./include/uapi/linux/landlock.h:50: ERROR: Unknown target name: "scope flags". [docutils]
   Documentation/userspace-api/landlock:453: ./include/uapi/linux/landlock.h:24: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:462: ./include/uapi/linux/landlock.h:153: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:462: ./include/uapi/linux/landlock.h:176: ERROR: Unknown target name: "network flags". [docutils]
>> Documentation/arch/powerpc/dma_window_attributes.rst: WARNING: document isn't included in any toctree [toc.not_included]
   Documentation/networking/skbuff:36: ./include/linux/skbuff.h:181: WARNING: Failed to create a cross reference. A title or caption not found: 'crc' [ref.ref]

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

