Return-Path: <linuxppc-dev+bounces-29081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CA4CA6015
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 05:20:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1FZ850xmz30Cj;
	Fri, 09 Oct 2026 16:20:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791523248;
	cv=none; b=dM2XHZZRniJgC8cdlevfwHu+CdCLdssQ6DohS+JDXW2eWtl3B8gvcKvZsUbjg72ftKAZbOeapxcTlhw3YSheH586A+W3D5nuVk3CtP90FFDOmvtqDP52ixUW+4jQHpOogYZvZP6HNb+hSWBAUPZaj7KG3/Q20FyNWscotp6bZwMG6hQEtdnaa6UpL46hhOGk4x5IO15zwsiqoBzWVAqflXoB2f40nDeoGgB0oZYKtUt00wMEnJMv3wV4m/vXR8v1VbllEv2olp6MvNCtocjNI3C284DUxO3kNV6vUuFmweTtpBbSAJvMitPKIFIG3706HnyjtynmGOr9ZYzQ9Bk5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791523248; c=relaxed/relaxed;
	bh=sDyfkCrXwbLn6kMafTLJU53onhxRb6teyEXi/IIzYeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp/XF1JDq1o65OUvYHdHeleD/rPZNj2kUVpoiQhiZe3D0ggcsTEfU4sGV4GyWB8qK6F6ioNJLUt8/bBz+oGda8sZyVYJBBM3I/VovP05IwX4SOmtakBtDe2QJaQI8Q5LfJ19kNbvjaui66D+CtPAp24Ewm5UTz/QjtB3FpVczY0NSQa6kwyzqEIXWCWNZhNvOFpTt82WDOYJMiVymSEl9+fBA/yH6Auyp1Hk+lLCt2CQ7w4+j7nUOF08iQSF7zQKaS6MI6xmA5PhspMS7pfVcKN/TezvnXn1F2ZZOl+pu5syGDtrIeHM0aZEmjwFNNhE1Y8FvtQIdX97WqXnfPu2Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWPWoo/X; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWPWoo/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1FZ2133Wz2yTH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 16:20:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791523243; x=1823059243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WUJ5y7qSeRkwAzEkHoEamlAmEM85Quzp2HqacvciaU8=;
  b=PWPWoo/XosMNS+6ULZTrgrcz70t/55ZuCgw5YaFe9DxkcWOqndEFubs/
   O4AWXlObjxneKFQ/w16/g74Z+x/cnj45qF4PHRTA2F+vE1E+Z7Pwl+j/t
   8+utBr8+nX+vF+XDchiioHyG2V+/xbWPfRFN16n/uUUP14XMKO3AUwpNa
   B94dettM4X1UUzz6NRXGWR07Jub10Gbf7h/YaLiuugE9+viMmZrg8C1ni
   tzXesnUaWkKVaok8ELloUa4MHw3RG1Orei0MOGu5thE4ndVSHzdKgrOFf
   IKsUqtBOvwXS4Y6XRrsHYIHlhVLIAUkiAkGJQMISkaw70vg7WeeZ3PaQh
   Q==;
X-CSE-ConnectionGUID: Vuv1jAd2QjChOUhgdD/V0w==
X-CSE-MsgGUID: I8MzEb/WQOmJ8IO3yCnHzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="191519"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="191519"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 22:20:36 -0700
X-CSE-ConnectionGUID: L1kiEqFiQb6nAV9QQyROiQ==
X-CSE-MsgGUID: /HmoO0+yTXuFpqzCVn9QOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="171261"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Oct 2026 22:20:33 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xF31y-000000005Lq-1yYo;
	Fri, 09 Oct 2026 05:20:30 +0000
Date: Fri, 9 Oct 2026 13:20:05 +0800
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
Subject: Re: [PATCH v13 04/11] scsi: ibmvfc: add basic FPIN support
Message-ID: <202610091350.pfimX8kZ-lkp@intel.com>
References: <20261007-ibmvfc-fpin-support-v13-4-b816abfa4fcc@linux.ibm.com>
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
In-Reply-To: <20261007-ibmvfc-fpin-support-v13-4-b816abfa4fcc@linux.ibm.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c3cff7fac01638ab58e85fe7df41a04fa25c5bae]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marquardt-via-B4-Relay/scsi-ibmvfc-fix-IRQ-leak-and-guard-deregister-on-channel-reg-failure/20261007-142545
base:   c3cff7fac01638ab58e85fe7df41a04fa25c5bae
patch link:    https://lore.kernel.org/r/20261007-ibmvfc-fpin-support-v13-4-b816abfa4fcc%40linux.ibm.com
patch subject: [PATCH v13 04/11] scsi: ibmvfc: add basic FPIN support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20261009/202610091350.pfimX8kZ-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610091350.pfimX8kZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610091350.pfimX8kZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:1905 expecting prototype for ibmvfc_relogin(). Prototype was for ibmvfc_scsi_relogin() instead
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'fpin_status' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'wwpn' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'type' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'modifier' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'threshold' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'event_count' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3401 function parameter 'crq' not described in 'ibmvfc_basic_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3401 function parameter 'wwpn' not described in 'ibmvfc_basic_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3401 Excess function parameter 'ibmvfc_fpin' description in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:5258 function parameter 'protocol' not described in 'ibmvfc_alloc_target'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'fpin_status' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'wwpn' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'type' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'modifier' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'threshold' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3319 function parameter 'event_count' not described in 'ibmvfc_common_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3401 function parameter 'crq' not described in 'ibmvfc_basic_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3401 function parameter 'wwpn' not described in 'ibmvfc_basic_fpin_to_desc'
>> Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:3401 Excess function parameter 'ibmvfc_fpin' description in 'ibmvfc_basic_fpin_to_desc'
   Warning: drivers/scsi/ibmvscsi/ibmvfc-core.c:5258 function parameter 'protocol' not described in 'ibmvfc_alloc_target'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

