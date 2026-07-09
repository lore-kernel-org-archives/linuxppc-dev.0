Return-Path: <linuxppc-dev+bounces-23905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C559C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:04:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwmDf6gffz3byj;
	Thu, 09 Jul 2026 17:04:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783580690;
	cv=none; b=Gn17DifSBvFPUBpwc8xeMmTw9Juv22u+QxO7gBLcnJdvVsuX18/2P55kZ1Ed8O1n3G4oolSoZA6U5LKfpO/L6ezB3hUhWEWrUSrumkpzym1qjyETkBktQKP5hYhh56tQ4n0tJuT9eYJEAlmDviZt0o9rKKYZqf9OXMNBCIEqp4QezLZqIKfTn3cIZ/px8GGK+tdAgWhKeaW1XFpJf+NXDZkAlVs81ry47UAV5wzsguDITVRYKFcZEURMnGToRKY3FlSnm/W97iUA7w5E5fXawmrbqGybEfhYgoA8BWuQEouj53YgwL8odEGYpdlRcNpzGiZOEJRS6quUtFD/kJMCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783580690; c=relaxed/relaxed;
	bh=RojLPltz8DwvvSu0nWycaSfVOIfQRK6RQOm7qxh34pM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=j8cdSEb//Avz0aNo+5ld97i9lgBLdcVqIIX6qutDLMn3vEecd11/lO4S+HQvYnqS01dfIKHPhMQ3ObB4fgZTDOsHKhJZOFKJZ84NmlCLvmpRgJzsGamp3ey06McEA1uVfD8nfei8cYt8k0rsxD9dzgWLGmp4Hi/XFFUtKeQ9IX3gi8xW53vHFuYIHErd2af3ApQGle0ahPekZZKbGVeNnuFyvrg7KaKP9TI/vtKymqt76SJEWBFt0S+/ST3+02PNfm/DPcpQ9gUGTgrp29T3GykV7FG0clpf6OEPRCrWD+52K1745VMFaJoTfBAIhrRF6MzPphQAPn8VGYYCihxtqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecFuXsXn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecFuXsXn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwmDd5PVdz3byh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:04:49 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-ca7c1176317so840908a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783580687; x=1784185487; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RojLPltz8DwvvSu0nWycaSfVOIfQRK6RQOm7qxh34pM=;
        b=ecFuXsXnfos3UVN555rjhaedOmgiV97xXzVQwDNdRZ2xOoBCbor9CzLJYQSjjskPfV
         LqE/Qoi1VRwLu41Y0TRsutdzdwyqVjm809soD9EQJUN4Bxt+W/p0522ubSOioLkhBGBr
         UTICZXNOMhK0k7Aw5veAZp2F7H1hiGqiwqb5wuDG1L5CsNgGtDCIOxsth7eTS6JvgNeP
         v8MAdBzTLvR2c+JErR8MFVR6W/AMAhmMn1owJfslZIPn4n+7lfkXzqkGDNORxFkQQHNi
         HcATYTF2jfPgyEgAUuFK6Td93x9mtQDV34q0EoyrjnSKVyECZfwctZWjrFx1QLtL+nmo
         gh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783580687; x=1784185487;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RojLPltz8DwvvSu0nWycaSfVOIfQRK6RQOm7qxh34pM=;
        b=OjIMGLN3WLEiUMCHCqlgS2zW4fVvp0jK5JeYda7qWY/QVXj/e9cab61n4mMXS/dBvt
         SAV4CeOs1oNop583CCKiF6pSHgoG2ifqsHU0mz/2wjrir9vJT8jU1pxT+duNCvKqzYX/
         smTY6SoF0TT+WiPt+Ehn/A7eCC8GabTA04McxDLcMm1fuvoNez/R+iA80Bd9dPRpEpv3
         dp35ajDWqmu9qgm/Xfd44NsyTcgpYNDw82Pun21d4dvNzjrMEb1NZxMNiOd9oMkTr0Ux
         QSqOxUox5Jc2/L0v7fo8ypNpCqnHyU2I7wzOlkPwJIf72B9FPKu4w/LPLALjI6D3XVNV
         87iQ==
X-Forwarded-Encrypted: i=1; AHgh+RopKPiw8qJD9mggWkKBLSvignE6L1/kVEOczJseuypW5f4apOCq0xWZEdxQ+6nDV512GS7dAb8UmBXNbwI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFc0OIXIYqf4qZlQiCixIF6pijXQVJxFV2GLZtpVb107er2MQX
	eyDOaB5IBBjZd5UhmIugmYQwS6vMbdKcjEYaSR2dN0bMFLFGmA6mHKBk
X-Gm-Gg: AfdE7cnnQqAb2oapBdFxOtnIE1sJTipOlYbqBkrWau+zmIMiQl9EAUrAgjVOpHEtCiV
	QcICdyYk0Lz6tqmlSFHucrLMAYl6BFZ8LbpycjKRcBdyUB3QABwIG96PnNVasSECwLgdxmgO9E3
	KjOlqtTgdNhEpabOXdDGA3CjScILijHKDbmbEFaO7eSdkvDGNH6k44aq23nzEwppbZ4jAziMnxZ
	Oe0eAKSVzvCDHgUOjARjDe26ICCpPFNVimt/2gJJyvMNU4vSxuZIV4p69S2kDgwwbiZzfU038Ph
	kDbGPxunxRpJWxhOkXagT9KKkqYEPiXPLsDCYmAmvpH5h2hrtr7HDnQZTOkVh6S/mjSoHPl1DB2
	hu2IAQdnbiyvGETUElyivH/soukPIEUK3GtzkmyP1i2D22vQxJ/1wAMOHOUyJ+yYlh3HvsAHNsS
	iKIZJE5k4Nfq8=
X-Received: by 2002:a05:6a20:d529:b0:3b4:85db:1bed with SMTP id adf61e73a8af0-3c0bcbc5c42mr6970115637.45.1783580687320;
        Thu, 09 Jul 2026 00:04:47 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm31951861c88.8.2026.07.09.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:04:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Salman Farooq <salman.farooq3310@gmail.com>, maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Salman Farooq <salman.farooq3310@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
In-Reply-To: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
Date: Thu, 09 Jul 2026 12:31:04 +0530
Message-ID: <8q7kwssv.ritesh.list@gmail.com>
References: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
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

Salman Farooq <salman.farooq3310@gmail.com> writes:

> Fix two instances of a misspelled word in comments.
>

Not sure what this will really get us and what is our maintainer take on
such spelling mistake fixes. I definitely hope we won't churn out a lot
of patches just to fix simple spell mistakes.
But FWIW, the change looks good to me, so:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Salman Farooq <salman.farooq3310@gmail.com>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 5fbb95d90e99..6ac8364a7639 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -163,7 +163,7 @@ static DEFINE_SPINLOCK(kvmppc_uvmem_bitmap_lock);
>   *  All its GFNs are moved to Normal-GFNs.
>   *
>   *  UV_TERMINATE transitions the secure-VM back to normal-VM. All
> - *  the secure-GFN and shared-GFNs are tranistioned to normal-GFN
> + *  the secure-GFN and shared-GFNs are transitioned to normal-GFN
>   *  Note: The contents of the normal-GFN is undefined at this point.
>   *
>   * GFN state implementation:
> @@ -1010,7 +1010,7 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
>  /*
>   * Release the device PFN back to the pool
>   *
> - * Gets called when secure GFN tranistions from a secure-PFN
> + * Gets called when secure GFN transitions from a secure-PFN
>   * to a normal PFN during H_SVM_PAGE_OUT.
>   * Gets called with kvm->arch.uvmem_lock held.
>   */
> -- 
> 2.55.0

