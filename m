Return-Path: <linuxppc-dev+bounces-27449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1469C88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 22:55:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hky621t5nz2xk7;
	Wed, 16 Sep 2026 08:55:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:33::1e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789512922;
	cv=none; b=N2IDpptVgiAlwo57VDh8vnBVmm3qsMHSw8Gn8fwHIe1jJkOWsfjAJYuYk1NROOQprfDLbciSTWD6GvKIdzyD8JpwqZrdwAwTnd31tucAvOwLoAhdPB/stdOsXrp7EEEZikYpzQw+qLJvSx4GRhbu64gkGV5uiZn3X+chbKp/USiZGosNm8PEdwVSkki1MZ+96wpWWI/fiICDeE3rU2RrFvZQ3PE3ft4usWNQIAAlV7d0odAeussvNBiUexjNPoIIjtnKP4eXi//2TQrGd11fhXKK9mEjr5Jd3CnrFvs5soZKNZ+KHhTxlfXYNaQ7+gg9/nLpjF55qYjMj3ysnrRjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789512922; c=relaxed/relaxed;
	bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4nVfbZ6/nnlf4jfrOodeD4qJ28cZ4vl30YeRol2dia9LCHcpnMJFsvCWpPr0bA/QLKNJ/mY3/ZoVsPgmM6DVANV5x9dzz4x1Rc+fZEcDNmCauQiOzrZnslPUP9uOTl2vspHd5xyTgb5/MUgLWm3kbknoBiMYcjfDjjrYTarcfUDpXTpp9VR7CvVDSOCBnig0MLeCImPsNN4NRm7SgRYhV3WQhYkxB2/hkXEFrBFMv86rkcRPHwjdeMbvpcI+ilboh6lVA4VLy6Rhu1g/huGbPR8mHjKubFhaywL4aTE7Z4pUzG33L62+13xjP00ORjHgmMHcSrHaxxocS0kcld9GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FupZlj3v; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::1e; helo=mail-ed2-x1e.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FupZlj3v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:33::1e; helo=mail-ed2-x1e.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ed2-x1e.google.com (mail-ed2-x1e.google.com [IPv6:2a00:1450:4864:33::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hky6069Snz2xft
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 08:55:19 +1000 (AEST)
Received: by mail-ed2-x1e.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so509056a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789512915; x=1790117715; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=FupZlj3vhtzxGk+GG3QQKEC3EDZqa1ukqnQlXcS/NJ/fT92ztxEpDhVHg3s4uBhlHu
         6nb/TrYbjQjE/pTZ8MnCinylQ4efrW5lQnT4lFAJ0EZLo9GCEoyuCSsxetk/Bzgtc8/e
         1bG5ODMjybGfUg+/TyVTWXpNDMKUbGdLv2CzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512915; x=1790117715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=mmuN1gsByCpIubLFXUZl/3YciaoAVWe/o4NiTQnSpnpPTljUvBRXu1UYygV9wl8FpT
         U4yxA23wRmxKqfp05IKCMfEfPqdJ8wEzolG7rMs6qnvstRPggQoM/6ZyJkyqktFqjvHe
         DbBFHe+2Kl1vdnjxNo2KDs0iDNHxMcbPfjjpIsTfxGiSEmDV6TmBAt+qfYNE58T/5YGn
         V1/qb6uHSBu8HqnkxyvOCuaLJHW7mCAWzKV5BbnL/RvEEl81lD/jyKTjnMFJWM7XXCfM
         TWV3h9cQzkl2TYgyrkkqbd9mXg5ImbwTTMNvrgotHKO/vwpLcHboIQH4PzavsBRlNLzN
         qYuQ==
X-Forwarded-Encrypted: i=1; AKwUvBykB4Yj9HgvqSAmzjfl/re+L55QNKKLaNT6L8Vs/eNGUB4qXeM0bOLKIvhcc4qU7/3TakfKyTJDDyhUZ3U=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lB2dh5F064PeYLb8lVe8TWhDESdqrn32HJUlq0bD1kotBmaM1O
	ytWKawOSHRaogGcBzbBENoBLOTNajTi7OceBaLSVrl4OPIF5iIYpfksRgKEul5GKn4lAqbOug49
	05x2XAQaJQg==
X-Gm-Gg: AYBFou2LQuYFgrtqAmAUsTaOw40NKHbqoEuDvMQham9LQ6tDfU9Ec3L8ba5hStE/vWe
	61p40rHqLMKp7nCDo245d3kzdISWb4+V+5Hflb4WynPWuYFUBg6Y1s72gjq/4ncpS1pcU+4T58U
	9/sbEvclB3QFNo0YVxqSftoKdLgutPRZHtcQ3HpReycdvMFvOfN2ir+2+E81A45Dwe479Hb/8Vz
	EEEHlmsXl1rvsqw/z8ygqRKOXV12Ot+A6s+gGCHP9iQ3/dlP29qaYfQypcUWV6TKidCD5CaxhYL
	zQgkhnd9l5GTwI/fgifcWekPK/HKDTBhTXGRZfBtubSbrVjspjYS2DJHLsqZk+E6pbL4EjUc6u7
	5N3SFKqFT67rJNABmlGOOglbH9JAeAw4NYAviDrCIKTdVU+fhui7NP2lsFwDXbTzV2FfDz+QbB8
	3H2MWo0zCjw5omzeOn9vjpG9kFN6Kde0+FMokCGEzAx/meHJOhVFt4LJpU+enB21a69AWYdSeYA
	ZdENicC8vBZVbpUcVeuAPqd1BrXDYwddbd4Br+baz7J0OF02Q==
X-Received: by 2002:a05:6402:274b:b0:6a7:ea54:389 with SMTP id 4fb4d7f45d1cf-6aa224005d8mr225469a12.26.1789512915270;
        Tue, 15 Sep 2026 15:55:15 -0700 (PDT)
Received: from mail-ed2-f18.google.com (mail-ed2-f18.google.com. [74.125.228.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d240669sm342029a12.13.2026.09.15.15.55.14
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
Received: by mail-ed2-f18.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so509033a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw1xWnlDLAfmGw1Tx2/MetfPUiJWV0BjipaM4F/Aqj2DglhT9pHfUGSUc46YpkH19hD/qaMhf2ASjsRt8A=@lists.ozlabs.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
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
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus

