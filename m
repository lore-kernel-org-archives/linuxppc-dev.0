Return-Path: <linuxppc-dev+bounces-20206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5DFFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 03:57:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4RTj2YVXz2ynv;
	Tue, 28 Apr 2026 13:57:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777348649;
	cv=none; b=JAvILUYP99R95a7vshieUfBBUfK0QdqlemICSKdKwiLhLDcclw0BPS2X4dyAtEjy2JMPNdlSGCOk7APwFdvyUcmbQ2SGDkcoRSvFpOzXbJQ8MjdqecfuDDxfiM34AxeYafl99VOM+px/Giy8RcAgVZLUO1xvBj+TFbEHbQqlpMiHkhO1ZThWOCicFvGbS2PKBQ5vEupuY/PZmiouVlw4RMzOIOXosWUSVAO5gEHn7ayspepenNKPHmDp0tPehclp391zCUGgDTZw7ifDaUQkVqPt8OjRHP7M7kwdLeM0EdBjab8AJcjomFLjGGjcFGon1BydVMBHgvsgwvvkt6mhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777348649; c=relaxed/relaxed;
	bh=HihunxX0kG7LRmd3HrgFHUgeqCV95GWNLs7fwLAUqXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sdox/gnSwC80y1qwgXUdQmSOdGEI0+uAHofOAneZ6D3n+FMqqw9PMSRV94ck2DocZU4GUvDlFtt+cjE0ABy7KGTCJDM765/lrNg1uhfpemggHA2eCI/VupK5CB6b4btDW23Clrvw6oVAOpLfXTsybCx5b2DXi5TtNmuhgnOmyJSwBGW6AydBnQqGSh7uEm+QRJB4nBrlxEoro4xQ8AMf3AFK5Ajh6z8OLpJF3rC+xBke+WP5kVUfEsgxBmpjUGnTXe7+prgKUZIhi1VDFXL5XRRnPoIHzwI9Z9fZFXm2M5hUZ6FXVYEKPPVZoLw4WBlb2Bd83dcfDFeYsAUCbf5Qmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Am41BdSk; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Am41BdSk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=yilun.xu@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Tue, 28 Apr 2026 13:57:25 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4RTd5js7z2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 13:57:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777348646; x=1808884646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xqcaIUX8QLlEguWmxNfjx0KBxYjMkol7RCbc5o2EAsU=;
  b=Am41BdSkAsBi9XgR3cB6roiu70Qv3uaS3KAWwgAjig0lEyWLZ0BsC5h+
   OeZX5xZsjQ15djdbg/LfcJ0+t7pGmQUSDisCRGzrzekL7cAkaNd0tQB/q
   C1MeoLVefeSq/9WwuAW1zC6peiSUlO9KvoRIZtsituJAtJThfD5dJQubZ
   uZZzBh5UVZH85VriZhEScjlV7JhA/0DEHB1pROUxuDXXIDEWfp8xftSPn
   IZCTAC6UZfHedNogoFcMJJ2LaZ9gxk0HtSmAbenE0t7+fbYHMkyRkkM75
   C1XGxXBfpCAUNm08fU9xjwIVFCzG1dHVTh2k1ntfjx6bEP93Gs+as7SHQ
   w==;
X-CSE-ConnectionGUID: l82f+fheTcaHbBcrXtSDvQ==
X-CSE-MsgGUID: BU8yGH3SRIa8GkGKw8oYlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88847369"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="88847369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 20:56:14 -0700
X-CSE-ConnectionGUID: 3nKhigtTTJGCsyK/LoClIg==
X-CSE-MsgGUID: CQbrqSW3RcGMpUchpv+whg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229469506"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 27 Apr 2026 20:56:08 -0700
Date: Tue, 28 Apr 2026 11:33:37 +0800
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
Message-ID: <afAqkfe8iOU1cUyQ@yilunxu-OptiPlex-7050>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
 <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
 <acLaDFuCzt0d33Q_@yury>
 <acON/EU/GFvxRO1e@yilunxu-OptiPlex-7050>
 <afAh1hq_mkRN3q2t@yury>
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
In-Reply-To: <afAh1hq_mkRN3q2t@yury>

On Mon, Apr 27, 2026 at 10:56:22PM -0400, Yury Norov wrote:
> On Wed, Mar 25, 2026 at 03:25:48PM +0800, Xu Yilun wrote:
> > On Tue, Mar 24, 2026 at 02:38:04PM -0400, Yury Norov wrote:
> > > On Tue, Mar 24, 2026 at 05:15:33PM +0800, Xu Yilun wrote:
> > > > On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> > > > > Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> > > > > 
> > > > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > > > > Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > > > ---
> > > > >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > index 10f678b9ed36..ae364c6636eb 100644
> > > > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > @@ -10,6 +10,7 @@
> > > > >  #include <linux/firmware.h>
> > > > >  #include <linux/mfd/intel-m10-bmc.h>
> > > > >  #include <linux/mod_devicetable.h>
> > > > > +#include <linux/mm.h>
> > > > 
> > > > Why add this header file?
> > > 
> > > When I was preparing the series, I had build issues without this. But
> > > now I checked it against -rc5, and it's clean. Would you like me to
> > > resend?
> > 
> > No need. Given that I'll pick this patch alone to fpga for-next with the
> > fix.
> > 
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> 
> Hi Xu,
> 
> This patch is still not applied. This is the last non-lib user of

I see it is already in v7.1-rc1, what's your expectation?

> the bitmap_print_to_pagebuf(), and it blocks me from removing the
> function.
> 
> Are you still going to pick it yourself? I can move the patch with
> bitmap-for-next if you prefer.
> 
> Thanks,
> Yury

