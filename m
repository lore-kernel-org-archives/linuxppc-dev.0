Return-Path: <linuxppc-dev+bounces-18986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D30FF4935
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 03:47:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkcdx2Fgbz2xly;
	Mon, 30 Mar 2026 14:47:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774842469;
	cv=none; b=Bt+d9BgmS0ioFEJJYEhZXrnPS5XbB2MSP2I/m2XnHkBEuaiQgy+1TpDrC60ordg9TuuiOw3IpVBlTTHV1yAj4NcUSNTafeXXvRSiuHdAqIjh5LxdAR5+vnWNzzR1YHh8s4cNmTPpFHMXsVbxvYbSLsdx4JQiU2X8JGdMeYGC/or0iuayqJmy5gylsNcCoFv4gSggDDatgpYbQMFXobvC455s57maLm3/L6GIHBFIda+xKx7GEuSFaJCCW4cYpqo8GTVC/sa+ANhB3XJzApieEXUE5Kb/vY2fdzlot4kWzrpfoWtuid3wyAgvL9aXc5T3ppdd252JYAHGIsA0qNSD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774842469; c=relaxed/relaxed;
	bh=nbn+1wU01z27PHPiB6pyjlcWzi6QRevgboBAEreZK0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip+HNlOoicuKix5fSnROO0bv2pdFiePNJ8rQzMa1G7AsXd8wPh/HdINwPQ1xbtdHCEDXMieb6M2w/CMUKQ+ODCxXMyVw0PFhsC9babIzh5o885pOxM+odacT90Bq0i4dEdVkRSEyEozTEvnQ/NIi3sXzVtlD9x2Q+3gmFg7VIcu4AuOiV8R+OApyv0YsWf/HzEbVquV2KuXnHI6sozN1nAAaiCKSuHVG4lnecdYJPIrpxkC0K5j5Psxw+lkDZHwhVOLh4wP4Pof32C4+f2coz50aJn5f1fYuIMmO+cDi6woxMmR410M8lByIpBprm1Df76rX/vJeiwBEo+bb9p9rbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lQBOuBoR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=guoren@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lQBOuBoR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=guoren@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkcdw1f43z2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 14:47:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D0683600CB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8599CC2BCB0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774842464;
	bh=nbn+1wU01z27PHPiB6pyjlcWzi6QRevgboBAEreZK0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lQBOuBoRajs1Rp5qdpTkcCuCCgbFubDXnSDK9+Q6dfuk+iRhjCzGkg4ebduPJGlyc
	 SOT0tpjC9PrELqtPWWYbFbhuRi4I8kLPrRs0sUefIgZ7YHofjY8HtyWZFYsMrsFMAH
	 kQI0czG3NeBj2y3fJEfwE2DrJgkKfIItnSaSmgvbTV4nEQGXTB9XZ1tY2d8dICxgp2
	 KixiSeGJQoFjl3BlEYS8un4BJjbJPaIAbR/tqw3rlAs0kvHsYrXHQz/vyghs3txjH1
	 HGFJ+X1yGjvC7BxqC0zRc+Qj9gu9QVML3ewI46rY6UXu4vh+nxdIsw0rKEJT249NOz
	 eKB5jX4VEAfkQ==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso24250935e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 20:47:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGVd89TUk9/4OIThnAC4rRn2bKrM+FWDUSkYfub9A456ZHMRIKqCKpx5UxH2ml8bCuuYaxfbJVi7h2lq8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4g3OuKxmS4EdKdk0LzhWsbXr1ADJGfb+LYFx2Ik6LFfieyQ3R
	lCKwkzG49ZVSdWqfnnLpyQX/+FDMTgLdXUMWga+a+wZx+D0rUnK97B/upC8w5hK6Qj4ZgsXUSVG
	ahFbqcPkAwo2qfp+WmzI+P8+H8BLnsfo=
X-Received: by 2002:a05:6000:1a8e:b0:43b:45c6:7ad with SMTP id
 ffacd0b85a97d-43b97a90decmr23305904f8f.29.1774842462488; Sun, 29 Mar 2026
 20:47:42 -0700 (PDT)
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
References: <20260328074013.3589544-1-ruanjinjie@huawei.com> <20260328074013.3589544-6-ruanjinjie@huawei.com>
In-Reply-To: <20260328074013.3589544-6-ruanjinjie@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 11:47:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQu0ekP6Emz=F3uEhPsyqNvH_PwwJU5yOADbR9poQ4noQ@mail.gmail.com>
X-Gm-Features: AQROBzBPJeJ2Q-LIGCNdFWKdGbP9VQWOujey1zE68GwImpeUgj1lBD6fgh2uH4Y
Message-ID: <CAJF2gTQu0ekP6Emz=F3uEhPsyqNvH_PwwJU5yOADbR9poQ4noQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/11] riscv: kexec_file: Fix potential buffer
 overflow in prepare_elf_headers()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, 
	peterz@infradead.org, feng.tang@linux.alibaba.com, 
	pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kees@kernel.org, elver@google.com, paulmck@kernel.org, lirongqing@baidu.com, 
	rppt@kernel.org, leitao@debian.org, ardb@kernel.org, cfsworks@gmail.com, 
	osandov@fb.com, jbohac@suse.cz, tangyouling@kylinos.cn, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, eajames@linux.ibm.com, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, vishal.moola@gmail.com, 
	junhui.liu@pigmoral.tech, coxu@redhat.com, fuqiang.wang@easystack.cn, 
	liaoyuanhong@vivo.com, chenjiahao16@huawei.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, james.morse@arm.com, lizhengyu3@huawei.com, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 3:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> There is a race condition between the kexec_load() system call
> (crash kernel loading path) and memory hotplug operations that can lead
> to buffer overflow and potential kernel crash.
riscv left no margin for hotplug in prepare_elf_headers(). Actually,
this check has been in crash_exclude_mem_range(); this patch makes it
happen earlier.

Although this patch has no real effect for riscv for the current. I
still give an acked-by, because it's a proper check step in this
callback.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

