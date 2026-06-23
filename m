Return-Path: <linuxppc-dev+bounces-22948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07361CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 20:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glGWr6fvwz2yQG;
	Wed, 24 Jun 2026 06:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782245704;
	cv=none; b=k4iF5J59+PXdbYYe7kNOjLafmGpdUF7wlcevq3NSoL0dG+DuFTgtlJUtOAlCQRDQyCLCbO+IjRUGU7IfdvMh25okeDgGb2cJ7AB5Q0Mmg5ORoBoZ9ko4ofepA0Q+g1o8R96F1cRSD5TCKvG2fXE2Gmh4E7F0rxHqrG225DkFBFjBSEQN/4jOb58dJFZLoaGtExfd2uU813FKE1t3xWTofZrI+p2dGrCAXl0eNNho4ADiR6tU0per5y5XT5c4lRTdCUaSNbobceMY98Ux5qx3jRPvX9ZshYP36Q/sSYaLpaiMbToa+3DtcCrZk1g3Sy6o2cYFV0TfSCZwexHxHBn6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782245704; c=relaxed/relaxed;
	bh=aexq7zUpO2IP64lpxZZ10UKnO2OdeCCURMpe3ph4GC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moYeAu1EN85bHMXxWses4QdE9KD1mBVTLVgTPIQqlDNB32I3NzbwEm2tCRzWhjlM+7PuIB6asnsiXSOFKcUDuFfbJEgFUw8jzR/Tvr94y42X2DDhB3IHxEuJ3VaRejwXSnB6VJTBPoYx2NyypvJ8ki27AKyYyzDv+lUVh6TWGr/tAhby+AjAOKUG5O5gzpzHoJ8rXFMwqbrfQG8CP5g1Hlkf+eBZ9f1V689q8qmdQOCAGRxELz4DOxYeCKz3A5ReM1eIQCX4h0IR8NaIAwQyMd4eqMxF2BFybobh7jsgx4JHUPwI1qH9sq0hyQYMzOtl3QZNmmbPtrjLfyLD1qgCbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FiUo6EN6; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FiUo6EN6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glGWq0vbYz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 06:15:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782245703; x=1813781703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JhveSp07tSCHgDphz8hRbsEB38K+EDMblTYhxwKyh20=;
  b=FiUo6EN6UO82tmgngOqUxbINGPvPV+/hHTO+o/X9pFv+D6KPFiHjjmEd
   Wf5O+A0cOBL85i9xTzxvPwM6LI7+/csm7CbFCH70d4wa+38+MMkJ9TndW
   7G1sDTdyYcR6e1nRndW8ChWF4oKtRX4W+a5hosbiCLweckTngNx4hxiAc
   1tyRiZ9yYtuQs6P6lIg0VTxFHXqDPlSl24bmFCOienaWQoVmKLQI9whSb
   4PkzSqhhJ1SKGQiiAc6s2s56auky3kQBgeXRpZc+xyB2qCZQYu2aqncCD
   kHSLlgCu2N9QxqTHhzyyDU7slDE0xnVfXyRUREGLsig/HNw1zkX1quDwv
   g==;
X-CSE-ConnectionGUID: DtmRi6QuTcmMea+WCH/3bw==
X-CSE-MsgGUID: rUbTGMUoQRqHA/vxeBy7Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100550539"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100550539"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:14:59 -0700
X-CSE-ConnectionGUID: EP95sZZnQAedd38PegXbmg==
X-CSE-MsgGUID: hN6IdZ0QRASEMOsiYztC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249726881"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:14:55 -0700
Date: Tue, 23 Jun 2026 23:14:52 +0300
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
Message-ID: <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <ajrob9r6cVtxqv72@ashevche-desk.local>
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
In-Reply-To: <ajrob9r6cVtxqv72@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 11:11:34PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
> > Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> > Add a helper that strips that bit without turning an all_bt only mask into
> > a kernel_sys_info fallback.
> 
> You also want a getter with check
> 
> bool sysinfo_is_all_bt_enabled(...,  *si_mask)
> 
> where *si_mask is the result of READ_ONCE() that you keep as implementation
> detail inside this helper.

Ah, sorry, I have thought that the mask is part of sysinfo implementation.
Disregard my above comment, it can't be done without also supplying the pointer
to the original one, which makes no sense.

-- 
With Best Regards,
Andy Shevchenko



