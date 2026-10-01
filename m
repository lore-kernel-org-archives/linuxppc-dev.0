Return-Path: <linuxppc-dev+bounces-28634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38EDCA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 08:45:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwQTg1zn8z2yTQ;
	Thu, 01 Oct 2026 18:45:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790844311;
	cv=none; b=mu8shiKuJod+hjkqJWHPg8cBNcbDFTViNQmSvcsxFTTaqNujTzlM4gU/gWhf0yLg14eP8ZgHCm8AEp+DVSV4zunt0TM1hMBz98F9oTGbb/PBBxv8jCvmBPLPZyk6ovBFNPDf/qRFs5Lobu9nEcEaPhey1LP1QYuX7DcSeBE9N8munRRbUHt0sp6Us2gtsA0wC1xCYHDYRAjMvVOVHygUUobrKcKczPgQlVCMjGd8IhQtIyhcPwRFiXaqIxmR57fqeye9Nl4DK/0rUJ7DAL7xLuTW+XfNJ28pui970iipHwroZVcGQcPe8Ss+JFl5TUEBURT9vTPbX/QSrGe/V63I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790844311; c=relaxed/relaxed;
	bh=gKfEG8QCBi+EkydhyBHP45AhFfxZuKGfAP2C3xABDoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P84js4kuff0rur4TqIowgfynlXPuRb58nGbmiZtSedd9CYLFKMQqjfpQk6RTdoy7xEiYGSeBpey/BL4n+td0m/26NUVCYvH27YyfCrJMtY3sVKaA25WBOP7d3b07QbZlUKIHDHh6+kSfk6CuS5hsxrSnxj7efY32ZImWSYCFT2k6L0QtfNM21Bk106OqLzUWjDbUJeZupNa4MjH/be9/bG0jNPPqtZujFDqJizikD+0tsTBMUdOzRIj5BCv/cmzsmTpj7+N2L8iil6Jhrypsl0BLYNPAk2OF6cE1TOD2jIynUIRjR/JKDW/OthMHl+dGFjmhnsz522SFsZ9qrj0jMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MTiwQFsX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MTiwQFsX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwQTf44HTz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 18:45:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC762601FE;
	Thu,  1 Oct 2026 08:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157511F000FF;
	Thu,  1 Oct 2026 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844307;
	bh=gKfEG8QCBi+EkydhyBHP45AhFfxZuKGfAP2C3xABDoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTiwQFsX5pi5tTgeWr+QpBSsBmk0QrTJpijz0u6ubv6BthjGv3VP5djjzKSrMIPmT
	 cQHBRdqR5A2x3aUiqkIGegwf5c+CgtdbsBNOIWYV2Ql8m6tzWlAl0QqoikFhcg0AQZ
	 hTjNOFzOgho5BRsJcns9T8xj9YeER3hIOhal1RD4=
Date: Thu, 1 Oct 2026 10:45:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Timur Tabi <timur@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"open list:FREESCALE QUICC ENGINE UCC UART DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: ucc_uart: Use platform IRQ helper
Message-ID: <2026100132-geology-shingle-d005@gregkh>
References: <20260927204317.21546-1-rosenp@gmail.com>
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
In-Reply-To: <20260927204317.21546-1-rosenp@gmail.com>

On Sun, Sep 27, 2026 at 01:43:17PM -0700, Rosen Penev wrote:
> Avoid calling irq_dispose_mapping() by letting the platform_device
> machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> and other errors. Handle before any allocation or anything to avoid
> dealing with gotos.

I can't really parse this, what is the bug here that you are fixing?

> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: move platform_get_irq() earlier.

Why?

thanks,

greg k-h

