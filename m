Return-Path: <linuxppc-dev+bounces-18759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0992FEA806
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 04:06:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgYJ96wTXz2yTK;
	Wed, 25 Mar 2026 15:06:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774411609;
	cv=none; b=Bx85XgWLbmwCsZkMD1ynWc2cWl4+zOqOBX2wSzZ/GR7ragHF6Mfm8S8ZDd8znVZe53TAXh6dur3duMo7uEAN5KP9F19nQUYY9SQF60b2c/vSTaYrXMviJMM57FAsWNkK4NKNqF2Y3TzGI1pheofnL0iTZwRhq7ohlbxyjoFmhj0f3jz+WL2Iuw2FWXDZDAqBkhxcO+7vK3W5jDE7lV+9o/NIzoPr9yUPlQGlMcxBFe4OIIbp9YKKmYD0XoGmnQ4vIXwnqWY2oe0bkQ3CcA3HsFXofaWtaaAhVW4KZmNrDAG6Se0AZ6QjeHOJIVpKUqCFe5StIC+99a90E00mh8Pj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774411609; c=relaxed/relaxed;
	bh=oikZdq+IKhmOORXBWkEbQjmrrU1iP/ab33eIDNTFj58=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U+8oovVj9QpqutTVuIfOrpIAS500mLHJwTiorFV4dtehyuLX15fH8VyyFBiSfczWMtJXs9FOe9SdZizmNDC1vSTYMwBP5MAXWW2vJRVZnIO0lzRi2bhLsvnbkvB0t6axhqQ7EjRiG+vw1i0cdnrlVoHo4qvDaAvwdZfkRrcRjylkDcOtMQMXeLFxOvmlx+iZ5/1eRZS32QoOK9g/JLTTdmhoRgxkDIkZQI2K0yawfLRHwv2qGuRPGLZmg1+Gbp4WvnWj+g6SpSFJvPkN9aZrCzv30qydEv0ALvCeUWHiXFT8LjLEhRB/fhXkLnAZIllzkeTawgaDMIx1Po5NTZmCcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=PfDGsqsk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=PfDGsqsk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgYJ8617lz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 15:06:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E84BA4443D;
	Wed, 25 Mar 2026 04:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34CCC2BCB2;
	Wed, 25 Mar 2026 04:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774411604;
	bh=WsAQHOogDYWxLt316VoEo1PFk4jzaM4l6YS9sGhWqrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PfDGsqskD39pLcCQXbYS2QFRFghCe4BEZzYtdfA21xdxwIIR4FoeGIkM064eBeWyY
	 D40CifymkJxTpCyEpPpnuoQ9OggtlKZBCPGL6v20TO0xKp5+AhL5+CF3V7RgF7HOF0
	 NjgD1tu5pmsYOFLipjeAqvBHsr0IFVKdBckI3XFk=
Date: Tue, 24 Mar 2026 21:06:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/3] kdump: Enable LUKS-encrypted dump target support
 in ARM64 and PowerPC
Message-Id: <20260324210644.28f6cf77a26dfadcc4b642e7@linux-foundation.org>
In-Reply-To: <20260225060347.718905-1-coxu@redhat.com>
References: <20260225060347.718905-1-coxu@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 14:03:43 +0800 Coiby Xu <coxu@redhat.com> wrote:

> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
> device dump target by addressing two challenges [1],
>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>    machines, a system administrator may not have a chance to enter the
>    password to decrypt the device in kdump initramfs after the 1st kernel
>    crashes
> 
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserved
>    for kdump.
> 
> To also enable this feature for ARM64 and PowerPC, we need to add a
> device tree property dmcryptkeys [2] as similar to elfcorehdr to pass
> the memory address of the stored info of dm-crypt keys to the kdump
> kernel.

We don't have any ack/review tags for this series.  Could someone
please help out?


