Return-Path: <linuxppc-dev+bounces-20509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2A5CD3424
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 08:44:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9TTk10RLz2xdh;
	Wed, 06 May 2026 18:44:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778057098;
	cv=none; b=gdeAze9xEtWu1kYNFmSql7bJqLEuz1CfP+8wiUySOl8r8vJ4jRNJCgf0vilkXK/1/wqEjxipjXCZjZ2gS/oX2FRr48dpzh7A08IpXm+vE/13MtDFyayl42B5ok3R1E8fyE0EAY3OnfEF5kp7S8bwqNHqAT1n0nln8bxxsrSvPL2Skt3HuybtEoD9gmjPN5DdvRrw6RfSW9TJf4LDJdlywCpof+fxFIYu30aZpg43RTyZyTaD8qhcjf6gGICGCrarfzK1uv9MyC/seLnUTJX98Vfyr1Gy3jItpj9bbVjOVBFo5j20zvBPGsd1CExuKVLdDAd037vvkhDhYhx5Ej9I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778057098; c=relaxed/relaxed;
	bh=GDDQpCg/fo3Ltp9yLgtX7++4gYUlRpj0ZHGljNHM18w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDNaCvGBsaL+EYRg3HgRraqS220zyzy5sUJGgSz8q30aDGyKbng+043LNTZE6QW1rqoxumZ34daEEk9ECKrGbshtmAYZP7hlGzLS72XWOrsLJOSboLx32SyneqfxLRLjxltUKSsXDzhaD+WsiUS67CdLw5T2/U+cT2bCsoj4cH9UzhRd7M/82hnrXuBa0zSYYXRaCIJo7a4pBK7PXDFkgMni7dVCF1uNalWq06CZJbTaBhHZMEI9hHyenuSXOS/kvSgs++77EXerQC3QQbkT2FROBzcBlcq4flU/BczsqgkHGweimfznUKKgSS0L1+VI5T5ZTlbJsrmKfF/pZYUWVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QmTCwjjD; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QmTCwjjD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9TTf3nTdz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 18:44:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778057095; x=1809593095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rnaW6h7hfxN/ADnzOwIB94lqMk5PhD9k0N7nSX9ctFk=;
  b=QmTCwjjDqCzPtS+sn9VuAiKfoZOskwHU3wYCifuj1JzCPM+CPr138Fpc
   Wb46El/PtZmQNRjDCfdi4dK3KJBMaZqzI6zdnKHaR3/1AjRzGX2SNUjIw
   DCOvwu1IQbDre9Y6dzSo/pFCg/jWvGCwyxohayOaOgkjOzAChkaaCAUt8
   MS9MZNKYotZH/dVGTNPlxpj3idbKRyxfSYan2i/cXncEO3lsb19+eZVQK
   jtlmybSNbWV830oX+y8gHlFKpPIZ9zTIiJYR5Wfut1HuyZlMI/s+j8Nm1
   7lZpL8K0/1IP/mhVbIdbbAkxhELLp/kme0mhydf9tCDWNGddpcPvQXmGy
   Q==;
X-CSE-ConnectionGUID: diQWuCPxQO+wUvr5qkSpSg==
X-CSE-MsgGUID: CyrjnJvsQ7q9kjudqRMN0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82848803"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82848803"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:44:48 -0700
X-CSE-ConnectionGUID: NXsA1zMVRwKyj3EsZ4hAlQ==
X-CSE-MsgGUID: RemB61o9RbWW5rRS2mbhAw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:44:46 -0700
Date: Wed, 6 May 2026 11:44:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: chleroy@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, kees@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, lilinjie8@huawei.com,
	liaohua4@huawei.com
Subject: Re: [PATCH V2] powerpc/text-patching: simplify the implementation of
 ppc_kallsyms_lookup_name()
Message-ID: <afr_e8wXcY-DPLrJ@ashevche-desk.local>
References: <20260506021143.13797-1-xieyuanbin1@huawei.com>
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
In-Reply-To: <20260506021143.13797-1-xieyuanbin1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 10:11:43AM +0800, Xie Yuanbin wrote:
> ppc_kallsyms_lookup_name() is called only twice in the kernel code, and
> the parameters are all constant strings. strnlen(name, KSYM_NAME_LEN) is
> called inside ppc_kallsyms_lookup_name(), when the compiler detects that
> KSYM_NAME_LEN is larger then the constant strings,
> the following error will be triggered:
> ```log
>   CC      arch/powerpc/kernel/optprobes.o
> In file included from ./arch/powerpc/include/asm/kprobes.h:24,
>                  from ./include/linux/kprobes.h:31,
>                  from arch/powerpc/kernel/optprobes.c:8:
> In function 'ppc_kallsyms_lookup_name',
>     inlined from 'arch_prepare_optimized_kprobe' at arch/powerpc/kernel/optprobes.c:209:21:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: 'strnlen' specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function 'ppc_kallsyms_lookup_name',
>     inlined from 'arch_prepare_optimized_kprobe' at arch/powerpc/kernel/optprobes.c:210:22:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: 'strnlen' specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> ```

This log can be made more readable:

  ```log
  In function 'ppc_kallsyms_lookup_name',
  ./arch/powerpc/include/asm/text-patching.h:232:13: error: 'strnlen' specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ```

> The error can be reproduced in the following ways:
> Use lastest linux-next source, change ppc_kallsyms_lookup_name() to
> __always_inline, use default ppc64_defconfig, set CONFIG_EXPERT=y,
> CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n, CONFIG_CC_OPTIMIZE_FOR_SIZE=y,
> and use gcc-14 or a later version for compilation.
> 
> Since ppc_kallsyms_lookup_name() is called only twice in the kernel,
> and the parameters are all constant strins, simplify the implementation
> of ppc_kallsyms_lookup_name() and avoid calling strnlen().

> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Kees Cook <kees@kernel.org>

Please, keep Cc list...

> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---

...somewhere here in the comments block. This will reduce unneeded churn
in the commit message when maintainer applies the patch.

> v1->v2: https://lore.kernel.org/20260205100517.292858-2-xieyuanbin1@huawei.com
>   - Not use strlen()

-- 
With Best Regards,
Andy Shevchenko



