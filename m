Return-Path: <linuxppc-dev+bounces-29230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C8CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 07:35:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j38Pp1qJ0z2yYY;
	Mon, 12 Oct 2026 18:35:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791790510;
	cv=none; b=HZC58LpchbqY0NG57vtHIMIJda8Apch6V+IIOzTKz6SNgHhk133dZj64c/5McB0RkxeelbNVsNbWKidYgoaiOA4c56kSdHL5g/bJi1g/XOWKwZCJrfrNPv5+3CllQngmstRmc8rDRzDZW7n75eR8uuVjldwLr+ysWVksElq4j/JM/Oiig8grtGT2GtJiSQSzoR7JQsR+i6zZzp4DdRcVzsLnq9CMXMehmHj4H/L0Dtl7Jdk02hcJRoqOn8737sB3fKnnonjVdcaz9A8y9RBhKn4k66xWZqIH/lane3fQUvs+H4NHnMTy2ZgUL4x89Y0gARBgR1cMfMYrq+JEZild1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791790510; c=relaxed/relaxed;
	bh=xMOFvPNz9oFMCxz54BgC69u4VKFsl6jxo8E/0eyzVEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbBQPdyVCZv1kEs3kbzELewecKShxlVccEbl90tVx6dbp+PSCY/VvkMUnc+7mPnbbguvirqCMomD7LaMGKY6x17pE1/HtRhkhNGkDvU5H4EVi6Eg1w/c0E1kSsyfbmDyQabvgbDofQmQXugED5VB5VT7qGSRRMZrYYFukRm4DFPqDPL89fANs3UOdoSvBD1YZt3RQAhlKQUpWSV2UiUlfNg0sC3MKRbhBFbR8X4/ClPAwdTjyHkXVQl3S8JocBy+icYxAfPUlRgNsYDEl1bMqcsF7KzkIJ+VbmooGpijETdmyk5Ag1HvuOEKRXwndDNTAY/nxKmuifspL6LdeHfsMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OfNeiavG; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OfNeiavG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j38Pl21MBz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 18:35:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791790507; x=1823326507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IfIXiTykCz0xjBObFyhrB/LWEMsOLwR04eU+20HNza8=;
  b=OfNeiavGbVBKgZhT744VdeluxSpzaiaHH3khj004PScEzPdqCTF9c73a
   ckQz/uFkppsET4yGtAg6emtXhZ9oDHkH3Ahc96+DciUYpDm5OUMBsshpq
   3iKERgv6S7rZVa+zTn1ZOkqionanLmSbcOtuAYy44KNEY7SpZqQTznuI7
   1EW+P6oDaHHxneEZtOgQfRH+HizbLtqjd/4wWIVZc0V6aIG/+Up5LL9rB
   Tuc/w3e/u+KkWPiNLLkmNBF9BqJ2j72RhitKqZw6fD08zexydKorl/DHG
   avGK6uuIoC5xQFVPzxPlJH42jirMXd1Gjn5oiVkFxibSh5RNyZ2Hsfql/
   w==;
X-CSE-ConnectionGUID: UVf74oY7S6yEl7u/fcpfKA==
X-CSE-MsgGUID: ySvIbRovScyCUnebMkpm7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="482470"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="482470"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 00:35:00 -0700
X-CSE-ConnectionGUID: SrlQe+BZR8GU+QavfGSruA==
X-CSE-MsgGUID: EoEqP+0AQYCJnBd5KXT9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1155237"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Oct 2026 00:34:57 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGAYg-00000000B9R-0qsD;
	Mon, 12 Oct 2026 07:34:54 +0000
Date: Mon, 12 Oct 2026 15:34:36 +0800
From: kernel test robot <lkp@intel.com>
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net,
	andreas@gaisler.com, sparclinux@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, oleg@redhat.com,
	linmag7@gmail.com
Subject: Re: [PATCH v2 4/6] sparc64: add SPARC64 VII CPU, MMU and SMP support
Message-ID: <202610121549.5ejZQ08o-lkp@intel.com>
References: <20261011195729.981243-5-linmag7@gmail.com>
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
In-Reply-To: <20261011195729.981243-5-linmag7@gmail.com>

Hi Magnus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cee9395acd8043be0644b25c34bfa86623f2b935]

url:    https://github.com/intel-lab-lkp/linux/commits/Magnus-Lindholm/sparc64-return-from-the-generic-clear_page-implementation/20261011-215553
base:   cee9395acd8043be0644b25c34bfa86623f2b935
patch link:    https://lore.kernel.org/r/20261011195729.981243-5-linmag7%40gmail.com
patch subject: [PATCH v2 4/6] sparc64: add SPARC64 VII CPU, MMU and SMP support
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20261012/202610121549.5ejZQ08o-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 51b433b4f56c531c0d95ba15e1a15e06c399d552)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261012/202610121549.5ejZQ08o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610121549.5ejZQ08o-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: fill_in_one_cpu+0x310 (section: .text) -> vii_cpu_topology (section: .init.text)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

