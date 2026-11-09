Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C93606AADF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ci4gVVxO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNb9X40Qzz2xdX;
	Tue, 10 Nov 2026 03:40:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794242400;
	cv=none; b=Yw49FF4zVznC4Fl4hxN7lv4IMSIu+q3RrUFcKdZKbR26/9Y/KRtRztKwmwSElkaBTOsXiIdjYB131Y5qN71kMwXfGKYXbPaFqMqz2u7rOJ/SQq0COEP7qoVWZic0WVqrbBr4rR0JwUO8aMn+qqKy30JaVKqXNW9xOLg1aIhRyKcSn6O2FE+O/h4qZHp5Oa4JLf+ITt0k31lPWPRiZCxjipejWQbWFuZxupNG75cC2C2enHFrAPfAeFu4f0o2zqI1+JlECMHN8A5YYnLqm0K8iOvL/rqLZkP+IUE+WykwyGOiusbBNNUMxXEcwCluJMm0PwBjFvwg/B2XszTF0SfQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794242400; c=relaxed/relaxed;
	bh=WB+NnUFeCMCsVOxK+oV+Ndnf6qqRZy22YpXN6vlA5YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAIkLO1SpLVYUD1o9P8WfgQC80Q/Czk2p7xrhG2Xf4ApKnSNq60WWjOKPL42I0X7hIs8DuqJF7bl4oShvZP3dbJPzqR6MuQgZ/Nl39rMbac68cSoD/XaJyN9CJYwwQEFLshM6YFzdT3Kn/0EKTYPd80LhIwtcGMymjuuHY+SolVPWohJEKvOdPHO9UtMUFzXzMCB+tmjBC9GpvbrfBF6XzaBZVlC+33huQE0Z5GDb3D2C3/uFMhpZ1ONfBIEOaYXZnLh6Ytxh6p74Xy7ESBRUxoQM+J2VOmwsyI30OP0y7iemvKwPJL67M4LiN4N8bBuYRUCFxBkUAn+ILi/RnDi0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ci4gVVxO; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ci4gVVxO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNb9V2wJ1z2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 03:39:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794242399; x=1825778399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qH7YxGJ9MhlbamqziXGD7CqNVxvvHmoJYm/8MPEQnoQ=;
  b=Ci4gVVxO2gKHa4GL/OJetFXXUKwZOmHEoQiHbrU2C8kO5mkmhEKjCmni
   C9z3rLxmrlDYLrTAuh5rLMA64rqMNpY98jSD4Bi1J/HKpD7sIkQGTjEDu
   Qs6jZp+dfqkqyywjcofjONogwybGSwbjuVcnFj8pEijAihv1sbVGgwbfN
   fp7T4Sywo08+8NU1rb3lVB2U17+Hbe6BowKpliFsxEmgU+vpoaITtlSdk
   rZOSGKQ5H5XRH/d2swyjJPhF4Xbll5FIePcsk9MIvrlDhmlXjniJEC5Bb
   0xDEk91C0EV7/3xfmwTgDPJ+X5dvb+OdnXeBVrGMOfMapynbDZ5NM6lBx
   w==;
X-CSE-ConnectionGUID: NrWyhG13Q+eAhy8dzqW0zw==
X-CSE-MsgGUID: mpn1BTagSx6+b+9UplBAeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3003925"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3003925"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:37:59 -0800
X-CSE-ConnectionGUID: GmDWVMvLTauuUilaK9NuLg==
X-CSE-MsgGUID: r/dUjpvoQKy3cqvMwTbmrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8073800"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Nov 2026 08:37:52 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQSNQ-00000000uud-40BN;
	Mon, 09 Nov 2026 16:37:48 +0000
Date: Tue, 10 Nov 2026 00:37:41 +0800
From: kernel test robot <lkp@intel.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>, printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Bradley Morgan <include@grrlz.net>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH printk 1/6] printk: Introduce and specify flush reasons
Message-ID: <202611100015.e1CNRy54-lkp@intel.com>
References: <20261109123127.489676-2-john.ogness@linutronix.de>
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
In-Reply-To: <20261109123127.489676-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d01f86a7da8161aac8c6304b377cf58fb75861ca]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-Introduce-and-specify-flush-reasons/20261109-133718
base:   d01f86a7da8161aac8c6304b377cf58fb75861ca
patch link:    https://lore.kernel.org/r/20261109123127.489676-2-john.ogness%40linutronix.de
patch subject: [PATCH printk 1/6] printk: Introduce and specify flush reasons
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20261110/202611100015.e1CNRy54-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261110/202611100015.e1CNRy54-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611100015.e1CNRy54-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/printk/printk.c:4735 function parameter 'reason' not described in 'printk_trigger_flush'
>> Warning: kernel/printk/printk.c:4735 function parameter 'reason' not described in 'printk_trigger_flush'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

