Return-Path: <linuxppc-dev+bounces-23556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB0BC44501
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 21:32:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsRmm5gbTz2ydn;
	Sat, 04 Jul 2026 07:32:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783114360;
	cv=none; b=Nj2I2snXUF+wZ5tG8FeH9sLFvSdfIsflqPdV/3Z+9LEmULpY7DMM4Ga+rCXUSXgXGN18n/5oVI13sLJCWoGMz3GQVFXxcDlUbXYnNAKdG/tqopxQtTMhlL7rlvOXNvq8bE278tBjrbiCga57+MJbmlMgCrj4f4Qk/ID6/pJtgoN9UvTPwljn0O9xlgpXZE0Nj/AAFBfonble3cCSmU9zKwm9VBcJhqY38RHJbboptgf2YfutZaDmogRw8bwIndu5Xu1zhai9Wm42O4oAFqsKpv0wCaUmg5VJ7ZyjqCL0O8KYJQEJ+OCmTEF4dkCDeJMIJ9sVxIKfkS1FstxR0nQJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783114360; c=relaxed/relaxed;
	bh=OKSIV0oOxnrYHCfPO5lAQhnCzHPQePBOMJ0ktW8HRY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPZg/4ehRMglSD37269ZTrsmyyaWsyjIz9DEPrXBh5Lbwi6M+LngsZF+krC662YXlfH81HTC/faUNUE5r0w6iNSwyMnY31DOQEcGiYX342lkd1gCy4qJH1d5dg56XyMuzaesgaFMzk3KhttxiG68tqBqPFw8wUyAldw4psfQxnspxxSWdwMJw14IrRlyQgs4mQEDEkSutlRUmZvTgb4kbuUdvRixwRrkAUXu1hfM4ejEWhpC66nDofyqg7J8FVa7Nze5zQ3+R8SAcv0Rv1iEuQj8u8XA7GcYlSOSs4bB+7gWmR3+mTo+ImQkcNAc2SUIdt5Qa7LUw5fJrc/qYGUhBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtXX8IuU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtXX8IuU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsRml5dngz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 07:32:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2706643E42
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2026 21:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5CE1F00ACA
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2026 21:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783114356;
	bh=OKSIV0oOxnrYHCfPO5lAQhnCzHPQePBOMJ0ktW8HRY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KtXX8IuUBNhuHWxHxBTjmuPBk9hzOQ7UsQ1CE9gvBu/kMIDFo6Om3uI/27v9fejDF
	 +EVx4yFRcD+ZHGYHSXYVZZrdD4NN/AABtyOquBKTUSIeaFLSvadRobD8UUMhpLHrw0
	 fvkNRGAwgqS7RXxOwI5DWG0GAAfbEfvGiRFksz8erK7uHpTpuZSuWn/tAoEAx/C2WO
	 88OCMIKeQZOVmG2qajorm/8ZVb4ZRZWobPwoWS9swqCLPbGZVB9YV96d8g65sWN148
	 RiD56W+0SQV3jJI86Xxpjs0EONHteMV6QzKzQJsvVBtqNZ2E7uv6VZzpJWrrCp/VUv
	 yBpdVzNcTlwqA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso860526e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 14:32:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpdZkfdIwnb7PXtSOKxi/KsN3LtYsvbceLBQECxraLqehMYcEL9xV08TC5IXudgx/G0Gfbe+3vqPwdaSRM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwBxIhWASLyy7AO6wQdN8lGFc6sxJy7v+JJpdI74yuwMt356VYe
	nDbPY1qMNu1vKg/a+51B7FQ6wc3JXbE/i8owS40LlUoEHzWss/uJMmH29IyBFeUqsExzOpoOwNX
	Hut1mWoObsLR/S13jldmqjTE75+WRVtw=
X-Received: by 2002:a05:6512:8391:b0:5ae:ba2b:b469 with SMTP id
 2adb3069b0e04-5aed5092745mr72984e87.18.1783114353971; Fri, 03 Jul 2026
 14:32:33 -0700 (PDT)
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
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com> <akdp6GAu77-ipsXA@kunlun.suse.cz>
 <87cxx4mmim.ffs@fw13> <akeIK5TRCjlKbzbp@J2N7QTR9R3>
In-Reply-To: <akeIK5TRCjlKbzbp@J2N7QTR9R3>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 23:32:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLn0Pfhx0bY9XywVkDVU-nyAbvrnf9Wr8TSkuV4hgJL=8w@mail.gmail.com>
X-Gm-Features: AVVi8CegcPVBpxUBhMgaVmjHkjMbMgWpKQVd4voTgZ2p1M7BcZ7lo9TMo7bB8LM
Message-ID: <CAD++jLn0Pfhx0bY9XywVkDVU-nyAbvrnf9Wr8TSkuV4hgJL=8w@mail.gmail.com>
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to return boolean
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, kees@kernel.org, guoren@kernel.org, 
	chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, luto@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org, 
	thuth@redhat.com, ada.coupriediaz@arm.com, kevin.brodsky@arm.com, 
	yeoreum.yun@arm.com, song@kernel.org, james.morse@arm.com, 
	anshuman.khandual@arm.com, broonie@kernel.org, liqiang01@kylinos.cn, 
	pengcan@kylinos.cn, ryan.roberts@arm.com, yangtiezhu@loongson.cn, 
	sshegde@linux.ibm.com, mchauras@linux.ibm.com, austin.kim@lge.com, 
	jchrist@linux.ibm.com, arnd@arndb.de, thomas.weissschuh@linutronix.de, 
	sohil.mehta@intel.com, andrew.cooper3@citrix.com, jgross@suse.com, 
	kas@kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 12:00=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:

> Bikeshedding below; sorry.
>
> I think the bigger problem is just that secure_computing() is a terrible
> name that does not express the intended semantic -- it's not clear
> whether "secure computing" means "seccomp permit the syscall" or
> "seccomp is enabled and some special rules now apply" or something else
> entirely.
>
> If we're changing the return type, it might be worth renaming the
> function something like:
>
>         seccomp_permits_syscall()

Yeah that's way better, let's do this.
(I also had problems with this function!!)

Rusty Russel's API design manifesto tells us to do this:
https://gist.github.com/mjball/9cd028ac793ae8b351df1379f1e721f9

Yours,
Linus Walleij

