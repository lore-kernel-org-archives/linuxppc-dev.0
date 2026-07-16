Return-Path: <linuxppc-dev+bounces-24312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1972C44507
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 03:10:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0yhc3Jhjz2xd2;
	Thu, 16 Jul 2026 13:10:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784171408;
	cv=none; b=G4MuSUQZKjb+HcTBa00S3kK6A86y0JDw8Ia9tqQ1Te4sEANDCRzqT4mndx2v5ND/oVdKz4qWKJnbKbp1asMfhJbQwiiQMdu6Sc6ZztbDjKFp4MyNsghjVj24AdGwxxHtqhKKrsJvk4dWc/5zKV8uGCtkPO/wiG21NJCsBsRmd82amTjJ6ISr+RPPt49yHzJs6OiPkR5Vm/Az0VB1Ci6OTNXXJzcyVuAcbsiyDOpphaY2g8gTvMJXYQ+jTFS96PXc8eWwbO4O1bTjb+J1tnD2DgyOliCbTweQH4SvQVcN7m077t3whqjf65EUCGbdqq8xzqeQagaLz66MKpyXodRCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784171408; c=relaxed/relaxed;
	bh=s9tYm0IkTA0YJ0RwPq9kg8bPOGU8vsO2O8CJJdk8K0A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B6Gp+sUEaxPKilOrkOWq3Sb5P5OJBg3Nzk7bphB4p8v/AUOX3WObJM5JncAEp9Dctq6RtHA2x15Pmm8OoFTuJa//+RdKJemFH7oPdiGgabDcteMvrCyrMry7TeNcRxBaCv0RV2aaZiYjE4KpCGwsIuRhciIr+JLfxzu3ubsex09QsMWYWxyxRXkrW+6+H364Pwxfnvlvfn/mx6HFMEel5Rk9AyQYVZ3vTBj0Xbw/dBTRdHTbkktViRXy6GBOvMlEon170LarKu4afvidG+5iwdfAv+BZKRn8kog/1RzjpmFSK27oxY534U5nzV4HUZoxNJwQDu2Kj+LrqdQXwmRNFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L0If1LMO; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L0If1LMO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0yhb0mqcz308Y
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 13:10:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784171407; x=1815707407;
  h=date:from:to:cc:subject:message-id;
  bh=V+uV3PF+Dqui36ANmEj9vlch1MWldwczavheD4/PNfM=;
  b=L0If1LMOV04ceW7b6T0mL1VO61JEkrvnfRB+ZlSgakhfpkP+0JCXhWqe
   pbkq0uCBUyUGDWX+eGufJheDd7KhrLqgN9YdpIqf8JvLCZD+1UXBafutl
   uXyslX2kCQqEMMORUkRcbZMJqe0IMumjaZHBSJ3B+OYD/JTuCMpGiweW2
   Lf8VhTZVcy6Bmxo59OS3J4Cj2X50FHCEUU1RN3jvzTrtTNdaAN3rZn9w/
   9vkv65sKb6EjUIJ1ijuJyPM4SWTwnDX0L4OZoEz5FO4yJ18JaY5oZgh53
   KmtOOm/StQIYo/rNIfN9rcxSpH2t/91mEjFrgWbq82dUGDH5KoSQCF99W
   g==;
X-CSE-ConnectionGUID: 8HNCjNeFRZCahnYFfOZ7/Q==
X-CSE-MsgGUID: zOvMO+jQT4qj11B3sY+B4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95425570"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="95425570"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 20:09:57 -0700
X-CSE-ConnectionGUID: tBdVVz1QQlu24bSF8hK4AA==
X-CSE-MsgGUID: 9b9Ya0uOQQuDej59ug0oyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260176699"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2026 20:09:56 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkCTx-00000000OFy-2NHH;
	Thu, 16 Jul 2026 03:09:53 +0000
Date: Thu, 16 Jul 2026 11:07:55 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD SUCCESS
 359cfbbc8527990d76a9d75b74c9c1268ce2f64d
Message-ID: <202607161143.2peWVr1D-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
branch HEAD: 359cfbbc8527990d76a9d75b74c9c1268ce2f64d  powerpc: Remove dead non-preemption code

elapsed time: 726m

configs tested: 2
configs skipped: 305

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
powerpc  allmodconfig    gcc-16.1.0
powerpc   allnoconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

