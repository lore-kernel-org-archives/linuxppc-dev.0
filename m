Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB3606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8hzk9P+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF8zV4TSjz2y8p;
	Thu, 29 Oct 2026 01:35:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793198134;
	cv=none; b=iAUMXA5f5tSBABly0finPo/dodYu7LxXVHNZB5rcIyTTI9bvqNmHr6pzn8W2JLfmN3HVwzCCv80HrRgdPv6QkRH96Nsvpq4H7lhKcFnB93lQ1UmMxas/FxbHSHT4oNweaUgPWmzxcqSG6EfnUjZyoakaZ/HzSda+ecUwaTzme55+qGf+BWDPi3knTj0grF3dg+PUUwfMRZTYcv0TNijBw3PsNV6GAC/JcMv7MB61sKxAky0TjMO8/5v55jj9A5lwMLjkHHVop7LZ8fD6pso9paDHY+skh4kkss4FOqOyZ6Zt3LlMjjRsBSnLJv4NuoZisbLiIYjAsD1boTc33VHoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793198134; c=relaxed/relaxed;
	bh=pN1MSQu89b3Fcl+JyWjZEXsAVAkBhCmDK4pMhtAcO+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww73qru7mcTvRA9piggtJlAikO+J9Iyzu4d8exxeKbLMvHD9MngQ+s6UYxPbvdp0EIaF4Lo5o6IvWdb7XE3lDLA3+Ruo3TXvEaaNme/dBsdq5iC+UkwlIxE1SU3XW+eu9BBw+tfbAUtJTWRapvGjScO1khZD6W0E6Qz9AeU0I2hqYkCuNsZrIcS2EGyToq8XhjMqEXOoOxu1g+1E6shwK/vCDbLfrUQLr84qdZyIIYEVRXkmE+Px66Lf6KLPnJ5ugPLVfWO2Skhhe0fhiUhZ8muWDcD9hM3bX3n72drWO8TDrwnyAhLZqLO5YXDQy4ddDL74/AnvpiBlolVzoP92Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8hzk9P+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8hzk9P+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF8zT543Lz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 01:35:33 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so898573a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793198131; x=1793802931; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pN1MSQu89b3Fcl+JyWjZEXsAVAkBhCmDK4pMhtAcO+I=;
        b=V8hzk9P+G08ZxSFZJoB7KFIDR2c8JCnBD6OCiw7//jn2gESog1fqdwHM8fE2IBoUZL
         WPCiC98h1xgRjhBX3OMbGARwAJj1n8+LoSDqrNkgR4YfXMKlLNqrRG23+W9Fucvi0FLA
         /jZIcXvTmgokocuxyt2fWnHGQMBss0HuzIA7O9aTtRCxRea1AuoDE2ID58OMMefXlSdk
         sgy+G/kTp0JyMA81hFDeTSTBCodjNcgOk66PzV2KWrmeEne47o3idtu1n9l6BkiXl2Sa
         la0PpQbi62XPtazVeePxYDR0jiWiwGTq6OCXz5Yq9Mipgbn5gTGOOrfRJafl8M+L4gJz
         p7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198131; x=1793802931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pN1MSQu89b3Fcl+JyWjZEXsAVAkBhCmDK4pMhtAcO+I=;
        b=p8wXwyVQWEPljwl3rEFvHl9T9TpCoOxWaIs/3vTHavWdvIrMHCxIINLrJ9NybbOP/p
         +5P6YjXpNKf4CNY0mN2BrWWQEFVlC3EP5wR8etB2LtCFgT5lbSoCWRqoCgrNoCKmN0Rh
         bywKV741gy8jfX9Jk9VEqcNH9q4tqyxFmbDs9zoHIzO+LyKpZgyWKG8rZM2ruZn1S9g7
         CbjTeCLrBolFvlnSz0LPywq/fbbESohmJQf4SprgtWR31HKgZHwy/8gDThVRUNmwEpCB
         oJmAAFRnEe8VpBqQZe37rpvGIHjW53eQfScOsFT/JaMiwA3+gRxYLHnAL2gdTarwjuJd
         UjFg==
X-Forwarded-Encrypted: i=1; AKwUvBwCmRLnrqgdSsMjy+UCFi07d8mhugGEvMuMrBw7fGWTfIRHXHjQCOZelvDbxuV+EoRK8BZbffiUf/S8oaU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIPY9oU9LDwZUDYK/4k3x29lwnrXK6yZXf5BYPPdXgJVQXhB7oj
	0+6xtrGYmiwsVGa5QVgJtZ1SEAS5dhWNfl6oiDwJ2SgaLaHwC4stiyvv
X-Gm-Gg: AYBFou3MxI7pOVQ5ZqgRe31i0uQAAWhtyYXCml64ABc1L75YPqjjTWWOb5E1IddAVFL
	KJdS6n5QmJyBXKqxWand4p4WI+k7qyD35l/ReK3sSjHtlQ272UMtX7qqzpWjupaX+FlyViNMTD/
	JNrcRfndIYI5qZd/omPucVeZ4hvOzCi7bYnz15Aa2RlMgz/xcFGzMZKeriOkzW19S6+BeAEB5/i
	i9f9qjXIxs7YOqq81EgC6QmGPGi1aEMSR4x4bcntCg7s03CN47oS/AOgJNuARm32OOxfKuq9jQj
	LhsH2RDDyeNB1aZxCpLIpR9Yte5sH4NNgRdWyh49BOfz1VZHGHP0Ze3o3MySTbjuy/lcy7z9r1J
	nm++PFyB4LnIFo2lgoTSm1PIkmhT3WzyyPqxClnXfYYl9m57k0GWbAB30b76MOFSEIOuq9bUj4J
	E+irW5nZ9MQC6/vmRghPvuBg07M9gRwzVtTo1pyHYWi62SVfDit3s0qSc9C8W93rLOPtOpZPbKK
	yr7G8JwTIzR5Pup7pW4aROr8pImIl3GyO5AdwDlf1QFbsJ7bw05y1MHFhMp+uinDjHmbUDxHe6w
	TT/xacaQ3eobyKWY4ssDlHsqnzYegtDtcDKAVmapGn2+TBNJMwaXLo827rm0yzaT3b0q6jx+4Zs
	=
X-Received: by 2002:a17:90b:2543:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-3ae581b5095mr1763826a91.18.1793198131090;
        Wed, 28 Oct 2026 07:35:31 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a5834b1sm3422045a91.13.2026.10.28.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:35:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:05:22 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, bwiedemann@suse.de, 
	ryan.roberts@arm.com, mchauras@linux.ibm.com, agordeev@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH V2] powerpc: Support for generic TIF bits
Message-ID: <auIHxotTRFuyJGBv@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261027074710.129819-1-mkchauras@gmail.com>
 <auCJ9ZDlTpHlnyTi@kunlun.suse.cz>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auCJ9ZDlTpHlnyTi@kunlun.suse.cz>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:24:37PM +0100, Michal Suchánek wrote:
> Hello,
> 
> what is the interaction with
> https://lore.kernel.org/linuxppc-dev/f6c831c95f1171e0b82353e611485231482f3deb.1791975972.git.msuchanek@suse.de/
> 
> Does it supersede this patch or should it be added on top of it?
> 
Hey Michal,
This patch is applied on top of your patch.

> Also does this one need the first patch of that series?
> 
I took your both patches and made my changes over it, so i guess yeah we
need both.
> Thanks
> 
> Michal
> 
Regards,
Mukesh
[...]

