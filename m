Return-Path: <linuxppc-dev+bounces-27569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CEFC88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 12:50:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlwbK1jXxz2y7Y;
	Thu, 17 Sep 2026 22:50:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789649437;
	cv=none; b=dyBXhYIfQbYzvaL2to416CPyHE5FRK6ZQgkBkVJ3zEAy1DJOghUfmTKOwR/fP911bd6T1//1oy31kiBl1yT8XFSdAZq3gsnJtgeyeH4JmgYXGql09JEDedk0gejOyVhaYaaw4/z0lT0vkq0G7QBdzsrab2/OFiYijz9AoDpZFxyNy/CciOdeVZePw6Pp0DzDVE7YUdK2oq5ZBp2AyVjx3RfpDsPxnlozMRwfawfJuRX1DawR3maW5AdkuC//PFt+CF3Ll3WfPvkhiPnXJJj/CufazHRpzPJOPHCSEGfD71DRC1i1qzf4n6r9rPC7OIjRBUWdlFr4UzG1g7JwWbv5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789649437; c=relaxed/relaxed;
	bh=aHTNssIP8WODe0+NiptBTJ7rKksQCSqusDyDP2cCNXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT2raQTZjaGbYcFPYReo2wHjB49nyNwVcayoaLq38QfGlXM2YCi6bgIg5iI9R59Utx1MFM/1Yxz8nq8PBG9pzwNS3h/nE4CDsR/m9IzlrNg3zlfFKXSai//aE3p5CzBWLpl7cuIkwDbKHWsuAhREl/+ZTelNeyLM7Jeo53c0bJ+oQBI2ceVgE0Aj/3YA0jTITVUc3IVTrjBcPZwK5dANZRNd6WlZpagiQWDuCv/gnueETByQjkJ1I3qqDL20pqbfLx31Nt88plhRWjGgkxn8d4ko1CPDh1bJCjl/xOdX0PbctZY3Le7NeYmkgLM8vPEentNY/D1nwqZ1hGJwDyZbFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kYgtsls7; dkim-atps=neutral; spf=pass (client-ip=192.198.163.5; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kYgtsls7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.5; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlwbF5mYSz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 22:50:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789649434; x=1821185434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzWXhI3KvUI5kNn0oJ2dnLkm0fr70XcUjNU3CpyXKjY=;
  b=kYgtsls7HcrWLCZuxFW0h64Hx/HlnRdTJDZNajc/OaSaYCbD8ZrClwFW
   xkB0ni35cZoSIoMT/fydkQpNS3UPqZadtKFOgP8icNLNz76a31XSv0d46
   SmUhSL3Ccex1BHIawdQM7VOWKCgQ2v3tLtk7XjyExiHuX4+zuMxJjVL9z
   LQnY9A+FCfn9whga919YED0cNIgSEVf1aUfZLU0eDECkPkajeMqztGw7G
   cc5MF0U6MRf/EMfKY394UXHwjOYnYZcxSWE3XhM0q5QUTPIxp9PBMG0CA
   nsmVse/mnS7NZrgl3LIOOOcn6HKC9dki8tLkOpP5xovmvZeiT2VmJtJAG
   Q==;
X-CSE-ConnectionGUID: Fbew8fLpQEup40Y/LWt0nw==
X-CSE-MsgGUID: 8zDkGxb5SwCDjlVF6eYGOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="571547"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="571547"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:50:29 -0700
X-CSE-ConnectionGUID: BHUVFHlUS6KIwZ6rSaE9JA==
X-CSE-MsgGUID: iF++V9+jRoaQSIqQ04iddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="278986712"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:50:25 -0700
Date: Thu, 17 Sep 2026 15:50:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Thorsten Blum <blum@kernel.org>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/7] powerpc/papr_scm: Return the string length from the
 sysfs show functions
Message-ID: <aqviD9ow5HLGcLTK@ashevche-desk.local>
References: <20260917002312.i.923-kees@kernel.org>
 <20260917002333.2306346-6-kees@kernel.org>
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
In-Reply-To: <20260917002333.2306346-6-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 05:23:18PM -0700, Kees Cook wrote:
> perf_stats_show() and flags_show() build their output with a seq_buf
> and return seq_buf_used(), which may include the trailing NUL byte
> when the seq_buf has overflowed. Use seq_buf_strlen() instead.
> 
> Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
> 16.1.0:
> arch/powerpc/platforms/pseries/papr_scm.o

...

>  free_stats:
>  	kfree(stats);
> -	return rc ? rc : (ssize_t)seq_buf_used(&s);
> +	return rc ? rc : (ssize_t)seq_buf_strlen(&s);
>  }

On a brief look it's a single ternary like this in the file, perhaps while at
it move to Elvis op?

	return rc ?: (ssize_t)seq_buf_strlen(&s);

-- 
With Best Regards,
Andy Shevchenko



