Return-Path: <linuxppc-dev+bounces-18480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2131093177
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 06:01:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcX5234Q7z2yY1;
	Fri, 20 Mar 2026 17:01:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773986502;
	cv=none; b=fvULo2w64TSkaQy1i1mmj8Cm5+wIrdG8bWNhFkBW3rZSWfiueprdpvqwDtMZy2RZ851V6hNBgZ8bUQKrkzdEAZXgaytOGHRKNerlROeKv4JdFCXPJJnel3lsMBJaFQd+3C6pIs/zRd4ZYQfn57Ng9YLegNebaRsp02CqguHEM4lNfVq150HbEUXEuYidfNRLs7o98/G5RaWRxo7xJbXDxA9VGbyoqXLUBvMqAAtLpuHWrjR5bx60fX8ca6RSzoT9ROsy4IyspRF2p7WyjZjN0eq9/JrGslaYFlr+UUkG2tT2tyY9MAHzHnLgq53yeLvFI3zXXAHGBeJZo1C6JNtlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773986502; c=relaxed/relaxed;
	bh=8rYZZhUBJa1FZRzIhufjJuk9/UKzqdxasYFupJHj42A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgIF56TcQQaUYs/h+OWQQLGJCjq3KUxiWz9rin0TrNMWavLYupV0YQZ+XdFxaXpzqKnxwnbxy8+fEJ1wcJboWgpR1t5zB3/fp54Hl+vOD6dQi647QZxKzjbX8ksxtmz5LvIyJvdvbzCXo61n6DcKGIq8di2sEmIDJRNLVVtxJBZ7qVsgHA3S9EH1qtlAidjuNHYITg1fuSj1MwRsNmvN7ShITKvlSN805R/x/0f2DqZryiDD+BA6GqKmX1FIpzLZ3uG5oWXMH+Hq3hw7Z/3hN/CLVpZ/7YX4cX4/AaQkGB4GT56ixdGBSOKvPERQi29mJUjpYzN1QkHWXwPjYIYFbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J4uVP5XX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J4uVP5XX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcX513szHz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 17:01:40 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35b95a7444bso157948a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773986499; x=1774591299; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rYZZhUBJa1FZRzIhufjJuk9/UKzqdxasYFupJHj42A=;
        b=J4uVP5XXjkSj0fXc1VKDkqheFs0hdlceJvgGj7AToiljQxldFVgDuDTFm047+0yF+Q
         2UTxSTMiow4FKe6q1usDdZ5kmvmfO6wUoNoLJGiBNy9rwZByE6lpUnEakgqM8lm1qind
         ozf41kpahzr3ttp1cqD47BD9N83XZpUwoCU/CiRtzKglyBr7PPcmoogPCZNbAP+qAYx6
         NJWMnzEl9BE3Eas14G4XU7b+Tz4IxbeKW6yUg/DyQCKGP63vQVodQsIU3Yf0H/u8iEsk
         8Vlftq50Z+sZm/TSQOJjQ/4WyDrLyxmIDAUT88HV6b7VIEsZyItZdqh4w+/HUErxSPPZ
         VL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773986499; x=1774591299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rYZZhUBJa1FZRzIhufjJuk9/UKzqdxasYFupJHj42A=;
        b=jfKDZJSXX6S/30K+MZIWDIleZfFkuTwd1z8e4Fr34HUAiBX7+XgDQKM3IhspC203hF
         eXl8hdVW+KFYuKQoqJyjAh8Fs0vC5Ak/kJWD05t5hJ9kzqeMQDJ5OKIRTvRCAOkZXEif
         +xAmC0TWEG2uex2/TozrXPK3+9X93kKPFEVT0Dlw8YLRvKn7JsafZ1NIaeiyf8nDNq23
         5aM7+3FPCLaREx1zNP7ucUEnQjeAigYL9r3G1wMoyI4jPV1oQ+aDtMkn8GL/OHxJaVXa
         87kSzSsvr8qFrws6gFOM1rdZnz9XZvgpDm80W2YnAnVjM21XplfR480G72nQ/x02DA8a
         Rabw==
X-Forwarded-Encrypted: i=1; AJvYcCUKAe/0Gn5Qhvg1zYuVhYp8ZHn5nzFlxYiawgWZtXt+hhJSo4cKZlP73AUoQ1v4mIDYaCfSbGl8xmT0vuU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8wnNSSSsgNUKy4rffOIEDARnsMd/PGyhHjoo8nOIAUJ+B7t78
	2veFcpFJB6FF3eH14fn/ClysSVhZYjhqk70fHFVTjHbbuHti2+QVAiaT
X-Gm-Gg: ATEYQzy6OlxBoS+wadB9kpsp3628uaZQOKu1bCb8y9lZQcmaernczKfAvRVh4VgZoWK
	Lwc5ROhBRx/PQXlwxwb4BjDWl/ApUMV7IDNKt/1KCKtgyujI/555XnE9ttXksGVXOCaBEw4qTX3
	Na3tB7qh60lE5SaChUQ+VVG6InO78Lc+hJD77GzLUPtKga/+5NKkUKj7n6AsMd2iMiNfgRiPxpQ
	uq5fWBHKz/e4cIkSYGaTNzTL+okfLMFOyF+mYx0R29d8Swt719B2dQ00QEBCuiPIeQy5+nqm6zZ
	M3dWl0eKu5DNTgiYfi58eCwGafUXMKBqAYRQnIku5JQ+PVS9Q/nwFWNPKiEaGvfOi1ULC2Ts7rO
	DfLY+OQmdQLcf9ekrJGBG0Ai1zyhdONKb83jhmYKSubIQPpTSvDcek//RlvMdLEVY70pEjyjbMk
	g7O9vZSfpenz8saWFS7/M56us3Rj3PuU2vk9OwjVySmsFO1ThMyEfsP3S4k4W8HFblXrGVTpwDR
	pIlVumohw==
X-Received: by 2002:a17:90b:4acb:b0:352:ccae:fe62 with SMTP id 98e67ed59e1d1-35bd2be6dcamr1563252a91.10.1773986498759;
        Thu, 19 Mar 2026 23:01:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.207.193.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff6789sm4491798a91.1.2026.03.19.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 23:01:38 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:31:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nam Cao <namcao@linutronix.de>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] powerpc/xive: rework xive_find_target_in_mask()
Message-ID: <abzihT4xYCe65gVC@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260319033647.881246-1-ynorov@nvidia.com>
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
In-Reply-To: <20260319033647.881246-1-ynorov@nvidia.com>

On Wed, Mar 18, 2026 at 11:36:44PM -0400, Yury Norov wrote:
> Simplify the function by switching to using a modern cpumask API.
> 
> Yury Norov (2):
>   Revert "powerpc/xive: Fix the size of the cpumask used in
>     xive_find_target_in_mask()"
>   powerpc/xive: rework xive_find_target_in_mask()
> 
>  arch/powerpc/sysdev/xive/common.c | 31 ++++++-------------------------
>  1 file changed, 6 insertions(+), 25 deletions(-)
> 
> -- 
> 2.43.0
> 
Tested the whole series with 
https://lore.kernel.org/all/20260320054202.3245144-2-mkchauras@gmail.com/

Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

