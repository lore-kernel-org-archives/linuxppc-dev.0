Return-Path: <linuxppc-dev+bounces-24771-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090B0C531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 06:00:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5y5j6nwNz2yLY;
	Fri, 24 Jul 2026 16:00:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784872841;
	cv=none; b=aWKJMwCQj2T0XyfCx+8MjlsOxI+fCjwz2NuaheleM5CpD8TvkI5kFDCwAGfVapvy6ojxvBG25AU38qXy0aV4NJPOBsmHFS0wpsRcGobD9+nWGWqPSx9gj0yJXLAEnUWxCaf+sTZawYMNwDTOK1NG7PHwgUFHrPB0ZVm8EtV3TnC6LYjXrRxGl7L9zPYG4XddVJzJGHpusYDeX6bmKUjC+gKO3YLC57c2MyXjryTK+9EE2jYnkWwy7w+5a+0jXums6ehIhAGHPnt7QPNWdUkX4hXmNl3VgolF/69xQLeR9n6QoDRwbglc8wpmQeWneXHYteXJ7ra6Y6RpTuYLXyn3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784872841; c=relaxed/relaxed;
	bh=6rzPW0CUckbkrF39Ekx9Pi0vtsbA5yjRkuFGFKuxzek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpMqomfZTbWDM0oiKym1xjdWBXZOuKg10/dlr1rYxTQqeXDx7c1UxPKssgnX4dWcKDvHp3aLbEwQ2yFxactNwyWdFGlHTfD2s+aYRljsu0Mh4Kn1I+uie3WWPycXrRSMkSalcEvYIUfXnTxGD0H8pID4KYeVt3pAUvZzPzSU0TtxkKwK4w+/vjiS3Dm/7CuoeqHyA7ahk2a+nxQltwhRgSwvMGzOvZ2JKgZdGRk08xr2HFbnWPw2Wp2p1DU7wP7CznwFTSSMba1WdKFyPKTRFH8gw6ooGnx0GZLsdl6EpsKjadcZ0irvZZczufa/PKgAqrM8uk5Id7pdTN+9qjoWnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ4S4muw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ4S4muw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5y5h6vCcz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 16:00:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 305EC600AA;
	Fri, 24 Jul 2026 06:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A41F00A3A;
	Fri, 24 Jul 2026 06:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784872836;
	bh=6rzPW0CUckbkrF39Ekx9Pi0vtsbA5yjRkuFGFKuxzek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SJ4S4muwxAjPqwN3bl5N3K9mlPX5ztOTcDpunS2J0kEzqUWBG0SS0UtzJGOf3bANn
	 eyjQumooGnJtkNw7HW5mNwxNfaSN2DrMHU6EsxiTgVBmth+jxT8ol2i6DKRgn7/U74
	 Nuahy8UsYiCHf6Q64qJ9zhYtA52xoHHWUsxCK3MLlJno1ItjqbmY+TCJcBBrMBDxUd
	 hXvZtusw1l6p0s4FNmOkI9g/ZRaxyWOo4Y+Gqjkb4QVp6Q7Wuf6+SS8hXgs2MifcgY
	 Jbx3MMJW0lKXITrAnkxqY6kgN8eUoXfd59iGo3vhR6P/zMHkPXnE1pCy1IyI02D2Xv
	 C1TfCVVca16sw==
Date: Fri, 24 Jul 2026 11:30:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 phy-next 9/9] phy: lynx-10g: use RCW override
 procedure for dynamic protocol change
Message-ID: <amL_gPKbD0BQG10S@vaman>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
 <20260721231603.67865-10-vladimir.oltean@nxp.com>
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
In-Reply-To: <20260721231603.67865-10-vladimir.oltean@nxp.com>

On 22-07-26, 02:16, Vladimir Oltean wrote:
> Up until this patch, the only protocol change supported was between
> 1000Base-X/SGMII and 2500Base-X. The others require an RCW override
> procedure which was lacking.
> 
> Since now the guts driver provides the means of applying this procedure,
> make use of it and remove any comment which mentioned the limitation.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

