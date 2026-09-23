Return-Path: <linuxppc-dev+bounces-27976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F48EC982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqSYW3rlfz2xs1;
	Wed, 23 Sep 2026 17:01:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790146879;
	cv=none; b=jDm7+WFbriYaaKoAMPcNfwbc9bpQcFPxWoJGFt6jJkMBDV67nhlVHOaTWCZl4MTc3b+fkmq9BNgAiXKghTQ6v6KKC6RUDbdKiRuDMDz10UPqUVhQfhnhvA2P9r8OLRYNMfAXGX0ittUkVIfMqSEDm/EnMXF3S0+Z1EYVAJBMjap3uIQgYkDwkZZ18hrTZ+3bP0FF5uXpxUnPxGBx4mqQx3taPD2wfFHsXr8/RGgjfRyCRYRetQAnJdHAYAG9JGSmUzRakDzE7HryBPwWrIhABMuFiNFia6Fvy+dhBEDcvgv9OrSWlmHR6JvbcHS72x5zhwclN31VrN0Q+Y8tcz8+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790146879; c=relaxed/relaxed;
	bh=I70/VAGdGqE8d4iO1uNSWkA0vYBN0PWe+5KOdFzj+lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec0ZOBVjCT1IINKJKXZ3gTMj7ZSFsyzvmpksqz+3YVkvyTEHfOXbG53/QV/Y0KuacfMBl37y7Ohaf9JG7VNj42Qo1lIsavNq68OzGw1KoLCnVIotWkQbj1633n9Ry/YPFtlfO5tEZSOmtPHq9M25UINp4LTY9AO4gQJ4COm2bbwah88ec8nQ63zufhEcpsOPOsO4evoTNUKm1JJsrEIMvOVbQtWpKE0vA03/M+QKCQC33wKTE1t9mgTx0SlvE2HjyVkGVr4vNCHjsHZK+kSl3oYtr7idRJlEARleE3q/VT9w5Px+Iu8VdmGuzHHTrLzKvirCJNrmyNY1yYPi5v5dFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iMBbTZ1Y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::10; helo=mail-dl2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iMBbTZ1Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::10; helo=mail-dl2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x10.google.com (mail-dl2-x10.google.com [IPv6:2607:f8b0:4864:38::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqSYT6sNyz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 17:01:16 +1000 (AEST)
Received: by mail-dl2-x10.google.com with SMTP id a92af1059eb24-142dd04be84so651809c88.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790146874; x=1790751674; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I70/VAGdGqE8d4iO1uNSWkA0vYBN0PWe+5KOdFzj+lU=;
        b=iMBbTZ1YYkZDsAjCqGL469PLIKEunhsFeDzRrGuRzuA7cbq+/EoiHNUqFqO+34+Q+U
         danrDajwIDaY6t2hIF0mn0HU0vMtHIpQ6fe0epuNBIUmeZMbrTgErFkS5lfyn51NN/SJ
         o2dlQnzcFwPNmM7GCs1FspCoxCndLg9fvW7PztnxN9lUnolpb6ceA7YNRuEfAUnU7bSd
         o85wy6z68XacyXIqkQyenynxVEzBcN8e78CJj8kSHq6mxHeB3c0/qVkztT7ogRayopmo
         KOS8JRr+38MSTpy0i90qyMru1BAjbph6gr9JdIhmgkvdw8OOhg6pdekYta6fUWLaQt2j
         vnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790146874; x=1790751674;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I70/VAGdGqE8d4iO1uNSWkA0vYBN0PWe+5KOdFzj+lU=;
        b=2VElgVEbCaH6r++fc7S+U32uzGQfnuQ530fHqeb1tHgD52OWtIfih49d28Lt162WDv
         wD7XTjmWiSUMUQo9+pgoODBzJCkHaPOZlbwkgtwb4AlIOTqFqv6QAHS3jhe5ZZ30KB9e
         q01MUH+AxY0aW3EqFNicLj63/AVRi/+Y8oObUgUjavjREFO1CCgEF93XluwYDPFcw7hU
         w3HDgA3YRSx3817MM1OUYhD/dJDn0/CEqocx6miUnupuw9MYveenuj+6EJAEaJs4mKiY
         /FT1ln/5Ac2FQ32GYOOsMHn/C57qEetdU12nWRUclL+5As5IzC5mF1bNPxmpjPEmygIa
         +BXg==
X-Forwarded-Encrypted: i=1; AKwUvBw6NeyNQr4Ul0UgPbb2yF8G1bfwGaEMbDea03epIplLHYcaIDdejouKnOtYpvTDMuruD3lWMiorpWriduY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lRlMT2qLw2yRo3fR0z/DBfh79qRu2FtAglQytxF5ouKnCxg4a5
	75ZkhzTx0AVgEYImw/J7358iFB4YrGwX+DT6BFlMe5OvmgguZC8bLZwN
X-Gm-Gg: AYBFou2TI3gIiNvxhTmMcGiIplcveIPK7SWVuvZeIIjv3ZHzbY9QN2Gk1roxQ93G8kO
	4jLZpaVeVAftb+3guSqeABOPiDwqQ8dHfnoaqsGvW6D36YxtTkxSn0Du4voHT6H9a+iW9/IyWgt
	xdJDOI0lZYn4ewRdjDCGuigXU1vFRH3mYIySCdQXxdmCdIqxeoeMMh0SiWcbFAYQOfbLiXL9A4P
	j4PlWH2vfkHHSfs0mDXZdO41ucesITlWYDbcR666Stt0IjWA8lR0+nu6Y0aj9gkazMTE5aZ5OZl
	ICvqyKze23t8rkok7qqlFgvp5l/rf06YQ1EOReUBGRS6x+wuSbqeI8EjuyWNvExC7Fvmhz8Ny0Q
	5uEtTr+JN0UKl14VtdCj5CmFndBa7zXWj8qBuHB5Eojx63x9MJk3G+LQzaSTg+arbj926LJUzDq
	ssiRdoFmouVHqg/tOv5LNq/7AWvM8JeMbNvITb6aGKYV6XDEK1yKbCg4T9Hc3ApYQm9NB1WFzRO
	oCYIRHUeSYT/6ebq86+xKGeuMlcZjfFqX6hP9nEXHo=
X-Received: by 2002:a05:7022:7e81:b0:144:ddf7:256e with SMTP id a92af1059eb24-144f9179543mr2364369c88.29.1790146873779;
        Wed, 23 Sep 2026 00:01:13 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98209ffsm3646819c88.4.2026.09.23.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:01:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:31:05 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <arN5AY73k0fRh9VQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
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
In-Reply-To: <20260921111043.49825-1-gautam@linux.ibm.com>

On Mon, Sep 21, 2026 at 04:40:42PM +0530, Gautam Menghani wrote:
> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
> 
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
> 
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
> 
> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> available (currently in case of KVM on PowerNV only), as the XIVE hardware
> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> functionality is not required. This reduces the number of spurious
> interrupts drastically.
Hey Gautam,

Thanks for this. Can you also share the numbers after the change.

Regards,
Mukesh
[...]

