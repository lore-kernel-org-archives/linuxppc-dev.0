Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B0C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 04:48:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447022081C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 04:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ZjUXK/oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447022081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4354m50SGDzDqST
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:48:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="ZjUXK/oN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="ZjUXK/oN"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4354hx4vr4zDqSx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 15:45:53 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id k8so374392pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 20:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Q7yzQcl4uXUktSBFD2YAQSDIZDj1q6vLBVJN9fVJr1s=;
 b=ZjUXK/oNAErFwOIaiFEhFUsIi7UM/BAxYjXdHIwAk0jRRfGsw7Wry/njXb+BNX73sE
 28WanaDJwT+MuF9dYV21j6coahUVzustifpSlYwfkpuMnrnpY6VRatQAGBSzy0NsirGx
 3PwG0ojsmVcWN5LyAqlcJgnv7lGKCXAYy8kD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Q7yzQcl4uXUktSBFD2YAQSDIZDj1q6vLBVJN9fVJr1s=;
 b=YQ35mI1fw9ccaD8MjQWqg3CXH5VqPK1isp28r1mO3rDzdWNzyaYzA0ew1ECjK9/wdn
 hEsWhGHomEuDaumqzT7kGaajJiWH1YNF/wWY/3ea5iwuVf/U07yvYGgskAUEs9K0rFxy
 JzbhEqo71CzH/GHd9T9hrQiKQm36woD9jmRtjssSbIW+Q/2Eq8KUoswVZKZIjC5JmiQj
 X5OhBiC7oSXxOq9J/rNqYopUwMu1fZcccF1lE8xJ79HoM/jY1FsKaqYf/3bJJRt5PAR8
 wsfAagGSs5P8hiGeA0EkBd0qsiVNxgP3FLf3pngNGGAOeLdj8S+gSRm1kU8/evk5Iqhb
 MHJQ==
X-Gm-Message-State: AA+aEWaUtxGBn3FAnZs6TYBNg4RXtZw0DEzmBx5zPSSkyikPpbti60TJ
 a7A1ROn2CDVE009DqDrekDDZ7tYdFYU=
X-Google-Smtp-Source: AFSGD/VQZJssbE8BAzg8ObOEjIxXvIqRZumB0RLSBSqVOTOUksqIzfVs8CaynhN4faTwkQSsP/nrBA==
X-Received: by 2002:a17:902:8a91:: with SMTP id
 p17mr26589plo.316.1543466750936; 
 Wed, 28 Nov 2018 20:45:50 -0800 (PST)
Received: from localhost (114-198-118-47.dyn.iinet.net.au. [114.198.118.47])
 by smtp.gmail.com with ESMTPSA id p83sm1213631pfi.85.2018.11.28.20.45.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 28 Nov 2018 20:45:49 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/boot: Copy serial.c in Makefile
In-Reply-To: <20181128043417.24784-1-dja@axtens.net>
References: <20181128043417.24784-1-dja@axtens.net>
Date: Thu, 29 Nov 2018 15:45:46 +1100
Message-ID: <87woow7apx.fsf@linkitivity.dja.id.au>
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
Cc: Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Right, so as both 0-day and snowpatch tell me, this patch is wrong.

It turns out that this:
>  $(obj)/serial.c: $(obj)/autoconf.h
> +	$(Q)cp $< $@
is identical to:
cp arch/powerpc/boot/autoconf.h arch/powerpc/boot/serial.c

(Clearly my make mastery is inadequate.)

Amusingly this which works for my 64e uImage but obviously not for
anything that actually needs code from serial.c.

Further analysis suggests that making with -j1 triggers the issue, but
everything works with -j2 and above. That would make sense with the
timeline of when I discovered the issue because I changed my build
script to not build in parallel.

Regards,
Daniel


