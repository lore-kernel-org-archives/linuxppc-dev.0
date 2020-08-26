Return-Path: <SRS0=u8mG=CE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E57C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:29:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2D52071E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8OlEqZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2D52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BbyD40PXgzDqN0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 17:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::343;
 helo=mail-ot1-x343.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=k8OlEqZL; dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BbyB61hHCzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2020 17:27:41 +1000 (AEST)
Received: by mail-ot1-x343.google.com with SMTP id t7so758179otp.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2020 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Gjvr5EC2okLFDmptfjgkq9u5+OJVDGoBUx+FYS3Ai90=;
 b=k8OlEqZLdhMqcinOPfwq/uWMGzA1S3Ox5LgqTVlP0sVDMaAOhP62wyZCtJ7zXrAIOC
 uZhv4On0gJQRzQr9nlWXIO4mAECOj+jgpsvyI8jE9B1UHIFsRU5X47HPjAZbD8ZkP250
 UNbqmjfeFpeZ0sDmWVHbK8MbpByGfmivYJH4e2W+DkOunNjxrnlpdeyMMeOloPXs614X
 j9QoZSOz96VTUQKIpRL8ssJxkLDD5zCVCTRw0YRJa3u2A2EACROI2ha+MfyO5Hr5idlA
 kvJVEbqwxoOW9gXKPEko5mJHkrQicP5JQq69k2Q5nOxvVYfCgjzatsXkLVsVeBUhq0/j
 1uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Gjvr5EC2okLFDmptfjgkq9u5+OJVDGoBUx+FYS3Ai90=;
 b=awF63YKxTmdnF7Mh0VQ8/629yZe31f+HZu6rFIxrF5HAvhWFZz4pshRq1boJdI8EsM
 wtZPZTMCtGKiMQJgTxL6yEv5MEF4w6mZ6fWh/iBvSeQJ7hytdnQ8ERRvVFG3HIBjMBjP
 zQ0dpF3hHwRBeZqsyqLajENlaCVMTAn1DKyo34Pt2BJ04qI2E6OLNCt0rEnkunin/oSc
 Xp/dMK773qqtImJ5Ja+NCyQO2ygzjfXv9eLSk5zKu7JmkpikDH7EB5kP9lSlTPiHdu4g
 CE5NS/BwmCK6ihYl1OrM6mgSGiBbKvkSlf2KEnIFgYa9wTXLRyewG4DV3okFARNtR4uS
 z/7w==
X-Gm-Message-State: AOAM531ftG6Bf8Nf5snzoqF1I4soya7dNVLTrmYG58vHWgO8EC6P2wGP
 V+DIAg976tBDguW/ZWW48rdU4YqmuRdYiP9c8I9sM/O8SzY=
X-Google-Smtp-Source: ABdhPJwoBQQmFTHwb5OzaLVw9bR+ALCxKhX2KxA4Z5W9wsCDVdUhtunn8J3nSJ21rS2TGuorL02Je6ITUiqJBsxiZYQ=
X-Received: by 2002:a05:6830:1283:: with SMTP id
 z3mr8919573otp.51.1598426858511; 
 Wed, 26 Aug 2020 00:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200824131231.14008-1-jniethe5@gmail.com>
In-Reply-To: <20200824131231.14008-1-jniethe5@gmail.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Wed, 26 Aug 2020 17:27:27 +1000
Message-ID: <CACzsE9pCYVUBBMS27G3qz5h4D=RmHhKUKnL6Q3TMbBVzYs4Rsw@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Fix prefixes in alignment_handler
 signal handler
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 24, 2020 at 11:12 PM Jordan Niethe <jniethe5@gmail.com> wrote:
>
> The signal handler in the alignment handler self test has the ability to
> jump over the instruction that triggered the signal. It does this by
> incrementing the PT_NIP in the user context by 4. If it were a prefixed
> instruction this will mean that the suffix is then executed which is
> incorrect. Instead check if the major opcode indicates a prefixed
> instruction (e.g. it is 1) and if so increment PT_NIP by 8.
>
> If ISA v3.1 is not available treat it as a word instruction even if the
> major opcode is 1.
>
> Fixes: 620a6473df36 ("selftests/powerpc: Add prefixed loads/stores to
> alignment_handler test")
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  .../selftests/powerpc/alignment/alignment_handler.c   | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> index 55ef15184057..c197ff828120 100644
> --- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> +++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> @@ -64,12 +64,14 @@ int bufsize;
>  int debug;
>  int testing;
>  volatile int gotsig;
> +bool haveprefixes;
>  char *cipath = "/dev/fb0";
>  long cioffset;
>
>  void sighandler(int sig, siginfo_t *info, void *ctx)
>  {
>         ucontext_t *ucp = ctx;
> +       u32 inst;
Oh this should be befine __powerpc64__/CONFIG_PPC64 (thank you patchwork).
>
>         if (!testing) {
>                 signal(sig, SIG_DFL);
> @@ -77,7 +79,12 @@ void sighandler(int sig, siginfo_t *info, void *ctx)
>         }
>         gotsig = sig;
>  #ifdef __powerpc64__
> -       ucp->uc_mcontext.gp_regs[PT_NIP] += 4;
> +       if (haveprefixes) {
> +               inst = *(u32 *)ucp->uc_mcontext.gp_regs[PT_NIP];
> +               ucp->uc_mcontext.gp_regs[PT_NIP] += ((inst >> 26 == 1) ? 8 : 4);
> +       } else {
> +               ucp->uc_mcontext.gp_regs[PT_NIP] += 4;
> +       }
>  #else
>         ucp->uc_mcontext.uc_regs->gregs[PT_NIP] += 4;
>  #endif
> @@ -648,6 +655,8 @@ int main(int argc, char *argv[])
>                 exit(1);
>         }
>
> +       haveprefixes = have_hwcap2(PPC_FEATURE2_ARCH_3_1);
> +
>         rc |= test_harness(test_alignment_handler_vsx_206,
>                            "test_alignment_handler_vsx_206");
>         rc |= test_harness(test_alignment_handler_vsx_207,
> --
> 2.17.1
>
