Return-Path: <linuxppc-dev+bounces-18008-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E36FD88FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 05:12:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVzQJ0WBSz3c9r;
	Wed, 11 Mar 2026 16:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773205944;
	cv=none; b=QqiHOvN9i67ggFY52rbtOau6IFW1khunGD/aZxW+2kQ2JfjvOgmEuI01/CafmxGIvgL6HoGPqg3N82xALQAMwFTyJ6vE2E7p9v3mx9wtr97zFjJjpRMdG3giw2Njf02u3sksQNIpoojwEJ70Z6LmBdJ8pAr2bzCgUuFnPnyS5AjzpV30MeuhysncI059r6ssOvrcBtcxSSitgHV/GWticXYDfmRSddKk8FItsPU4tcDA3dhUaDr5zryGVKjZOrUojy3O0/8YTYclDRvBY6rxqE72fO5oKHuZF9+AjmbWMHq3S5C+ZlulZhXJDI9AQNlMSVnDJobi7N/uP+XkXpVWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773205944; c=relaxed/relaxed;
	bh=v3KpXveWnbBXaRtu+GF52rVsSzzQs7VdSUIri7pF6cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoEwZj5XVWZf0P0xrI1iajwQ/Jr4dMOl1q+ftS3If/IcxSsUGOTA9LDPBrUy4zc1zUPV99ly+FJWOPVKWhknRdsGXbFW0FnnAIMy5FoHJyhT2h956muTWY583FCV1cC2T+6QSS3STatnitxo9hM8FAA6fWVnBbjUAFsLq9+q+Cx6j02ER4izwrn9BQ/smVKuQ5WWT0wu3EcNWvKkTYiSIEJBLfTTIjeRIaClY5U1DpeSSw9KRVcg25XCJDmxUGYejZFE6/B5zJoUisM64FXrT653YCyhHp6UbTHxYLuHXtMt1ZrArrrhEw6i9Yb9gdCTfzIfSM2yojkTpqq53Dj8kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k5gQ+n2V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k5gQ+n2V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVzQG5YJmz3bTf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 16:12:22 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3598a09fcb3so4281855a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 22:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773205939; x=1773810739; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3KpXveWnbBXaRtu+GF52rVsSzzQs7VdSUIri7pF6cc=;
        b=k5gQ+n2VelH7YtZk6yfXNfzI4DE5dE/WM1Cmj2KpxyVHR0DFQ6wOH/IkuckydLASs/
         ThXiyw/MIVtqK9ymUS4eYHOTRrum6ZRxxvoMqxy0U3cUyv4BcOkwZ+7pbpPNjdp9/doy
         PlcN94VNFU7SBvK49LxQMbU0ewPSOBuh41Nz+ZlQ/vrbW0LZS4j4KBtlhvioUm6CYXhB
         1eCsOV6vmfyNKvw3www81KLfkNUQlH+Zk4mK0TEgr46yIojqvPwNlr1gSDbisfrL8XE/
         TSRiN99JFXv6DgyvE2XXGmo8yPKmZFmjki7TGp3sIeqsgFp3OR90R+Y/vwgV1Pt0ATVg
         IhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773205939; x=1773810739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3KpXveWnbBXaRtu+GF52rVsSzzQs7VdSUIri7pF6cc=;
        b=Pw0do/nSiwGtb345JYq9+Tq0HeltbqVqzkj3WYYCbmWNxjAd9LgNh2LQqtH16Njgf6
         FYfObeUIlISjiHqgS5UEFUMJ888lbqlH0gh231/BWYgD2bJmhEohLN0XoB/LUlwj2hdP
         IGXiPQKO0G7/+RMury95lB/DuTJQPFQEVQXUGy5ORK3JR/O7TUwueTymZHx0QRu9W7To
         WZ15WeHrcCY5PIS0CgwCPdbybCtarKwOiSxnUDDvfITZDcESeMsdiMt7VoFai+DMW+Hl
         IRRYLm3UmQesw4rUZUZ7qcMNFV8zzglcC1XPaYH7igMWnJ7mYyNeEbj2MS31U7CQbQXa
         o59Q==
X-Gm-Message-State: AOJu0YyCUAThnW1Sefpa5fNE16qO2n5r6brUZXmZPSwNqxCtpN4oHPfY
	ZOQq9c++c9M75FStJA5DaNKxMfVsPUNKZgi2BnM5BgM+5yAMFZHQZvSQ
X-Gm-Gg: ATEYQzx4VLLl07g5CDUH0Cx9nJa2qGwBV7rrazXPKQBpbEKqnazvd3me0YjNsmi/SxL
	43pNAurE4Vt4hRKK2oGRiZH91tFG32/5aneKSFStbmW/bNvLJBWkHaWOnADlg74bGdu1zMkWm5n
	1pmg+cZp2EQ4FSski8TZyuHfloS2g3igSVMUAR7zwkfSk+O4VUYmwXpmW8Q9OpyDF3mkAvuBHVL
	3INCeGIHhyEcrzOwdNND1zJKUnK8Ts+7xRsUUR+2eMHaRYvfQz3Z5XRAk7W8skhVNsox9Ipwl1K
	HeX0s5bNRfAylZRwDsJScwTcSOtPJnaT7JU+FeErOe4LmtAmxfOIJSmKwW5bZshfik7sQdfw0yB
	hokRgvyTcQEsZ9DJBuSvmiU7/MOHx8+aUKhtr9NTmkDRk1Z0qZAjBwHoQYBms/NuehOTwxk7dhO
	18TV2iHcyOEF/8V91ztqfSP78QLcz8mLmW0oqdDzXiKsiQ/uDkjbFhlfjnM9YtOs+BucBDm5Q=
X-Received: by 2002:a17:902:f70a:b0:2ae:5b64:12d2 with SMTP id d9443c01a7336-2aeae8d2a8dmr13649005ad.40.1773205939455;
        Tue, 10 Mar 2026 22:12:19 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([119.252.217.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae246777sm11955395ad.21.2026.03.10.22.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:12:19 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:42:13 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, chleroy@kernel.org, 
	nysal@linux.ibm.com, mkchauras@linux.ibm.com, rafael@kernel.org, 
	daniel.lezcano@kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] cpuidle: powerpc: avoid double clear when breaking snooze
Message-ID: <abD5O7p7f1YxapOi@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260310152811.1131119-1-sshegde@linux.ibm.com>
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
In-Reply-To: <20260310152811.1131119-1-sshegde@linux.ibm.com>

On Tue, Mar 10, 2026 at 08:58:11PM +0530, Shrikanth Hegde wrote:
> snooze_loop is done often in any system which has fair bit of
> idle time. So it qualifies for even micro-optimizations. 
> 
> When breaking the snooze due to timeout, TIF_POLLING_NRFLAG is cleared
> twice. Clearing the bit invokes atomics. Avoid double clear and thereby
> avoid one atomic write.
> 
> dev->poll_time_limit indicates whether the loop was broken due to
> timeout. Use that instead of defining a new variable.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 5 ++++-
>  drivers/cpuidle/cpuidle-pseries.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 9ebedd972df0..b89e7111e7b8 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -95,7 +95,10 @@ static int snooze_loop(struct cpuidle_device *dev,
>  
>  	HMT_medium();
>  	ppc64_runlatch_on();
> -	clear_thread_flag(TIF_POLLING_NRFLAG);
> +
> +	/* Avoid double clear when breaking */
> +	if (!dev->poll_time_limit)
> +		clear_thread_flag(TIF_POLLING_NRFLAG);
>  
>  	local_irq_disable();
>  
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index f68c65f1d023..864dd5d6e627 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -64,7 +64,10 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	}
>  
>  	HMT_medium();
> -	clear_thread_flag(TIF_POLLING_NRFLAG);
> +
> +       /* Avoid double clear when breaking */
> +	if (!dev->poll_time_limit)
> +		clear_thread_flag(TIF_POLLING_NRFLAG);
>  
>  	raw_local_irq_disable();
>  
> -- 
> 2.43.0
> 
> 

LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


