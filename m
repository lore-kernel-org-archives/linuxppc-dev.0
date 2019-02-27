Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7205BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 08:36:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE07218D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 08:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mo00MrN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE07218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448TYY3SNlzDqNR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 19:36:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="mo00MrN8"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448TWW6xV9zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 19:34:47 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id x3so12857857ior.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 00:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0xHuew9n2ZaXfGGIT1bL+6hd0S3FId/K5bsv3ThAwsM=;
 b=mo00MrN8/7REJ8h76ktNdA8Uslsjug59G7WpvfLrHnkmKpAZk/UlbXfrVhqFvk2okI
 91dkFw4rZADxMk20Gik8HHgtJlAe76XrdhT6GWznd3FPxf0Gv1Ti0E4qc72QObMuZmLR
 COxbXo0PzLNBj7UvBEQLKumeTawBEIr5Owe7T47opXpME5sCBKMhHWqWevFuYuo8lnR+
 PvNWejRIb6ggcD5O2N4vsobeFT7ZNBVEVoRy5fpT5fMfin+traileTjABSjSmekF0lbk
 KLX9tqoLpxWOqkGjXXZO5VJBA1oTsH/w2bws4mmsR3hOZRwKmZ1v+6DDtfsmIhf2zPPq
 RmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0xHuew9n2ZaXfGGIT1bL+6hd0S3FId/K5bsv3ThAwsM=;
 b=hnJXGOwKrAHjagJT1Vh2ENCHbToT3csanTJenCSMX3eaquBiW848Z9lKEA1s/53Itq
 dikxh5VWb1z2lX06FlSlyl76/mUgZl25iZo/KcVesHlahJOY093mlb7QF2BomhBB36YC
 eHtGr2pkJ2DZ6dzMvGFcggL48hWiQ0WIzlBsBXQBStF2lCdPpQVvLP5l9bqOOKEz8z10
 W3LaMQz3Yq6z1KfJ9OcHgvkbyG+dHiWJmLyO42I7mSV9n0eDSi4CpM3em3masBfxZFeA
 wU8RtHDkfUsbM1PfrB1jYd1oBJoYqtGYrjCVNVfwWCeKG3vOqDOGe+6ef8cIjBLItDuj
 3F2w==
X-Gm-Message-State: APjAAAWZUXQmzPr4UZQFPrsuW7nijwGFYFQLuBEn75WW8jLYr9YVGhLf
 +YCGf3+pah39LcTtJiSfyS/KbRRfqBwYGn1wAo/sMg==
X-Google-Smtp-Source: APXvYqzoFpWZLN/LYuyTaNPIHi42vvzMbUJ8NtJN84VsWy2k2bBcGxk+Kb7P1M5/Tgl1vV3odNLM3A0ZWOAjoviPg2I=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr1340885ior.11.1551256483219;
 Wed, 27 Feb 2019 00:34:43 -0800 (PST)
MIME-Version: 1.0
References: <c6d80735-0cfe-b4ab-0349-673fc65b2e15@c-s.fr>
In-Reply-To: <c6d80735-0cfe-b4ab-0349-673fc65b2e15@c-s.fr>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 27 Feb 2019 09:34:32 +0100
Message-ID: <CACT4Y+bTBGfsLq+bE9-no8sj8yvrkPN6iaELZMi7DX4Vr59zrA@mail.gmail.com>
Subject: Re: BUG: KASAN: stack-out-of-bounds
To: Christophe Leroy <christophe.leroy@c-s.fr>
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
Cc: kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 27, 2019 at 9:25 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> With version v8 of the series implementing KASAN on 32 bits powerpc
> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94309),
> I'm now able to activate KASAN on a mac99 is QEMU.
>
> Then I get the following reports at startup. Which of the two reports I
> get seems to depend on the option used to build the kernel, but for a
> given kernel I always get the same report.
>
> Is that a real bug, in which case how could I spot it ? Or is it
> something wrong in my implementation of KASAN ?

What is the state of your source tree?
Please pass output through some symbolization script, function offsets
are not too useful.
There was some in scripts/ dir IIRC, but here is another one (though,
never tested on powerpc):
https://github.com/google/sanitizers/blob/master/address-sanitizer/tools/kasan_symbolize.py



> I checked that after kasan_init(), the entire shadow memory is full of 0
> only.
>
> I also made a try with the strong STACK_PROTECTOR compiled in, but no
> difference and nothing detected by the stack protector.
>
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in memchr+0x24/0x74
> Read of size 1 at addr c0ecdd40 by task swapper/0
>
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1133
> Call Trace:
> [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
> [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
> [c0e9dd10] [c089579c] memchr+0x24/0x74
> [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
> [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
> [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
> --- interrupt: c0e9df00 at 0x400f330
>      LR = init_stack+0x1f00/0x2000
> [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
> [c0e9df20] [c0c28e44] early_irq_init+0x38/0x108
> [c0e9df50] [c0c16434] start_kernel+0x310/0x488
> [c0e9dff0] [00003484] 0x3484
>
> The buggy address belongs to the variable:
>   __log_buf+0xec0/0x4020
> The buggy address belongs to the page:
> page:c6eac9a0 count:1 mapcount:0 mapping:00000000 index:0x0
> flags: 0x1000(reserved)
> raw: 00001000 c6eac9a4 c6eac9a4 00000000 00000000 00000000 ffffffff 00000001
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   c0ecdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   c0ecdc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >c0ecdd00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
>                                     ^
>   c0ecdd80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>   c0ecde00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in pmac_nvram_init+0x1ec/0x600
> Read of size 1 at addr f6f37de0 by task swapper/0
>
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1134
> Call Trace:
> [c0ff7d60] [c01fe808] print_address_description+0x6c/0x2b0 (unreliable)
> [c0ff7d90] [c01fe4fc] kasan_report+0x13c/0x1ac
> [c0ff7dd0] [c0d34324] pmac_nvram_init+0x1ec/0x600
> [c0ff7ef0] [c0d31148] pmac_setup_arch+0x280/0x308
> [c0ff7f20] [c0d2c30c] setup_arch+0x250/0x280
> [c0ff7f50] [c0d26354] start_kernel+0xb8/0x4d8
> [c0ff7ff0] [00003484] 0x3484
>
>
> Memory state around the buggy address:
>   f6f37c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   f6f37d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >f6f37d80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
>                                                 ^
>   f6f37e00: 00 00 00 00 f2 f2 f2 f2 00 00 00 00 f2 f2 f2 f2
>   f6f37e80: 00 00 01 f2 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in memchr+0xa0/0xac
> Read of size 1 at addr c17cdd30 by task swapper/0
>
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1135
> Call Trace:
> [c179dc90] [c032fe28] print_address_description+0x64/0x2bc (unreliable)
> [c179dcc0] [c033020c] kasan_report+0xfc/0x180
> [c179dd00] [c115ef50] memchr+0xa0/0xac
> [c179dd20] [c01297f8] msg_print_text+0xc8/0x67c
> [c179ddd0] [c012bc8c] console_unlock+0x17c/0x818
> [c179de40] [c012f420] vprintk_emit+0x188/0x1c4
> --- interrupt: c179df30 at 0x400def0
>      LR = init_stack+0x1ef0/0x2000
> [c179de80] [c012fff0] printk+0xa8/0xcc (unreliable)
> [c179df20] [c150b4b8] early_irq_init+0x38/0x108
> [c179df50] [c14ef7f8] start_kernel+0x30c/0x530
> [c179dff0] [00003484] 0x3484
>
> The buggy address belongs to the variable:
>   __log_buf+0xeb0/0x4020
> The buggy address belongs to the page:
> page:c6ebe9a0 count:1 mapcount:0 mapping:00000000 index:0x0
> flags: 0x1000(reserved)
> raw: 00001000 c6ebe9a4 c6ebe9a4 00000000 00000000 00000000 ffffffff 00000001
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   c17cdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   c17cdc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >c17cdd00: 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 f3 f3
>                               ^
>   c17cdd80: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   c17cde00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in pmac_nvram_init+0x228/0xae0
> Read of size 1 at addr f6f37dd0 by task swapper/0
>
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1136
> Call Trace:
> [c1c37d50] [c03f7e88] print_address_description+0x6c/0x2b0 (unreliable)
> [c1c37d80] [c03f7bd4] kasan_report+0x10c/0x16c
> [c1c37dc0] [c19879b4] pmac_nvram_init+0x228/0xae0
> [c1c37ef0] [c19826bc] pmac_setup_arch+0x578/0x6a8
> [c1c37f20] [c19792bc] setup_arch+0x5f4/0x620
> [c1c37f50] [c196f898] start_kernel+0xb8/0x588
> [c1c37ff0] [00003484] 0x3484
>
>
> Memory state around the buggy address:
>   f6f37c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   f6f37d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >f6f37d80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
>                                           ^
>   f6f37e00: 01 f2 f2 f2 f2 f2 00 00 00 00 f2 f2 f2 f2 00 00
>   f6f37e80: 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in pmac_nvram_init+0x1ec/0x5ec
> Read of size 1 at addr f6f37de0 by task swapper/0
>
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1137
> Call Trace:
> [c0fb7d60] [c01f8184] print_address_description+0x6c/0x2b0 (unreliable)
> [c0fb7d90] [c01f7ed0] kasan_report+0x10c/0x16c
> [c0fb7dd0] [c0d1dfe8] pmac_nvram_init+0x1ec/0x5ec
> [c0fb7ef0] [c0d1ae90] pmac_setup_arch+0x280/0x308
> [c0fb7f20] [c0d16138] setup_arch+0x250/0x280
> [c0fb7f50] [c0d1032c] start_kernel+0xb8/0x4a4
> [c0fb7ff0] [00003484] 0x3484
>
>
> Memory state around the buggy address:
>   f6f37c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   f6f37d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >f6f37d80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
>                                                 ^
>   f6f37e00: 00 00 01 f2 f2 f2 f2 f2 00 00 00 00 f2 f2 f2 f2
>   f6f37e80: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
> ==================================================================
>
> Thanks
> Christophe
