Return-Path: <linuxppc-dev+bounces-26582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71925C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:05:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcN8q4vCjz2xlJ;
	Sat, 05 Sep 2026 16:04:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788511886;
	cv=pass; b=cAD1DQZ1DUzR0ZfAVsbEMtIrtFTQYrxS7klMJh/YY7gvLoszQhRr8dUZZpeq/ABFMJG2RTzw53JTVLMOTGybhSETBop+guSpUuOz9z+oMy+gZ7iX8Xgt4VmQnjxI9NAuIbMEaWjXu/7ny/EKio68AiuTxHh8/KgtrmmSYSwlCs2RLKTafvSy3vUO1eqn4Q6SDHTpy32YOOlNmFYpSBlu3wk4uNlbinO4X1M8ywEMUVmpZHP8t7h6UNQJP5rso2ISgZOJ+jAR/OLUp/VqZ/YaOs78TLB7/RX8uphN8hWpL2R5DHgH/BFWgeTepsYWzckICA5w5KBHBWGgdjLDri5JGg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788511886; c=relaxed/relaxed;
	bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch5RG13vckLiKbK2X7pmq5VdT7gQXQ9WYD9ur3on8v8lvc490RKFBNhAsA8doaijrD5pGMWL72c40IT3gXKBxeDJVzJuQxS54IJC9bcZGoN7qw1z0bZfNsLZrvniRx6xZJ/LsCmLN/o0Rpy8aQgI7Hjrz4iUUNTM5H2mfG2z32eG7ugZJ84tXro/UaIVSXxN1B+zWQ6bwaOxHGKmUFCRcvG7VMWacasGLVzZ6SrQo/vYreiC7BchhkxT34TsJYObgFvHbAFGTS+85cB/j9m3tlZKBX9xRqf7R6tiEQDyZftMm66ooyZUurxxD3f5QqqzFZOogJioc0jbXOI9xD5QsQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MBUdAbKE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=aivazian.tigran@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MBUdAbKE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=aivazian.tigran@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com [IPv6:2607:f8b0:4864:20::b131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbqvK6S9yz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 18:51:24 +1000 (AEST)
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-66e64e6e3fbso673856d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 01:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511882; cv=none;
        d=google.com; s=arc-20260327;
        b=X6jpoLDknedBRtSiLKF22IH3Qw6p5wQiFOvJ9iGuvoZb/Pmou+J2wWmkZBcZB8c9om
         V3zR6Lxa7teRPK7IerLG1G0zc2oF43GgPmCQ738iL9LFwRwUFVwbsIQqUqCe8tn2fVdf
         SjR0SIV+2o/g9NBBjdMB5K+zKUgbgEClRm4A+vPsOK4k0hC8luyY/5gEEbIGcz+hbZs2
         89pghh2T0bFijd9tAhO9CTf2c/mFWa1TCl24jlq0l0FgCn6xezZxooOCGbqez0KmV28S
         Je5onwcjgK6/5V3WjEB/3a0OzvVTtx2lxWWSp2UCm/irh/Gzrx8NspMfbeV8sUN03PVg
         Cjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
        fh=sIGvV9J5HYw9glgnh4rvnONK3fo1ECVudZNZzW2QwLU=;
        b=KamyGu1CYvHh8WYdErR2nifWCJ0AVhiWX8tM1/z2Gpg+3wbYFinoB+I9rMSqu26aVy
         a2vKp/e7xXtjCd5eky4tzbz74P2fz1Wp/IvQ6gp425OvTbKnvJgyyJjtmF8aiWg7tGQF
         UegIjk4ExAxUEQHdzA2taEnhgGjD8C1WuIsE04JwTLti7aad0JqqXzqVaNVkfFIYZ27B
         0N7jTfFG14YYV/yse+2pgA0Wm00QeT+/DrIaixWiOyU/7HDVBBu/h2TV0yBI9C4LAu86
         uAJF9gSZF5nX03RvqpPyykay8PKtAR+5xYXWaWtRh6qKz20WphBuDFuT4eD+6SMzVfdI
         WT9A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511882; x=1789116682; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
        b=MBUdAbKEaY39W2kDrvEl1TU6qD8Iw4EiSNE7xyJl6NkqSQ67RGw+aFY/xqMLsYyWj5
         PEu47J43CNBwa/XDl2njy6ssbXzxE9XA2KFHfZeyw0xxNx+tic6DgPqzCzWFr8euGKk/
         AMkWxHrTtA1QOtG929mbUFz7TZazwvh8LAFiJ/T4jjO4U5ZZQdrPMIiIQ1vsq2Jr3c11
         jbQvxy00u91vhwEVJP1j/K4bw8Zbp5dGKVlap3xWvAHV43vw9Njs3B+fX7spYNJ690ss
         QUVkQoJ3viocjP32asqVAeSUYCGwDkCLey5zKH++Ss7rgX9UQzzX5inVeB8Xvvtub6NB
         MyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511882; x=1789116682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=el9C0eC2AOZtIteG0TNFb/RC0Pp+DPvBNH48NZ87dWM=;
        b=OYJ1yn14XGnye2sJG3klJrk/pn94fMZgjw8+lqKkB/V/H1wNPfikSkrFzHBmABtzLS
         zV467EDvLFunfkL3gWPt1i2w8W7h5fUXNzh4klbhANnJFtFvf/2LtfvcAz4X2m96CPSc
         +OW1K4qYNeJnMV0MTKIQR0Qknx2rCmN04L1KWVGnW/yK1IEUMg0+4AW3oT54ck2U902X
         78WvLrdQ9sxEkyfXHSgaJi8QEOXYwEn+OClon7TEryEM0mOaUWKC1HUVoMNChqsGdPZ0
         jgLxtebDkoDGq1OyWZObGB4YR7SMl0+IsApDEXYhXOFFovLG95/bkUu0ZD1+iexC9x7T
         QwOg==
X-Forwarded-Encrypted: i=1; AKwUvBxYEKifhGM5lIIX2ApO9SH9X/5rNuktsniB4Q3EXkR9nm4PlNqvs5yE7stSjPJEvuq4eLxhco22vkEFGl4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mWBUWko6v9GidXSQ9nludoVlXY3BDx1jfZ1N7Gkf6XGx90h1Rj
	DfraGHkzx1vrA87i0EZbNuiVqidyhDR1VBl/jLUlMX9W6tdLVyG/e2gtVtm2ovT2QFV7e6gF/9t
	ryrMmtySFoOtvdtX+2oJlovEwo/kMQVQ=
X-Gm-Gg: AYBFou1VQjBsnMdIhDQV+A9QeQvzW0x5vNQdQnnmiwpbln+QdXrhNmrCHbjy+WNPMpy
	ytq5FlWhSbPJROACOUOwDVHdE3DouuyynPe5cCSSNCSt+d4vn1YBw/uZj1HxRwRgqCtVCVK8uut
	RbOUDqBG5Xyb7N96MMo6mFzfdFX1ZHvitqGzVbL6q5i8WCi1YK88Y0591zAawjG3EdSZHMcYNxl
	tQ0J0iyMDruSYKLmIXJqKXaxpsoHdNVoIpg0upn1fc9eI2asuJ7Dza3mghNhQaIcnMSGezn4zdE
	a/ALNPsEri2ZkEiSKkU+byvm3ZO317jZsoYqBETG3JQwZa0sG63qbPF5Oqv3r5/xX1CoG00XlDO
	ddEECU8pXA9rD+SuOMp5owzlM
X-Received: by 2002:a05:690e:e25:b0:66d:2c09:fb70 with SMTP id
 956f58d0204a3-66fb575c665mr1287497d50.0.1788511882074; Fri, 04 Sep 2026
 01:51:22 -0700 (PDT)
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
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
In-Reply-To: <20260904082954.48738-1-enelsonmoore@gmail.com>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 4 Sep 2026 09:51:10 +0100
X-Gm-Features: AcwNN1US813RpOVK53IyVszIyhGZqjM2-hVqjP58I9fP7PqngduJcqRbNBYYNbU
Message-ID: <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>
Subject: Re: [PATCH] bfs: remove the filesystem
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Howells <dhowells@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"Theodore Ts'o" <tytso@mit.edu>, Catalin Iacob <iacobcatalin@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hi Ethan,

On Fri, 4 Sept 2026 at 09:30, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
>
> BFS (not to be confused with BeFS, the BeOS filesystem) is the
> filesystem UnixWare uses for its boot partition. It has extremely
> limited functionality, only supporting contiguous files and no
> subdirectories. Even though the bfs driver is very small and is
> unlikely to cause future maintenance problems, given that the only type
> of data stored on such a partition is likely to be kernels and
> bootloader settings, there is very little reason anyone would want to
> access it from Linux. Other old Unix filesystems (efs, freevxfs) have
> been removed recently, and bfs is highly unlikely to have any users, so
> remove it as well. Retain the UAPI header to be safe.
>

You are right that probably no one would want to use BFS for storing
the actual data today.
But some things have didactical value, rather than mere pragmatic
usage. It is the didactic
value of MINIX (and its limitations wrt making use of the wonderful
capabilities of i386) that
has originally triggered the creation of Linux. But back to BFS: it is
actually used in Steve Pate's
book "Linux Filesystems" (2024, unfinished yet), which is a sequel to
his excellent classic
"UNIX Filesystems" (2003), as an illustration of a particularly simple
filesystem implementation.

I remember when Linus accepted my patch with BFS on 28 October 1999
into 2.3.25 his comment
was: "this appears to be a particularly simple one".

Kind regards,
Tigran

