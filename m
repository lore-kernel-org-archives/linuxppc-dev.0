Return-Path: <linuxppc-dev+bounces-18713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3516EE9A74D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 09:36:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg4gD2BQhz2yr7;
	Tue, 24 Mar 2026 20:36:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774345000;
	cv=none; b=LYuxAQvZXN5KATO23MEINHDlD5wOIlH/7JR9mI1122UXwBIylXkpxiFdk9HgxiQVKmWcC3Gzzvni2iVzkvbW//hE6pv4ZFxPMy24ZN/OFGOloIoFci4swB6eW9A/UbKiXbGOwGtmZ9KVidWK/ruk45z8zO20/8ywevfDzYSY/pu7vJ5KLELy60v1lA1I+4ICQv2HAwmtYiYxqmOJ4vIiR0178jxWzZvqTnUctyq3bJlyu4h7X8gLJ2j2pFGBZ89culJEgSFc1eaBEOZOaw6asJaAYiPd4/jdgJFSureUkZyPk4qowrtpaQf9rMOZCL+lnmli1p23TjYj2g3kBqsdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774345000; c=relaxed/relaxed;
	bh=Fz+pLbhFp0S4qTFWWddsgDGaQpvX0q+4gZ+/3kcTYd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR+jS7hf5ECUujowXv987S55wF6avKi0hkQITNcKmaGLKQ7SbBr51qCRMoyXPoqecS/qx9jT3oAWfzVRQYXt0OtMkqFPPVNs972+HX4Rr6y+5MVTBK6P/ISdPPtoQ8vCHTdsY6md9Nh8l+vprq+qRWxz951gdFmI+g3cU1AWmBVmpneEmauQor/xQrVlMoOETRBt+vjN7ljV1GxpO8HkgtrjWo/NHp/st3yTvdi4lmjD3GISjfY4Ee8Mv3Yv3G7/D5FcwmsHGGoA58J5Y/Cq29H1BCxyA5otkFj0/j8Pw2KM6yHrlW/ur9Hk9/MCq/nHeBJ0WH8wLwyaoRej/QyRSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UQAB8Bnz; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UQAB8Bnz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg4gB0S1Nz2yqc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 20:36:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774344998; x=1805880998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cl9Jn50dUXWt3BrXPsUSkT+go0J8MdRhtpKlgBhriss=;
  b=UQAB8Bnznny6EZBnIofXgQEx1nCwzRx7/SnDcrKX8KTzXFea98eTANMQ
   Du4sUtsQDxQYMLfLlqLpgZzokH2Cf4/cIMJ3n+CNfjbyofDxrj/bWTkgR
   1XyBOkl7/OFip9LXKWtxQbHvtcKU2ATnTfXRyBZiGPkeomnkPaHhAxJ+H
   eVtKMO6b3YHz+c7x1cmRq1Ek2PFE5R5fJeiHFPA123CByo/Y7DW96f2E6
   qhhwAGwQn2TdXTzLYy4CVP1HtKp5DFZak3cw04H1NiZuiBmrxDdK50IqJ
   8YvvFDtKXI7CzLDxrKGq2wL0tPlTrsmbu5YlUm6ignne/JJkpmLvszGoH
   A==;
X-CSE-ConnectionGUID: Z5/FfsaOQUOUTD1JdbETlQ==
X-CSE-MsgGUID: IQ83pXEBQXK/VqBnEbsswg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86725138"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86725138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:36:29 -0700
X-CSE-ConnectionGUID: DmWR8uXHRDSrXII1rchdOA==
X-CSE-MsgGUID: CPrU1x//RC2oHAiWQSJ1zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="229228806"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 24 Mar 2026 02:36:21 -0700
Date: Tue, 24 Mar 2026 17:15:33 +0800
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
Message-ID: <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
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
In-Reply-To: <20260303200842.124996-6-ynorov@nvidia.com>

On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> 
> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 10f678b9ed36..ae364c6636eb 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mm.h>

Why add this header file?

Thanks,
Yilun

>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
>  
>  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
>  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> +	return sysfs_emit(buf, "%*pbl\n", CSK_BIT_LEN, csk_map);
>  }
>  
>  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> -- 
> 2.43.0
> 
> 

