Return-Path: <linuxppc-dev+bounces-23775-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3878C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw98F2M75z2yS0;
	Wed, 08 Jul 2026 17:43:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783496637;
	cv=none; b=UYGbXZrjF/PBCMYjy+uWPJCrLzObqFGtbPWYbCKyMdAlmHTfRSUOR4G1FmsaM+5DkX+TAAWAUy/0Tycu/H1Bw/J7/QYpSbfGzDeT4EISpXBeQBD+MPFhlR8PL87yK8W1NhLMglp0J15XdT/S6s+8VUfYDLdeH7bOL9iAgDx3d440gd8/1EZhLW4p6RIEIb7PXhFWru64giIawYZk3E+Xo0PXdPCVW+aWU8RKAuOb7y0b5h3TGuP3cboqvWXsvV4L68LdcaQlGq66GGPx/c2I+ocaTF1FCuiXmxgtEpUsaC/BfvUVov1YRs0vXuk8WIYSlUZndaf9WupOXVrgXUtSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783496637; c=relaxed/relaxed;
	bh=dFahrLwgEul8F4uGr/6lyn5dRtMvIdvid6P+Q7aFyy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE6NmE+2xf6xpTj3zE8S8i4mTK+EA0XJMeu7rQQAeYxyRs6SXPQNrBVEheRh/aaPbhEhRunkbC/uWEbpgtPLMor1M5Sk/fCwgaMO6K/h/2k0utQPZqun7pLKdtn0Dl4zdQZVUtkdkL1qttMzFdLRJQCuVN7uwyoAtye3SY9SLgRyfvOVgs3mAa3BvbZrvOMZfkvH8bk74IBFn5fdBRk6W87/Wy1QR720EICAsXJp20ZmCXLxzG34zQuCeK026SX/Tdz06QlVE6SJbX7ndPeUIb3R8MwlgPbsZBtDiWEaCJoDxzJTX+k6TgQjmLab+pVPD/HsW/wUmt7sT6bwxOgUWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klXcCmWJ; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klXcCmWJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw9895hTbz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 17:43:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783496634; x=1815032634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3lqpiIpNEzUN9lwKmVBXBp+CWylctSM96UNv4c7p21Q=;
  b=klXcCmWJ46J6i7LyNknTlh0oOa513ipGIm3/WESbT9BPwCQUiOMJTBli
   rjtGVj4YHWAuygHi9Dnk6Gw0Qxgch+XEr09OAOa3KqxfIbPW0wJ1MBSCj
   clme4JT3a0Q9BIy1oRmlONROoAHY4m2sjaRIEzbWeUdZZz/glQXCL/QS/
   aFU+C02AhmDi9Z43928EpKgjC1Kj9rLBEZIfC+ekhXqlILfS5jyB9n0or
   tb6CHDx/lmlArJOKlRIdhn6b+k2aXiEzupM35+gNI1AmqxWtSIVZRCy4s
   NUUZ87lZsyiApEGVqd4zbPT3YBNyS/VvwdXeVEyUhyM7stlhhSUW+TlM4
   w==;
X-CSE-ConnectionGUID: OatWGVgoScKDuVPTEyMRnA==
X-CSE-MsgGUID: QIcdGSuAQ7mLLrz3JBzj9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="106948256"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="106948256"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 00:43:49 -0700
X-CSE-ConnectionGUID: 58gMj78cTua/UrqRR5ORwQ==
X-CSE-MsgGUID: aZ4mf7g+Q7Kknfea4mp5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250230526"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 00:43:47 -0700
Date: Wed, 8 Jul 2026 10:43:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org
Subject: Re: test_bitmap fails on ppc/ppc64 on kernels v7.1.3, v7.2-rc2
Message-ID: <ak3_sGAnFxbmxfe8@ashevche-desk.local>
References: <ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org>
 <98d65de7-e5aa-4197-85bd-219eab01e572@kernel.org>
 <b9b762d0-cfe1-4fdb-b668-b6ef4afb0059@mailbox.org>
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
In-Reply-To: <b9b762d0-cfe1-4fdb-b668-b6ef4afb0059@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 01:25:01AM +0200, Erhard Furtner wrote:

...

> > So there is something with your config
> 
> Interesting! As I get the same test failure on my Talos II too.
> 
> Anyhow, I was able to bisect the issue. Offending commit is:
> 
>  # git bisect bad
> 6b5a4b68736798df1031404a2fad06d031253ef7 is the first bad commit
> commit 6b5a4b68736798df1031404a2fad06d031253ef7 (HEAD)
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Thu Feb 26 12:16:44 2026 +0100
> 
>     bitmap: Add test for out-of-boundary modifications for scatter & gather
> 
>     Make sure that bitmap_scatter() and bitmap_gather() do not modify
>     the bits outside of the given nbits span.
> 
>     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Signed-off-by: Yury Norov <ynorov@nvidia.com>
> 
>  lib/test_bitmap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> 
> Reverting this commit on top of v7.2-rc2 lets the test pass:
> 
> test_bitmap: loaded.
> test_bitmap: parselist('0-2047:128/256'):	888
> test_bitmap: scnprintf("%*pbl", '0-32767'):	6074
> test_bitmap: test_bitmap_read_perf:		1190938
> test_bitmap: test_bitmap_write_perf:		1259471
> test_bitmap: all 208655 tests passed
> 
> Your hint about my config made me check a few options and I found the
> offending one, which is INIT_STACK_ALL_PATTERN=y. On a kernel built with
> INIT_STACK_ALL_ZERO=y the issue does not show up.

Oh, this is nice. So, there are two (more?) options I see to mitigate
the issue:
- carefully copy the garbage from the stack to the expected values
  (effectively merge the whatever is on stack with the expected value)
- allocate buffers on heap

The latter seems the easiest and right thing to do (since we can't really
predict if the stack pattern is the same or bitmap APIs scatters the bits
just on top of the respective set or clear ones over that pattern).

I will send a patch, thanks for the report and analysis!


-- 
With Best Regards,
Andy Shevchenko



