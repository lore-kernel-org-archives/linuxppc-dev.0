Return-Path: <linuxppc-dev+bounces-27026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4499EC79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:34:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgcZV3CsKz2xGr;
	Thu, 10 Sep 2026 22:34:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789043698;
	cv=none; b=TH+m8+s+8i+I10FUNKjGZGd+zgQpJV3k/v7TjKkq2l07dLbyFY7edUVHzT7DFBlSSf37SNZlzrNUjcHClFoNli+Ol8CYj8bW5vsvWssCWgvwuv94fZhWQQlxsRodNMkS6NClZYe3SuAWv0AUXUJFvbif53hEwVwS8u4F27jeBtnxAlGSzGQKMbj2AoyKHLu3MHHPKoUAj6Wqj/hiV5aBkgNGj/OojAGl6J7eD5XDFRkfZcOqpoGSTHUGfndFwt7LF3vVkdjTuBumuY8r2scZ2fVgKqZswXqzA4aL3G1bqJ06HrGmFdur53fYSc2D+e/MAoI3fo8OkcKKeDwAI23U9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789043698; c=relaxed/relaxed;
	bh=Io3H7eT8+LcVwxa4TUx68Yyzl1iwGXsQIYcZ6tFQJ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JijPx9svpOaTXEx+HAZ1zk4x75OY0yZeGteJVf+AtP7myCnqovLU5IIGK6joxInAu44vkkl+7XSNv18ZQo9mAP+yFFdqPkW4wyHwCcSgfx4GCv33HyAvZ30jbpJuOEf/qlCwq9e/xWYHI/QkiDFZPYpVCNXXWxsX9DV9UIb+eERUMEcgitbDknnPPsbxH8FgPvlyHwE334Hiua2qTE0PvMkeg0e/EPAsDvhKGtKpiQ9+vKX+0U3TLxHDuQ97lRPj4gnPKkoOubzPZLOacsf4d1KBPqtShAby9aWUmYC2I/NSaB3IOWg+wpl5qr4XMNH6kURdf/GU7/5T0sSzJhkhnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u1xLW18Z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u1xLW18Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgcZT2L8Qz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:34:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F01CA43B84;
	Thu, 10 Sep 2026 12:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578341F000FF;
	Thu, 10 Sep 2026 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789043693;
	bh=Io3H7eT8+LcVwxa4TUx68Yyzl1iwGXsQIYcZ6tFQJ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=u1xLW18ZHX7/n1Wou5fWybTlwRYu6ZlLjZtXO8L23OFv40UOva766BrcpKgINEwrf
	 AhteRRgEUNZ1S2S4dJBbJX26x5fRnke9xFf26XrSZASXOHoei01unD1PQv+JG5dpM2
	 Mdw4hTSE2GPfyTpK9pcMOPeFuaHN8/0Cm9zpXfGk=
Date: Thu, 10 Sep 2026 14:34:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Qiang Zhao <qiang.zhao@nxp.com>, Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qe: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
Message-ID: <2026091038-trailing-jaywalker-2055@gregkh>
References: <20260908-usb-fhci-drop-gpio-nonexclusive-v1-1-8e405dc67874@oss.qualcomm.com>
 <40845ad0-e321-4e1b-860d-ff798f430c42@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40845ad0-e321-4e1b-860d-ff798f430c42@kernel.org>

On Tue, Sep 08, 2026 at 01:58:18PM +0200, Christophe Leroy (CS GROUP) wrote:
> Hi,
> 
> Le 08/09/2026 à 11:27, Bartosz Golaszewski a écrit :
> > The GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for gpiod_get() is deprecated. For
> > actually shared GPIOs, it should be replaced by using the functionality
> > provided by gpio-shared-proxy. The Freescale QUICC Engine GPIO driver
> > uses it as a workaround to access the GPIO descriptor already requested
> > by the caller of qe_pin_request() in order to access the private GPIO
> > chip data.
> > 
> > As the existing comment itself states, the user already requested this
> > GPIO and the only user in tree is the FHCI USB driver which does in fact
> > request it, we can safely modify the function to take the *exclusive*
> > GPIO descriptor as argument and stop using the deprecated flag.
> 
> This change seems sensible. I will take it via soc/fsl tree unless you have
> other plans.
> 
> Greg, can you ack the change to drivers/usb/host/fhci-hcd.c ?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

