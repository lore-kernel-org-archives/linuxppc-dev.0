Return-Path: <linuxppc-dev+bounces-18766-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51148FEA83B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:32:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fghWQ0LGSz2y7r;
	Wed, 25 Mar 2026 20:32:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774431121;
	cv=none; b=HRYQ1JEo9QMpZ5gMGCB/MXRxESMfPZWvo69/NvykfSbdIAthlCFAsd7+PztuNYXFJfIyd/eN7+Lt5ZkDFBaVQ+imjLzuA2P8wMUWPRBX+Nma4z85RVQ6j+wmsLIHLmwH203RrPKjCzUqrG8GHO4FLRcC5H5CWCbVWulczI2AC3QLNLRxyEtL5YMdTIAH6neAsgouWBwAtuYFRqlDpWHJukIJxfB8AxTgHdgpFgVp2rSQ/VIN2VsYLiLWpCsa1poe1ppBWO9xPKQUI95JhA9tYys+gcdK/SZFHsTwOReYuT1Sc/cgAK2XXl6fglWRZhGnyGsW8O+DsmoUcssYFapIog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774431121; c=relaxed/relaxed;
	bh=TF/+cxtFW65/t3CsODFg6Eg+Msha9EyFtJo/8aQf58o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=FpqCCaZ4fhnk3glOJwOqJq7Nsdjs70JCniW4nhJS9YHKp4wGfJzsCfs/7wz0LVjzmhnCj/qWnbbk63whOtH3eU2Wj9Jg0mhMsqpjD5xK+T5R2VFRXzGAKARAEqQv76OCFPrkJkjznPUckYoxf/xUmHNqY6YAqbCMk3Rxie+iCBrnCJMMwtwJ/eQmCvVeEQojPuRKvfOKswcSIRaHnrol4QVAAj/82moS/DCgQ3h+app4GjDC+PUyyp/M2jOKtzElq/LRXJ53DuJHxy9AhVrnnDFtqh9lY+TMe0NTzo6eSpeakivRIVIKQEitcV/FAlELVQhcXgHQ8BSE0PsaeaSdtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TiFEigAE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TiFEigAE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fghWN3bZ4z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 20:32:00 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35c124d2613so223255a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774431117; x=1775035917; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TF/+cxtFW65/t3CsODFg6Eg+Msha9EyFtJo/8aQf58o=;
        b=TiFEigAEktPNb6o/AVn6Ral+rLqLCRWumaE9ZKvbb7qSvjdv5GYg8i3rV3PqwRWUdv
         SfPTqiYMoNuz7f7i1RpNg16uLLDJo+1Px83bEzfxv3hWmsHqYLP9qm0e2eZqQnX4wu8c
         rLj61DU7dSik5VVzQWO6/S3qbx4zMPWPjRvyx5N9GG3+SS80kVdw7YkkcaLdQyvlfvkk
         HQrKdQCZtLCb6WHw6GYStLWlGnzRPI9f/oMlOSV/KQ22cCB0kxQZ706BUqr9XFrhePEO
         KNVbKwRm62K2Dxio1NBeJqqnju3j1D0p2SfQrtiRgbEX3yBXRAmJ6Q7e2fKjmF3dtRg+
         dWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774431117; x=1775035917;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TF/+cxtFW65/t3CsODFg6Eg+Msha9EyFtJo/8aQf58o=;
        b=Ia/XqY7o5rOjkUxMebys2n3ll9dhzvxXXEFJupcImvdYuno/GAClof5RmjzihFq6kD
         ZaoPAUQgKJs7p25w24+8E9F56b9enZN3tKZ+OBDbwah8f8WaWQA49WHL2mWUhWJBBWQx
         tW+Qlo4HMnNyah5V6wsSZpOAZgge90f4HjPFUkdigZq+tAstNXTClTUyq5/391iJyKYW
         Iar3jE66/Ob3apw3rPA1lSJ+NHjU6jSyXKqEGYIDirpv9J9rGfWZxgngl3f7XbtvzxAf
         g5hYJrPqNWnb5MXbUlbF1e7Mne+uIA6H8PKq6t/noWNOw9PCkHemOmStIURwQ4L/7ymZ
         13qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0LIfM/tTtFW1F2nAJU6RaFZNsbcd4b3PPwTi22DIQizzKd+MiCoyuurGCXgnuXxvrm1HhXMypie7AWnk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOXd+6r9vYSNzuqncWHFUYtV5yEu1Ju+Rr8MsL3QnqwTO0jUxc
	xf69EjFtt9gws5wm4qsAZ4shgmcR+hsXW700SWk1CnG8sn+OObtyMonV
X-Gm-Gg: ATEYQzxqhooCrhLtKTUU8PTV6RquKYkDIbTaLXkTOtMnArbRQUCNxyBnjrIGHX19J0D
	LlAbiltXqYj7vYRV2+pCm972iWiQlcgu55wPAIoV0hBtK3/fY8SJ6GXa0z11QJmDVmLNsLDW+yg
	HGgneIN8Xsbuq0YU0zpz7Yk78KYEUkT07RiWBkMOuKSozgJ89npQs0ZTSyes7M1Cdx1WlHpzLGi
	EqMXUNJJlkaWNRhO4rUCPnDs6US4/+OmPNgXHWxlpu4p2sxhQUAY2EHQ4q289OqFg3FTI6Z1eKN
	nUjjEBlSUwaZbXhwCciJ6W/q7rlynb1LACD4fBdJ+F2xjBi68lPxdWBvfZGAypmV7OJPMI+lf8g
	FSMxqh2nPtpo7WTYI46eXCOBn8NXAP7MxDDELVUyIsR8uKAOubXfuvIQtP6Jflj3rlAlXDpMkKm
	Lq9h5h8wZ0+/res63qVcA0wUNxT1dmKxDi
X-Received: by 2002:a17:903:37cf:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2b0b0a48b14mr30087295ad.23.1774431117028;
        Wed, 25 Mar 2026 02:31:57 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0b0129905sm25660755ad.27.2026.03.25.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:31:56 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, nathan@kernel.org, nsc@kernel.org, ojeda@kernel.org, masahiroy@kernel.org, linux@weissschuh.net, tamird@kernel.org, rostedt@goodmis.org, ihor.solodrai@linux.dev, maddy@linux.ibm.com, peterz@infradead.org
Subject: Re: [PATCH v2] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable warning
In-Reply-To: <e6db8617-6b12-4f90-967d-85c9f7805823@kernel.org>
Date: Wed, 25 Mar 2026 14:34:04 +0530
Message-ID: <7br0nuuz.ritesh.list@gmail.com>
References: <20260323073220.25798-1-venkat88@linux.ibm.com> <e6db8617-6b12-4f90-967d-85c9f7805823@kernel.org>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 23/03/2026 à 08:32, Venkat Rao Bagalkote a écrit :
>> v2:
>>    - Added missing Suggested-by tag from Ritesh Harjani (IBM)
>> 
>
> Patch history must go _after_ the --- below, otherwise it will appear in 
> the commit message when applied, which is pointless.
>
>> drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
>> used. This results in a compiler warning on linux-next builds:
>
> It is probably not only linux-next builds, I think the problem exists 
> since 20e07af71f34 ("powerpc: Adopt nvram module for PPC64")
>
>> 
>>    warning: 'nvram_mutex' defined but not used [-Wunused-variable]
>> 
>> Remove the unused definition to avoid the warning.
>
> It is not what you are doing.
>
> You are just hiding the probleme by saying 'maybe it is used, maybe it 
> is not used, I don't know I don't care".

Venkat, do cares about this warning, and hence he sent the patch in trying to fix it ;)
I think, I missed seeing the upper #ifdef block of PPC, and hence
suggested him to use __maybe_unused, instead of complicating it
further with...  #if defined(CONFIG_PPC32) || defined(CONFIG_X86) || defined(CONFIG_M68K),

> Please properly fix the problem instead.
>

I agree, make sense.

> I think the fix is probably to remove the #ifdef CONFIG_PPC32 around 
> IOC_NVRAM_SYNC.
> If you think it is important to return -ENOTTY on CONFIG_PPC64, just add:
>

That make sense and I should have thought of that.

However, I looked at the suggestions from Arnd, and I too agree that all
underneath function operations already do their own locking, so I agree
that we could just kill this nvram_mutex lock itself.

-ritesh


