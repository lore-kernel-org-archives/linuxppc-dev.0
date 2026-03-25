Return-Path: <linuxppc-dev+bounces-18762-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A65FEA82F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 07:46:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgfB85RTKz2xMQ;
	Wed, 25 Mar 2026 18:46:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774424816;
	cv=none; b=G8r8tcKTMqe8fHUkyFVS04ZTSeZY34eL4MIyqQ5VFlE5Cprmp/FwQUEe1I30oqFAJTraHXKyU79jq+70lYX2ARgD3fFaxlZZ5sJoOd61A7w3IwqNYswtDXmpgYr8NlFkZ54/ZJU/HLLAyMz2mvlIkjo+YBHHc5SnOyLCJhEKm0jdAbC90SdGL6Kb9gEN53gVjfZrSTbXHQCWaiLAoNWbxprQT25Set8VLoEcuTdXjMIlz4ucoQ3A37yX8UAMhflSN2vwwISuGnCUskd7RSOZBqHfdhAIHKHLSMfBWllPVOxHepbo7Jf17V3e6DK1mQNesNJ/eQ4fFr0uYs6outT/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774424816; c=relaxed/relaxed;
	bh=Ldiyv8rNKG7bmOlB8uMzLrCK/6xi87IA/bu3T+K4rJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+RWTeGS8mMbXlmUfXdFJCH3KGjIFHrY/1hXKOgJmRW5eBRFPyYREFIP78pXGjtmqgdPGEqXqJNLEmD8aMkwxkcsLannoht/aAlfi0zKMODV54DIf6w6tIV2DKz/Hqx7IsiJjgUm4c6FOaB+fuzDAL0Lgscb/XJNeorL4USR4/fhANDiHPh6k6zY6+n/RO6/9dKYfoFKyGfVZlu7OsqRB7Fgwkq3Wjg7P9ZGlaQidBJg1SQR+kGmioYKZCE9Qnv2T5Q/Wczlz3sHNS6Kb5zUxQ4IkaF5ln6zAyyP8xIh0FHANAa+fKcOoanxFD1HO6Igy60YfrbNIQriNZWk8excDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNKNrMCv; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNKNrMCv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgfB51831z2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 18:46:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774424813; x=1805960813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4QhcKUHKk5f8eHU20gHK+CrNvm5trqyhWVTA3ToVauo=;
  b=CNKNrMCvbkJOe7zJBHHClxVIBzLSX+XjT2b9HSVQppkWyRHL6ReO3ILs
   vHfRF7lSTo4N5oqLtqCR7WHodhFCL22GqXa8IFkNsm3moqsUF/QAnONf4
   F9O/mVmX8sVfYqWm3WmzMpuG8pjhYMi/cnTgEUO6JOekvgHVaOc505CtW
   qx4HqVPDPw5A0H/qtn2BrZtWRxGDIyAd1C9f3pO1RJzsop8KiR0xOVdlv
   UA/iOV3B28J/LSLjIyWGKVQciDxaiOtz1m+CLqjTr8a45SVtUrcNyt7t7
   ISaxmsU1WGmiJ1Rv0aKROzFz2hoi0nIVIaQNTUn+6Dqixs1u1H8yya4p0
   A==;
X-CSE-ConnectionGUID: yKSkD1AHT2ywapxf/eQsDg==
X-CSE-MsgGUID: oj8gZlHJTzuZhcANQgPrwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75172562"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75172562"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:46:46 -0700
X-CSE-ConnectionGUID: G5PNN/E4QiyOvAoi05CTsA==
X-CSE-MsgGUID: sOq0GGDtRp+QhOXKg1GRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="229378652"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2026 00:46:40 -0700
Date: Wed, 25 Mar 2026 15:25:48 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>, Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5/5] fpga: m10bmc-sec: switch show_canceled_csk() to
 using sysfs_emit()
Message-ID: <acON/EU/GFvxRO1e@yilunxu-OptiPlex-7050>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
 <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
 <acLaDFuCzt0d33Q_@yury>
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
In-Reply-To: <acLaDFuCzt0d33Q_@yury>

On Tue, Mar 24, 2026 at 02:38:04PM -0400, Yury Norov wrote:
> On Tue, Mar 24, 2026 at 05:15:33PM +0800, Xu Yilun wrote:
> > On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> > > Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> > > 
> > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > > Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > ---
> > >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > index 10f678b9ed36..ae364c6636eb 100644
> > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/firmware.h>
> > >  #include <linux/mfd/intel-m10-bmc.h>
> > >  #include <linux/mod_devicetable.h>
> > > +#include <linux/mm.h>
> > 
> > Why add this header file?
> 
> When I was preparing the series, I had build issues without this. But
> now I checked it against -rc5, and it's clean. Would you like me to
> resend?

No need. Given that I'll pick this patch alone to fpga for-next with the
fix.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> 
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > > @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
> > >  
> > >  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
> > >  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> > > -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> > > +	return sysfs_emit(buf, "%*pbl\n", CSK_BIT_LEN, csk_map);
> > >  }
> > >  
> > >  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> > > -- 
> > > 2.43.0
> > > 
> > > 

