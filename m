Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F9CCD1284
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2024 08:46:51 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CjUtumo0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDKMF5dPVz3dWW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2024 18:46:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CjUtumo0;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDKLL66X4z30gK
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2024 18:46:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712652362;
	bh=8C5Zd7KFg+VaVbXLO/DDkwh9Zx1FAb8TYggRa0PUA08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CjUtumo021QlqGOmFhCj4Xc7cB8O5Y2s8NRExYdFBlrqt2KO0/6Br7ZBlM603duGQ
	 m0WSPfordKltiagx/c45LjLaPJ+yO9UMKufHadRcjb9R6k+LjKW4RF0lgP8WhpykX9
	 i8wKDk4pLW3Oh3SoXEJE3l5khBNLqn88fTTjfCtTcl3gRWWBGfjqnpp7mRI7XVkgw0
	 5aw4lMjNVBlXqNfggGgv74tMbTLnX4OTwUFqi/qn5xC7OpCiI9aGzYS1GuvdPtPjDr
	 EF7gUczTt+179uB/YAn/IpMU3feHTgLw3RS1RSNMAMkNB2gvDH3Wv4R5F8WQjJ2sfj
	 xE12LAKUhkX5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDKLL37lQz4wqM;
	Tue,  9 Apr 2024 18:46:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lidong Zhong <lidong.zhong@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: remove returning ENODEV when uevent is
 triggered
In-Reply-To: <20240323084737.12986-1-lidong.zhong@suse.com>
References: <20240323084737.12986-1-lidong.zhong@suse.com>
Date: Tue, 09 Apr 2024 18:46:00 +1000
Message-ID: <877ch6c4af.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: lidong.zhong@suse.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Lidong,

Thanks for the patch.

I'm not an expert on udev etc. so apologies if any of these questions
are stupid.

Lidong Zhong <lidong.zhong@suse.com> writes:
> We have noticed the following nuisance messages during boot
>
> [    7.120610][ T1060] vio vio: uevent: failed to send synthetic uevent
> [    7.122281][ T1060] vio 4000: uevent: failed to send synthetic uevent
> [    7.122304][ T1060] vio 4001: uevent: failed to send synthetic uevent
> [    7.122324][ T1060] vio 4002: uevent: failed to send synthetic uevent
> [    7.122345][ T1060] vio 4004: uevent: failed to send synthetic uevent
>
> It's caused by either vio_register_device_node() failed to set dev->of_node or
> the missing "compatible" property. Try return as much information as possible
> instead of a failure.

Does udev etc. cope with that? Can we just change the content of the
MODALIAS value like that?

With this patch we'll start emitting uevents for devices we previously
didn't. I guess that's OK because nothing is expecting them?

Can you include a log of udev showing the event firing and that nothing
breaks.

On my system here I see nothing matches the devices except for libvpd,
which seems to match lots of things.

> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index 90ff85c879bf..62961715ca24 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1593,12 +1593,13 @@ static int vio_hotplug(const struct device *dev, struct kobj_uevent_env *env)
>  
>  	dn = dev->of_node;
>  	if (!dn)
> -		return -ENODEV;
> +		goto out;
>  	cp = of_get_property(dn, "compatible", NULL);
>  	if (!cp)
> -		return -ENODEV;
> -
> -	add_uevent_var(env, "MODALIAS=vio:T%sS%s", vio_dev->type, cp);
> +		add_uevent_var(env, "MODALIAS=vio:T%s", vio_dev->type);

If it's OK to skip the compatible property then we don't need the
of_node at all, and we could always emit this, even when of_node is not
available.

> +    else
> +		add_uevent_var(env, "MODALIAS=vio:T%sS%s", vio_dev->type, cp);
> +out:
>  	return 0;
>  }

I think we also should update the vio modalias_show() to follow the same
logic, otherwise the uevent MODALIAS value and the modalias file won't
match which is confusing.

Preferably vio_hotplug() and modalias_show() would just call a common
helper.

cheers
