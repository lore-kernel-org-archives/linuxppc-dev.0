Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70EFC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 01:24:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99F5218A2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 01:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MCEkpfzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99F5218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ppws3xkNzDqPn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 12:24:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20150623.gappssmtp.com
 header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MCEkpfzG"; 
 dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ppv531rRzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 12:22:54 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id f23so3981867ljc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 18:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yQak0Tx1h8ZzNvJhxHCJfkfqfqQkp5tZm5k1rkzGAWo=;
 b=MCEkpfzGAVkV8OUWwvDfADJaHEJrKphKNk9ZBHdDkhAUp7Xi+D/fivnaUTpvnchwYj
 J2EHm4s1wlqI4ZcZiv+Js1gSi7emoP5i5oV+4iZXmIE6Qq/JWZibrzfpA0Rp90SC5BUn
 W5zfcnA3uCN/DoLkvQtKQVKubObxSOEcEhAXIrNLr81lzhyUiNHPb6wSNGfccRmX4EMy
 /H5QiSC0lmtG8aFUY+Ruz0y/ovCpRP+EuPkxhvyYHuVHYUt3qyNZ89c0ETPAPCjXUllU
 UGH5e61Ppbup0MOniwkWehzvHSNj+AwTjl0HV9bfHQFFKp60o9DqLyRIjute8/M29s41
 Wklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yQak0Tx1h8ZzNvJhxHCJfkfqfqQkp5tZm5k1rkzGAWo=;
 b=gNiVbQQMGJJ07IZE+utuz6sQcpYoCgdAHZG0zPgCBWqA5Gj71O+nUyqqcL5xKh5wzd
 rEVWSiPDB8bJR5on3XGXxWt6RaRDGAEOd01KwUbfg308diFXbP5f2LMpjltYNvDJVD9X
 wh/tqekDdv196aCbnmEcLbXa/pZRUT4LALj84Ufs2pEcCAGFqMqqXNdUg1SXIc+v7DE6
 Rk+x+5LNHEBLJ6xWFewOpTI7+BIEXNO/9N4r4kz1xPrX1O3456iL16Ovvb80qtnAdFkO
 4qgJCdGUL8fCiXotbs0eyNzed+dRX0dgs/HSJA8iBpKSb+HBHqiGeBtJcvwstSNX36SX
 +9zw==
X-Gm-Message-State: APjAAAXIPrkX5HbNl9RG29UVbpIM+X8UhVGr9cyy0ov71se6+mhV8FE8
 IOX02qaw4d49emcQriDxkvAAV6M4vFOgnNR6bmYV
X-Google-Smtp-Source: APXvYqz9Z69ggdD7Zm5pwgIrjh6J08nEG+oOiUcxma3ymHttjivN/PjyGvMdyp2UOzbYS7NuNo7HvewRoASj71uxYPo=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr481912ljb.169.1553131366528; 
 Wed, 20 Mar 2019 18:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190317233018.GN16301@altlinux.org>
In-Reply-To: <20190317233018.GN16301@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Mar 2019 21:22:35 -0400
Message-ID: <CAHC9VhQWKT8Mr=_pcmiccpChMB9oufUHO-4Agzmot7M=6ShNnw@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] syscall_get_arch: add "struct task_struct *"
 argument
To: "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, x86@kernel.org,
 Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>, Mark Salter <msalter@redhat.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Andy Lutomirski <luto@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, linux-audit@redhat.com,
 linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Mar 17, 2019 at 7:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This argument is required to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going
> to be called from ptrace_request() along with syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions with a tracee as their argument.
>
> The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
> should describe what system call is being called and what its arguments
> are.
>
> Reverts: 5e937a9ae913 ("syscall_get_arch: remove useless function arguments")
> Reverts: 1002d94d3076 ("syscall.h: fix doc text for syscall_get_arch()")
> Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Kees Cook <keescook@chromium.org> # seccomp parts
> Acked-by: Mark Salter <msalter@redhat.com> # for the c6x bit
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/alpha/include/asm/syscall.h      |  2 +-
>  arch/arc/include/asm/syscall.h        |  2 +-
>  arch/arm/include/asm/syscall.h        |  2 +-
>  arch/arm64/include/asm/syscall.h      |  4 ++--
>  arch/c6x/include/asm/syscall.h        |  2 +-
>  arch/csky/include/asm/syscall.h       |  2 +-
>  arch/h8300/include/asm/syscall.h      |  2 +-
>  arch/hexagon/include/asm/syscall.h    |  2 +-
>  arch/ia64/include/asm/syscall.h       |  2 +-
>  arch/m68k/include/asm/syscall.h       |  2 +-
>  arch/microblaze/include/asm/syscall.h |  2 +-
>  arch/mips/include/asm/syscall.h       |  6 +++---
>  arch/mips/kernel/ptrace.c             |  2 +-
>  arch/nds32/include/asm/syscall.h      |  2 +-
>  arch/nios2/include/asm/syscall.h      |  2 +-
>  arch/openrisc/include/asm/syscall.h   |  2 +-
>  arch/parisc/include/asm/syscall.h     |  4 ++--
>  arch/powerpc/include/asm/syscall.h    | 10 ++++++++--
>  arch/riscv/include/asm/syscall.h      |  2 +-
>  arch/s390/include/asm/syscall.h       |  4 ++--
>  arch/sh/include/asm/syscall_32.h      |  2 +-
>  arch/sh/include/asm/syscall_64.h      |  2 +-
>  arch/sparc/include/asm/syscall.h      |  5 +++--
>  arch/unicore32/include/asm/syscall.h  |  2 +-
>  arch/x86/include/asm/syscall.h        |  8 +++++---
>  arch/x86/um/asm/syscall.h             |  2 +-
>  arch/xtensa/include/asm/syscall.h     |  2 +-
>  include/asm-generic/syscall.h         |  5 +++--
>  kernel/auditsc.c                      |  4 ++--
>  kernel/seccomp.c                      |  4 ++--
>  30 files changed, 52 insertions(+), 42 deletions(-)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
