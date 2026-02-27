Return-Path: <linuxppc-dev+bounces-17375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67746FD5313
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:08:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMjDS5vGmz2xMt;
	Fri, 27 Feb 2026 20:08:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772183320;
	cv=none; b=eIduJxLx1YkjiCOlr7ViGCRpX+UpN5hyJ1YImKZLstdOL3Ro6DEyVRuqXooLXl9tAeoZTAdN4Fqckgu0JR7zVljiTHFmeoN1BwnwBaKJ69X39WJGNwakAHm7WzW7BJ7ZJP52XISbM9fsJnDyivnBxabDWEjcH4VFvkxQLSU4XNHR4NW8MC625zXGbnz2iKB10uy5d5TrfgYbCPB2NjzV9LkaH3PcL9MA/vLGYrsI/Dy9z/ynWA17qYkSMe/LKg6HNXmGq40VGwAfxMqNVtUZUOMDXnLDjfww8GhRo/UnL1chT2nrdj/WpMgQUBLIY1ARhpkLQH526UMF8bseu7qvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772183320; c=relaxed/relaxed;
	bh=PMFAO4csiSN1neHee9OeKdJZyaErSWGhMT/VU9fURKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amB9p5sdOEzyXoZ4sUTp+J/bN+FA7hVdQHS0Tz7HloKbkgQV4mi2X5HEGUHTGf0yDbsaABjIIzwioShgPTt2dIbF+82i2YXlmqWEohVPCanXJ53cZYyvZwYgGbrjky5vbpOV+Ll1FXQrmXMkwI8zwXAQQdZbFOsrTk0LGTPuL+tUL7tyjSTa3bpF2XW5zmIm3Z0W1K5NHKmHRUpITaV4GPBC0JIS6SkfWiHAfW2gU4DyojIy0dXrAm0Z0xWI544s7i5hdEv5Dbz5Xr80PnvT+f+9Dkwu/oqO4ebq8ZHtvFJOnzSOnQLar2Gyv6IwHHZn7fr8MBfjzavlNUbJ19UX/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=NNt/+kgd; dkim-atps=neutral; spf=pass (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=sang-engineering.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=NNt/+kgd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMjDR3tMDz2xLv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 20:08:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=PMFA
	O4csiSN1neHee9OeKdJZyaErSWGhMT/VU9fURKM=; b=NNt/+kgdJvUJ6dErCiQZ
	FsjmBZOYgAIctuPF+FsJTFm1XfUfq0bbV2r75EIzm32GJZONBIpZQb18pjKoEYfz
	v1BkfHcvRUuWFPaUKI52cD5vUZlgEh0U0jC6YnGQF4FAUS/ANpi708r2HeFeps5d
	760lZ8tMAOh2/LW5EnJwMWBybA8EisVDcz8Nt+j1enOM4kBmiEXnL2+BV8/6VZwn
	Ii6YPZvpBS1ZzqSqUimwGhUmg4M9rNqVVZs0zgGX0Fd7v92aJIi7IbX/S4NhfDB2
	rr+uysI8ngNiXM9fOjw2UQiaonzEht4kHSYcngE0oAEswp32ODspy3yP4k3v7KZn
	fg==
Received: (qmail 1412929 invoked from network); 27 Feb 2026 10:08:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Feb 2026 10:08:35 +0100
X-UD-Smtp-Session: l3s3148p1@JPv0lMpLHKAgAwDPXzF+ANZpdrMKUeLI
Date: Fri, 27 Feb 2026 10:08:34 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aaFfEsfh0xTh0b1y@shikoro>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com>
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
In-Reply-To: <aaFcs1miP88QWmtH@hovoldconsulting.com>

Johan,

> Wolfram, I noticed you merged these last night. Please think again and
> let's discuss the end result here. There's no question that there are
> lifetime issues in i2c, but this is not the way to solve it.

I did think again and do not see a way how the life cycle problems can
be solved while drivers happily access the device struct of the adapter.
Whatever the solution to the core problem is (revocable, custom SRCU,
something else), I still think this step is needed in any case. If I am
wrong with this opinion, please enlighten me. Pointer to some existing
thread is OK, too. I didn't have the bandwidth to read the revocable
mail threads.

Happy hacking,

   Wolfram


