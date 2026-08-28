Return-Path: <linuxppc-dev+bounces-26162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA7CC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:06:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWTtv34jDz2y2T;
	Fri, 28 Aug 2026 17:05:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787900759;
	cv=none; b=eI7rB50JcbiTCO6dZAE4/L9lYxYy+v38FzmisE4zHYamkoiWJu1irqC+g8WGR8UdhTz9LLknXoP9h/2kOsGbsZG/U/Z1NfvphrHkl2OrvHwPYf3yJvD2p8VGecf50TLX8YgLZe/Fi/R0JeYVHLy1X1h7h1jTWduFx0YNn3sqNT0zKBVealvaX2R3AHO8W4oMqJRAG+CbZ5IK8gMN5kCM0c7kr9P1XEsRqM0ZI9iTy1s1fl0kXszqAOAVTmwXF48jDxTOpyZfPn+HUagZSgzZqwPOQ7NDsZ9yvGxiqlVs3IcMEb1xaIq1D1CulvVQgCzBdUfHE2KwYC7I5Zb+RyTyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787900759; c=relaxed/relaxed;
	bh=oyhWX7eOAfeEW9vgW0WBxjvrBvoN2XFCwMEYhnpzZJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrnYbVbm5Se0eVmJuEmHjqOD0h2UPSk4O6wjjDaMtM283BOq6shn3vQx5pecKJKmrKSl0Ac2wU+0lHPoof9bpfLGovtMx2zYWJZXw3hlb5bcl3PZqCIkROY8t8M7byIZlZ6wjUQ70Wm/AXyaa3uv8P+hFhCJXYDy1BzqdEf9fh2x4Iebs6JG5R3590lHAxX4jnebjuBBBOGBEYzyNVHms4JHVMa2M430M9Dez0K7cGEw4ASNMoNF6BW+oGeppNaSBdcjxAQl1Fy0nLvpc0OY82/wumuWUmIP1S025HfBB1+6frXZjuBKhK3XmOmFLU+iMWV91YYmzrKzkTzgXFLW4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=p49vXzGd; dkim-atps=neutral; spf=pass (client-ip=195.10.208.40; helo=mout-b-210.mailbox.org; envelope-from=ralf@mandelbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=mandelbit.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=p49vXzGd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mandelbit.com (client-ip=195.10.208.40; helo=mout-b-210.mailbox.org; envelope-from=ralf@mandelbit.com; receiver=lists.ozlabs.org)
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWTtq1Vq9z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 17:05:52 +1000 (AEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hWTtd0F2MzFqjg;
	Fri, 28 Aug 2026 09:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1787900745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyhWX7eOAfeEW9vgW0WBxjvrBvoN2XFCwMEYhnpzZJA=;
	b=p49vXzGdVKpNp9GptBkhbT1mcK/ABByD8PKX7EeU47qxaSz/J5jWqhjKsdrBc64OYjWnwy
	kCksJw+uYaLbaf7lgDJJXpnzeiJJLpqXx06mLG5RoJISV0gryJW7Ri2alwD4TL+pRLjdfE
	w8qsRJypSpLPAD/A3DFtTnIjBfrhVS05zZY/NHXbdSkr9/+/cQGo/i9BNABMo8t+VeVR5b
	eoJ7ry3cO+cvQG5XOAP2TOcT60stRtU+HWkTcFZWUzgod+H8qGct6sI6590wyAX/hh+w6K
	CAkNIlQ6wzdqNL9q2RxZB4paNBFTc4IpwNzg+jYcjqCUhutXUdUrNpLwq/Qmnw==
From: Ralf Lici <ralf@mandelbit.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Ran Wang <ran.wang_1@nxp.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [REGRESSION] 6.1.y/6.6.y: fsl-usb fails to build
Date: Fri, 28 Aug 2026 09:05:34 +0200
Message-ID: <20260828070535.38490-1-ralf@mandelbit.com>
In-Reply-To: <2026082858-footing-calorie-a196@gregkh>
References: <2026082858-footing-calorie-a196@gregkh>
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
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 07:44:44 +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Thu, Aug 27, 2026 at 05:43:00PM +0200, Ralf Lici wrote:
> > Hi,
> > 
> > While working on some backport patches for an out-of-tree module and
> > looking for the exact versions containing the disable_delayed_work_sync
> > symbol, I stumbled upon occurrences of that function on longterm v6.1
> > and v6.6 in drivers/usb/phy/phy-fsl-usb.c despite not being declared or
> > defined anywhere. In fact, disable_delayed_work_sync was introduced by
> > upstream commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> > (delayed) work items") and is only available since v6.10. Neither 6.1.y
> > nor 6.6.y defines it.
> > 
> > Consequently, kernels built with CONFIG_FSL_USB2_OTG fail with:
> > 
> > drivers/usb/phy/phy-fsl-usb.c:990:2: error: call to undeclared function 'disable_delayed_work_sync'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >   990 |         disable_delayed_work_sync(&fsl_otg_dev->otg_event);
> >       |         ^
> > drivers/usb/phy/phy-fsl-usb.c:990:2: note: did you mean 'cancel_delayed_work_sync'?
> > include/linux/workqueue.h:470:13: note: 'cancel_delayed_work_sync' declared here
> >   470 | extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
> >       |             ^
> > 
> > I reproduced the failure on PowerPC using corenet64_smp_defconfig with
> > CONFIG_FSL_USB2_OTG=m, building drivers/usb/phy/phy-fsl-usb.o with
> > Clang.
> > 
> > AFAICT, in 6.1.y, the regression was introduced in v6.1.160 by commit
> > 4476c73bbbb0 ("usb: phy: fsl-usb: Fix use-after-free in delayed work
> > during device removal") and remains present in v6.1.185.
> > 
> > In 6.6.y, it was introduced in v6.6.120 by commit 319f7a85b3c4 ("usb:
> > phy: fsl-usb: Fix use-after-free in delayed work during device removal")
> > and remains present in v6.6.154.
> > 
> > Note that the same problem was pointed out by Ben Hutchings during the
> > 5.10.y review:
> > https://lore.kernel.org/all/d147f0eb71f9cefbfb7605e95d98564d7f0ed346.camel@decadent.org.uk/
> > 
> > The corresponding patches were dropped from 5.10.y and 5.15.y, but
> > appear to have been retained in 6.1.y and 6.6.y.
> > 
> > Simply replacing disable_delayed_work_sync with cancel_delayed_work_sync
> > at its current location may not be sufficient: it looks like the delayed
> > work can also be scheduled from fsl_otg_set_host and from the IRQ
> > handler but I'm not familiar with this part of the kernel.
>
> Can you just send patches to revert the offending commits?  Or we can
> just ignore it as it's been this way for a while and no one has noticed
> which implies to me that no one builds these modules for these arches on
> these very old kernel trees :)
>

Right, the lack of reports after roughly ten months suggests that nobody
is building these modules for the affected configurations. Still, I
would rather not knowingly leave those configurations unbuildable, so
I'll send revert patches shortly.

Thanks,

-- 
Ralf Lici
Mandelbit Srl

