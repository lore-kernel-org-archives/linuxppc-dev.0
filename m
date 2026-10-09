Return-Path: <linuxppc-dev+bounces-29161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A51CA9EBB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 20:29:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1dkk0V70z30TQ;
	Sat, 10 Oct 2026 07:29:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791577773;
	cv=none; b=bmD1i2NxLqH+PclGSQ9gE0Qa3S/CIDqU4xdNEbrDc0Iq4OUwNmuHf/nyAcQ3sxUwsmG7flsgMPODBl+OGM1uEW9NC7c8QmHQjCI4f47AKWQFecQoS4f4luSWh2LN1s7syo39Lk1bYGBBoZxukShPUTsSjmIwO3Aq0mwu9B9m78E3lOuP+sowhRP/o++j9AlmQqhHr/3FQvjsulazSiT92Izfbfp6bGX1crpzB0cq5fDOn3s7MZ1TBz/tgXaw2QgkI18NHaKoAXCdLxDL1gCxRpHiIcHX5bvORs1lj9Sd3At9KMxNyDduEOzcblDemQSQOhFz+eTnE29MIG6ERBalIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791577773; c=relaxed/relaxed;
	bh=LsnWjssj0Oq2KWTslJC0HRpMbTumGcLSDu1deorxGns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9+kbJjhCegK9v8r2dA4AWGv7Clg1LneSubD82bjhViuNFGWr8o+UQ4Ya3FanbPcmdWpgf7ESYM5Tt91weWlJXm98lK952mXLTcDwvUuowUfxOJmMr/Cr1QBn3nIP6W8NnihFP34KlT7bX0qxCMJpPbhvXvbceyZs82FJ5FNxUFX5nwmcKxN9UeHsOUUyjMHopZ7zOK+Co65A5n3j9DqJK0qrwQMkWI7gjCfuyNPItyf/Ajy0CBFxZevVqcBTxhBgZvU/Dni47w8dHnpY1LysehS+pIbgf511q0BL3IfVxeU3DhhHezX7PoO6lW6ArWYOSOAuBFh2ut8AkfOpp0SIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FwrDWpaA; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FwrDWpaA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1dkf66MFz30B0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 07:29:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577772; x=1823113772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N6GWgE6fmvtl3ic4OGMSelBMSe140c+Yw//7o6UYAaE=;
  b=FwrDWpaAMiRIiZMSrhOtdllCNHWAtv+StBMi+Wn7BalF2XmEdJyKVwTz
   96iDzV7YrxS5pb78KOgDB9uHvIRPCTsniAW0U8K674Cm/QLe43iifo/kf
   1uaHSXC8yiYApVoNi5AmulPNEBpSPjihIbB6+tsMSD3jehU5pRLZqfMdG
   GZr95VJCRMS0EPqJIJMZ50Lafq2Bf7k0ozro+JDwBwU97tUlOmjkzhTWH
   cQLp6rozp+aNfRMfaPKcDncFwrOPn5XEcfBuryr9Hzkzm5cZtjKOtXuG9
   RbqAd1MZlDNBxdrAUEwnkSbjPMIu0TdsjJr1XjaaRv9ycQY66Ew+zvO9m
   w==;
X-CSE-ConnectionGUID: 33tP24KGT4OENsUUIuf2Tg==
X-CSE-MsgGUID: Ob/2K8DoTke14+V+hBT0VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="377335"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="377335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:29:24 -0700
X-CSE-ConnectionGUID: dcbKz97PR2KL6gNmUxWfzw==
X-CSE-MsgGUID: 1lMqbYAlQqKHnURBp6y0/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="846926"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2026 13:29:20 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFHDS-000000006Ae-098j;
	Fri, 09 Oct 2026 20:29:18 +0000
Date: Sat, 10 Oct 2026 04:29:11 +0800
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
Subject: Re: [PATCH v13 11/11] scsi: ibmvfc: handle extended FPIN events
Message-ID: <202610100443.UCrGdTXp-lkp@intel.com>
References: <20261007-ibmvfc-fpin-support-v13-11-b816abfa4fcc@linux.ibm.com>
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
In-Reply-To: <20261007-ibmvfc-fpin-support-v13-11-b816abfa4fcc@linux.ibm.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c3cff7fac01638ab58e85fe7df41a04fa25c5bae]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marquardt-via-B4-Relay/scsi-ibmvfc-fix-IRQ-leak-and-guard-deregister-on-channel-reg-failure/20261007-142545
base:   c3cff7fac01638ab58e85fe7df41a04fa25c5bae
patch link:    https://lore.kernel.org/r/20261007-ibmvfc-fpin-support-v13-11-b816abfa4fcc%40linux.ibm.com
patch subject: [PATCH v13 11/11] scsi: ibmvfc: handle extended FPIN events
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20261010/202610100443.UCrGdTXp-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100443.UCrGdTXp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100443.UCrGdTXp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:1914 expecting prototype for ibmvfc_relogin(). Prototype was for ibmvfc_scsi_relogin() instead
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'fpin_status' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'wwpn' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'type' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'modifier' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'threshold' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'event_count' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'severity' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3410 function parameter 'crq' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3410 function parameter 'wwpn' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3410 Excess function parameter 'ibmvfc_fpin' description in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3449 function parameter 'wwpn' not described in 'ibmvfc_full_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3488 function parameter 'wwpn' not described in 'ibmvfc_ext_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:5505 function parameter 'protocol' not described in 'ibmvfc_alloc_target'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'fpin_status' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'wwpn' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'type' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'modifier' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'threshold' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'event_count' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3328 function parameter 'severity' not described in 'ibmvfc_common_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3410 function parameter 'crq' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3410 function parameter 'wwpn' not described in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3410 Excess function parameter 'ibmvfc_fpin' description in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3449 function parameter 'wwpn' not described in 'ibmvfc_full_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3488 function parameter 'wwpn' not described in 'ibmvfc_ext_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:5505 function parameter 'protocol' not described in 'ibmvfc_alloc_target'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

