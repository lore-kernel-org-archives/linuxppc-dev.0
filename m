Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C8BC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 18:57:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4C32075E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 18:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oShr81BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4C32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZsdN45wDzDqRM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 05:57:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::b44; helo=mail-yb1-xb44.google.com;
 envelope-from=jcmvbkbc@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oShr81BX"; 
 dkim-atps=neutral
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZsbQ5DxwzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 05:55:43 +1100 (AEDT)
Received: by mail-yb1-xb44.google.com with SMTP id e12so1445439ybq.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=25sghkzH7+QQTBx8fQe0oQc1kNQMTCVYK21rCY5qth4=;
 b=oShr81BXfJmMNACrlPJNe3qZjMk8TVDODP/4DOZSEiguPFnp1XoQQSzj2L+/S7OgcZ
 xlRxsRSl3LKCT8cceZDc18vbr0akZuu8eHO9YvBuQC+ZF/Bg8Nd03nDvnFvPx3DTgSB8
 stQjWpAL9qfP/+KDg6paUcBuFqxkPiT8XzUlvjf8FjjvD7SiRbtUnQVK6FFEUypEDtYr
 qEOfIrGQMIzPvqW5P7S02ntouLCBWfQfbcVkwPGrsbjjwDMVuxZQUHNol5XmKFpEaG1w
 tH/XQqKdk0d4pVTwSgCh0Dh/8KyNP9gBybXk1tsa55B2gmsPvleeNJBUVZHmlKELfyUB
 hvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=25sghkzH7+QQTBx8fQe0oQc1kNQMTCVYK21rCY5qth4=;
 b=lGzE+cztjOpxKbCzZDuzq9InOjcdOZmv9r21i6Kqm8CAQuM5+oMNqOj4yZz3AAyCCz
 tGXv/KWuXqntPQLoXYrdW/OeUfMYE+TwnF6298DyqVykQ5R0CgpNZQdEWQZXFZ00uThR
 eEQC+HNkw/Ka+t65zdHUrGpwmFA6Y097aI6PlmbbcRpJN5hgZlxMJVTmWXGdEsdrHPX6
 ++m0jycQaHrCMuvkzsCXfifxOLtDd9k6VTS7xcDpCo8/x53XRq6HLpNeLTqvdhaIZY8I
 WSJipInGXxaqXMZOgxhbXOoifktv7ZxH3JAH5C31c+1bXts1bWmMTtSqlF9JjKNO1Laq
 46HA==
X-Gm-Message-State: APjAAAUsk1jvmpXXJfRWbMFPtFG/QGzBSFFnIefvJfztTEbHR4oJxlbb
 /EWABxEYtfQFtsgq0nQaDGV96NpjrDA3x5dToQU=
X-Google-Smtp-Source: APXvYqzh21O0ITqX+GxLGlXQTKYy8XTPMJsQuockVZOBkdbHKpkJnf7AUuLxdh0xNW+jLZEdFbPk0yqWF+qcuNBCN9g=
X-Received: by 2002:a25:6e56:: with SMTP id j83mr7056113ybc.16.1554404139647; 
 Thu, 04 Apr 2019 11:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.442323029@goodmis.org>
In-Reply-To: <20190401134421.442323029@goodmis.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Apr 2019 11:55:29 -0700
Message-ID: <CAMo8BfLooVJgKCPQFDXUAfieH3XAF=Bhz2PmAb+3t7BhVBW5FQ@mail.gmail.com>
Subject: Re: [PATCH 6/6 v3] syscalls: Remove start and number from
 syscall_set_arguments() args
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
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().

[...]

>  arch/xtensa/include/asm/syscall.h     | 17 ++-----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
