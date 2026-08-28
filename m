Return-Path: <linuxppc-dev+bounces-26160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECCDC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:44:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWS5N1kWPz2xT6;
	Fri, 28 Aug 2026 15:44:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787895896;
	cv=none; b=ooASzuxYwYgqVsFP9OQz/a2vExKaVliVaCn/jX2a1WBl2wBkGNQTfQugnwMybf5RIn0FqUQ0O88PnwD48VTb9tnaPswJKbN/ORa5iWGRXSPUaVIRjp5TUuzEh1mUrvMj/TE5ujcOEsnGwMXtEguxuxsHNb2x/vvsSefXxMubuhaIf/NWL1X6bSgpovG5MKTu+vW8b0tusKjcNzhrb2X+t9rObnwo2kLWW1smp/AvjvBHpKbvkPjiexgqE7LsyBNZGOmWH1FwU7gdFWYzTVoESVjzCW+wIWS4nkcaPtWw6+e1KormOMOyjBJrx8Ev/fMIdaJEvy24Q462sthHN8sh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787895896; c=relaxed/relaxed;
	bh=JZ8jkENwhXSI17hcjxLdU7YO7IQjlwVthIoqDgQePP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECByRT/pKQpXA3uHJ1Ln71IYgYHAj1UXCs3pxqnShpj9+yhhNuPMGowlvD3kGTKB9YWvpoScbtKgyb7A2LrEHP9S0mGK/m90USFzGR4FdIDA2jrQj3NpSNxrgk95OTfELC9RbdBdTyw9v8r+f8wHziSoiwdIHS5m+EpdgukCiSiMebZnQyPZ3o74hPpt1dh+Q0IYOfagIgLV0t3zguEjmK+x0vQvkO4SHhf3R06wrawk3uPUhRA1qK71CXZQOonrBPIYX4iovZSXPM8UUu5czqoXU5Wovsf+bwkZS+0rgFJrFOMWCuj8jr2Aep9K2Ou2HgjqPhM1AF7UGWg2hOlznA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=N8+uxbg2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=N8+uxbg2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWS5L3yGLz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 15:44:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 500C940627;
	Fri, 28 Aug 2026 05:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81041F000E9;
	Fri, 28 Aug 2026 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787895887;
	bh=JZ8jkENwhXSI17hcjxLdU7YO7IQjlwVthIoqDgQePP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8+uxbg2iVPFHvllbLKHUnWT5PT9AiI3kkwQKtwzlyhFPH+gYXTCVQ7SXN73RQbwS
	 /B/YQ2m4nD0QSIH5yIkuRaY6k5GOxwjuHrx8EAmschXAZ7RRHzZCtTDJx+szg2Z4Vb
	 e/rNbkM9TR9p5ZcKkOQsS+lK1GfRw71dmZbjgRgI=
Date: Fri, 28 Aug 2026 07:44:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ralf Lici <ralf@mandelbit.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	Ran Wang <ran.wang_1@nxp.com>, Duoming Zhou <duoming@zju.edu.cn>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [REGRESSION] 6.1.y/6.6.y: fsl-usb fails to build
Message-ID: <2026082858-footing-calorie-a196@gregkh>
References: <20260827154302.706689-1-ralf@mandelbit.com>
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
In-Reply-To: <20260827154302.706689-1-ralf@mandelbit.com>

On Thu, Aug 27, 2026 at 05:43:00PM +0200, Ralf Lici wrote:
> Hi,
> 
> While working on some backport patches for an out-of-tree module and
> looking for the exact versions containing the disable_delayed_work_sync
> symbol, I stumbled upon occurrences of that function on longterm v6.1
> and v6.6 in drivers/usb/phy/phy-fsl-usb.c despite not being declared or
> defined anywhere. In fact, disable_delayed_work_sync was introduced by
> upstream commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> (delayed) work items") and is only available since v6.10. Neither 6.1.y
> nor 6.6.y defines it.
> 
> Consequently, kernels built with CONFIG_FSL_USB2_OTG fail with:
> 
> drivers/usb/phy/phy-fsl-usb.c:990:2: error: call to undeclared function 'disable_delayed_work_sync'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>   990 |         disable_delayed_work_sync(&fsl_otg_dev->otg_event);
>       |         ^
> drivers/usb/phy/phy-fsl-usb.c:990:2: note: did you mean 'cancel_delayed_work_sync'?
> include/linux/workqueue.h:470:13: note: 'cancel_delayed_work_sync' declared here
>   470 | extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
>       |             ^
> 
> I reproduced the failure on PowerPC using corenet64_smp_defconfig with
> CONFIG_FSL_USB2_OTG=m, building drivers/usb/phy/phy-fsl-usb.o with
> Clang.
> 
> AFAICT, in 6.1.y, the regression was introduced in v6.1.160 by commit
> 4476c73bbbb0 ("usb: phy: fsl-usb: Fix use-after-free in delayed work
> during device removal") and remains present in v6.1.185.
> 
> In 6.6.y, it was introduced in v6.6.120 by commit 319f7a85b3c4 ("usb:
> phy: fsl-usb: Fix use-after-free in delayed work during device removal")
> and remains present in v6.6.154.
> 
> Note that the same problem was pointed out by Ben Hutchings during the
> 5.10.y review:
> https://lore.kernel.org/all/d147f0eb71f9cefbfb7605e95d98564d7f0ed346.camel@decadent.org.uk/
> 
> The corresponding patches were dropped from 5.10.y and 5.15.y, but
> appear to have been retained in 6.1.y and 6.6.y.
> 
> Simply replacing disable_delayed_work_sync with cancel_delayed_work_sync
> at its current location may not be sufficient: it looks like the delayed
> work can also be scheduled from fsl_otg_set_host and from the IRQ
> handler but I'm not familiar with this part of the kernel.

Can you just send patches to revert the offending commits?  Or we can
just ignore it as it's been this way for a while and no one has noticed
which implies to me that no one builds these modules for these arches on
these very old kernel trees :)

thanks,

greg k-h

