Return-Path: <linuxppc-dev+bounces-9257-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63453C61DB2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Jun 2025 20:12:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bH0Ly5vLSz30DR;
	Wed, 11 Jun 2025 06:12:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc2:55:216:3eff:fef7:d647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749586330;
	cv=none; b=IV5KfOTZ013oVJjRGi+B2O8S9u8UAbIuBNRsxQhD4YzpZ57TLxwvvNiYQSGtGPczK2UndwvGMlb5mM6vUCOYKaZvc/bM2m1P7lm7dAEk2pQ882ntHfV4p4Dr4Cr6xXE+6NsZkqiVysBV6OmQ3pw08nDusmhco4eKY47k3tuCIV+tv0dnnS+cNI/AoDQhm3NoVcDyRbKf8EqE6quathHApehtTamR8AbU3vNbbiE6e0dLWzov5ewq32QJqhhqWv5HoEnhnMjS545tiwcvcRQTCXDAqxnraFAgg3qrLFuacWWrVARtwv//c6pE1Z5oPpITYq+RuVdAW/9+aNKU9CuN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749586330; c=relaxed/relaxed;
	bh=CEGuU5AQfHlZMDo2xfbPO1VA0MItiJUsDWdzYpvY7dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqcuPE2zD+mVavLurqJiiXzYBIl8SAq17XsbacrRhnH/ftP6em17wSN97A+KfxCRS7m4xjOnDDvzzIk7jOIJY1uhBAzfviQAqfQnC8qfaRayVh0mfcvAx7HSICevES6DE6lRI/ZmKv0ign4L3JwJtmmIObMrCdx3ctJ+JQv59nYJnWIdTqR2EYRf1vxSoYY0OF+wGnR2QXJBpl+d0YoExymsWewoalRuYItI/QlYaTeAG8u/DseWoOXlSZot7p4xIEpSfP6Gf6VrxxzAkNGbP5/iI6nyQWZ6CbvA15rwbguxoU3MqQ9IyMXymqy7kE0Q1/7nQDDGHy6JPeJ966O8HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=U1/fu84m; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc2:55:216:3eff:fef7:d647; helo=perceval.ideasonboard.com; envelope-from=laurent.pinchart@ideasonboard.com; receiver=lists.ozlabs.org) smtp.mailfrom=ideasonboard.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=U1/fu84m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ideasonboard.com (client-ip=2001:4b98:dc2:55:216:3eff:fef7:d647; helo=perceval.ideasonboard.com; envelope-from=laurent.pinchart@ideasonboard.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 488 seconds by postgrey-1.37 at boromir; Wed, 11 Jun 2025 06:12:09 AEST
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bH0Lx42tlz2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2025 06:12:09 +1000 (AEST)
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 529D8982;
	Tue, 10 Jun 2025 22:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1749585824;
	bh=pZHDy7uHsJk6rWzKI9DZSCzFdjUnTIW6weNE7ccNbFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1/fu84mQZKS9UPfHrYElq/cS626ou3jlL8uDc+sG5RcQe1xoEDX6LaaKf641Ob+A
	 xT2Z0fuaHvOM6CDPCWYnexJuWjuvmhLJatwwV7kUYFV4J1/Mvg9xRZVK8PivW9NBT5
	 wAPu27uMpxd95CNEZffdCB6/i8bhdhXkM+kSXxcw=
Date: Tue, 10 Jun 2025 23:03:39 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"zhangzekun (A)" <zhangzekun11@huawei.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, robh@kernel.org,
	saravanak@google.com, justin.chen@broadcom.com,
	florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
	kuba@kernel.org, kory.maincent@bootlin.com,
	jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, taras.chornyi@plvision.eu,
	edumazet@google.com, pabeni@redhat.com, sudeep.holla@arm.com,
	cristian.marussi@arm.com, arm-scmi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	chenjun102@huawei.com, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/9] of: Add warpper function
 of_find_node_by_name_balanced()
Message-ID: <20250610200339.GA1233@pendragon.ideasonboard.com>
References: <20250207013117.104205-1-zhangzekun11@huawei.com>
 <20250207013117.104205-2-zhangzekun11@huawei.com>
 <Z6XDKi_V0BZSdCeL@pengutronix.de>
 <80b1c21c-096b-4a11-b9d7-069c972b146a@huawei.com>
 <20250207153722.GA24886@pendragon.ideasonboard.com>
 <be93486b-91bb-4fdd-9f6c-ec295c448476@stanley.mountain>
 <aAuqgiSxrh24-L-D@stanley.mountain>
 <20250425170732.GA21390@pendragon.ideasonboard.com>
 <aEiJ856egeMCC6ao@black.fi.intel.com>
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
In-Reply-To: <aEiJ856egeMCC6ao@black.fi.intel.com>

On Tue, Jun 10, 2025 at 10:39:31PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 25, 2025 at 08:07:32PM +0300, Laurent Pinchart wrote:
> > On Fri, Apr 25, 2025 at 06:30:10PM +0300, Dan Carpenter wrote:
> > > Whatever happened with this thread from Feb.
> > > https://lore.kernel.org/all/20250207013117.104205-1-zhangzekun11@huawei.com/
> > > 
> > > The issue was that people weren't expecting of_find_node_by_name() to
> > > drop the reference on the of_node.  The patchset introduced a wrapper
> > > which basically worked as expected except no liked the naming.  Krzysztof
> > > suggested that maybe the callers should be using of_get_child_by_name()
> > > instead.
> > 
> > My conclusion is that most of the users of of_find_node_by_name() with a
> > non-NULL first argument are wrong, and should be replaced by
> > of_get_child_by_name(). We need a volunteer to do that work.
> 
> Wouldn't be coccinelle a good worker for this job done?

It's not mechanical work, every single user need to be audited manually.
Finding the call sites is the easy part, and we have them already.

> > > I created a Smatch warning for this and here are the four issues it
> > > found.  The line numbers are from linux-next.
> > > 
> > > drivers/net/ethernet/broadcom/asp2/bcmasp.c:1370 bcmasp_probe() warn: 'dev->of_node' was not incremented
> > > drivers/net/pse-pd/tps23881.c:505 tps23881_get_of_channels() warn: 'priv->np' was not incremented
> > > drivers/media/platform/qcom/venus/core.c:301 venus_add_video_core() warn: 'dev->of_node' was not incremented
> > > drivers/regulator/tps6594-regulator.c:618 tps6594_regulator_probe() warn: 'tps->dev->of_node' was not incremented

-- 
Regards,

Laurent Pinchart

