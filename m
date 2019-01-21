Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F60C282DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:53:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1372084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="irk0kpYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1372084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jlhg5gZmzDqVJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 19:53:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="irk0kpYT"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jl9t0RKRzDqVs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 19:30:41 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id b23so15746274ios.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 00:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ww085OACm4i7mqE67ZdIQ/eDnX5lMbW7fzlbmIgXAEk=;
 b=irk0kpYTWl+fMLn717tgCoPUMr7EWiqL5y7s82Xc9j0VPLy6PAEnLNMuGjDMoFV0Yy
 2s6vFd/lJb8XWemgbmryxsgj9dEtQNcd32fDPLB1HsPt+SCVEUwFg4/boDUMEJovqRzI
 tq52Q6C+gt6cf5wqYzISfoTdLLYBN02u3ujIZskb8jftLw92rTGZZjnJz1hsV9wXrDwk
 QqRqk/lF7M+Uqv3JWbLC6qUiCXDAOeAg6XTvtuBeOl8E/SF/msImGHKEtZ9pK7L5/RlO
 LT2jzgZDAGSaMmD8El1xkmk10aw+dR7ee7ENpuhltHJDDXl+vMsj0KbQTq6Ym/yi89P7
 X1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ww085OACm4i7mqE67ZdIQ/eDnX5lMbW7fzlbmIgXAEk=;
 b=cKS5DgsCGWBMYWfa5xAvDLVaC5Qp+cRp4QwiNfQZ01s/uX6Y6fMnWWTo4rQnErWggA
 ZtQ7pJQnBTiZAgyhwoEA5m3TgLOyM2r74yXQqHYjYCQ4OSLmvwOBzbyOOBA65lY+MavI
 1M6oW+iglOXhCOGIK3VRMK1V222qfUi1XVSWaHgrRjvOa6TTdrzqGOYxuwxzOphNQOtQ
 4aDB0A0OpTO7ajI6ejHjVGgqKjLq1B675eypg9yjerU0myQrvZmzhzg4wgwzrmFchLAJ
 8ExdjC5AJ4HcYSdvfNsJbW4zUe5tcotvcbGygBeN1TjvTZfvQ5VrKikTXWDG/bH9cYGe
 2Vlg==
X-Gm-Message-State: AJcUukdVM17RszHpnSAFgOGU+i6msAUIYLug4O8BPxfp0XtJPh4iUqng
 Vhq7qroH6OxI6rlbhvQ7HDqB2gVN277TIZwG+kvX4g==
X-Google-Smtp-Source: ALg8bN6pVSUQAGPoALJVcBXrooWWBo6DjGveKj9PCGXAw/Gya0V/2bdBH5M4qgvqAI4lru73E5WrUgt3rKufK0pKDe8=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr16024815iom.11.1548059439657; 
 Mon, 21 Jan 2019 00:30:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <935f9f83393affb5d55323b126468ecb90373b88.1547289808.git.christophe.leroy@c-s.fr>
 <e4b343fa-702b-294f-7741-bb85ed877cdf@virtuozzo.com>
 <8d433501-a5a7-8e3b-03f7-ccdd0f8622e1@c-s.fr>
In-Reply-To: <8d433501-a5a7-8e3b-03f7-ccdd0f8622e1@c-s.fr>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 21 Jan 2019 09:30:27 +0100
Message-ID: <CACT4Y+Z+UbN1rjHr3T5rgHpCJUknupPvEPw0SHs1-qjWBDhm3Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/32: Add KASAN support
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 21, 2019 at 8:17 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 15/01/2019 =C3=A0 18:23, Andrey Ryabinin a =C3=A9crit :
> >
> >
> > On 1/12/19 2:16 PM, Christophe Leroy wrote:
> >
> >> +KASAN_SANITIZE_early_32.o :=3D n
> >> +KASAN_SANITIZE_cputable.o :=3D n
> >> +KASAN_SANITIZE_prom_init.o :=3D n
> >> +
> >
> > Usually it's also good idea to disable branch profiling - define DISABL=
E_BRANCH_PROFILING
> > either in top of these files or via Makefile. Branch profiling redefine=
s if() statement and calls
> > instrumented ftrace_likely_update in every if().
> >
> >
> >
> >> diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan_init=
.c
> >> new file mode 100644
> >> index 000000000000..3edc9c2d2f3e
> >
> >> +void __init kasan_init(void)
> >> +{
> >> +    struct memblock_region *reg;
> >> +
> >> +    for_each_memblock(memory, reg)
> >> +            kasan_init_region(reg);
> >> +
> >> +    pr_info("KASAN init done\n");
> >
> > Without "init_task.kasan_depth =3D 0;" kasan will not repot bugs.
> >
> > There is test_kasan module. Make sure that it produce reports.
> >
>
> Thanks for the review.
>
> Now I get the following very early in boot, what does that mean ?

This looks like an instrumented memset call before kasan shadow is
mapped, or kasan shadow is not zeros. Does this happen before or after
mapping of kasan_early_shadow_page?
This version seems to miss what x86 code has to clear the early shadow:

/*
* kasan_early_shadow_page has been used as early shadow memory, thus
* it may contain some garbage. Now we can clear and write protect it,
* since after the TLB flush no one should write to it.
*/
memset(kasan_early_shadow_page, 0, PAGE_SIZE);


> [    0.000000] KASAN init done
> [    0.000000]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.000000] BUG: KASAN: unknown-crash in memblock_alloc_try_nid+0xd8/0=
xf0
> [    0.000000] Write of size 68 at addr c7ff5a90 by task swapper/0
> [    0.000000]
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.0.0-rc2-s3k-dev-00559-g88aa407c4bce #772
> [    0.000000] Call Trace:
> [    0.000000] [c094ded0] [c016c7e4]
> print_address_description+0x1a0/0x2b8 (unreliable)
> [    0.000000] [c094df00] [c016caa0] kasan_report+0xe4/0x168
> [    0.000000] [c094df40] [c016b464] memset+0x2c/0x4c
> [    0.000000] [c094df60] [c08731f0] memblock_alloc_try_nid+0xd8/0xf0
> [    0.000000] [c094df90] [c0861f20] mmu_context_init+0x58/0xa0
> [    0.000000] [c094dfb0] [c085ca70] start_kernel+0x54/0x400
> [    0.000000] [c094dff0] [c0002258] start_here+0x44/0x9c
> [    0.000000]
> [    0.000000]
> [    0.000000] Memory state around the buggy address:
> [    0.000000]  c7ff5980: e2 a1 87 81 bd d4 a5 b5 f8 8d 89 e7 72 bc 20 24
> [    0.000000]  c7ff5a00: e7 b9 c1 c7 17 e9 b4 bd a4 d0 e7 a0 11 15 a5 b5
> [    0.000000] >c7ff5a80: b5 e1 83 a5 2d 65 31 3f f3 e5 a7 ef 34 b5 69 b5
> [    0.000000]                  ^
> [    0.000000]  c7ff5b00: 21 a5 c1 c1 b4 bf 2d e5 e5 c3 f5 91 e3 b8 a1 34
> [    0.000000]  c7ff5b80: ad ef 23 87 3d a6 ad b5 c3 c3 80 b7 ac b1 1f 37
> [    0.000000]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.000000] Disabling lock debugging due to kernel taint
> [    0.000000] MMU: Allocated 76 bytes of context maps for 16 contexts
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 817=
6
> [    0.000000] Kernel command line: console=3DttyCPM0,115200N8
> ip=3D192.168.2.7:192.168.2.2::255.0.0.0:vgoip:eth0:off kgdboc=3DttyCPM0
> [    0.000000] Dentry cache hash table entries: 16384 (order: 2, 65536
> bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 1, 32768 byte=
s)
> [    0.000000] Memory: 99904K/131072K available (7376K kernel code, 528K
> rwdata, 1168K rodata, 576K init, 4623K bss, 31168K reserved, 0K
> cma-reserved)
> [    0.000000] Kernel virtual memory layout:
> [    0.000000]   * 0xffefc000..0xffffc000  : fixmap
> [    0.000000]   * 0xf7c00000..0xffc00000  : kasan shadow mem
> [    0.000000]   * 0xf7a00000..0xf7c00000  : consistent mem
> [    0.000000]   * 0xf7a00000..0xf7a00000  : early ioremap
> [    0.000000]   * 0xc9000000..0xf7a00000  : vmalloc & ioremap
>
>
> Christophe
