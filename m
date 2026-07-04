Return-Path: <linuxppc-dev+bounces-23559-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82232C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Jul 2026 09:10:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gslFx5VL0z2yRn;
	Sat, 04 Jul 2026 19:10:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783156229;
	cv=none; b=o2KNyyWKLN9Nvk9NHIrB0ppf96aqfnwx0OKZPFbaqMLSIZoaObMzDsNwQ8XqHA/s/wgc6G5871KB7gVfsGkJkZ/IvlbV2UVv6c/p1QrS3gxUyMJ3TwT9QNMTz1RwT68/0RO4L+sCcC3d3jB/Mh6ym87ld0WUpSXA05Dn21NLWTicPwslI13A6k38xaeC3fsQtn2qu2TvMHaK3nP6NJt5jTGPGIyOratf3hipfXotK4sXmBvR9VmbpWXORKI57NElOiELFIbUoyh7iK+DNYWKVdMRzbBSPIjCOWdeYv7WicmnhS1zm1dXipft9wLSk5BpovJjMQwCEmvh5RlAFQeZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783156229; c=relaxed/relaxed;
	bh=53EQLw8XTEKafDGHQxdckYh+PN5Z8cHEu1Ax3kBjkYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWPL1aAMnKjPdmZdTLvhlrcPHDXm47NM7z/CueB0cYZpFgC5GM6dlMsXBBxXwOftwV6HKZKjiXOnKAszrJ0C9LDmo2MUoAqIVaCDKAAGETSFEauW/LGE9d85yWYjj4QgKPA2wEuT7nzOJK3fnPqKTJ+6T5Do8zjTTw5fI98Ypmw5/ELLJchI2A+loUJ4wy7F4Ri+hWuuKBY4Tw784VGkxCbQa+00riv8mfDGxSybVLirP40Rq18YwBoGC7Hos6vFxM4GlXNpRbD563XK1nOZNlj6fVW79IuRpazXGkWu0NZrvR6Y6oCapBJIqLJ9hpm3bjs0XQDlrVgmnoa+kSUUlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpKZ4WvB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpKZ4WvB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gslFs05G4z2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 19:10:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B64540AF3;
	Sat,  4 Jul 2026 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8563F1F000E9;
	Sat,  4 Jul 2026 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783156222;
	bh=53EQLw8XTEKafDGHQxdckYh+PN5Z8cHEu1Ax3kBjkYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mpKZ4WvB1LGdTw/vgASBVUBuaZlEfZeN8b1CQ7ChT63YY4UYXNWKcpSMS9vf/g560
	 G1v3sXJYYcunL1fwyBgAKYbKwgnLjSgxwOUUbpklJR7dcnhkYjW8981fYk0HLz4gYC
	 3jbApuPrxjc0EZRJt3+gfakE7mVV2KK13kI1IflqOwlz7WggXSDdQgwelGykLer7v0
	 mvl7pn7UbBhOFT61LgMujJzotLp6bVAmJDNNTLSikTXunU8Z3EHu7nFtlJ4yBuoOgu
	 CrMbCze98EfT0Yujmu4S+XRb42FQkUOxT3Ror6libgvFbNa/bJTJ5x+i7kZcBWRdpA
	 YZH09UM8bRpkg==
Message-ID: <dbd95f4c-cef3-4f7f-8619-375fe37c8852@kernel.org>
Date: Sat, 4 Jul 2026 11:10:18 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/bus/fsl-mc: Use strscpy() to copy strings
 into arrays
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260608095500.2567-1-david.laight.linux@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260608095500.2567-1-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/06/2026 à 11:54, david.laight.linux@gmail.com a écrit :
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Do you expect this patch to go via individual trees or will you apply 
them all together in a given tree ?

Ioana, as usual I can take it via soc/fsl/ with your Ack.

Christophe

> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 221146e4860b..372175fe169c 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -903,7 +903,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
>   	int state, err;
>   
>   	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
> -	strcpy(endpoint1.type, mc_dev->obj_desc.type);
> +	strscpy(endpoint1.type, mc_dev->obj_desc.type);
>   	endpoint1.id = mc_dev->obj_desc.id;
>   	endpoint1.if_id = if_id;
>   
> @@ -920,7 +920,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
>   		return ERR_PTR(err);
>   	}
>   
> -	strcpy(endpoint_desc.type, endpoint2.type);
> +	strscpy(endpoint_desc.type, endpoint2.type);
>   	endpoint_desc.id = endpoint2.id;
>   	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
>   	if (endpoint)


