Return-Path: <linuxppc-dev+bounces-27785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3A9C982CC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 13:57:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hn9zG1ZT6z2xSg;
	Sat, 19 Sep 2026 23:57:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789826234;
	cv=none; b=bWPczxH7Hz4QAhmomFslmhd1EKlSPSDZtjog7Vaw3nr2imXytxRbBtJKlCJaTtjxxhPducbuDmKHgOyyTcLPzcyRE4lnKGypfgaw8OjfJUVFPfoEarTLO0Qid7lgqV53khzv7jSPN92r6AqSi8DMtk1I9aGzr39yNcGs8G/Ely31hR7sP0V8vRZpLQUT64RHshaX2qMds2iRKtcXPzvJrsj2FCKT4Ci/EUQekpeN9Q+YczUi+W0yj7kVxp2UXzK5igDXhFEhvt0Sfqo6iYt2zQ3F9+ZhozCPAFofatzZDSv1BlJkiJACoYfZmNgOD54xhRPR1J/Bd1nifoMfbyVq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789826234; c=relaxed/relaxed;
	bh=YRhAGyzUZRi1jjBO2+0a2vqLcqSoZqNGW/ZSVMMVt0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwaI3iYzf4vzgCzCVUohQGme0UjytitH42HfkUIjYAz7JgHnHKW0TAtQyCKhIoJvDzvOYJKaWwfCGbDop1+bDMf3N382J2TyAYRaeFm4VMrbN6kkyAmTil7FEHZNKBjF3yDo8jRlcNxNAFXdPnRQTHT3Z7QoW2CQHXC/SdHMntL7RRa+u8e6z65JD/Zsf/aNEEVmakn0U43PueqTtM2L5GRXt7e61UrMNQyfu8i73nsd6BzFHovPDOKDXvx0Tujy2L+VBCpvNcBiAqSV4QWIJtdb2u6RZSz357Id3u0Hlyft3JWvjEOzpCcoqLebe2QApZP3cSgHR9jnsWDIimitcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHLywtwa; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHLywtwa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hn9zC3PgQz2xST
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 23:57:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789826232; x=1821362232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNAAz2y1hQI1jpd/UD1AKmVlqfxjbi/3Ibab7fxF58U=;
  b=eHLywtwaFA0yURDow3/aPw5ekKP9Kogoht+/3kdPBJa820HVxXHiL9LG
   nZsIPbMD1YjNCA4QE1A+8IRUPyIz3OieGfjgznQBigXtNv6jMkT6Exrjn
   pr5kJk/bPJH9Uh7AQ8k/KpF2j5ZVt/HG6LeoN6HUnzn5CQXZt5bGKztDC
   gTrcll89abhg7Agh192cBxUg/nksUG41UCCnzvS/7u6dOii+KXKvUr6ge
   ctK+xREfwCIgboUzGfbpIFIla3XPGokd0PeHSWT94/9jJwKaABv/EeIku
   q1wBDq9gveiKutqHfCkjqVF6MyMqWpAoApprdp1f53tXGKxmC4p4cMea4
   A==;
X-CSE-ConnectionGUID: cEl3hvzzTaaMU+uo0gMKTQ==
X-CSE-MsgGUID: ari7Z42jT+mKaXN28BRDsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="92856444"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="92856444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 06:57:07 -0700
X-CSE-ConnectionGUID: sOAvjBjpTLqXtcDgmqC3/Q==
X-CSE-MsgGUID: iJhVdkZTRsGRyU1tFZqjug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="276781262"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.50])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 06:56:55 -0700
Date: Sat, 19 Sep 2026 16:56:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 7/7] dmaengine: Remove deprecated
 dma_request_slave_channel()
Message-ID: <aq6UpdBvXV6qnj3G@ashevche-desk.local>
References: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
 <20260918113727.1898998-8-andriy.shevchenko@linux.intel.com>
 <aq17qvmxF6nwclkR@parshuram>
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
In-Reply-To: <aq17qvmxF6nwclkR@parshuram>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 11:28:02PM +0530, Vinod Koul wrote:
> On 18-09-26, 13:34, Andy Shevchenko wrote:
> > No more users.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I thought I had acked earlier one. Here is it again

This is strange. I used `b4 am` to collect tags, most likely it was an old
version (before you sent that email). I will anyway issue a v3 and I double
check that all new tags are added.

> Acked-by: Vinod Koul <vkoul@kernel.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



