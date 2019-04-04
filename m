Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F652C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 18:59:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBD72075E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 18:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M76lnXAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBD72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZsgD0vT9zDqRF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 05:59:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::b44; helo=mail-yb1-xb44.google.com;
 envelope-from=jcmvbkbc@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M76lnXAH"; 
 dkim-atps=neutral
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZscN1vwnzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 05:56:36 +1100 (AEDT)
Received: by mail-yb1-xb44.google.com with SMTP id b88so1437791ybi.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=czb2ENwQGWnSQaCPQIrYNCynYy2KSbTtKbmrxk8aiuA=;
 b=M76lnXAHZW3E/8sfPEo6AMsEvKo1Fj2EhqlUI6eC714OKjs2ScEs0g5Kdp16SCqkPF
 N0+X6xTwMiV/VBKBoM8U7lCaiLZf0D5h8H0NYyJsPMWgNRUMOJFoGIeE3Kw2Z03GU9vT
 zVyDQ6CnNyqqWAbFqnkhKqeqcKWpSWW3q20J6IQ+uvd8srIqBj9yOsnXEon9ojIURp4v
 bTLlHhqhnN0+9uDyqXd9PWoJbT4ZfrXOkz5CQF3mN7LEVXFyBxCwjgwaWqj7DMqenuLs
 uXedhWbK9lmCM0WnwBXxlX+/J6awXNP/t6T5RlKFdEob9MOiRhxs9ue2K7i3gYHUzYfA
 pf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=czb2ENwQGWnSQaCPQIrYNCynYy2KSbTtKbmrxk8aiuA=;
 b=YqcjxKqSeOgoMxWwyVj0heLGpY5PNI+JvoAPMcTeNCzjWkHwU8mdgmCstTNWJ5p52k
 T6g/HtRskJ0XtMAM8mLBxtVOQF0VuuotEaS9N5VEtu4zYqyaLTWdp+hUvxBp8E1cQCGR
 aqL2uBcmJFRClh/r2hUHMMYtcS0hPQJMTKba9MHuBMGKeULgQUJBZQWTkJE7h0vYcVMK
 L5XdwhX4MsXW+YY7BGVB00BI2U48KLDiQ2qPpCQIFc4ttwc6T84U+p+epgQkfsHDGSPe
 RKveIiMTYjlATUhsES1bjBlmCNlgyiDT9JBSQpYLyzJwAF2OsvXZuor60JBiN/akvqOG
 ZYAA==
X-Gm-Message-State: APjAAAWtzDnSDph6knJm+zYo7B7c5luFaccD60lUiNdhOSAhFIxQyVQd
 2gsv+HQpVSWQKtGSjPId2Ry36QglFjEJ9jDhVk7yl5ihO3MS8g==
X-Google-Smtp-Source: APXvYqw2AeCdLcNxw3yXyG2q9A1yJJjPzbkEFkUNasjS0SEO0/rC6tigTrt97xSpbl9QpVkQd9PzuPxHxf4nnJWaXhg=
X-Received: by 2002:a25:6c88:: with SMTP id h130mr6951040ybc.112.1554404194312; 
 Thu, 04 Apr 2019 11:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.278590567@goodmis.org>
In-Reply-To: <20190401134421.278590567@goodmis.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Apr 2019 11:56:23 -0700
Message-ID: <CAMo8BfK8gdgni3z3PKv1rd0KPFMXgDCpicQQ_obuoDAEz3PkZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
To: Steven Rostedt <rostedt@goodmis.org>
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
Cc: "open list:IA64 \(Itanium\) PL..." <linux-ia64@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Peter Zijlstra <peterz@infradead.org>, Palmer Dabbelt <palmer@sifive.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Oleg Nesterov <oleg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 Dave Martin <dave.martin@arm.com>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Roland McGrath <roland@hack.frob.com>, linux-um@lists.infradead.org,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "Dmitry V. Levin" <ldv@altlinux.org>,
 linux-arm-kernel@lists.infradead.org,
 "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 1, 2019 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in only
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the first 6
> arguments of a system call.
>
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.

[...]

>  arch/xtensa/include/asm/syscall.h     | 16 ++----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
