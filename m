Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA1DC67861
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2024 15:07:13 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YN1jK3ZT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VB1zz5cXqz3vZ3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2024 02:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YN1jK3ZT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VB1zB65vxz3d39
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2024 02:06:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712329591; x=1743865591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qlwdvOusJure/L1Yv/zKMo5qRCUbM8BhZMF14KYnllA=;
  b=YN1jK3ZTGFdc7DKgJxCGy4LviAMEIvXMluJbed3zoygbpWMPWvpSj2oo
   fgYVaRGm+QejcSsadRN7fwfLMuRNxcrrZUdHPibuuEj8akHO8w5cWLoO6
   4pEfcD4mQCJqApDmECpvdVe/ZVrxR5EKqaPBVZjvFt/kS8GeU6JrbqJxn
   x4tdkIpMpRKxvTVXPdt+B/y4z7/zDP0CuiwkH6FHG9Q//4749BYf8UOJj
   +sqvhg08swABmdof4S2zQL+U0lFNNlDcnqksCeSolRpM0kPtneH+2iXDK
   FX+sX7mcYdMPo2Q3LZlPmH7GeorH2F3e/7Lt9XOAgxilkPOeOZOfx9zVO
   Q==;
X-CSE-ConnectionGUID: AW9771seTgKGxVVcJnQ9Bg==
X-CSE-MsgGUID: 6cPSdNeXSHW1uqGCDJgmNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18271644"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18271644"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915256454"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915256454"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:06:23 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsl92-00000001mBS-3ubw;
	Fri, 05 Apr 2024 18:06:20 +0300
Date: Fri, 5 Apr 2024 18:06:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
Message-ID: <ZhATbD18BhW9vnI8@smile.fi.intel.com>
References: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
 <Zg0yTnTswS2je9VG@smile.fi.intel.com>
 <871q7k8ytc.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q7k8ytc.fsf@mail.lhotse>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 05, 2024 at 10:58:55AM +1100, Michael Ellerman wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Wed, Mar 13, 2024 at 03:56:45PM +0200, Andy Shevchenko wrote:
> >> of_gpio.h is deprecated and subject to remove.
> >> The driver doesn't use it directly, replace it
> >> with what is really being used.
> >
> > Any comments on this?
> 
> No comment :)
> 
> I'll take it for 6.10, or do you want me to sneak it in as a fix for 6.9?

Up to you and thank you!

-- 
With Best Regards,
Andy Shevchenko


