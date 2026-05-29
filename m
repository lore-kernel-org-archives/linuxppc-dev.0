Return-Path: <linuxppc-dev+bounces-21742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF67CCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:04:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmnY3k1qz2yrr;
	Sat, 30 May 2026 01:03:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066993;
	cv=pass; b=WpDXPYQDzDlt0H9aeey3d8UvlUqoyvcJB+7ju4/w8+manRB8kFYHUwhULwJndX7mjJaj0oBwYxPRkkQje2kyCs4Fu3SQi+2gTgsHAA9g4egJLyDjklVwAZlCkqZfJqV9atNTPeBTd1IgvzsmJwhaWawc0DRRQL6aqIqIbPX2pBsCgVxy4I7+/TV5dRXKna4ZhIFChft6zp5zSG/wihHO+JW0yc5laniWd7jXDhNineMQWj079Jc9VrW4gQrN63hc/nuwm4Qqc80MvZU9JO5Q7WsFFYt3hzIeuwIJCCN7KiBfMpIQFrtN97Y05b7GnsN/EJgAcPBCDxmIAjs5pRolQw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066993; c=relaxed/relaxed;
	bh=rkloP8gyiqjPfJtfZgrVZcCrdjQVQeCR6SSeI06FVbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjEyqxY3/LwZ6N7SqV1H0rO4d6sSZsmUcS51E21WCR5r30xi+WXVMysYJ3tyMyX3QP2TdiQO/DWJ5z4s0jaHwuN9mcZI7BXci5F+aCBPC/cDcqKb+U0BUbWwRRZd5zOx/NDcR6z1qSQ4XXeO37LANAHpZ/DhG2UfVtWsLYdIRAkNDzmL+UopccAop6jN4C1TvCtOa6j14JNSFpnvn9aiIW9zaqOxHRin3ziw1oZYGUDbFxHGBPXvu4l79iLkFKGzjLrohiqu8U7gzsOIfL4jMxXYkwcmCtgQ/0AC9WUu79nQTlZsQAdtL40uis5QnVrEmgZjbl6wm7PG7oWR+hDNXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Br0XEm/k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Br0XEm/k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmnX16jyz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:03:11 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2bc7b311e77so65199135ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066989; cv=none;
        d=google.com; s=arc-20240605;
        b=jyLF+fz9CIE3/B2xQtsYqKFKH/p5tAOeopwQnJSFH153JQAKReV+NGuHSB2Nnvf/Wg
         M7mfOmbaTQ+MwhAgPpuBcxApcbIPvyKATQPnd8f1WSZHQJiKzuwhiOCFNgNVDVVM0z3t
         BvOBkxupQ+56kRB1hiqvC3SrMC4tryZ6ldish9P+QFOgr8/4iV9LCKprQpff7hhKQWyt
         k75dUw4c6kwDdsGEJD80OdD6nv8nHcxHNWv6mFmvgf26wvrQAiWpUKvev11eVyzpIg5c
         vMkgahkBL8xmABqftAzL8K+JjRcBPxnIV306K9l899aP+MevZ1SiCA8lmotfLFxrCp4o
         ErBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkloP8gyiqjPfJtfZgrVZcCrdjQVQeCR6SSeI06FVbw=;
        fh=yVyaHLH9fxbisF+K7Fpf0PBN3ukub6dglY/M/fiMCT0=;
        b=cV1Tr1EVitRSyin2oYv8s8/FnGTt+QtoXqr+bqSrhwvkHv9FAEnJ5P2wkkXpd0YKuU
         5+rWVJro2VVKUj9/HQJ8FNQlIE4+lCCH9jJ7CA4AImZFxwTqoa0zPjcLQ+/iQ89VRSlZ
         Gnwtqt+6jLO1ZRc7uvsiMrBGJuH49OYcBmqgg7XQc1XyCKTKpzgFJn13Yur052T6zqdv
         5qpJMhpFsaox5d6TExP2zq80eKLhucPB99y2pdPKD4XU/rQWqbNVU7lMnJaeIhw4KTJ/
         n14/HwGMC0kpzZ4oayCA8hQ9VlCJX/pm+Exe04qa82572qbQTJuuyBRHzzLynrjFw5Vy
         U8hg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066989; x=1780671789; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkloP8gyiqjPfJtfZgrVZcCrdjQVQeCR6SSeI06FVbw=;
        b=Br0XEm/k3wGfqZkGYdjSFT4+RZTAxznvFo4telaBwERKTQQAOBU4UecxJPyabrHate
         zcuhNjzaO8Wp2EYehK5HVuvQ4qiOg9ndm0Zbg7Eg9bkiwoVKnoE7UJdyO4KKTZYW/wJ0
         Xqw1N0u1OH+clgjegDKGf8D/QrNF59lluwezYtlN/UHIXwlHEzQTfJcBBUf8krCLEdPj
         q29DDRMwqS+rICKoRUpU+F3GHtZk5pCVnNHJmmhUS/OPmHDqPeuKmCYrvxEVoimPHcoK
         X5AlqeBa2KYs+sHsbmFG+IK1jXxx2KWWfPf+4fRBwqEdGsZcJjXpibvjRZpGlekXsqRw
         pRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066989; x=1780671789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkloP8gyiqjPfJtfZgrVZcCrdjQVQeCR6SSeI06FVbw=;
        b=f12hrLfBvuJPDBzC5EgxAcN8IVvVRLek8ITeZWld3jtWO79A3v4b6K6GN5cKC6RPM7
         f9kRheT4J1wyDb5Ke0pwfCOA3CmYP3ZC5AAP5KJpFBzQvRU6NGR7A0gyWi3nIUINaVkU
         yZEVG3PiVQfpy9dBNhLLCtb0ySBfIJNQGHRrF7T4OsdvAMMBqGzM0/GH2LNO58aJ2SVX
         nMm20o2s9AM8eTCbAo2WVpjwQBcKt/F1JAv7oQHDmGqJqVmh5DB81th0PDx6vBWhiufD
         oVxZJDPYVGC897Se5uJyhJd/2EZIt7L4WLVRd910+18rwiRH3pRS+tESM3foL3lvZk2F
         DJ6g==
X-Gm-Message-State: AOJu0YyBJsUlMsz4TEH25JBQZQY7buhuI6mABBvXsz6YO3TJQenmfJ4Q
	txvs5M3iuKTmUItp/8dFdbCJOTflqsGg1n1/vNGrwS1GIc46e6I2IxmV0FKQoxwDoUwmm2663rg
	B2CT7GV7xzrTDW4zQtgBMo1ilCI7Usf4=
X-Gm-Gg: Acq92OH0LauBAmUm3UPEf/fnhlHx7keU3w4znp2fVdc7h9rXORTar6wXpOrkt7hNGx4
	sHmtdeJvoYQzUeXf79pK7fpekBwsajE0ZG1e5WeDc34L3bWUidNQUgmsHlGTbn7M3IfhBA5eOpF
	tHAH7xpDevkcVuwa5rwXm7I1D0RdVuPEwaWU13XYyVqi6LSe6w3kAWnQgJdvjkx2qKC6jMdAGND
	MeK7zSoCSX/jE1AxjFjjac1Uc2MAUQDHRUc+e0Of6VDjwYeMzX88yBaA203oLRnYmpCdXav8wGI
	avhCLpc2oW7aHdhcag==
X-Received: by 2002:a17:902:d4d1:b0:2be:1eb1:eaf3 with SMTP id
 d9443c01a7336-2bf20d9b4d8mr29381365ad.11.1780066988467; Fri, 29 May 2026
 08:03:08 -0700 (PDT)
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
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com> <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
In-Reply-To: <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 May 2026 11:02:57 -0400
X-Gm-Features: AVHnY4KKhuwSMumEj0Bb_Upfm-68zeF3D23iMS5HaXZrsLOyeIcIpCVE26AqncE
Message-ID: <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org, rppt@kernel.org, 
	paul@paul-moore.com, LKML <linux-kernel@vger.kernel.org>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 9:40=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
>
> On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> >
> > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11
> > hardware. Attached is the config file.
> >
> > **System:**
> > - Hardware: IBM 9080-HEX Power11, pSeries
> > - Broken: 7.1.0-rc5-next-20260528
> > - Config: 64K pages, Radix MMU
> >
> >
> > **Problem:**
> > Different crash at each reboot.
> >
> >
> > **Example Crash 1:**
> >
> > [    4.678016] BUG: Unable to handle kernel data access at
> > 0xbffffffefec10628
> > [    4.678112] NIP [c008000004e3c74c]
> > xfs_dir2_block_lookup_int+0xd4/0x300 [xfs]
> > [    4.678281] [c000000005eaf7d0] [c008000004e3c6d4]
> > xfs_dir2_block_lookup_int+0x5c/0x300 [xfs]
> > [    4.678363] [c000000005eaf850] [c008000004e3d56c]
> > xfs_dir2_block_lookup+0x44/0x1e0 [xfs]
> >
> >
> > **Example Crash 2:**
> >
> > [    6.327116] BUG: Unable to handle kernel data access at
> > 0x762f736563697695
> > [    6.327242] NIP [c00000000073cf34] __refill_obj_stock+0x74/0x2c0
> > [    6.327261] [c0000013ffdbfd10] [c0000000007418b8]
> > obj_cgroup_uncharge+0x48/0x70
> > [    6.327271] [c0000013ffdbfd50] [c00000000062fffc]
> > free_percpu.part.0+0x12c/0x630
> >
> >
>
> Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname()
> to allocate path buffer as the first bad commit.
>
>
> # git bisect good
> 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Date:   Wed May 20 11:18:56 2026 +0300
>
>      selinux: hooks: use __getname() to allocate path buffer
>
>      selinux_genfs_get_sid() allocates memory for a path with
> __get_free_page()
>      although there is a dedicated helper for allocation of file paths:
>      __getname().
>
>      Replace __get_free_page() for allocation of a path buffer with
> __getname().
>
>      Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>      Signed-off-by: Paul Moore <paul@paul-moore.com>
>
>   security/selinux/hooks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> # git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # good: [e7ae89a0c97ce2b68b0983cd01eda67cf373517d] Linux 7.1-rc5
> git bisect good e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> # status: waiting for bad commit, 1 good commit known
> # bad: [f7af91adc230aa99e23330ecf85bc9badd9780ad] Add linux-next
> specific files for 20260528
> git bisect bad f7af91adc230aa99e23330ecf85bc9badd9780ad
> # good: [7189ebc81d5e4cb4e03dc4040b07c582b95b09d5] Merge branch
> 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.=
git
> git bisect good 7189ebc81d5e4cb4e03dc4040b07c582b95b09d5
> # skip: [d22aa6f023f3fc275e1f994045a6b347288b2e5a] Merge branch
> 'watchdog-next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> git bisect skip d22aa6f023f3fc275e1f994045a6b347288b2e5a
> # good: [40d5349aaaae55ec62451bfacc6189cf44ce02cb] iio: adc: ti-ads1298:
> Add parentheses around macro parameter
> git bisect good 40d5349aaaae55ec62451bfacc6189cf44ce02cb
> # good: [6665ab5cf8e74edba571d3d2f31e575f89373dfd] Merge branch
> 'next-integrity' of
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
> git bisect good 6665ab5cf8e74edba571d3d2f31e575f89373dfd
> # bad: [4cc60db652df7ae5d659ec23325c341a52d065e0] Merge branch
> 'driver-core-next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.g=
it
> git bisect bad 4cc60db652df7ae5d659ec23325c341a52d065e0
> # bad: [e1d469c38defe7fcb8c6f62a2b7dbf4a103da300] Merge branch 'master'
> of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> git bisect bad e1d469c38defe7fcb8c6f62a2b7dbf4a103da300
> # good: [4678d11f294de0fd295a265e02955b5d1a4a2684] Merge branch into
> tip/master: 'x86/tdx'
> git bisect good 4678d11f294de0fd295a265e02955b5d1a4a2684
> # bad: [9397e02d718fc52703d753f489042293cd807dd3] Merge branch 'next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> git bisect bad 9397e02d718fc52703d753f489042293cd807dd3
> # good: [c574bdb524095d24169e229b2e3b9318c72e733a] watchdog:
> ziirave_wdt: Use named initializers for struct i2c_device_id
> git bisect good c574bdb524095d24169e229b2e3b9318c72e733a
> # bad: [5568ff6b5e30c7736c24e2096e968c8785c2c245] Merge branch
> 'for-next-tpm' of
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> git bisect bad 5568ff6b5e30c7736c24e2096e968c8785c2c245
> # bad: [23f6b2756d28e76464c7e87850d3d4f6d8c8b365] Merge branch 'next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> git bisect bad 23f6b2756d28e76464c7e87850d3d4f6d8c8b365
> # good: [ecf41f6218b58c72f1511e395e480f70a9f44889] selinux: reorder
> policydb_index()
> git bisect good ecf41f6218b58c72f1511e395e480f70a9f44889
> # bad: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux: hooks: use
> __getname() to allocate path buffer
> git bisect bad 54067bacb49caeada82b20b6bd706dca0cb99ffc
> # good: [2f0af91353cb64b54cfee5423820d2149039338d] selinux: check for
> simple types
> git bisect good 2f0af91353cb64b54cfee5423820d2149039338d
> # good: [bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c] selinux: use
> k[mz]alloc() to allocate temporary buffers
> git bisect good bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c
> # first bad commit: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux:
> hooks: use __getname() to allocate path buffer
>
>
> > If you happen to fix this, please add below tag.
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

IMHO that commit should be reverted:
__getname()/__putname() exist for a different purpose IIUC.
__getname() does a kmalloc(PATH_MAX...), whereas we are then calling
dentry_path_raw(..., PAGE_SIZE) immediately afterward.
This assumes that PATH_MAX =3D=3D PAGE_SIZE.

