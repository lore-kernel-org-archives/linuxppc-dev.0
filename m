Return-Path: <linuxppc-dev+bounces-24043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D88C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 12:29:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gy7LR0WPgz2y8F;
	Sat, 11 Jul 2026 22:29:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783772974;
	cv=pass; b=kfPKU9Bzz4nvTUi1XpfRPSVunnIjZTphmBfSK84xkIt0zhk6QtP1TDeKtkJVVHUcNQlqWffs/nPjaeXHrSXoIlZgCn0DYZoaukuu+IkOM80759bZypv1u7CRIdiKpE1SN+RBkFFh4mOm3oy1VBviEBMAZt4mQ77ovEg6zQRHZdzjzCXi41Jmhic/qHbCze4Zaaw1yRPvWgiE4SpAnGPLKy14pVZtazpO5rRkLisERAGixg4O2gM/FEaZX6PACKfd87XsyvPDgfVzJMvEKsE2r1Sc9tQcDJueyCKNp4N7ST02R+nVX0LcZIvr8LKWKDpaJ9oS4AArSKRp/A9HVAL8vQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783772974; c=relaxed/relaxed;
	bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oov4j98gI42dL5x/ExKAkekmr7YbWT1ogfv8IcHbsNYZhTgXBSYgEWjpnK0fOI5P9bN1YncvY8ya7WUxzrNFhvWVonU7fqAtk762SKRy8rHC5sjL9D5+YUZkWIji93pL8gCjyC33oWnQzLskQOnWCS1FcwZYeLgtrR7lPkUXAYe2bz5kkDK4fgjWXm/ksNFOCiF85XOaJxNi2FkahRqGX+a03xqCDl9u9P+97t+/Dbd6cbRLCZqecgAUavm8CgQHkQT5059xRUdJyfNl28ORr57XXO4d9cbSLKuPPLnlPM4C4dZ/xPyztovFhK/RhyMEEGtlOTYgNEkUC+5ter2FLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C+f63BuP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C+f63BuP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gy7LP4mmhz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 22:29:32 +1000 (AEST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2817333a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 05:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=q/dhpoAfDutc6pa8M3IXmGAD7nyi9t19n5nKr6iaOVPslm5yHDuBH+gANxacgIefxH
         KL3NU/KiAb9bmu4KkZgbNLstQgt0mb/L95r6jpLwlaD8I21Vess3FUkNNlF04DsiQZ0C
         7EJj75fSRE2Sum0jcl6Y0lZw2FkJwSbm3wgY8IefGjtZfm+TUf/D0fQumjjjUcxG5ec9
         sxrILao6MTBieTWkzEO8WfnJsZ+oXAXl2w0fZbum/icno9WGG79ViJHQx/mmAhoecRCx
         1cCeLBJ5862z1GLa/ODZI7t8OumsdMaXdBVPCU/er4kAGfnrqblJREu/N2mihGowETLK
         GQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=ttMl75uNkEmmCCAXves0kQHGvyc73RzZy8EGFHVLZe8=;
        b=JirsugDSUBZRDcjsN0yJbks8Qyq7xzQdZYHix4iQrh9Xxvo6eB/11bxEZrF1b93WQV
         E2OBuPUJrNqKc24aDwa0RaLF3ss9sqcJip69wlw5EArPGBKXV2rF2GkpEBafWH8ZXuLa
         /KtMzwq3iPNCteeuJZ8m6P9btJo5xmcYZemX6pbSKkdy7Oj/EVnVLQ1vhtixXTjEjxbM
         T0t59Vb1CpnBYbx9b1Kf/iZmFIim6Ba6B7F03/Z2r5OuLapAzlI4auQs5QnTMms+gnPZ
         5kicUgaT+GOHCgtXKjIqrFeCOwrttaIVNjygUJe9pnwVSZWDXA+gx4V6t6Zzwqx7Anmz
         NpJQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=C+f63BuPKINcUHcb1TpQ5Vhntvo7E7vy593Kvm/TTlqaJG6M/IZrUHHDKB3vv8pMKh
         tfxVbO28QK/M4dw1ajQnJedClAscqQTiR8CnfJt53je5drpL9LfRNsO4Dx4afR2Hzm8i
         PBRV/ngtJvSMnZxNXOPa73qcI6TSgQb4GYabmpzSS7k4VDC8m54eR6OWDIyY48VXzcZn
         u5HnL8x3TCohnlUab6N2dsae0pvnPAT6iPcQ4Fp8NVh6U15nuxvn7A6ZUt8k2dA8r+av
         sJLerUVOLhTOCZIddOZQZnSi14584cJg0K7sDtzGx5DqEFyYp8Y6U6xoc2ZFHg1OjwpS
         oT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=WfsdDf2ualwyrshqmavE704buf4fwAO+oOldgJvXfC9jGIdIETo8fFzvBUeG66H1Qh
         Xj1j72mG153h1X31JvRSiSZjLH5aHt9pHuzvxYgwHGpdCNMI0Zs4PlO5SiOETKQgrNiH
         iys78io4EU9Ok7iof9eQLYYumM5V2VljejP61oEd33MNF8Uutr0NsEAlMp/MdzBHPh5G
         kd1kTuoN4/TfoW7l+QFizb+K9Ttl5hZpPuzqjBhUC5rU4ww0A/lbld7YmdHOPzMOmUdF
         tEHbk42hpde3JxYdCN4miumIMRqd2JpqdLj0w24eFkTzUYhToaJlBkMHMP2YJax7Mcnj
         +UDg==
X-Forwarded-Encrypted: i=1; AHgh+RqITeKTzZft0SC7l/+0m4oGzOQcnTak7g+khaoZUGYbIfTsKKYyAVBIkBjkOZE1vIhbj9RCUqQN9TYhbPM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YySy9pwwQYbKmKp+4dUZU4pqS/vV0DxD3woz7g3KQQoQ0yW5mkh
	C2q5S8QIfx04j7PA+u12dT7cgc1i6j1mgGCs1CNGoGKYVoQI46dDhAH9wxaMekDpZdIim76RL1y
	odPC1rgwr8UD8RRiJ1uFoZ7oqf+O0O8c=
X-Gm-Gg: AfdE7cnwQBLT/73fuMwytKNBwh5eBaTGzuU7jQ7f6ICoY8/rmsWVNz23ltv2kxzatpr
	gb2RgqxT98YwQ4s+S4AIltgRBz78zsxUDqZRxLwf+phv1wnV9GIj9oZWzNcmTZy9JrB3kHPrucO
	ea1FN6QYz7ORq3T5WhT6MphallhoJu4UT6mkoyDaoDfUZKcyEZGyb4nHXurbUyPS/5xSqKoLANU
	UyA5QY+a/w2xPXyEuLD0+ZxKGOUWQO888utNcgLn3I1NsLfqVhnlCaLdj4ITW+7uvzaS70Qlyjw
	/Yxik0e12vXJoGw8xw8RXJ7HRBLF7BOBzA92NzKkVPMv+gWNhut5eDg5FQtgmME=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
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
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>

