Return-Path: <linuxppc-dev+bounces-20000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798DBF9934D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:53:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1Syh11vsz2xls;
	Thu, 23 Apr 2026 17:53:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776930828;
	cv=none; b=BvfFpNWE+2Qpt/M5FPAostFXZI7noewPux8+FEI/IO04+G93NqAiSivzvaGNn5MqttqrJczw6TOYtigYk/4dCzK9QjC5QbGXu48hzS+uCBbWv6dmZ0gjwzPlDcKk8Uhx/D5hXnqKuxNj475e4ws4UGRwv19ChrT7qkU7pTOCyA4oF3IU6MJIMCJ6faHh5H/hD0RgR7VU/00JJAc8nYo5GHcG4cy+KrABI3Cx+olkBurjv9RSbzZduJBLJMtLB+tM2ipEZ4QBcEnxJ1BKkPsUH91dnmsYlCMgzy/Go9lR2Dm0FynrWCQBl2cQyGl8h4iUH4YhdWu54WoXF3pDydYqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776930828; c=relaxed/relaxed;
	bh=A4osVC4A+5EYosBFlh/i9w3U6Ib9WXcZN3B8nWvqopI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHH9whMeuhJvWyLR+nfbJpb6bFBYfEoH+OkjtNKhdeGnBfYU6ZQJsjhWdUM5PRhS7FMhJLQEzasfTwK5EgNp77GlECmj2inUXD0/dSNMCWnhzKCnyILKYcwnyLbTvnplSCANU2XNKTzCsXX14ydV6IMwAX07JrgesgcKx6V4gOmvKqizhr0QW+xmsjnQvCFIwV70xbwosXjy4Xmy+3ytQN6Se4E8RdOylFDC0wWWJENAfZLjtx47KIICTNWtX1wPX6jWYMHCK5OzJiG0kebY6/Y3ZkdHND6JI1RuLLFx7phwcBEcm2DhXRZNxhCMt5WFeAXsbEKjmNLydBVwT6GWbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cl2Kz1tO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cl2Kz1tO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1Syf4N6jz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:53:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930827; x=1808466827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4Q3alcc3k9cVvnJzyMRTqGyURqykgMXdDEUAJ0yJG/0=;
  b=Cl2Kz1tOzvM1PV8KACYaMxb4Ko8EcDygacFbvCvzzY8STo/g5GB5CqVX
   eN1l9zlt0W8MHqZiw1Y0QG3PrzRmGJBMf2NqaHzJH5/o+ttTTDONFGIXY
   7/gCCjDL4U+49DrZYlVXYVxYNDkpKqWPcalMD3Hi7XM8Mv218lFVvcPMi
   yyH6PxL0Ay/syel3b69oXq235mjz2RzDu69p5oxzIxiOMKxPbvAQDr7BE
   o97iqRDFC71yf4fqh49TO2F2qQFqK208UT+GY13hfzYK+DAzPeOxZAJUB
   xWy7uRF48qCKClJPysJoDWK0DHioPM4UOC+ghZc/lXoaGLhqaSyJSC5+P
   g==;
X-CSE-ConnectionGUID: xklthg1tRzCQlt9lp9EkUA==
X-CSE-MsgGUID: oFzzMAe2QuydAwuRkkLE2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77595774"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77595774"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:53:41 -0700
X-CSE-ConnectionGUID: oloRMtPmSCax/2pqcSRMMA==
X-CSE-MsgGUID: 6a5xSc8VTxmeZrNbkaejHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="236952191"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:53:31 -0700
Date: Thu, 23 Apr 2026 10:53:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	openwrt-devel <openwrt-devel@lists.openwrt.org>,
	Guy Ellis <guy@traverse.com.au>, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux@armlinux.org.uk, tsbogend@alpha.franken.de,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org,
	idosch@nvidia.com, jani.nikula@intel.com, mchehab+huawei@kernel.org,
	tytso@mit.edu, herbert@gondor.apana.org.au, geert@linux-m68k.org,
	ebiggers@kernel.org, johannes.berg@intel.com,
	jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
	fourier.thomas@gmail.com, rdunlap@infradead.org,
	akpm@linux-foundation.org, linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <aenP-TVgF-PrayEu@ashevche-desk.local>
References: <20260422041846.2035118-1-kuba@kernel.org>
 <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
 <68316F0B-2442-4492-A041-E57EFC58AC08@redfish-solutions.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68316F0B-2442-4492-A041-E57EFC58AC08@redfish-solutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 08:41:27PM -0600, Philip Prindeville wrote:
> > On Apr 22, 2026, at 7:05 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Tue, 2026-04-21 at 21:18 -0700, Jakub Kicinski wrote:

...

> >>    I'm still deleting the solos driver, chances are nobody uses it.
> >>    Easy enough to revert back in since core is still around.
> >>    The guiding principle is to keep USB modems and delete
> >>    the rest as USB ADSL2+ CPEs were most popular historically.
> > 
> > Still not entirely convinced; I worked on both USB ATM modems and on
> > Solos, and the Solos is both the most modern and the only one I still
> > actually have. And the only one we have native support for that could
> > ever do full 24Mb/s ADSL2+, I believe.
> > 
> > If we drop it, OpenWrt will need to drop support for these, which I
> > think were quite popular at the time; there were a few UK resellers:
> > https://openwrt.org/toh/traverse/geos1_1
> > 
> > I still don't actually care *enough* to try to find an ADSL line I
> > could plug one into for testing though... :)
> 
> I have 3 boards lying around if anyone wants them.

The problem as I understand it is in one's willing to maintain and
support that driver while doing regular testing...

-- 
With Best Regards,
Andy Shevchenko



