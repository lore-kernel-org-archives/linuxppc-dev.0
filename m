Return-Path: <linuxppc-dev+bounces-17237-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BF9FC590A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 08:00:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM3mY017Hz2yFc;
	Thu, 26 Feb 2026 19:00:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772092844;
	cv=none; b=Tjgx6/eoWy3Y1Is2QacOz9PSneN6pqLrwxhhSjC9a6xDIvcAHyhkURd/J1ldKbbjCUUxp89BRUhqwPqQRyy/m3iq2z0rSeCDzS3C1wDYBMuT8IvMy4ltC5+sPYYaiCzVJQFhw5WIfHjNS0V1HvCt90gB2abWbSKum4R/VSvJZ09XbsMUDKXfuF6njDRHPO1ZvEwcYbSbj0xQR4uZ2uRyrxxlhI+DIjNRCAizHM0RsL9btX9AHFZ46CIa7r43PCyB45R5HGE5DoTFD6YpnrYfQbVZk2VWTkux95gkdyli2pSLWGNVuVLTrFuSHQQNTsjbZMLXpSEduyEV9cobzw7qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772092844; c=relaxed/relaxed;
	bh=45JsBOPCFZIuEnMHMmIEK6FxJ6Vmoi6JWlGzfgTlKd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+6HLaDcOq/4z2ERUp2NlViQLua1vng6e+JjnP2xEYss8+Xd8qJYyTK1i01MfQsboQUqpNQdxuoSuetSwC4Z7GMSr5YRsbW1IwIPL++6sa0sE8lVNdJBS632fHR4PEqke7/mojxEOjzgXu1CaVlHJ7RqKuTJDZzGwWJn5Pp6fKcl/xxbrt/3XfpZO+cGtFHgEOl8PSZtM3KWMNYLrcPh+oHDtzzJo/Gy/lsLVfv3wr+FAjEbBPIgY3wiZY3V4Rg97kaWB8eo5Y/chDGP3cozT1R0Q3zwGaX/7ZoReyqQxTLyyOaDp3U8QBYcjRl/M2ZqGqghJWnBrtJ88iImMUBPlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJSyJR2d; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJSyJR2d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Thu, 26 Feb 2026 19:00:41 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM3mT23M7z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 19:00:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772092842; x=1803628842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rs0qEAZbdxZqApzkbG0FHEalQVhLZ+XgQWmJpEIvOnc=;
  b=eJSyJR2dHtUdxrPzJnvzlm5lh/CfkM36HpwvK3l30h0dY7MwnPLP3839
   JqS6Ifd72MNddL+8asfxAbdjhxhq+/nuFwlGG7MvCEadQGwsIgvjI3Kct
   5r4qobZ/OyVEIf62ri/PjnPh5uIbAdG084UyVHlvTwxubq8f2HaAulD4t
   Ysk0PP1it1X5BvGQ9y4R76N8lTb5mPJxpaBn216xNrUbAH8+gN0WbQo9j
   jv2FIvs473vsXrs245UCKNkqDHbBniASBgMb9fg8E4Owd6xUpxlkeQF5r
   H2znahtm5sMVXYVC0EBcvFATPsjZ2jP4InIDs9gMAxQdZlccGxf0Stwh4
   A==;
X-CSE-ConnectionGUID: ABt9kXeeRWi/ux3/ZACkyA==
X-CSE-MsgGUID: vRH+UZtnRpWjYGHCKx3P7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73018068"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73018068"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:59:30 -0800
X-CSE-ConnectionGUID: HXHY4jaTS763fk0dqYE34Q==
X-CSE-MsgGUID: n89NMNHmQ2uMu7evv5CMDQ==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 25 Feb 2026 23:59:20 -0800
Date: Thu, 26 Feb 2026 15:39:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Antoine Tenart <atenart@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Yury Norov <yury.norov@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
	hariprasad <hkelam@marvell.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 09/12] fpga: m10bmc-sec: switch show_canceled_csk() to
 using scnprintf()
Message-ID: <aZ/4whL40HHi/85Z@yilunxu-OptiPlex-7050>
References: <20260219181407.290201-1-ynorov@nvidia.com>
 <20260219181407.290201-10-ynorov@nvidia.com>
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
In-Reply-To: <20260219181407.290201-10-ynorov@nvidia.com>

On Thu, Feb 19, 2026 at 01:14:01PM -0500, Yury Norov wrote:
> Switch show_canceled_csk() to use a more common scnprintf("%*pbl").
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 10f678b9ed36..5ae76b8ece18 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
>  
>  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
>  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> +	return scnprintf(buf, rest_of_page(buf), "%*pbl\n", CSK_BIT_LEN, csk_map);

As Thomas mentioned, use sysfs_emit()

>  }
>  
>  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> -- 
> 2.43.0
> 
> 

