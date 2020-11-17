Return-Path: <SRS0=3gej=EX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C168BC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 21:15:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1FC24248
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 21:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MWHmfYIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1FC24248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CbJcn075dzDqY3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 08:15:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MWHmfYIY; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbJZm1MPTzDqSk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 08:13:33 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id x15so10971821pll.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 13:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cUL+9SvzrRzllFEAM5OhpKctCqgJfj/sR/XV7GWar0I=;
 b=MWHmfYIY9ch9OvmV2riVcHnEmRpuPVUXqLW0gkD2sszZU8xssgw1NP5X1ShxEm8HJa
 0hsVkK3fKE20KdO6VmXkfWW+cgXtGbCsjVnNFMstYf+pK2L5LTkbrAxCuUfBB/WpAjAt
 75tDLdzwv7U0UzXqesHtuAuhick5Z8a/RrA2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cUL+9SvzrRzllFEAM5OhpKctCqgJfj/sR/XV7GWar0I=;
 b=IugGraEbIFv+8BSKJvATzHpRtPHDwhXRpcb7DkUaDqXG3Hh0fhqXZZ5MKbY5Q9gAAY
 63G7/v4dLe7Q4IxLg4ntsh7Oi4iwfNlMrBobnBALBy6dru62qJYl4WUmGIUTZD5RwQe5
 kFIP5mJqfROlLUZqCis8RRm8CIKxgpX1QehMRQHnL6UAMNv6DIY8Jeae6LxxT4x2ytl8
 nlodQheNFZQKqotLTI7U39OHwDubED42mxmf11Y8c6Owtko84nIP7eQmw9aIczDVFZOY
 ljrD3GPITVxXkbnjhyx3sU9UM3NXTvk+f/CG6N2hhEJa+U+KfhR3HGRO6wYtZ3YyWOfZ
 HiZg==
X-Gm-Message-State: AOAM5324kHy9QWLzTyYo7SLf+kJMlUGjPHpaPgGnLXBtYbdHvz3Hp4mB
 NL5Y1oBBWiMAmjaRYHKgcEvwCA==
X-Google-Smtp-Source: ABdhPJylohww9dg1GYyIbVMq/Nw8ytFEu6RVmpEehQbjLtvam+DWoalMEAMP5jppFr2nQ0E9S6IUIA==
X-Received: by 2002:a17:90b:80f:: with SMTP id
 bk15mr934491pjb.119.1605647606216; 
 Tue, 17 Nov 2020 13:13:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id d18sm19469582pgm.68.2020.11.17.13.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 13:13:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: containers@lists.linux-foundation.org, YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH seccomp v2 0/8] seccomp: add bitmap cache support on
 remaining arches and report cache in procfs
Date: Tue, 17 Nov 2020 13:11:13 -0800
Message-Id: <160564746555.1001899.9792418917631139658.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1605101222.git.yifeifz2@illinois.edu>
References: <cover.1605101222.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>,
 Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>,
 linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>,
 linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>,
 linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Josep Torrellas <torrella@illinois.edu>,
 Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
 David Laight <David.Laight@aculab.com>,
 Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 11 Nov 2020 07:33:46 -0600, YiFei Zhu wrote:
> This patch series enables bitmap cache for the remaining arches with
> SECCOMP_FILTER, other than MIPS.
> 
> I was unable to find any of the arches having subarch-specific NR_syscalls
> macros, so generic NR_syscalls is used. SH's syscall_get_arch seems to
> only have the 32-bit subarch implementation. I'm not sure if this is
> expected.
> 
> [...]

Applied to for-next/seccomp, thanks!

I made a small tweak to the last patch to add more details to the per-ARCH
help text, and to drop the needless "depends on SECCOMP" (which "depends
on SECCOMP_FILTER" was already present).

I successfully build-tested on parisc, powerpc, riscv, s390, and
sh. xtensa doesn't build using the existing Debian cross-compiler, and
I can't make csky with clang work, but they look correct. *cross fingers*

[1/8] csky: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/ee7ce951028f
[2/8] parisc: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/7f049cc068a3
[3/8] powerpc: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/95f8ae2624a0
[4/8] riscv: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/8f9f0f44a37b
[5/8] s390: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/5897106c6902
[6/8] sh: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/75186111c257
[7/8] xtensa: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/4f408bc643aa
[8/8] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
      https://git.kernel.org/kees/c/49a6968cc78f

-- 
Kees Cook

