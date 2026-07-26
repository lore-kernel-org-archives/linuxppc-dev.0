Return-Path: <linuxppc-dev+bounces-24847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43D0C531C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 20:50:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7Ylc0l1Fz2yd7;
	Mon, 27 Jul 2026 06:50:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785099036;
	cv=none; b=c+HvCgcgDUD9H4CxyZH71x0F1fMZL0mLQjdzDdu5bN63fPMD9/9w8mUI4P/EgIBS6cxucQcbJNp6fZKoTdq9zPgKjE4kS5aseKj5nXe3LFJ+3evnlI+zm2L/P8rXJCYBEdr4S6oxw2+Y1pmP3X+ck7sj7AoxDpYNHHT3nD0U51a8gfRI9xzqj6JCy9WLvtqdYeX/j5r+hGor3LeL9qreUOcrdQX7dnmlZ1ZJP4d/uF1dd/agSKRVjw9dLlcTDls9/VlhK/fqEwP+xt72321goW0VJDbVGmKZgXPZX3A7zi427LtW8KnK2GjZfvjLYqYrF+Otq1gLfCMzLN/f1kX1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785099036; c=relaxed/relaxed;
	bh=HLpZYMENBNgPXFarYmWwn7VwAhRa9SmUHkcGWYZHpG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrPYs7lWR+raZHoDbMTtac336mXELJm0b62HKVls6k6pm0BG96I9Y1xiQ6WZvx4f6n0G3h4kdX7D/O1q27byvgcZel6pqasfsAStYyqM5gyeGTigAO/Dg1sh170cqx2jPSIs6yFuKE6eMITn2yqYC5I9qDdQDOj6+HwqBWYB8/P7dq6gwniSWL/qFnaeMvSVkkX9b3xfMR6HWny3+Q+Sex39VjJ06Nsj1Oq0Z64a3aQNvWovMNRMPPDUBjqSs5qqDGSNyqTmWgEyIgTrDUIh5orWPLz/vZVumy7Jsbr+IKWUoK7+OY8jmf6O0u11td9n9J+pCegi9cHEi9Ajf4N75w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=In5V3KSS; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=In5V3KSS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7Ylb2rgnz2yFP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 06:50:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 38BCD42CBB;
	Sun, 26 Jul 2026 20:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4611F000E9;
	Sun, 26 Jul 2026 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785099031;
	bh=HLpZYMENBNgPXFarYmWwn7VwAhRa9SmUHkcGWYZHpG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=In5V3KSSLdWN4HHPW+I8bvUb7SeetiUPoS+vwnKYBb2rUiZOW6WdSPgD7lUHb2ay2
	 aEV8ESrjf0zFLfFex/SkOqNEB0Vj752OA8tBNny/jl1XwEuHlMuT1eq1+pgtxqUNRV
	 4RB4LYce8X4AXHS91Jl3DeTxLBsFytz0qCX4/dsHqKyDntQdurR5j7n9uLgpGXcu8/
	 1nuAFjFRygNUHsQa9d64ooc+nT4MptG5vbo9oXzn3nbgFG/J8JsoyceViKUD7QG5kl
	 K3FdMqec0+WZ5CNDX4q3SMVfQHRxBwc6CQKsoAX6wh7LYKIXkBrEyf5BnVloSBt/y5
	 iBhv21g14JvFA==
Date: Sun, 26 Jul 2026 22:50:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: pxa-pci: use platform_device_set_fwnode()
Message-ID: <amZzAGnHvXxS8CM8@zenone.zhora.eu>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>
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
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>

Hi Bartosz,

On Mon, Jul 20, 2026 at 11:24:49AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

