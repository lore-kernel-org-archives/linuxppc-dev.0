Return-Path: <linuxppc-dev+bounces-23937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991E7C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:53:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwtds1khRz3byZ;
	Thu, 09 Jul 2026 21:53:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783598017;
	cv=none; b=bbLdhIxgi/UzG9UhTnKS30U0n2tNkh8tM9tn8JUVmuKHQaSAAspJV4wZ9kSTC1CQSYF0B8Q4kyhC1ZvcwtglZvKzH90N9oGWW5znTvxQsAEs7Sd5ulgE2N1Xu+lwzIQ/dw3pftHKf624vhe4OYwjNxLq817QutX9/szaBwp4TYZcpJJZbN2PnnAaBF5rlnikjh3UeLjo93I+X/ZBglPnoAZOSgYBpNnD9uyc31T2h/hK/1wk3o3kO88JCdk9yxRpeRSbGUlgmQALStHyAS90Lm9rEysTRJHZK47bw01zbTDm+raF4w8qu+0yMk4uq3iZkEe4AqeRkw6PSTfL6gN1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783598017; c=relaxed/relaxed;
	bh=eVqNlO6e/kaZUubS5+OfG6rJEc4MiSvEakp9qEV1dq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A152ELemI51oOahyKxNI6eK5dgdqQYxq41kHTBu2ySl7qfJsLGOGNQHafvDp4iBSu4427DxdfMGm+vTeMmAR6xEGYMxyN4PVZ9Q4BkYsAZ1o8KcProyVutqgwLTK/1+RHYQhFru0irBSCKucqeJjaA998+x3TyyrV4+BlpXrqHQxOVbGMJJAyBJxUcTxww78VO8F++iC0Cq1g1SjIfRQSGMaI98VOKP+ichMxzXFV9VpWnAXdHS/nv9J22vM7Y3zcIOodQkCY729R+XsP/myZqAnZXWc/yvTyLTGxCu9B4BUNm1WsyrJf7p/3Cm8293DyScLlBsUtuAQCkt0f2kZVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=njbmd4ZF; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=njbmd4ZF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwtdn2TLGz3bxl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:53:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783598014; x=1815134014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ozmVITewMY7x7o4QHkkB6PUQJDlhHAcSVz23m7NADU=;
  b=njbmd4ZFztVZ1D9v9ruRIGKHDSZ7eZOBJMkKAc5o59PeU5fOk4MfCkXz
   82+RlIsqoBRcph/Xzdl1Ldx9DNiywkkOzLYTItGJPZGrCApiU0gFvNGWR
   ER+TskKIurb2jCcjTtiDOsHnZFX9dwsS9WllbxUAMq3NN8Bg1BZTWlb97
   h6HZxwaOJ96Oeb0ns2eBcLEE9R9EFjz1SEl56ej5YURo4xqlIIkUw7Jhg
   qrZm4g4wQnSpPiMeEVum1BdZ7RV6PMTas661q4BU0vQvc7D1Nmke/ZlE/
   QQ2jhcvbdDWxXDY9NqSBD49e3AdnZejVq7vCfk9bXgKTB/WmJOFJldPXT
   A==;
X-CSE-ConnectionGUID: vLsJgLB4TTGN2CtcnZYWng==
X-CSE-MsgGUID: aMSuxf3ATQ+j7zLlvMEjVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84468147"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84468147"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 04:53:28 -0700
X-CSE-ConnectionGUID: NzVXENsmTzav4XDhEZon7A==
X-CSE-MsgGUID: wqNAPSGtQPKGx1Y7uLZC6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254684167"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 04:53:26 -0700
Date: Thu, 9 Jul 2026 14:53:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] bitmap: Properly initialise destination bitmap for
 scatter & gather test
Message-ID: <ak-LroqSUcVMSSrZ@ashevche-desk.local>
References: <67d1838732b85b1f715cc3ada5bb38dcfcf9db55.1783593992.git.chleroy@kernel.org>
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
In-Reply-To: <67d1838732b85b1f715cc3ada5bb38dcfcf9db55.1783593992.git.chleroy@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 01:40:06PM +0200, Christophe Leroy (CS GROUP) wrote:
> Erhard reports failure of bitmap tests on powerpc:
> 
>   test_bitmap: loaded.
>   test_bitmap: [lib/test_bitmap.c:397] bitmaps contents differ: expected "1,3-4,9", got "1,3-4,9,65-71,73-79,81-87,89-95,97-99"
>   test_bitmap: parselist('0-2047:128/256'):    912
>   test_bitmap: scnprintf("%*pbl", '0-32767'):    5977
>   test_bitmap: test_bitmap_read_perf:        1191082
>   test_bitmap: test_bitmap_write_perf:        1270153
>   test_bitmap: failed 1 out of 208655 tests
> 
> The happens mainly when CONFIG_INIT_STACK_ALL_PATTERN is set.
> 
> Commit 6b5a4b687367 ("bitmap: Add test for out-of-boundary
> modifications for scatter & gather") extended the test to
> out-of-boundary bits, but those bits where left uninitialised.
> 
> Properly initialise the entire result bitmap before the test.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

-- 
With Best Regards,
Andy Shevchenko



