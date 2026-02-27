Return-Path: <linuxppc-dev+bounces-17371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC55FD530D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:55:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMhwt686hz2xLv;
	Fri, 27 Feb 2026 19:55:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772182510;
	cv=none; b=jJS0avdlBXmFLX2z5a1JLDsb3UzTjDJwp4R+xKf9IenMebURoI7itIgLhfV4/oac3sF3odhSnbgk5M02MHgMSy3GJdkXqOeAX1hZPToVrOXHbsuC2JwuCFRTGeRGzRwPrkTGJuM22I/zZ0VRPNOhLyNZb033TeSkkI/iVGKtgnFPg4wUnSJilZtsCU1GA3NCyfsKk9jpRmZO9gv9MU4u7K3lLX6nO9Plo4AnECVGHHvslU1aMDGKlUaDW/TJ4MRh2IiWzqGb4tAKalSJB+TC4tjdcfMMBhENhaoItTQei1cf3G4CdsQB2osrWW0rpCBswP9ZxuxeNjNwpmCEvZywsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772182510; c=relaxed/relaxed;
	bh=zQBPoqGuy+Nk3Y+axMWMHgErBPv1pT4vgLvjPkfdeB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+sX6ZlhMIoqHNaU54gUoeUU9O9/aIL2w4Q24r3wkWRFC1b1kWCX2BRdI44ueoEXltC/F5+SLS2ESWO7eYjvhDpWClPes/mFB0i5R/D8hXVvf6pK1A/a2PVc9TNBDFqWKKFn4IP1FpZs0kSZowR4ryWEHux2fvcOzxNECIWXveXp3I/HzArDBYOFov73IjHv+e0c68g0Q7gXdBGjvyMN+zizB2FCknAVy8n7FgyPjah85Hh9EzL1Mt2Lpgo/F55pKHh/rTaDZok0IrIMsh070C5oLsK7shJDx4XDNeQHDOmqtHrA7N0EpJ1u+oRvBgRVfKYH66b5+s9caN4Er+rvmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=YiK3rVbv; dkim-atps=neutral; spf=pass (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=sang-engineering.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=YiK3rVbv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMhwp0fpFz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 19:55:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=zQBP
	oqGuy+Nk3Y+axMWMHgErBPv1pT4vgLvjPkfdeB8=; b=YiK3rVbvnQi5HCQx+CS8
	YBNCLH3j2e3tWPs3BGg10CYQGHxHKGNHXMa/1TPBdLEFDMgqW5h0gFf2h8CUROKX
	rbX2vx3nYJ6vVGVvsS/WdbSo2ys1bOesFZj1OD6XIH8eBy+Qr3ff7kgB8/ZtwYaB
	A6Jb7bFsW3BUULyobXH9XsGVBZms9oSRl4Bz75gPLgGaksueHlrfy2k+OLYEnVCy
	wxqTqsv39VUL1TvYAwhgqxjC5M8GdIHSKQOGfv+Wyw1LCFHmq1Ohua+F0MIVazYF
	fMnbgTwlMRR/HB1KU1SABkh4vmX/1MH0P/Az+PNRzgD+7j9EcTvFqVwAO/+6mVmE
	ew==
Received: (qmail 1407771 invoked from network); 27 Feb 2026 09:54:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Feb 2026 09:54:56 +0100
X-UD-Smtp-Session: l3s3148p1@7LYqZMpLnt0gAwDPXzF+ANZpdrMKUeLI
Date: Fri, 27 Feb 2026 09:54:56 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Khalil Blaiech <kblaiech@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
	linux-media@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aaFb4DW1yob1djDW@shikoro>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaCrT1SvMCIKQDmc@ninjato>
 <CAMRc=MfwR7TfAFXO4opu7a=v84MK9hY048woPg+-09wkGJgWFg@mail.gmail.com>
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
In-Reply-To: <CAMRc=MfwR7TfAFXO4opu7a=v84MK9hY048woPg+-09wkGJgWFg@mail.gmail.com>


> > I applied the series to for-current but squashed the user conversions
> > into patch 1. Changes are trivial enough and I don't want the pull
> > request to look excessive, so it can go in smoothly. Hope you are fine
> > with it.
> >
> 
> Sure, do you still want me to send these changes in separate patches for
> review?

Yes, this is totally fine with me. I think we get more tags when the
patches are broken out.


