Return-Path: <linuxppc-dev+bounces-23640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41E1C43602
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 15:50:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv835736gz3bby;
	Tue, 07 Jul 2026 01:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783353057;
	cv=none; b=avR9pzdw2nYb5+MrFqLIaQkDvQMCVww2hSROLZvyFRMDB/giJOIlcM0Nvz0NlpCx3x+QOsaFk3MzTv04eV8qz6a0TdJiTQ8LR/EzlicDBA6HS9n0kyuK7ek0KnqPOO/GIJeDH3eCX9+v2A4J+F3mbb+9Qg/tP4lpCrr/oCQsA4RrAUwkgdqmkaosyPDhzU2k8wRH55OXVM19UjTO03acGWRe0ooBc0pweiYnNRna2TKIKPxjPpIqy6zVZB1vMHYDOCCCJ0uJzCWv58/f6RgzqvxssrCapwdPEVlO2ZF+UL6mWJVkgcx8qUttMq1oWkvat3zzRplY2Gyrxu3IYEosbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783353057; c=relaxed/relaxed;
	bh=SH7QsUXzWQhVc/gsbztQ+L5dR82PdPpik3gv5uuonZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqKSB8/zArKwnudLHwmt6uDEwtLk+Za8xgagqSguK3syZBWH4KJRO5n3tIwhs2myXeTn/yXM41Fyqu8x20FVwx7HDwWF8P7xfP+OcHG1ySudeppYqLWhpMI+IjKmLR2PGe5dciVlzbWSzvus6stTTEW6KP6ajmAadMSXbRROiLeYZq0Qaegen4zxHwuGCPG1z5zias3Z5JWW5AEyPvvnZhyV9UGUF83c4XydvKquX/2e/ncncqZ/FN143qN4nawY7i2al7d8g8QssymhC9t8mxXD0MoWkCyI+cyzvydcJci5B4If/1xMP5ST6zHH8ZlMeTCYO3/kW6C7KvKuvOXFqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hP3UGnaO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hP3UGnaO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv8316nr5z2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 01:50:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783353055; x=1814889055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=of6d9n1ZVp2VvNBWbeQxrIvJaxz8Dqo4F/lZHKvIDzs=;
  b=hP3UGnaOwDaXrkKikQz5v+ASr2ZW6cbSPmX1XhtMpfaXVUSxnjvonFmd
   +1UMTPmPW83nqlMEG12CzL9xt+fkSPca9bn7mBn0pKcIPaSdNpInSJzB5
   p9BnueBp7C58xDkMzxUgy81oSSF7ajya8oKz1VAp5hZuafUJUNR/2WH7Z
   tXr1uemQzgCPY+EcjNMu62rICgaY3pWEBLGXVe2Ak3d7nUQmlvpwdoqhj
   M1gQMVKmOHh56cdqw0MzHja52H06ljJVJoKZmedNKMaXmgXpKAns06Jl7
   L7quVXFOoDHCjekxLwLyQE/IYl/Cpj1iW1UQjqyjvNMSKeQCsfSO95rab
   A==;
X-CSE-ConnectionGUID: Zj7VUQoySRWLaR1GPI4Z1w==
X-CSE-MsgGUID: iC8E1jMpQc+TGFIAMi3vRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="101408867"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="101408867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 08:50:32 -0700
X-CSE-ConnectionGUID: NvB5N+KWQv+u1kUJ01a6bg==
X-CSE-MsgGUID: ST8IrUj4Qs29+PTwG4IXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="283836189"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 08:50:18 -0700
Date: Mon, 6 Jul 2026 18:49:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manuel Ebner <manuelebner@mailbox.org>, Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
Message-ID: <akvOo2EeERLYPh72@ashevche-desk.local>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
 <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
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
In-Reply-To: <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 04:39:00PM +0200, Manuel Ebner wrote:
> On Mon, 2026-07-06 at 14:44 +0200, Bartosz Golaszewski wrote:

> I removed Mark Brown <broonie@opensource.wolfsonmicro.com> from recipients because:
> “RCPT TO <broonie@opensource.wolfsonmicro.com> failed:
> <broonie@opensource.wolfsonmicro.com>: Recipient address rejected: Domain not found”.

Perhaps he needs to send a patch to update .mailmap?
Cc'ed to Mark.

-- 
With Best Regards,
Andy Shevchenko



