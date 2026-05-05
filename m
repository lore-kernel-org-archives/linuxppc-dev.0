Return-Path: <linuxppc-dev+bounces-20493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FF0CD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 23:48:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9FZK0RCmz2yN8;
	Wed, 06 May 2026 09:48:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778024889;
	cv=none; b=KvdB6FBEalW2wiqXieQTpTDAV64FeopNUEKA62tpOUHCSnVyHWbgS0tXG0ZD/nkWgrg9DnpVGgiZrHEYgjvu4l00e7ffp1DXBKkgp6GKhgwulCQkwTaIPXpzx6+oHvvUHl3x1N79DMp1y0eiw/8hSXHYUmNEgrEDqgEA3CP3u/4W79mVkQTPpmfXdGVpgCdL3PIfyOhgwiL4eLqPgLrSo1XgcoYahrVxH82L5/Wvvg76ddbv+X7JVpQrU378qfwoudj0v/aKtsXT5QpUyj+8GbN1mWaR1nQ2KZUS8cXv8NAuk0qpzBPm+RWzvjO3Y3qRt2erA/Kfaf9YczM8Ig5xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778024889; c=relaxed/relaxed;
	bh=nmY21Wt8z+kFnPtsccY93ukiUMbj9Uhy48/0QaW5z8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j67jlKGxmLUlpbMkblsVeoOLJsrbz1hQA2w0rUB85Ry4jOcYgl7eFf+tgyGWwI2oJ7omYcOAEQcVOic0wL4JpCtU7+WzXlr+poGtmCl/IY4lOdvKpz0Bip8UVczLFqQLwgUGFJ6cEcKNQd9H1ndzPPdcR3LXPIshpyv54h9ey5okDREApPV/fCi1V1GADTQ8SYN2fqZhuTa3D3JSGR6fgEQm8vf23codhXUZJwgr1fHbpmxVf2RKaKnOHuIZP4Hj01rtbYS5K4czEhZspQMtTXv7vCiDsE+TIooQYSKA4gimNKqLUvdgaPVYdVmkYg6l73ePb7CPmT5mjYqh0/ff0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZP2p/goD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZP2p/goD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9FZG696dz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 09:48:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0658D6132B;
	Tue,  5 May 2026 23:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6483AC2BCB4;
	Tue,  5 May 2026 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778024884;
	bh=EDj42oTlUCfFy2Xun7dP6BWVobiofKeIRahiASYQY5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZP2p/goDYD7ewtp1fQsxU/6bBhXZIXlRkgJg0+3u6S0ohZDY5G79CX+0QkPxjFpO5
	 CPtqxZqxfwwBdjbOIdcIx+k77O7HFBuOgjcMBj1Z7QnxWVvkvoBtYtZKmeg2n+22+n
	 QyDx8vSS9o7dMbEEXbV8MBzACKY95N57kzXbdKc+5FWE/B3rD+qHNzxBpX5CGTsygz
	 W9hIjMnfP2o2BUDecNhBU2c/qGK0m7UnyRCQsr1qC8bMC3we5PhnbhEd6/PnNJY2tK
	 EmX6I0fin+7YpoWDC89RzptkDq1OI3Vswy/BTBblZdWMUNCFlifSQ7yesCn0W+0tOA
	 yzkCUYJvE7QSw==
Date: Tue, 5 May 2026 16:48:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
 <qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
Message-ID: <20260505164803.73d87809@kernel.org>
In-Reply-To: <AM0PR06MB103966A8283FD757F6C9459A0F73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
	<e3abfd12-6537-42b1-b35e-c79a06f87172@kernel.org>
	<AM0PR06MB103966A8283FD757F6C9459A0F73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 08:16:01 +0000 Holger Brunck wrote:
> no not mandatory needed. I just saw that and thought that also such minor issues
> should be fixed. Can be abandoned.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

