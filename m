Return-Path: <linuxppc-dev+bounces-19107-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A330210F92E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 16:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flYBp25bPz2ygh;
	Wed, 01 Apr 2026 03:16:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774973762;
	cv=none; b=b8ulLYDoD2JTpl1CdOFJfyJDuY0zfnom8/ZRv31Ai7G099J9f2bcivGkQGN1TuqHXFOzdPOzIFZ9c5G4Fnq6kie+vVvmhTlKm4c/OWhnBkRtFoFIvA8jg4r7S59GQ9eiIcSH/b03CvNyuP3dWjm6ZN30B4qmxaDyIZUOmtq6uGUrjQqqK0hLhtpfgmjFnFDST03TQVrwzWi0YoAUxe1MYUOL+pelMDbVQL4GEHnESMwsQsetuyOZdXuPqWi+gKaCjftoRV5DIIPKMA0IISI6kylm2mo/c9iLKxuWUy2G6g/iuVy8gHqP0rqdxshu7jE26tFMMEyUe/n7dp/LWgd4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774973762; c=relaxed/relaxed;
	bh=rZBhlRLYU65z72BBEjtivUZpgR4C0BvXMtceQv6bjFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1isfBgjuPUwzImVdXojzTRqx0W5Ype0DCsnbvCAKdn7rPRKlTfBBvI/YOfGaV/5Hrj0NjAirUGFzX0YardQWM2DHXoRCu2uxzL5Eg7bEwBhxMxX87qcQ+MypvVPut2/szmbOlSgYrt7wFfLGFvbC4RGkS42u1Rc8bwaMwiTnlpgowjiWQdxTShJxolN17+zXgKa8tQFZHGhJ4TWRiDkZPgQNdfrqoNJur2o+pnLiNcaE19mNTWvs1/SNoBcVi0Bq5aw7CMFP13ZULKSJinJ4gLc1WCDIBB8s9B86BDsChKLiqMRwmo3HeUGNUuBYI6FBW/KmdFuOW1YJkNE4S/G5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XmhRws/z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XmhRws/z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com [IPv6:2607:f8b0:4864:20::122e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flYBn1Kt2z2ygf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 03:16:00 +1100 (AEDT)
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1271195d2a7so4254702c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973757; x=1775578557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZBhlRLYU65z72BBEjtivUZpgR4C0BvXMtceQv6bjFA=;
        b=XmhRws/z/OqMDrJO+lyPu+ZJbkzx4T2CKqxe85+EU7NUOySJgCd4NcF+VT/Mu0RqeR
         s8V5IvKFQsww5+UEjKoDGQvgxUfOsV9SFBRNNHtOM83McA9jH7mt/XHVCX3WfE1Ern3E
         JKXs+4TAr16iJN5VpbacJEMFp9KJmoGN/qDHHCFOuoIO+cSbyXxyrIsWJkgbRN1rYonw
         kjLjcwRtLgMDjRZ6G7hQYDwb0WigIT2/j8gzXs2SNkp21ntZMmuXTgaf56EbVeOAd0IX
         QoKtcFkPp5BKIrAzBzM6II0uukP58HbliHmfbYUZ/8cLHHL9AE8L7v0HbyXC77LVAx/F
         XSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973757; x=1775578557;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZBhlRLYU65z72BBEjtivUZpgR4C0BvXMtceQv6bjFA=;
        b=cdTwtqSQgcwSmlxfUPh6kgKkbCaibL9cjz0fX2MJWG78xVKQYspnEeds/PmM4epGk+
         lVcDL1cc30SsB+9nMi6mnf82E6Z3Tc8PooE8G92WE6E3Lu09aZNzoyoBwU19rZwfDnAU
         1qCvapXqnzv77jSYVX65glz+qCTFo/1eBoVVz9KQqY87rNNvojommmu6aQoVMFUUeZ4z
         gi15GeHVjucr/jT1HYqX49KFmYEvfKBrfP/Ji67lPRZ0t269+BNI81ipxeZWRdL0LAdQ
         KV2n2szLW9U1xCcBoQWyRY+lYfuf7f9Q3+VUSEGFWMI8Ce+VqjB4pH9Xuh5+V79npfwH
         8ZCg==
X-Forwarded-Encrypted: i=1; AJvYcCVdtFDZ1UdGAU7VPBIaqnxL5rPbiV6hv8LSREjO3eVLIP50inSYqJj+suIU5+0A+4Zd1h8CiG8AIFl26tY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7mV7q6SLKAMB2T6KHme7oYaL8hwIecqf9HUNbeeVii2PU10Ql
	3tXwdMuqhJh6cXjjn1iVhjFahOoQbfVgp9WpfoyRM9p/LNnk3xe5+Vys
X-Gm-Gg: ATEYQzy3xC76o8McJa5oXaUx/c6CbtrkGnwzJ+RMwpqqqQFxwm5ulBwd4GQRTxwuHyf
	Y/zfx08DDEBV2k+mkMj9Au4+dSOeLm+ontGCvRJnfipvAcH1/Q3aaYk/FSnl4Kjt9CId7pZy0yh
	s0hUVOres2Xg4APQp9BaTLg48kk85hQPndwQ0ngiQpyOPiXCvHinSgrjwQFImf2KPSZyYwvvKxN
	8p39MM+UHDZOFWyx6qPpA2M2NxaG/WoBu2JVWD9HOhLug8rNpNBKyFPNesuxlduHe5opt7MBNyS
	LkkfQCymOXDNO8/EeKcuuwmQpWSpEaL250WtnlZvm24NuW8ybQvyyc/juD9KHlBwHiv5e4N7Wy+
	08zN1lnNrOf7F0YWWackFC7Ri3kueScdIx0LYDZ9EZzkZtncxmmOcC+xQz/ICAXJeHyGYrRqtxi
	oh+D4OJ5vQnn+Tea0byKybrdwf/+nygJIk9AXr0eT7sQc/hdfOGtGoKvSbenMESeNpFgNIiYgzp
	MGv
X-Received: by 2002:a05:7022:e19:b0:12a:68cc:3efb with SMTP id a92af1059eb24-12be643856fmr66976c88.16.1774973756726;
        Tue, 31 Mar 2026 09:15:56 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-218.user3p.v-tal.net.br. [177.4.161.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm11494127c88.0.2026.03.31.09.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 09:15:56 -0700 (PDT)
Message-ID: <a5537802-ca5d-417d-9fb4-18e0b0d21467@gmail.com>
Date: Tue, 31 Mar 2026 13:15:51 -0300
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
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
 <878qb8rs48.wl-tiwai@suse.de>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <878qb8rs48.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/26 11:27, Takashi Iwai wrote:
> Do we need to clear the active flag here?  It must have been cleared
> by hw_params call.  Or is it the case for errors?

Yes, that assignment was meant for the error / re-prepare case.

For the normal reconfiguration path, hw_params() already clears
pi->active.

My intent there was to avoid carrying over a previously successful
prepared state if prepare() is called again without a preceding
hw_params(), and that new prepare() attempt fails before completion.

That said, I can drop the clear at the beginning of
i2sbus_pcm_prepare() and keep the state reset in hw_params() and
hw_free(), since that is sufficient for the stale-state issue this
patch is addressing.

What you think?

-- 
Thanks,
Cássio


