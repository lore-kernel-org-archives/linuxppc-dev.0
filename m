Return-Path: <linuxppc-dev+bounces-21750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3978ACD4F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 19:50:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRv9W3kd1z2yN8;
	Sat, 30 May 2026 05:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780084255;
	cv=none; b=AyB7TVxAlAHrq1TyQhbFSkIOlflihq6yAaBgIDjPixrVGkiq2t6rzb/qjVK0fxwwRh5yubHMPJHVo+R/dQTwgOfwtRBS4VsW3DM3Hp1MqF77dxLGXYyHInpbl6E+VUi3PtC4JLIdLNAWdekTY4H0BS6Q/Em+zULz0kTadGdaLkgaP7qaoLgn4eeNgBWtzNotQqP6Aw2BOWKn3lpBErb50YTPod0lzIQCjx+tGeaUuSnlykgNrRT3R61GSPNVTaVGNtD4kDT7xP1BQ0VLU7GlRDQLwX69/XmMFLYZIoskvDJtdXUYdQMPHRMwqxjQVnxUQ+sU3yC2bvLqEX7A+dOeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780084255; c=relaxed/relaxed;
	bh=9mosavUQhPwQgg41SgWFIt67OkCP0k2fTVt6P/KeJDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URl/45stLfF8MLbWAeI3UrK9vSBrUgQktOaTDYCc010xsXMiROZvcox+OaHE7B/lKlA/blmVZZ+Y1RtC0lFwSBXTU0kgX/PiTaVQx5hkIgd6O9fpMjOlzB4wHRikD9KjEoV+FuZR63fwnw4xlwG/T+DlgB5zJxf0qqfMOVQipvcQYiw7MsO1uE3I/DDkYOhKa8Ul3sV+Ki0aqTo2b7Ubzuoy8dl+IZ0cwZKiHyuMq4Noru7Ggj9AuT6H84vPOf1ximz128MCzDxbIUQoHSqd6A1TwrpO+s0t2RFStwWzZ+Rc4WWOyDZVMxfQaTUee2pgZVuRtMaTFKF0pxCZyZ1kbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fhiLCZwy; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fhiLCZwy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRv9T6zN7z2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 05:50:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780084254; x=1811620254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xy47Vb9m65sQMnuPVEfRiE4rCqGWTQXYogQjJ4vAUFE=;
  b=fhiLCZwyMnEamuXYcltF9fbZDjAmxKQMzKmqRLJo2FHUhMxCieHhYvDW
   Kgm6oQlEc5jMgjj5ZRLspJk9QUPig5cMxVXLP7xu0n74JfSrcoDuKf/T2
   ui7y7Pck3FEbfFXICHQ7VXu09zOnEHi9rjD9HyUWgawlDlHBNitPqq9GJ
   1F341D9tREynEqYh0LPIH/ZgCQT9lVX1NASNKFYocQROgD4kVRRK2gROF
   stq2PzRNBNWinDLZoWoOShyIJdDbFuZDRdSaTl9MEhUo92wxTq17XmxGa
   7nBGDZQMXVBGa20HY0frvNM5+555RxvF1SlultIwqyn+XmMofotVh7e7n
   w==;
X-CSE-ConnectionGUID: FPk0MyaRQXeEoGO7ZQkIQA==
X-CSE-MsgGUID: IWZg9o8+S4+pqkCyfsCDmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91252449"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="91252449"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 12:50:49 -0700
X-CSE-ConnectionGUID: caj/6dIZQ8mge6IaX0afWA==
X-CSE-MsgGUID: +stMZUGZScOU1l87RpGVlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="246946747"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 12:50:48 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wT3EC-000000007dq-1Gfm;
	Fri, 29 May 2026 19:50:44 +0000
Date: Sat, 30 May 2026 03:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: remove unused min_t/max_t macros
Message-ID: <202605300340.G7sL2jlK-lkp@intel.com>
References: <20260525091839.817778-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260525091839.817778-3-thorsten.blum@linux.dev>

Hi Thorsten,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v7.1-rc5 next-20260528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/powerpc-boot-remove-unused-min_t-max_t-macros/20260525-172120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20260525091839.817778-3-thorsten.blum%40linux.dev
patch subject: [PATCH] powerpc/boot: remove unused min_t/max_t macros
config: powerpc64-randconfig-r061-20260529 (https://download.01.org/0day-ci/archive/20260530/202605300340.G7sL2jlK-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9409c07de6378507397ecdb6f05f628f58110112)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260530/202605300340.G7sL2jlK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605300340.G7sL2jlK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/boot/decompress.c:37:
   In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:241:
>> arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:158:21: error: call to undeclared function 'min_t'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     158 |         size_t copy_size = min_t(size_t,
         |                            ^
>> arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:158:27: error: unexpected type name 'size_t': expected expression
     158 |         size_t copy_size = min_t(size_t,
         |                                  ^
   In file included from arch/powerpc/boot/decompress.c:37:
   In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:242:
>> arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:357:9: error: call to undeclared function 'min_t'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     357 |         left = min_t(size_t, dict->limit - dict->pos, *len);
         |                ^
>> arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:357:15: error: unexpected type name 'size_t': expected expression
     357 |         left = min_t(size_t, dict->limit - dict->pos, *len);
         |                      ^
   arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:1101:25: error: call to undeclared function 'min_t'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1101 |                         dict_limit(&s->dict, min_t(size_t,
         |                                              ^
   arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:1101:31: error: unexpected type name 'size_t': expected expression
    1101 |                         dict_limit(&s->dict, min_t(size_t,
         |                                                    ^
   In file included from arch/powerpc/boot/decompress.c:37:
   In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:243:
>> arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c:469:14: error: call to undeclared function 'min_t'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     469 |         copy_size = min_t(size_t, s->temp.filtered, b->out_size - b->out_pos);
         |                     ^
>> arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c:469:20: error: unexpected type name 'size_t': expected expression
     469 |         copy_size = min_t(size_t, s->temp.filtered, b->out_size - b->out_pos);
         |                           ^
   8 errors generated.


vim +/min_t +158 arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c

24fa0402a9b6a5 Lasse Collin 2011-01-12  149  
24fa0402a9b6a5 Lasse Collin 2011-01-12  150  /*
24fa0402a9b6a5 Lasse Collin 2011-01-12  151   * Fill s->temp by copying data starting from b->in[b->in_pos]. Caller
24fa0402a9b6a5 Lasse Collin 2011-01-12  152   * must have set s->temp.pos to indicate how much data we are supposed
24fa0402a9b6a5 Lasse Collin 2011-01-12  153   * to copy into s->temp.buf. Return true once s->temp.pos has reached
24fa0402a9b6a5 Lasse Collin 2011-01-12  154   * s->temp.size.
24fa0402a9b6a5 Lasse Collin 2011-01-12  155   */
24fa0402a9b6a5 Lasse Collin 2011-01-12  156  static bool fill_temp(struct xz_dec *s, struct xz_buf *b)
24fa0402a9b6a5 Lasse Collin 2011-01-12  157  {
24fa0402a9b6a5 Lasse Collin 2011-01-12 @158  	size_t copy_size = min_t(size_t,
24fa0402a9b6a5 Lasse Collin 2011-01-12  159  			b->in_size - b->in_pos, s->temp.size - s->temp.pos);
24fa0402a9b6a5 Lasse Collin 2011-01-12  160  
24fa0402a9b6a5 Lasse Collin 2011-01-12  161  	memcpy(s->temp.buf + s->temp.pos, b->in + b->in_pos, copy_size);
24fa0402a9b6a5 Lasse Collin 2011-01-12  162  	b->in_pos += copy_size;
24fa0402a9b6a5 Lasse Collin 2011-01-12  163  	s->temp.pos += copy_size;
24fa0402a9b6a5 Lasse Collin 2011-01-12  164  
24fa0402a9b6a5 Lasse Collin 2011-01-12  165  	if (s->temp.pos == s->temp.size) {
24fa0402a9b6a5 Lasse Collin 2011-01-12  166  		s->temp.pos = 0;
24fa0402a9b6a5 Lasse Collin 2011-01-12  167  		return true;
24fa0402a9b6a5 Lasse Collin 2011-01-12  168  	}
24fa0402a9b6a5 Lasse Collin 2011-01-12  169  
24fa0402a9b6a5 Lasse Collin 2011-01-12  170  	return false;
24fa0402a9b6a5 Lasse Collin 2011-01-12  171  }
24fa0402a9b6a5 Lasse Collin 2011-01-12  172  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

