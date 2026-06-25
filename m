Return-Path: <linuxppc-dev+bounces-22969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA9CDB47F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 06:25:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gm81s0bcWz2xwH;
	Thu, 25 Jun 2026 16:25:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782368737;
	cv=none; b=GEKExf4w0I4BYD5yJqmklSbLEzJWJN1aAPGvhzzjRP4OWaUTEaFFqyU3W1g7BcFgXkj/TC50G0y9nhCtM3MRIR+ZG3gReV26ugHReTdxtDu+V70Rj5ZQfXKKmcrB0oA5WK21Xfi2qnrM1uT+RjmgwvZJpSdun7r1Sgq9FNhCjEBfeUguik43g+XGuQVt5K/85sOKQHALgsp/fK+tx73h1sepnJIAbtlIlMakcEw64PmMlcgh2UXX13BjRy/81Bz922SbHDJvUNNhbCQcYufo+AdQ0kFahFd+zCWfgSrZvxofbg1ptjUp9ePfReGdU64xbDuZGrdVS0RK/wWtgpfxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782368737; c=relaxed/relaxed;
	bh=RhlqiGuyIL8uaStRf09OkECgRIZy+exLcSaWwdhfsqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsM+QO0tRSFxPCgSO702JrON6yyfxpdOs9qQPP0KThgi5J0B3JQH+a7evopLOxhb+r1jefPh1kHB0MB7R0CTGkrEs0HKkzQjaiKkYvKDTMqL1pNYqc3HuKv8P/chl8qHKWQ9sMrkIbfKjKsRc7gYa1n6KRZU82EmmL9cXJBuDfZIMAKY7HE3JLE5SBMqrP4n3aRBC+SyZ4ZOCOA3hDmxAwfTlSix7q+rdjeg9fPhEF2e2DvxgQseFQqKPHUikoGAXjHxRWXHkpafOtgvQotjbrVo3dUzCEJEwXzPQlvB96e23+M4YqmYUTujCNTQxWg+i6qWSPhQTIGNDOB7KRa1eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4Wu7uSi; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4Wu7uSi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gm81n0QHkz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 16:25:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368733; x=1813904733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qN6rxeLPrWEPmxFGStMS4jQk+7YyeMkk+HD//Wyqj8g=;
  b=A4Wu7uSiEzk7Xj9Ka62QuJaYzOOuAlSRpEWpE5pHBxtKMGDsxVBvXuZz
   BIFeIskMS4HAPnP1eWJFJycjW40xw5tk2iBbgpTKzzhXoa4ZGnpL7qyTK
   J5WXJsrKjqKVs51twdhCglcOhsi0F9flJEJQFdGqLhmlDfQktzGbZqcxH
   lw5ZuP3FD2vJAkj5smjsEziKFpigQ8mfQiT8RVXPHKUSLXDDqwR+6UQ8i
   EmubiLP37XrfU/tAUjCp5mUZ//Me+VCe8SPwRWIFyiEZk4StaJuUoqrjv
   33TE/77w7QACL+DKmoeUW1S66Z+M1EhbfGSgLKds4sfTv+kcX+ZIryqpG
   w==;
X-CSE-ConnectionGUID: e89jtibYQ3GeBp3I+AbXhg==
X-CSE-MsgGUID: Q0jH+5hzRZqBai9DAI5pVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100566513"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="100566513"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:25:26 -0700
X-CSE-ConnectionGUID: mgpo7onQQoGmj/svgy/OYA==
X-CSE-MsgGUID: 38zIrkM8TsC/DcZrYr1OfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="255127244"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:25:21 -0700
Date: Thu, 25 Jun 2026 09:25:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-ID: <ajzJz_YgpTRLiJxX@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
 <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
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
In-Reply-To: <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 09:44:37PM +0100, Bradley Morgan wrote:
> On June 24, 2026 9:34:19 PM GMT+01:00, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
> >wrote:

...

> > It would be nice to have the conventional [0/N] cover letter to tell
> > readers what this is all about.
> 
> I added a what I changed? I'm iffy on cover letters, if you want I'll do
> it...

FWIW, always do cover-letter when you have 2+ patches in the series.
And do not add it (there are rare exceptions, though) when it's a single patch.

-- 
With Best Regards,
Andy Shevchenko



