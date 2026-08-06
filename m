Return-Path: <linuxppc-dev+bounces-25533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B19C56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 21:51:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGLb13gtkz3brN;
	Fri, 07 Aug 2026 07:51:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786053101;
	cv=none; b=MUAp0LPgAAXGCj2mDUG8fkNhqRGR9GH64hHgNUFYxYeecDxg7S9DP6PL/xR31jmIGpj2paT/vTqxd7oiTBI1NSUF5mXyMZXZp7NjtVWW+ETQH5OwbDvDkJYLbJ4DUjqipguZmXrBGrzciC2ijJ++TNABFHYFUr0jUjYsenL91bqLp1HOMZcd39cxfvRHUhUJJ2sj68OHT2tzlHjNOcDIs2ix5FfkzMibI3ll7Bt8NKgPuQMjyxoO3LuSjui7663aPwv/Mqf5dZN+HkENd5dvu4FOfMx2cZguG732VBRDM6dhRTmQqnHMQnmkIppGAKegt3mVaWs7E0qk4oGC9utlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786053101; c=relaxed/relaxed;
	bh=fdNYUN2NKYN/Z1c6wkVpv11hDVgUadb9eUS5kEIFV7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n94qteXxZALQWF97hkFzkjUC42I0s4NBFI3MBvB69Eni4v1A2VU5XrG71sFUtZdnkzVA6Lv1ebXE0MIYS9zAKXJq2TGbYH8Efm+5NmSuiUEU3VjPZ3PLsTLMRdsn1rs+aGqqbGV8KopOfmePnU8HXf8Mkba4/QC7ak7GuqUsiX9HAjxeUdhbikln6JNZbKRkQ6gP13B1bSniK37EbcVgBcdgjdsZZodnSnRZXVGIFCZLHmqxbDesAUArINlqjY6x5KO4XAHxNvO2VQMfMkq/qFtBCKM5zUiR/UyjTyMGBQ1xKlI2CwphQ31t19GdkoFINzXfleUnZKWjXIKgaSGCjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SsACYIZ5; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SsACYIZ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGLZy2n5Fz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 07:51:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786053099; x=1817589099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YXZzO7rHKj6qKOZ2jDkYVaRVikc1Wt8k9LrXwdPOkI=;
  b=SsACYIZ58FlbZYBPKon0xlLk42dQ1hxobIE4rk6JNxiaUop8oUbkzC0j
   waEPFaG9bEhDa7mdCmgi4KNLQJGRlfniPn/yLNLVsG8eQ7wHrvoiCgCfp
   QOylu1LQlCoAgb6k8QtkPPi8oWLClkgOpvd3i6W/zdGh+rNgia4HHJww9
   1a5XnPjbYFI/k3Kw9skwf6icdkG3fouWOhIvAjJGOnZbAqUteddtBCJH1
   Ondnyk7lrcry7V2yffFCMpDzE37dLYJOCvpLuXgHHZRyP1fPCKJsoEFQI
   ivKurol72vesfhn/QVpJjGc/TEuCKEUOyh+nJMWk2ib3sWHBBqfXbhVE5
   g==;
X-CSE-ConnectionGUID: 3TrUhf6kTcuk7GjLVqDtRQ==
X-CSE-MsgGUID: 3ILnIEksTaajYU6i9sL/eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="109453870"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="109453870"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:51:32 -0700
X-CSE-ConnectionGUID: AB8YyTXOSCSKko1pPJhpvA==
X-CSE-MsgGUID: gfPYtjsYTwuf1P+pMEQQWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="285586569"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Aug 2026 14:51:25 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws5zl-00000000GKf-1GLg;
	Thu, 06 Aug 2026 21:51:21 +0000
Date: Fri, 7 Aug 2026 05:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, acpica-devel@lists.linux.dev,
	bpf@vger.kernel.org, coresight@lists.linaro.org,
	kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, virtualization@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] tools: Use fputc() calls in some functions
Message-ID: <202608070547.MRKfa3bH-lkp@intel.com>
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
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
In-Reply-To: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v7.2-rc6 next-20260806]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/tools-Use-fputc-calls-in-some-functions/20260806-165154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/48f2d61f-d468-49b7-881e-f00777db073f%40web.de
patch subject: [PATCH] tools: Use fputc() calls in some functions
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260807/202608070547.MRKfa3bH-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260807/202608070547.MRKfa3bH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608070547.MRKfa3bH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> builtin-check.c:300:8: error: incompatible pointer to integer conversion passing 'FILE *' (aka 'struct _IO_FILE *') to parameter of type 'int' [-Wint-conversion]
     300 |         fputc(stderr, '\n');
         |               ^~~~~~
   /usr/include/stdio.h:155:16: note: expanded from macro 'stderr'
     155 | #define stderr stderr
         |                ^~~~~~
   /usr/include/stdio.h:611:23: note: passing argument to parameter '__c' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                       ^
>> builtin-check.c:300:16: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'FILE *' (aka 'struct _IO_FILE *') [-Wint-conversion]
     300 |         fputc(stderr, '\n');
         |                       ^~~~
   /usr/include/stdio.h:611:34: note: passing argument to parameter '__stream' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                                  ^
   2 errors generated.
>> disas.c:540:9: error: incompatible pointer to integer conversion passing 'FILE *' (aka 'struct _IO_FILE *') to parameter of type 'int' [-Wint-conversion]
     540 |                 fputc(stream, '\n');
         |                       ^~~~~~
   /usr/include/stdio.h:611:23: note: passing argument to parameter '__c' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                       ^
>> disas.c:540:17: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'FILE *' (aka 'struct _IO_FILE *') [-Wint-conversion]
     540 |                 fputc(stream, '\n');
         |                               ^~~~
   /usr/include/stdio.h:611:34: note: passing argument to parameter '__stream' here
     611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
         |                                  ^
   make[5]: *** [tools/build/Makefile.build:96: tools/objtool/builtin-check.o] Error 1
   2 errors generated.
   make[5]: *** [tools/build/Makefile.build:95: tools/objtool/disas.o] Error 1
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [Makefile:123: tools/objtool/objtool-in.o] Error 2
   make[4]: Target 'all' not remade because of errors.
   make[3]: *** [Makefile:74: objtool] Error 2
   make[2]: *** [Makefile:1587: tools/objtool] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

