Return-Path: <linuxppc-dev+bounces-19933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1813F94CD8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 07:54:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0s1N2RFFz2yqs;
	Wed, 22 Apr 2026 17:54:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776844440;
	cv=none; b=lSqMaQayWXzcB43iIVK5Rj8nsvQuvFIADrqJYvAQzP3OK5L9r7/G+5TVIoimEpJBenU5V5p5KIOKJlF+4vzuZSuLuWDuLpn8IkhLqSZysP/5poApyWf3yHI6Hd3fCszlmA/S2uvDEBE1qbfw/7jVS7HYCZ1LeW35wtxr+nkjytz7X2ubiqLvjd2uWEnjWgWz5kpAdZyJc7vdBX/zJYl4raJvASV0FOgvR4CYzafjP6n0e1Rz4/VX0pVxPzf3NZJkRgXUUef40FEXx+wGqTjoYdm55vAHBf570t2Um+j8iyXHFryxUzJcql4LzDMIuAG3mb3Ex9CIkN1UWW5LN5VpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776844440; c=relaxed/relaxed;
	bh=CjbD5DAtK575buPNI+qG/w2afm0sso4VcbZ59zXJsdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meq0KWOyQfjIKUJazW+rqOXy8bhBr1HBc1KJ1q8hwHlcbmyGHJfr3axAaQDJo8CifnxT+rNZrSCYTlQ5MWGMcJIiJ2snadhTjQPPH1NQdz/GJjCTcWWgi5C416QpOkmtxTlldN4sgvfNSVbCBDv9PNj6YlZF19VyktuaxGICZtr3vH5FVW1dybmvCLFZeh6t3adW3efi3LIFWS/uyQ2hBnvwrqtGQxlNYBobAsyGyPor0xFXjtAkI7Pk1ckYwvdz+jh0j54eA4hkPyOTc76xE0aAqYX4qJjPaL2iU7alPZzTD4h6CY017pmmPs8029NYEPbudV3PEdN/b5S6tPEtvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmIDx1Kk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmIDx1Kk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0s1L4CQrz2yql
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 17:53:57 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82f69adeecbso2209952b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776844433; x=1777449233; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CjbD5DAtK575buPNI+qG/w2afm0sso4VcbZ59zXJsdU=;
        b=HmIDx1Kk3GLlXIMTk3oqrvcB+sWnG4dlx/01kbbxm+49fOEo013K3+B58DATvZ1mBk
         IyTczId24bYW8A0asYHrwarFqb8JuD1DiQCuAgfssHstkHexUK/krobkh3GxfWPMdpss
         eDNIQVr+KYZ3SbeIIoj34hmenA8B74pv6R0y2dBpJkgMCAVYehHGdOJq53J56FY3j/Ut
         u0hQ5ZzZGAMssrwAjruELRfxdjDnOFc2NKTbsKJsPhmnXOjmDfnR+Li3/jMYfPIiQGRI
         Uo40iP6J/X7zdzsyxNa2NSwwdNNG4uaUkZkto0Xrae3QzFyBJmTjlweRkg1ovSzTk6j8
         pNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776844433; x=1777449233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjbD5DAtK575buPNI+qG/w2afm0sso4VcbZ59zXJsdU=;
        b=Kaqt5ycsSiOM4T4HOHp6Ep9Qf0M3Tb/VVdgy4F75AtBktKeRuMqe9mQVajQtXCln3O
         c/sGO0+NtpWA+yWCFpD63jLxK/pV5TjOQNwGQvw48eVHSeWG1qHwbfW3+t0RQns+vi0f
         5OIBMKAZ4oYwKD+bXI5IMkcV3VE/AGWhIrZNboo0xVB1Dy1mC3YC5+Us+Jk4rposXcKX
         XoV4Tb+u6MtPQzqXh72b6dcxc7gTlGvr+J9ksmVwb5Egs2/5zi/qYv8wi0z7qI08AQzB
         auVUGDD6T8Z0MAcgHf2ud0aCFhTZHs+3W+MvGYDSLEykQ6TpjjSnKvdJidUv2GNU3mfj
         +ueg==
X-Forwarded-Encrypted: i=1; AFNElJ9cS9OZ4M/JKuzTQzVoU/nsiMAYIMPzotr/3lU33P89evIJB5HLZbPH5+hCL2buKOR7vWh/yU8yWhh+d+M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhnaKhzyzfYHsrCbj4yLARdMScRl+X/3DgGvtCDLqSi1xsEIXC
	dFQJU5oIj0I0caoRlv1h3wDBBcpFTmsmhCPgEHlIaTSiwyvbCeOD4kkc
X-Gm-Gg: AeBDiesS9k6WgZnhp/VzNUTsaIs9uZDuf7vkfn/jDvqRMENDAKzsg86zr6T7yx1iWQ0
	0ng3dgDC+R+OI4cK5eVZHW3POt1d9SpoFIyfrmyu/Zz7+yvIjhjhOUrDEGnHQNhHpa5EWLhdmyK
	I5bxQIjTnXYBr7eAUHCU70/F+BoYVrPpY8gtOp1IglNGc+CCysWfLM2HQ6negOiuyQXTjOJ5PpI
	U7WQRcoTTNzEhCpEgu1BXJHwkhXwUXMVwXfP/mm10rFrpTCXUcx/DGzBbjmuQBqjustBK6YN6DY
	gzRUu90CnQQuDyv5v8alDocz7MEhHwB+EAqgUgyEiDapm1ft+hEYu7fSYY/7KiUgraztQQahwlv
	1EivBrCjUogMYWu3nPzftSzvTVch7wph31hJtNdd7p0O63ydJMH0mB90YdZ22e8zgJkRSKGvU2C
	sP11nP3CDFwZhxVKoOIavOsjybwhSoRgwbLiGw7ibkgZ+gK4xcvby3wqQApT7g//xDwdc/TRuQy
	E13uw==
X-Received: by 2002:a05:6a00:3315:b0:82c:d6d3:3190 with SMTP id d2e1a72fcca58-82f8c99bb55mr21216994b3a.38.1776844433042;
        Wed, 22 Apr 2026 00:53:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm17662514b3a.14.2026.04.22.00.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 00:53:52 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:23:41 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Link Mauve <linkmauve@linkmauve.fr>, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aeh-QhEGO7ZiwQZ7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna>
 <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DHYYG7A745M5.VQY4GMDJNC1Y@garyguo.net>
 <aee3ivM9VkbqdQby@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72k7HXYE+1hhbT8xfL+pwhBwVqCQaN=1xXUuTnMhH0J7QQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k7HXYE+1hhbT8xfL+pwhBwVqCQaN=1xXUuTnMhH0J7QQ@mail.gmail.com>

On Tue, Apr 21, 2026 at 08:16:06PM +0200, Miguel Ojeda wrote:
> On Tue, Apr 21, 2026 at 7:47 PM Mukesh Kumar Chaurasiya
> <mkchauras@gmail.com> wrote:
> >
> > There are some other build errors apart from this on 1.85. So few months
> > back in the meeting with LLVM team we concluded that for sometime
> > powerpc will be ahead of other archs at 1.95 till others catch up.
> 
> In that case you may want to modify `scripts/min-tool-version.sh` in
> this series too.
> 
> I hope that helps!
> 
Yeah this helps, Thanks :) 

Will post out a new series soon.

Regards,
Mukesh
> Cheers,
> Miguel

