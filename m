Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43956C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 17:12:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6C320657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 17:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IGysP+d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6C320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fH2y042TzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 04:12:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="IGysP+d3"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fH150BtxzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 04:11:04 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id p197so5421225itp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vtRv+bC2b+ZKIpllhcnEkC8mS52A6059IN3SfIUvhCc=;
 b=IGysP+d3tnbyPkdQg4vGdHxuFQrail167z6JMr/frchJzjv7q3yRaRlzOcRW9l86JL
 wsWZXal0fnZQGv8Glipj9178hYrmvcdVihCkzxW0MQayUNNX/c+amOxro+cWUKhnTtCc
 dWd4a3sTN9rD63+34rBUiOTNhtzvEyhRF3sPnK1ks494cI6mQQk/x+KAHwAfBJuPAt/0
 /tnNQMA2fyVQkBqT8o7k4oupI4yjCD+9wf8/kyA42dXhJ4Ipw3d+wHivQgeWgdXGgJQc
 9BUxZ1P6xYI7OCCnX5Nu9EfCg0dnpL1oEKAECoN7dagit0YeU4KCiqCOhRWvnDb1Gtzs
 QT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vtRv+bC2b+ZKIpllhcnEkC8mS52A6059IN3SfIUvhCc=;
 b=OX7hiEJf3Q8bLC/zqPlepRyTySbZWHE3LIRlAp8OEy2kUTzX5vaFcl6UT2ZIV0EBmd
 YqqWlJRjM/C3w4Ng9p6kxTlUovv0UwPP5lOUw+xgynIjFiT/lz5TJTnPRYG8fkmKmovD
 ACfSo5TOKVPQjlOWldyxKWQ+3A4K/y1VUQSCpR7dCQu9YLowfjSMFX4rjqp5uufL64hD
 eSnS48j3xcaQ8UVvnTQ+gdwENvZXA6c6rioPNqmoN19yBCqCH89EEvYoTQ6RK1HQIP7D
 5tVQlsfEZwkV7OC2JhiMbxgM540Vg3uf3LcN0XBQ1Zvq9tob0noxPxq0/n7QEhj+uL/p
 G8+Q==
X-Gm-Message-State: AJcUukeUzCcLu/GSeLBdEgLkKzjI9Y2+FpgOyFs/qyWxCg3EW4usD3vG
 TL3wXdhFKCTWWxc2p3kpBTPENcUvc/KQBedYpoV8Dw==
X-Google-Smtp-Source: ALg8bN4YJbAecTWcw1ox2ZgsKutstrXMrEyF+8QN6Rz+VyO0TybO7s6WPUvJbVowNXYRSzrkq8j1RTB5wb9zgaLVmUQ=
X-Received: by 2002:a05:660c:f94:: with SMTP id
 x20mr2787821itl.144.1547572262348; 
 Tue, 15 Jan 2019 09:11:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
 <CACT4Y+aEsLWqhJmXETNsGtKdbfHDFL1NF8ofv3KwvQPraXdFyw@mail.gmail.com>
 <801c7d58-417d-1e65-68a0-b8cf02f9f956@c-s.fr>
 <CACT4Y+ZdA-w5OeebZg3PYPB+BX5wDxw_DxNe2==VJfbpy2eJ7A@mail.gmail.com>
 <330696c0-90c6-27de-5eb3-4da2159fdfbc@virtuozzo.com>
In-Reply-To: <330696c0-90c6-27de-5eb3-4da2159fdfbc@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 15 Jan 2019 18:10:51 +0100
Message-ID: <CACT4Y+ajgTdDyFFWCp0oRSPKZh9ercDpq3pAq2-ZSx7ouAvZYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 6:06 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 1/15/19 2:14 PM, Dmitry Vyukov wrote:
> > On Tue, Jan 15, 2019 at 8:27 AM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >> On 01/14/2019 09:34 AM, Dmitry Vyukov wrote:
> >>> On Sat, Jan 12, 2019 at 12:16 PM Christophe Leroy
> >>> <christophe.leroy@c-s.fr> wrote:
> >>> &gt;
> >>> &gt; In kernel/cputable.c, explicitly use memcpy() in order
> >>> &gt; to allow GCC to replace it with __memcpy() when KASAN is
> >>> &gt; selected.
> >>> &gt;
> >>> &gt; Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
> >>> &gt; enabled"), memset() can be used before activation of the cache,
> >>> &gt; so no need to use memset_io() for zeroing the BSS.
> >>> &gt;
> >>> &gt; Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>> &gt; ---
> >>> &gt;  arch/powerpc/kernel/cputable.c | 4 ++--
> >>> &gt;  arch/powerpc/kernel/setup_32.c | 6 ++----
> >>> &gt;  2 files changed, 4 insertions(+), 6 deletions(-)
> >>> &gt;
> >>> &gt; diff --git a/arch/powerpc/kernel/cputable.c
> >>> b/arch/powerpc/kernel/cputable.c
> >>> &gt; index 1eab54bc6ee9..84814c8d1bcb 100644
> >>> &gt; --- a/arch/powerpc/kernel/cputable.c
> >>> &gt; +++ b/arch/powerpc/kernel/cputable.c
> >>> &gt; @@ -2147,7 +2147,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> >>> &gt;         struct cpu_spec *t = &amp;the_cpu_spec;
> >>> &gt;
> >>> &gt;         t = PTRRELOC(t);
> >>> &gt; -       *t = *s;
> >>> &gt; +       memcpy(t, s, sizeof(*t));
> >>>
> >>> Hi Christophe,
> >>>
> >>> I understand why you are doing this, but this looks a bit fragile and
> >>> non-scalable. This may not work with the next version of compiler,
> >>> just different than yours version of compiler, clang, etc.
> >>
> >> My felling would be that this change makes it more solid.
> >>
> >> My understanding is that when you do *t = *s, the compiler can use
> >> whatever way it wants to do the copy.
> >> When you do memcpy(), you ensure it will do it that way and not another
> >> way, don't you ?
> >
> > It makes this single line more deterministic wrt code-gen (though,
> > strictly saying compiler can turn memcpy back into inlines
> > instructions, it knows memcpy semantics anyway).
> > But the problem I meant is that the set of places that are subject to
> > this problem is not deterministic. So if we go with this solution,
> > after this change it's in the status "works on your machine" and we
> > either need to commit to not using struct copies and zeroing
> > throughout kernel code or potentially have a long tail of other
> > similar cases, and since they can be triggered by another compiler
> > version, we may need to backport these changes to previous releases
> > too. Whereas if we would go with compiler flags, it would prevent the
> > problem in all current and future places and with other past/future
> > versions of compilers.
> >
>
> The patch will work for any compiler. The point of this patch is to make
> memcpy() visible to the preprocessor which will replace it with __memcpy().

For this single line, yes. But it does not mean that KASAN will work.

> After preprocessor's work, compiler will see just __memcpy() call here.
