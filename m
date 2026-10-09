Return-Path: <linuxppc-dev+bounces-29096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87CACA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 13:23:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1SHM1K6zz2y8Z;
	Sat, 10 Oct 2026 00:23:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791552223;
	cv=none; b=IaA8yKZnNDF6nvQXBGo2hl/AZ7T2pDWAjGdjz8eyImnNL0F477bmCm0JWt5zfLxBYzT+LGbz7Nmj7x9KLLmzxJ4TMC6ODUjvYdp2+kdXJwhzWuNOGVz/j03GoSCZZ5Rloe40+MEW8rlaJZAha3Lp6CHfo3tuQygQ8jyqKaNuFE1SHYj/ePGgiiOdpRzCuuJ6W2otcN3pw2l/MImIIwIQvggPqdcrxZVMuBpQxERMEouqX0uA1ew4kSFFqflHiz55Mjf8hi8G+IBeEKytIJW754ou/qlaSPHINmUOF7dHNnGdTqNPFjxArWCuTQGEbmCW9pf0CfrqBtnQD3pFiUJVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791552223; c=relaxed/relaxed;
	bh=SCLWZU8blPIXaqVZoHf8GiELwJrChoHcATn6ja6MFJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNUoV/ciRdVE/+thpR63yFIRtq2Hua74J4Ikxk3yU8aI0tFELC1Wc1n2BoR9MCf6h++xDvTVliip5aB5rpQ0VteoDoLtJg975F3lKvZvjzrzKxGaClS0FA9wSoWRBb3yhQ1SqfMpm/CLYf3jn0EC1uJdapuV6EFwexKrQp4CrXAktMS/v8UG8ChYiX69BM0lCVaAAhe0C/nrcLm84xpEvS1JLbac6Pz2fx+oKrnEw3cJZj1c7gAAJ4E47GzWtSbGg0J2SUKPcptkZAiq/lNXE88rSte73Khv5m0W5ky3xpq+2ip31hRtTxhWNcm/VIbtw/PHHqN9usS+Sz/HwlUz8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDODdzvD; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDODdzvD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1SHJ436Lz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:23:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791552220; x=1823088220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4H+cfQ6gedWLiGYFeWv9qkDPH02uU6E0Vl/1XEXCSTU=;
  b=EDODdzvDacuP01ExugiFRnSnW2M3bPqeuE1g5uXDeRz/4EX9Rx5ZUGop
   RkM+RYLU6jyiQgUghTcsfn1GD/w9PWQJTD66Bf+fOD2jMU2841eqZJiyh
   KVWj4kVpjzh66piGxVh72yp8A0emWL2sEhkN5YYGEPHAfrQZNRltkxrmx
   lV85SfOjkWTblrnfMm/XMRwu+FRIUdJHE6NvqjgWfBUxzSSbdUVPeQzHD
   Jnu/A+BuTm70khEPwtUEjvAZLqRXo1zOjngDLWTDPndCJr23NuxTgyhUc
   tcm4mr3NVADQrECVDUttp/563wogoqNXG2hFl2gYaqIhqRzQ9tj0SXyKM
   g==;
X-CSE-ConnectionGUID: qOKRrcMyQIaMI6pQgSKHzQ==
X-CSE-MsgGUID: EMIEWoA1TkGvcr7iAHsVBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="351443"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="351443"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 06:23:35 -0700
X-CSE-ConnectionGUID: fM27SqKuQ1a9/cYZZhFHCQ==
X-CSE-MsgGUID: aqHt4obJTHKybI4bEsAbVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="437266"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 06:23:33 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFAZN-000000005q0-2wVU;
	Fri, 09 Oct 2026 13:23:29 +0000
Date: Fri, 9 Oct 2026 21:22:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH v13 07/11] scsi: ibmvfc: extend async event handlers for
 async sub-CRQ events
Message-ID: <202610092107.e7gHIyl7-lkp@intel.com>
References: <20261007-ibmvfc-fpin-support-v13-7-b816abfa4fcc@linux.ibm.com>
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
In-Reply-To: <20261007-ibmvfc-fpin-support-v13-7-b816abfa4fcc@linux.ibm.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c3cff7fac01638ab58e85fe7df41a04fa25c5bae]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marquardt-via-B4-Relay/scsi-ibmvfc-fix-IRQ-leak-and-guard-deregister-on-channel-reg-failure/20261007-142545
base:   c3cff7fac01638ab58e85fe7df41a04fa25c5bae
patch link:    https://lore.kernel.org/r/20261007-ibmvfc-fpin-support-v13-7-b816abfa4fcc%40linux.ibm.com
patch subject: [PATCH v13 07/11] scsi: ibmvfc: extend async event handlers for async sub-CRQ events
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20261009/202610092107.e7gHIyl7-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610092107.e7gHIyl7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610092107.e7gHIyl7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:1907 expecting prototype for ibmvfc_relogin(). Prototype was for ibmvfc_scsi_relogin() instead
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'fpin_status' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'wwpn' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'type' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'modifier' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'threshold' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'event_count' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3403 function parameter 'crq' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3403 function parameter 'wwpn' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3403 Excess function parameter 'ibmvfc_fpin' description in 'ibmvfc_basic_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3442 function parameter 'wwpn' not described in 'ibmvfc_full_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:5367 function parameter 'protocol' not described in 'ibmvfc_alloc_target'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'fpin_status' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'wwpn' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'type' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'modifier' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'threshold' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3321 function parameter 'event_count' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3403 function parameter 'crq' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3403 function parameter 'wwpn' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3403 Excess function parameter 'ibmvfc_fpin' description in 'ibmvfc_basic_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3442 function parameter 'wwpn' not described in 'ibmvfc_full_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:5367 function parameter 'protocol' not described in 'ibmvfc_alloc_target'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

