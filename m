Return-Path: <linuxppc-dev+bounces-22947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B07CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 20:12:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glGTD4V4qz2yQG;
	Wed, 24 Jun 2026 06:12:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782245568;
	cv=none; b=PnvIPLOXr7hxqluWRXi+kaIlA6NZafdOq+buRPp9/nM2BuG/eWywfrFF3OLraQfsHJC1gcSS8MbwW1N0AUIqH3UldbJniskeyIq/K1IEXOkX0qsdHOxxqgCdky4AMoEuMJ/4kbyRfe1m/RLeLW/BaordHgXTFyITOoUJD3BHPqHEIitF28eMYfbo66QkHc70TB9RmQZWiZcMQ5TaYP9XwI8XMcSvEk4gK1SXwI9UWO8MKZpmeg2BZ8vbowgIX+ixRsZsz8PAMhfr6U7e/G+tnUhyNp/BqZySPfoCMl9aO8IlJEgVRJaIl2O88ZqX4o5MHExhBcBgWNwqYW849ckXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782245568; c=relaxed/relaxed;
	bh=5g7C4tkUfwL9F4pt8RcDc1MBIp9SmXv+OXzZgySW81g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+zAapxV/9LQclA/5l38HaDSaUINHwdkrE1kAAOYx2iENrWQqGIPWR1Vnj/Owy/+xrG5wqFaBH2VZXMiPBXX64vbiz+2OQjWB2nfWQlAmO5wfzLNhBzwqw/v7dKT26wRIa9IaQLKI6eINSfYYwY1gn3dsgvgWbYoJFn3sRzNmKVhboRtg1KQiAyQ1rcxxf0672DhQaDLXSCYdbsBbt3yif2dmKq995rtVr54Dw6GmOPkScPNzLaPosKVzNnKA/Wigz8SI2Zmp046mGqB1WYNgLA/3g8B0i+FsIqceB0DqBruriP2Va826fku3wzGATQfL9+nKO0Cx4bq9IvU3ABh7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vw5//LVl; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vw5//LVl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Wed, 24 Jun 2026 06:12:45 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glGT92RQMz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 06:12:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782245566; x=1813781566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kW91b4d2Vx0G184J/85Y4W5ZdTuxK1621sMYs06jpXc=;
  b=Vw5//LVlyp6/U8aJ3FSAyj/YFlqhDA4a9hnRw1+ZPxcUx6hE8iT48UKQ
   BfZpqaUXwrY7b0Wqsku+3qcus2kCQ7GIcw2MzEkEeFs1fUCVDc3VwyP8/
   W05INuUunvbgtoXazNhj7h/eVj5r1SEOEJZ3BlHhSSfKJNvu2dw9sMA12
   eMxpHLquql4BTuhPJ38kxT7FZ4pgh0ikjcJ0k0NuLhS01I8NoY70X/MUl
   vQmD6XdL4WYtnVnKgHHuh+NAY8jLrm1t2k0HkEpDrs4h4cZQpRMsCY5TO
   Ba5isMtbHNH5OH6qomndYkSVGY7hRt15Fpxi5oXd+MTPQOZ+Pxj3TEVPN
   Q==;
X-CSE-ConnectionGUID: utuef4V9Q+uU+IEsvyZKaA==
X-CSE-MsgGUID: SF0ILEMARaKUOtik9JjlEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="81975046"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="81975046"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:11:35 -0700
X-CSE-ConnectionGUID: 7e5sP7wISn6wthXldq4j8Q==
X-CSE-MsgGUID: P7NBgoiESFeBKK0b9V/v5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248730861"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:11:30 -0700
Date: Tue, 23 Jun 2026 23:11:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ajrob9r6cVtxqv72@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
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
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
> Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> Add a helper that strips that bit without turning an all_bt only mask into
> a kernel_sys_info fallback.

You also want a getter with check

bool sysinfo_is_all_bt_enabled(...,  *si_mask)

where *si_mask is the result of READ_ONCE() that you keep as implementation
detail inside this helper.

-- 
With Best Regards,
Andy Shevchenko



